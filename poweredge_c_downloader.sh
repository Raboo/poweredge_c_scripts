#!/bin/bash
# Downloads firmware for Dell C chassis machine type
# to use this script simply create a function call like this:
# fetch <MACHINETYPE> <FIRMWARTYPE>
# and then run unzip with -p something like this:
# unzip -p ${TMP}/${FILE} *${FIRMWARE}.bin >> ${TYPE}_${DATE}.fw
# that will output a file named like BMC_2013-05-31.fw
DATE=$(date +"%F")
DEST="/var/www/html/poweredge_c_fw"
TMP="/var/tmp/poweredge_c_fw"
CWD=${PWD}

mkdir -p ${DEST}
mkdir -p ${TMP}

function fetch() {
	cd ${TMP}
	TYPE=$2
	MACHINE=$1
	FETCHLIST=$(curl -s http://poweredgec.com/latest_fw.csv|grep $MACHINE | grep $TYPE |cut -d, -f6)
	FILE=$(echo $FETCHLIST | sed 's!.*/!!')
	NAME=$(echo ${FILE} | sed 's/\(.*\)\..*/\1/')
	FIRMWARE=$(echo ${NAME}| sed -e "s/^.*${TYPE}\([0-9]\+\).*/\1/")
	curl -O $FETCHLIST
	cd ${CWD}
}

# BMC
fetch C6220 BMC
unzip -p ${TMP}/${FILE} ${NAME}/KCSflash/DCSFWU/linux/open/R${FIRMWARE}.dcs >> ${DEST}/${TYPE}_${DATE}.fw

# Bios
fetch C6220 BIOS
unzip -p ${TMP}/${FILE} *.hdr >> ${DEST}/${TYPE}_${DATE}.fw

# FCB
fetch C6220 FCB
unzip -p ${TMP}/${FILE} *${FIRMWARE}.bin >> ${DEST}/${TYPE}_${DATE}.fw

