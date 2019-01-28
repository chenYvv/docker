#!/bin/sh
set -x

# 启动 crontab
/etc/init.d/cron start

# 启动 apache
apache2-foreground

exec "$@"
