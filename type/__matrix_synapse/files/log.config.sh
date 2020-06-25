#!/bin/sh

cat << EOF

version: 1

formatters:
  precise:
   format: '%(asctime)s - %(name)s - %(lineno)d - %(levelname)s - %(request)s- %(message)s'
  journal_fmt:
   format: '%(name)s: [%(request)s] %(message)s'

filters:
  context:
    (): synapse.util.logcontext.LoggingContextFilter
    request: ""

handlers:
  file:
    class: logging.handlers.WatchedFileHandler
    formatter: precise
    filename: $LOG_DIR/homeserver.log
    filters: [context]
    level: DEBUG
    encoding: utf8
  console:
    class: logging.StreamHandler
    formatter: precise
    level: WARN
  journal:
    class: systemd.journal.JournalHandler
    formatter: journal_fmt
    filters: [context]
    SYSLOG_IDENTIFIER: synapse

loggers:
    twisted:
        level: WARN

    synapse:
        level: INFO

    # the following levels are more verbose than most users want
    # set them to INFO if you need more logging
    synapse.metrics:
        level: WARN

    synapse.http.federation.well_known_resolver:
        level: WARN

    synapse.storage.TIME:
        level: WARN

    synapse.http.matrixfederationclient:
        level: WARN

root:
    level: INFO
    handlers: [file, journal]
EOF
