#!/bin/bash
> report.txt
#1.判断SSD硬盘是否使用过
for disk in $(lsscsi -sw | grep disk | awk '{print $4}')
do

    disk_count=$(echo ${disk} | awk -F '/' '{print $3}')
    disk_rotational=$(cat /sys/block/${disk_count}/queue/rotational)
    if [ $disk_rotational -eq 0 ]
    then
        echo "---------------------------------------------------------------------------" &>> report.txt
        echo "开始检测${disk}硬盘:" &>> report.txt
        Ssd=$(smartctl -a $disk | grep endurance | awk '{print $6}')
        if [ "$Ssd" == 0% ]
        then
            echo "${disk}为SSD：未使用过" &>> report.txt
        else
            echo "${disk}为SSD：已使用过" &>> report.txt
        fi

        for smart_delayed in $(smartctl -a $disk | egrep "read:|write:" | awk '{print $3}')
        do
            if [ $smart_delayed -ne 0 ]
            then
                echo "${disk}的delayed不正常，需要返厂 " &>> report.txt
            fi
        done

        for smart_errors_corrected in $(smartctl -a $disk | egrep "read:|write:" | awk '{print $5}')
        do
            if [ $smart_errors_corrected -ne 0 ]
            then
                echo "${disk}的smart_errors_corrected不正常，需要返厂 " &>> report.txt
            fi
        done

        for smart_uncorrected_errors in $(smartctl -a $disk | egrep "read:|write:" | awk '{print $8}')
        do
            if [ $smart_uncorrected_errors -ne 0 ]
            then
                echo "${disk}的smart_uncorrected_errors不正常，需要返厂 " &>> report.txt
            fi
        done
        log=$(smartctl -x $disk | grep -A 13 "Background scan results log")
        echo $log &>> report.txt
        echo "---------------------------------------------------------------------------" &>> report.txt

    fi

done

