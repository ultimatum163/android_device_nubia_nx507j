package com.cyanogenmod.settings.device;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.util.Log;

import java.io.FileOutputStream;
import java.nio.charset.Charset;

public class BootCompletedReceiver extends BroadcastReceiver {
    final String KEYS_ARRAY_FILE = "/sys/devices/f9927000.i2c/i2c-5/5-005d/touch_key_array";
    final String FAST_CHARGE_FILE = "/sys/kernel/fast_charge/force_fast_charge";
    final String CHARGE_LEVEL_FILE = "/sys/kernel/fast_charge/fast_charge_level";
    final String PALM2SLEEP_FILE = "/sys/devices/f9927000.i2c/i2c-5/5-005d/palm2sleep";
    final String CPU_BOOST = "/sys/module/cpu_boost/parameters/cpu_boost";
    final String INTELLIPLUG_BOOST = "/sys/module/intelli_plug/parameters/touch_boost_active";

    public BootCompletedReceiver() {
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d("X9180", "Starting BootCompletedReceiver");
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
        if("1".equals(prefs.getString("keys_order", "0"))) {
            try {
                Log.d("X9180", "Trying to change touch key layout");
                FileOutputStream fos = new FileOutputStream(KEYS_ARRAY_FILE);
                String data = "158 172 139\n";
                fos.write(data.getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        boolean fast_charge = prefs.getBoolean("fast_charge", false);
        String fast_charge_value = prefs.getString("fast_charge_level","0");
        if(fast_charge) {
            try {
                Log.d("X9180", "Trying to force fast charge");
                FileOutputStream fos = new FileOutputStream(FAST_CHARGE_FILE);
                String data = "0".equals(fast_charge_value)?"1\n":"2\n";
                fos.write(data.getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if(!"0".equals(fast_charge_value)) try {
                Log.d("X9180", "Trying to set fast charge value");
                FileOutputStream fos = new FileOutputStream(CHARGE_LEVEL_FILE);
                fos.write(fast_charge_value.getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        boolean palm2sleep = prefs.getBoolean("palm2sleep", true);
        try {
            Log.d("X9180", "Trying to change palm2sleep value");
            FileOutputStream fos = new FileOutputStream(PALM2SLEEP_FILE);
            fos.write((palm2sleep?"1":"0").getBytes(Charset.forName("UTF-8")));
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean cpu_boost_freq = prefs.getBoolean("cpu_boost_freq", true);
        try {
            Log.d("X9180", "Trying to change cpu_boost_freq value");
            FileOutputStream fos = new FileOutputStream(CPU_BOOST);
            fos.write((cpu_boost_freq?"1":"0").getBytes(Charset.forName("UTF-8")));
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean cpu_boost_cores = prefs.getBoolean("cpu_boost_cores", true);
        try {
            Log.d("X9180", "Trying to change cpu_boost_cores value");
            FileOutputStream fos = new FileOutputStream(INTELLIPLUG_BOOST);
            fos.write((cpu_boost_cores?"1":"0").getBytes(Charset.forName("UTF-8")));
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        context.startService(new Intent(context, X9180DozeService.class));
    }
}
