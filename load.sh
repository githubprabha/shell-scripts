-----------------------------------------------------------------
# install stress in you instances before running the script
# sudo amazon-linux-extras install epel -y (for amazon linux-2)
# sudo yum install stress -y
-----------------------------------------------------------------
#!/bin/bash

#Defiine the maximum cpu load percentage
max_load=90

#define the spet size to increase the load
step_size=20

#define the duration to maintain the load at 90%
duration=1800

#loop to gradually increase the cpu load
for load in $(seq 0 $step_size $max_load); do
    stress --cpu 1 --timeout 5s & #adjust parameter as needed
    sleep 30 # wait for 30 seconds
    pkill stress
    echo "Increase load to $load%"
    if [ $load -eq $max_load ]; then
        break
    fi
done

#after reaching 90% load, miantain it for the spcific duration
echo "maintaining the 90% of load for the next 30 minutes..."
stress --cpu 1 --timeout $duration #adjust parameters as needed


