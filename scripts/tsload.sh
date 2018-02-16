#!/bin/bash

DATABASE=
FILEPATH=
FILENAME=$1

function tablename {
TABLENAME=`basename ${FILENAME} .csv`
}

function format {
case ${TABLENAME} in Dim.SectionDetail) DATEFORMAT="%Y-%m-%d %H:%M:%S";;
                     *)                 DATEFORMAT="%Y%m%d";;
esac
}

function load {
LOGFILE=logs/${TABLENAME}.log
tsload --target_database ${DATABASE} \
       --target_table $TABLENAME \
       --source_file ${FILEPATH}/${FILENAME} \
       --has_header_row \
       --empty_target \
       --date_format "${DATEFORMAT}" \
       --skip_second_fraction \
       --bad_records_file "bad/$FILENAME.bad" \
       --null_value "NULL" \
       --boolean_representation "Y_N" 2>&1 | tee ${LOGFILE}
}

function main {
tablename
format
load
}

if [ $# -eq 1 ]
then
   main
else
  for FILENAME in `ls *.csv`;do
   main
  done
fi
