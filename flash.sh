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

IPMIFLASH="echo /opt/dell/pec/ipmiflash"
FLAGS="-p"
FWREPO="http://10.24.2.100/poweredge_c_fw"
BMCUSER="root"
BMCPASS="root"

for server in ${TGT_SVR_BMC}; do
	# BMC
	${IPMIFLASH} ${FLAGS} -H${server} -U${BMCUSER} -P${BMCPASS} bmc ${FWREPO}/${BMC_IMG}
	# FCB
	${IPMIFLASH} ${FLAGS} -H${server} -U${BMCUSER} -P${BMCPASS} fcb ${FWREPO}/${FCB_IMG}
	# BIOS (will cause hard reboot of machine)
	${IPMIFLASH} ${FLAGS} -H${server} -U${BMCUSER} -P${BMCPASS} bios ${FWREPO}/${BIOS_IMG}
done

