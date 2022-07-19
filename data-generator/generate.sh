#!/usr/bin/bash

# Util script for mocking interleaving transactions in a log file

# Usage: ./generate.sh transaction-number outputfile
# e.g. ./generate.sh 101 /test.log

# Synthesising logs with date format "dd/mm/YYYY HH:mm:ss'
TIMENOW=`date +%T`
DELAY=`echo $(( RANDOM % 5 ))`
TRANSNUM=$1
LOGFILE=$2



if (( "$#" != 2 )) 
then
    echo "Usage: ./generate.sh transaction-number outputfile"
exit 1
fi

#Start log entry
DATESTAMP=`date "+%d/%m/%Y %T.%3N"` #note we include microseconds in our example timestamp
EVENT="START"
echo "Starting transaction ${TRANSNUM} with delay ${DELAY}"
echo "${DATESTAMP} INFO trans=${TRANSNUM} event='TRANSACTION-${EVENT}' Some log data about the start of transaction " >> $LOGFILE

sleep $DELAY 

# Intermediate log entry
DATESTAMP=`date "+%d/%m/%Y %T.%3N"`
EVENT="MIDDLE"
echo "Middling transaction ${TRANSNUM}"
echo "${DATESTAMP} INFO DELAY=${DELAY} trans=${TRANSNUM} event='TRANSACTION-${EVENT}' Some intermediatary log line" >> $LOGFILE

sleep $DELAY 

# Final log entry (this determines the end of transaction)
DATESTAMP=`date "+%d/%m/%Y %T.%3N"`
EVENT="END"
FINALDELAY=$(($DELAY * 2))
echo "Ending transaction ${TRANSNUM}"
echo "${DATESTAMP} INFO DELAY=${FINALDELAY} trans=${TRANSNUM} event='TRANSACTION-${EVENT}' Some more log information about the end of the transaction" >> $LOGFILE


