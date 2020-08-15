# Sat Aug 15 11:33:35 PDT 2020
#
# Synchronize local content with FTPS server
#
# Mirror commands don't work, bummer.
# Neither does anything else :(

USER=fitzgerald
HOST=ftps://webpages.csus.edu

lftp -u $USER $HOST

mirror -R _site
