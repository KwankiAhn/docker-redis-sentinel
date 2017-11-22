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
	sed -i "s/@MASTER_HOST@/$MASTER_HOST/g" /redis/sentinel.conf
	sed -i "s/@MASTER_PORT@/$MASTER_PORT/g" /redis/sentinel.conf
	redis-sentinel /redis/sentinel.conf
#	redis-cli -p 26379 sentinel remove mymaster
#	redis-cli -p 26379 sentinel monitor mymaster "$MASTER_HOST" "$MASTER_PORT" 2
	echo " >>> Finished"
elif [ "$ROLE" = "MASTER" ]; then 
	echo " >>> Run as master"
	sed -i "s/@MASTER_HOST@/127.0.0.1/g" /redis/sentinel.conf
        sed -i "s/@MASTER_PORT@/6379/g" /redis/sentinel.conf
	redis-sentinel /redis/sentinel.conf
	echo " >>> Finished"
else
	echo " >>> Run as UNKNOWN Role, this is not supposed to triggered as 1st invoking redis"
	redis-sentinel /redis/sentinel.conf
        echo " >>> Finished"
fi
