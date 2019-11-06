#!/bin/bash
# This script will download and add domains from the rep to adslist.list
TICK="[\e[32m ✔ \e[0m]"
PIHOLE_LOCATION="/etc/pihole"
GRAVITY_UPDATE_COMMAND="pihole -g"

echo -e " \e[1m This script will download and add domains from the repo to adlists.list \e[0m"
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

curl -sS 'https://v.firebog.net/hosts/lists.php?type=tick' | sudo tee -a "${PIHOLE_LOCATION}"/adlists.list >/dev/null
echo -e " ${TICK} \e[32m Adding domains to block list... \e[0m"
sleep 0.1
echo -e " ${TICK} \e[32m Removing duplicates... \e[0m"
mv "${PIHOLE_LOCATION}"/adlists.list "${PIHOLE_LOCATION}"/adlists.list.old && cat "${PIHOLE_LOCATION}"/adlists.list.old | sort | uniq >> "${PIHOLE_LOCATION}"/adlists.list

echo -e " [...] \e[32m Pi-hole gravity rebuilding lists. This may take a while... \e[0m"
${GRAVITY_UPDATE_COMMAND} > /dev/null
 
echo -e " ${TICK} \e[32m Pi-hole's gravity updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"


