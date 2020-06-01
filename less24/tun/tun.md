CLIENT

[root@r2 vagrant]# iperf3 -c 10.10.10.1 -t 40 -i 5
Connecting to host 10.10.10.1, port 5201
[  4] local 10.10.10.2 port 42568 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-5.00   sec  42.4 MBytes  71.1 Mbits/sec    7    332 KBytes       
[  4]   5.00-10.00  sec  42.4 MBytes  71.1 Mbits/sec    9    334 KBytes       
[  4]  10.00-15.00  sec  42.2 MBytes  70.8 Mbits/sec   11    271 KBytes       
[  4]  15.00-20.01  sec  41.7 MBytes  70.0 Mbits/sec   30    303 KBytes       
[  4]  20.01-25.00  sec  41.6 MBytes  69.9 Mbits/sec    9    227 KBytes       
[  4]  25.00-30.00  sec  42.0 MBytes  70.4 Mbits/sec   12    190 KBytes       
[  4]  30.00-35.00  sec  41.8 MBytes  70.2 Mbits/sec    0    312 KBytes       
[  4]  35.00-40.01  sec  43.5 MBytes  72.9 Mbits/sec   11    251 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-40.01  sec   338 MBytes  70.8 Mbits/sec   89             sender
[  4]   0.00-40.01  sec   337 MBytes  70.6 Mbits/sec                  receiver


