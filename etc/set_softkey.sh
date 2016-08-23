#!/system/bin/sh
# Copyright (c) 2015 PaoloW8

sleep 2
softkey=`sqlite3 /data/data/org.cyanogenmod.cmsettings/databases/cmsettings.db "select value FROM secure WHERE name='dev_force_show_navbar'"`
file="/system/usr/keylayout/Generic.kl"
to_do="$(cat $file | grep "key 102   HOME              VIRTUAL" | cut -b1)"

mount -o remount,rw /system

case "$softkey" in
	"0")
		if [ "$to_do" == "#" ]
		then
			sed -i "s/#key 102   HOME              VIRTUAL/key 102   HOME              VIRTUAL/" $file
			sed -i "s/#key 139   MENU              VIRTUAL/key 139   MENU              VIRTUAL/" $file
			sed -i "s/#key 158   BACK/key 158   BACK/" $file
		fi
		;;
	"1")
		if [ "$to_do" != "#" ]
		then
			sed -i "s/key 102   HOME              VIRTUAL/#key 102   HOME              VIRTUAL/" $file
			sed -i "s/key 139   MENU              VIRTUAL/#key 139   MENU              VIRTUAL/" $file
			sed -i "s/key 158   BACK              VIRTUAL/#key 158   BACK              VIRTUAL/" $file
		fi
		;;
esac

mount -o remount,ro /system

setprop softkey.change 0

