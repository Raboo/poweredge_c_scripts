#!/bin/bash
#
# -f  force flash
# -p  preserve config
# -n  disconnect after sending flash command (use for flashing many systems)
#

# Target BMCs, space separated list
TGT_SVR_BMC="192.168.8.191 192.168.8.193 192.168.8.195"

# Name of firmwares
BMC_IMG=BMC_2013-05-31.fw
FCB_IMG=FCB_2013-05-31.fw
BIOS_IMG=BIOS_2013-05-31.fw

IPMIFLASH="./ipmiflash"
FLAGS="-n"
TFTPSVR=192.168.8.174
BMCUSER="root"
BMCPASS="root"

for i in ${TGT_SVR_BMC}; do
	# BMC
	${IPMIFLASH} ${FLAGS} -H${TGT_SVR_BMC1} -U${BMCUSER} -P${BMCPASS} bmc tftp://${TFTPSVR}/fw/${BMC_IMG}
	# FCB
	${IPMIFLASH} ${FLAGS} -H$TGT_SVR_BMC1 -U${BMCUSER} -P${BMCPASS} fcb tftp://$TFTPSVR/fw/${FCB_IMG}
	# BIOS (will cause hard reboot of machine)
	${IPMIFLASH} ${FLAGS} -H$TGT_SVR_BMC1 -U${BMCUSER} -P${BMCPASS} bios tftp://$TFTPSVR/fw/${BIOS_IMG}
done

