#
# Regular cron jobs for the mongo-cxx-driver-legacy package
#
0 4	* * *	root	[ -x /usr/bin/mongo-cxx-driver-legacy_maintenance ] && /usr/bin/mongo-cxx-driver-legacy_maintenance
