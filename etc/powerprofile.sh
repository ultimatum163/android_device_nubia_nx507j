#!/system/bin/sh

powermode=`getprop sys.perf.profile`
dev_governor=`ls /sys/class/devfreq/qcom,cpubw*/governor`
        case "$powermode" in
            "2")
                 stop mpdecision
                 sleep 0.5
                 echo 1958400                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo performance                          > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo performance                          > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo 1                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo 578000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo msm-adreno-tz                        > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "msm_cpufreq"                        > $dev_governor
              ;;
            "1")
                 start mpdecision
                 sleep 0.5
                 echo 1958400                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 1958400                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
                 echo interactive                          > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo interactive                          > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo 1                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo 578000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo msm-adreno-tz                        > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "cpubw_hwmon"                        > $dev_governor
             ;;
             "0")
                 start mpdecision
                 sleep 0.5
                 echo 1267200                              > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                 echo 1267200                              > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
                 echo 1267200                              > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
                 echo 1267200                              > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                 echo 300000                               > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
                 echo conservative                         > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                 echo conservative                         > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                 echo 2                                    > /sys/devices/system/cpu/sched_mc_power_savings
                 echo 389000000                            > /sys/class/kgsl/kgsl-3d0/max_gpuclk
                 echo msm-adreno-tz                        > /sys/class/kgsl/kgsl-3d0/devfreq/governor
                 echo "cpubw_hwmon"                        > $dev_governor
              ;;
        esac

