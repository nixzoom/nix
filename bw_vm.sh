#!/bin/bash
vm=$(virsh list --all | awk '{print $2}'| sed -n 6p )
intface=$(virsh dumpxml $vm | grep vnet | awk '{print $2}' | cut -d"'" -f 2| sed -n 1p )
rx=$(virsh domifstat $vm $intface | grep rx_bytes | awk '{print $3}')
tx=$(virsh domifstat $vm $intface | grep tx_bytes | awk '{print $3}')
tot=$(($rx + $tx))
echo "Total Inbound Traffic for the Virtual Interface $intface $rx  for the VM $vm"
echo "Total Outbound Traffic for the Virtual Interface $intface $tx for the VM $vm"
echo "Total Bandwidth for the Virtual Interface (IN/OUT) $intface $tot for the VM $vm"

