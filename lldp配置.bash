lldp

#!/bin/bash -v

配置开启网卡监控
1. 获取网卡名称
i=ifconfig | awk -F'[ :]+' '!NF{if(eth!=""&&ip=="")print eth;eth=ip4=""}/^[^ ]/{eth=$1}/inet addr:/{ip=$4}' | grep en

2. 开启服务

lldpad -d

3. 开启网卡监控

lldptool set-lldp -i $i adminStatus=rxtx
lldptool -T -i $i -V $i sysName enableTx=yes
lldptool -T -i $i -V $i portDesc enableTx=yes
lldptool -T -i $i -V $i sysDesc enableTx=yes

#==================下面是正式脚本=====================================================

#!/bin/bash

systemctl enable lldpad.service
systemctl start lldpad.service

for i in $(ifconfig | awk -F'[ :]+' '!NF{if(eth!=""&&ip=="")print eth;eth=ip4=""}/^[^ ]/{eth=$1}/inet addr:/{ip=$4}' | grep en); do
  lldptool set-lldp -i $i adminStatus=rxtx >/dev/null 2>&1
  lldptool -T -i $i -V $i sysName enableTx=yes >/dev/null 2>&1
  lldptool -T -i $i -V $i portDesc enableTx=yes >/dev/null 2>&1
  lldptool -T -i $i -V $i sysDesc enableTx=yes >/dev/null 2>&1
done

lldpad -d

for i in $(ifconfig | awk -F'[ :]+' '!NF{if(eth!=""&&ip=="")print eth;eth=ip4=""}/^[^ ]/{eth=$1}/inet addr:/{ip=$4}' | grep en); do
  #
  se_dev=$i
  ld_tool="lldptool -t -n -i $se_dev"
  sw_If=$($ld_tool | grep 'Ifname:' | awk -F ': ' '{print $NF}')
  sw_name=$($ld_tool | grep 'System Name TLV' -A1 | tail -n1 | sed 's/\t//g')
  sw_ip=$($ld_tool | grep 'Management Address TLV' -A1 | tail -n1 | awk -F ': ' '{print $NF}' | sed 's/\t//g')
  echo "se_dev: $se_dev
sw_name:$sw_name
sw_ip: $sw_ip
sw_If: $sw_If
"

  #
done

#================================================
