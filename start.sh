#!/bin/bash
echo "******************************"
echo "*** START SENTINEL !!!     ***"
echo "******************************"
if [ "$ROLE" = "SLAVE" ]; then
	if [ -z "$MASTER_HOST" ]; then
		echo "empty MASTER_HOST env param!!!, exit..."
		exit 0
	fi
	if [ -z "$MASTER_PORT" ]; then
		echo "empty MASTER_PORT env param!!!, exit..."
		exit 0
	fi
	echo " >>> Run as slave"
	redis-sentinel /redis/sentinel.conf
	redis-cli -p 26379 sentinel remove mymaster
	redis-cli -p 26379 sentinel monitor mymaster "$MASTER_HOST" "$MASTER_PORT" 2 
	echo " >>> Finished"
elif [ "$ROLE" = "MASTER" ]; then 
	echo " >>> Run as master"
	redis-sentinel /redis/sentinel.conf
	echo " >>> Finished"
else
	echo " >>> Invalid Role, exit..."
fi
