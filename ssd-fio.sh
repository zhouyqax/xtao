#!/bin/bash
for disk in $(lsscsi -sw | grep disk | grep 400GB | awk '{print $4}'); do
    disk_count=$(echo "${disk}" | awk -F '/' '{print $3}')
    disk_rotational=$(cat /sys/block/"${disk_count}"/queue/rotational)
    if [ "$disk_rotational" -eq 0 ]; then
        fio --filename="${disk}" --direct=1 --iodepth=32 --numjobs=4 --iodepth_batch_complete=16 --rw=randwrite --ioengine=libaio --bs=4k --size=100G --runtime=300 --group_reporting --time_based --name=n2 --ioscheduler=noop

        fio --filename="${disk}" --direct=1 --iodepth=32 --numjobs=4 --iodepth_batch_complete=16 --rw=randread --ioengine=libaio --bs=4k --size=100G --runtime=300 --group_reporting --time_based --name=n2 --ioscheduler=noop
    fi

done
