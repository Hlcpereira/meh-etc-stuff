#!/system/bin/sh

scriptname=${0##*/}
notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}


product=`getprop ro.product.name`
mem_total_string=`cat /proc/meminfo | grep MemTotal`
mem_total=$((${mem_total_string:16:8}/1024))

notice "Moto System tuning: product=$product, memory=${mem_total}M"

# App compactor reclaims background apps without killing them,
# so it significantly reduces the app kills. As it also increases the swap,
# so far we only enable it on device with 6G ram and lower device.
if [ $mem_total -le 6144 ]; then # <=6G
    notice "enable app compactor"
    device_config put activity_manager use_compaction true
    device_config put activity_manager compact_action_1 4
    device_config put activity_manager compact_action_2 2
fi

# We have too much cache level apps after Android Q due to background
# execute restrictions, tune the max_cached_processes to balance the am_kills
# and performance. Please note: below max_cahced_processes config will
# override the ro.MAX_HIDDEN_APPS.
if [ $mem_total -le 2048 ]; then # <=2G
    notice "set max_cached_processes to 32"
    device_config put activity_manager max_cached_processes 32
elif [ $mem_total -le 4096 ]; then # 3G~4G
    notice "set max_cached_processes to 36"
    device_config put activity_manager max_cached_processes 36
else # >4G
    notice "set max_cached_processes to 42"
    device_config put activity_manager max_cached_processes 42
fi
