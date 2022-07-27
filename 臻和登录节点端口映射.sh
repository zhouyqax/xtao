#!/bin/bash

nohup socat TCP4-LISTEN:10165,reuseaddr,fork TCP4:192.168.79.4:10050 &
nohup socat TCP4-LISTEN:10151,reuseaddr,fork TCP4:192.168.79.5:10050 &
nohup socat TCP4-LISTEN:10152,reuseaddr,fork TCP4:192.168.79.6:10050 &
nohup socat TCP4-LISTEN:10153,reuseaddr,fork TCP4:192.168.79.7:10050 &
nohup socat TCP4-LISTEN:10154,reuseaddr,fork TCP4:192.168.79.8:10050 &
nohup socat TCP4-LISTEN:10155,reuseaddr,fork TCP4:192.168.79.9:10050 &
nohup socat TCP4-LISTEN:10156,reuseaddr,fork TCP4:192.168.79.10:10050 &
nohup socat TCP4-LISTEN:10157,reuseaddr,fork TCP4:192.168.79.11:10050 &
nohup socat TCP4-LISTEN:10158,reuseaddr,fork TCP4:192.168.79.12:10050 &
nohup socat TCP4-LISTEN:10159,reuseaddr,fork TCP4:192.168.79.13:10050 &
nohup socat TCP4-LISTEN:10160,reuseaddr,fork TCP4:192.168.79.14:10050 &
nohup socat TCP4-LISTEN:10161,reuseaddr,fork TCP4:192.168.79.15:10050 &
nohup socat TCP4-LISTEN:10162,reuseaddr,fork TCP4:192.168.79.16:10050 &
nohup socat TCP4-LISTEN:10163,reuseaddr,fork TCP4:192.168.79.17:10050 &
nohup socat TCP4-LISTEN:10164,reuseaddr,fork TCP4:192.168.79.18:10050 &
nohup socat TCP4-LISTEN:10251,reuseaddr,fork TCP4:192.168.11.25:10051 &

socat TCP4-LISTEN:10165,reuseaddr,fork TCP4:127.0.0.1:10050 &
