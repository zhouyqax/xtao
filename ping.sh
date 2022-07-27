#!/bin/bash

pinglog=/var/log/ping-cache.log
echo "开始扫描检测" >$pinglog

read -p "请输入IP网络位:" ip #从键盘输入，注意ip前面要有个空格
for i in $(#seq用于生成数字1~254
    seq 1 254
); do
    {
        ping "$ip"."$i" -c1 -s1 2>&1 1>/dev/null && #$ip和$i是两个传入参数代表网络位和主机位。2>&1 将标准输出错误重定向标准输出到屏幕,/dev/null代表linux的空设备文件,也就是将标准输出1重定向到/dev/null中,
            echo -e ping "$ip"."$i" 是 "\033[32;49;1m通的！ \033[39;49;0m" ||
            echo -e ping "$ip"."$i" 是 "\033[31;49;1m不通的！ \033[39;49;0m" #这里显示结果,""里代表字符串颜色  #"||"代表如果前面的执行失败就执行后面的。
    } & #注意在shell中不支持多线程的.这里&是采用多进程执行方式,{}里执行了,不管结束没结束继续执行下一条.

done >>$pinglog
wait #{}执行完,执行下一条,相当于高级语言多线程同步作用.
sort -n -k 4 -t . "$pinglog" -o "$pinglog"
cat $pinglog
echo "扫描检测已结束。"
