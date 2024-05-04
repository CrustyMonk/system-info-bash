#!/bin/bash

output_file="system_info.txt"

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

get_system_info() {
	echo "System Hostname: $(hostname)" >> "$output_file"
	echo "--------------------------- " >> "$output_file"
	echo "OS: $(lsb_release -ds)" >> "$output_file"
	echo "--------------------------- " >> "$output_file"
	echo "Uptime: $(uptime -p)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "Kernel Version: $(uname -r)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "CPU Info:" >> "$output_file"
	echo "$(lscpu)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "Memory Info:" >> "$output_file"
	echo "$(free -h)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "IP Info:" >> "$output_file"
	echo "$(ip addr show)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "Filesystem Utilization:" >> "$output_file"
	echo "$(df -h)" >> "$output_file"
	echo " ---------------------------" >> "$output_file"
	echo "Last 5 Error Logs:" >> "$output_file"
	echo "$(grep -i "error" /var/log/syslog | tail -n 5)" >> "$output_file"
}

main() {
	get_system_info
	echo "System Information Has Been Collected And Saved To $output_file"
}

main
