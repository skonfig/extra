#!/usr/bin/env python3

import collections
import hashlib
import json
import re
import sys
import urllib.request

from cksum import Cksum

GITHUB_REPO = "https://github.com/srvrco/getssl"

class CksumLine(collections.namedtuple("CksumLine", (
        "id", "sha256", "cksum"))):
    __slots__ = ()

    @classmethod
    def from_line(cls, line):
        cols = line.rstrip("\r\n").split("\t")
        return cls(*cols)

    def to_line(self):
        return "\t".join(getattr(self, k, "") or "" for k in self._fields)

    @property
    def version(self):
        if "@" in self.id:
            return self.id[:self.id.find("@")]
        else:
            return self.id

    @property
    def gitref(self):
        return self.id[self.id.find("@")+1:]


def extract_github_repo_path(repo_url):
    return re.sub(r"^.*github\.com", "", repo_url, flags=re.ASCII)


def fetch_github_releases(repo_url):
    repo_path = extract_github_repo_path(repo_url)
    releases_url = "https://api.github.com/repos%s/releases" % (repo_path)
    page = 0
    releases = []
    while True:
        page += 1
        with urllib.request.urlopen(urllib.request.Request(
                "%s?per_page=10&page=%u" % (releases_url, page),
                headers={
                    "Accept": "application/vnd.github.v3+json",
                })) as resp:
            rlist = json.loads(resp.read().decode())
            if not rlist:
                break
            releases += rlist
    return releases


def github_file_url(repo_url, ref, path):
    return "https://raw.githubusercontent.com%s/%s%s" % (
        extract_github_repo_path(repo_url), ref, path)


def perform_hash(algo, contents):
    if algo == "cksum":
        c = Cksum()
        c.update(contents)
        return "%d %u" % (c.cksum(), c.size())
    else:
        return getattr(hashlib, algo)(contents).hexdigest()


def checksum_url(url):
    with urllib.request.urlopen(url) as f:
        contents = f.read()
        return {
            algo: perform_hash(algo, contents)
            for algo in ("sha256", "cksum")
            }


if __name__ == "__main__":
    with open(sys.argv[1], "r+") as f:
        cksums = {}
        for line in filter(lambda l: l and not re.match(r"^#", l), f):
            cksum = CksumLine.from_line(line)
            if cksum.version in cksums:
                raise RuntimeError(
                    "Duplicate version in cksums.txt: %s" % (cksum.version))
            cksums[cksum.version] = cksum

        if len(sys.argv) > 2:
            # manual entry
            if "@" in sys.argv[2]:
                # it's a commit
                releases = [sys.argv[2].split("@", 1)]
            else:
                # it's a tag
                releases = [(sys.argv[2], sys.argv[2])]
        else:
            # automatically insert all found releases
            releases = [
                (r["tag_name"], r["tag_name"])
                for r in sorted(
                    fetch_github_releases(GITHUB_REPO),
                    key=lambda r: r["published_at"])]

        for (version, gitref) in releases:
            if version in cksums:
                continue

            getssl_bin_url = github_file_url(GITHUB_REPO, gitref, "/getssl")
            checksums = checksum_url(getssl_bin_url)

            if version != gitref:
                version_id = version + "@" + gitref
            else:
                version_id = version

            cksum = CksumLine(version_id, **checksums)

            # Append cksum to file
            f.write(cksum.to_line() + "\n")
