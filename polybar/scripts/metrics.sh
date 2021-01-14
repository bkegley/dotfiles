memory=$(free | grep Mem | awk '{ print $3/$2 * 100.0 }')
cpu=$(top -n 1 | grep %Cpu | awk '{ print 100 - $8 }')

echo "Mem: $memory
CPU: $cpu"
