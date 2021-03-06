# Get all domains
_dom=$@
 
# Die if no domains are given
[ $# -eq 0 ] && { echo "Usage: $0 domain1.com domain2.com ..."; exit 1; }
for d in $_dom
do
	_ip=$(host $d | grep 'has add' | head -1 | awk '{ print $4}')
	[ "$_ip" == "" ] && { echo "Errors: $d is not a valid domain or dns Error found."; continue; }
	echo "Trying to  Getting information for domain: $d [ $_ip ]..."
	whois "$_ip" | egrep -w 'OrgName:|City:|Country:|OriginAS:|NetRange:'
	echo ""
done
