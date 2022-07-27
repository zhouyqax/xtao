vim /etc/sysconfig/network-scripts/ifcfg-enp59s0f0

IPADDR3=10.3.1.4
PREFIX3=24


#添加ip地址
echo -e "IPADDR3=10.3.1.15\nPREFIX3=16" >>/etc/sysconfig/network-scripts/ifcfg-enp59s0f0
ifdown enp59s0f0 && ifup enp59s0f0 && ip r  #重启网卡


ssh node18 echo -e "IPADDR3=10.3.1.18\nPREFIX3=24" >>/etc/sysconfig/network-scripts/ifcfg-enp59s0f0
ssh node18 cat /etc/sysconfig/network-scripts/ifcfg-enp59s0f0

#脚本
for i in {8..18}; do
echo "节点$i"
ssh node$i "echo -e "IPADDR3=10.3.1.$i\nPREFIX3=16" >>/etc/sysconfig/network-scripts/ifcfg-enp59s0f0 && ifdown enp59s0f0 && ifup enp59s0f0 && ip r |grep enp59s0f0"
done

#单行脚本
#添加ip地址,重启网卡，查看ip
for i in {8..18}; do echo 节点$i;ssh node$i "echo -e "IPADDR3=10.3.1.$i\nPREFIX3=16" >>/etc/sysconfig/network-scripts/ifcfg-enp59s0f0 && ifdown enp59s0f0 && ifup enp59s0f0 && ip r |grep enp59s0f0";  done


#查看ip地址
for i in {8..18}; do echo 节点$i的ip; ssh node$i cat /etc/sysconfig/network-scripts/ifcfg-enp59s0f0 |grep IPADDR ;done




echo -e "GATEWAY=10.46.1.254" >>/etc/sysconfig/network-scripts/ifcfg-eno1 && ifdown eno1 && ifup eno1

+++++++++++++++++++
# 配置临时ip地址
 ifconfig eth0 192.168.56.112/24 

 #多个临时ip，ifconfig 网卡名：0 第一个ip
ifconfig ens33:0 192.168.1.112
ifconfig ens33:1 192.168.2.111

#删除临时ip
ifconfig ens33:0 del 192.168.1.111

++++++++++++++++++++++++++++++++++++++
