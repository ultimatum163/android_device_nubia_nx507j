package com.cyanogenmod.settings.device;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.SystemProperties;
import android.preference.SwitchPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Arrays;

/**
 * Created by prodoomman on 19.02.15.
 */
public class SettingsFragment extends PreferenceFragment implements Preference.OnPreferenceChangeListener {
    final String CHARGE_LEVELS_FILE = "/sys/kernel/fast_charge/available_charge_levels";
    final String CHARGE_LEVEL_FILE = "/sys/kernel/fast_charge/fast_charge_level";
    final String FAST_CHARGE_FILE = "/sys/kernel/fast_charge/force_fast_charge";

    final String PALM2SLEEP_FILE = "/sys/devices/f9927000.i2c/i2c-5/5-005d/palm2sleep";
    final String KEYS_ARRAY_FILE = "/sys/devices/f9927000.i2c/i2c-5/5-005d/touch_key_array";

    final String CPU_GOVS_LIST = "/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors";

    final String CPU_BOOST = "/sys/module/cpu_boost/parameters/cpu_boost";
    final String INTELLIPLUG_BOOST = "/sys/module/intelli_plug/parameters/touch_boost_active";

    ListPreference charge_level;
    SwitchPreference fast_charge;
    SwitchPreference palm2sleep;

    private class SysfsValue {
        private String fileName;
        private String value;

        private SysfsValue(String fileName, String value) {
            this.fileName = fileName;
            this.value = value;
        }

        public String getFileName() {
            return fileName;
        }

        public String getValue() {
            return value;
        }
    }

    class SysfsWriteTask extends AsyncTask<SysfsValue, Void, Integer> {

        @Override
        protected Integer doInBackground(SysfsValue... params) {
            try {
                FileOutputStream fos = new FileOutputStream(params[0].getFileName());
                fos.write(params[0].getValue().getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
            return 0;
        }

        @Override
        protected void onPostExecute(Integer result) {
            if(0 != result) {
                Toast.makeText(getActivity(), R.string.fail, Toast.LENGTH_SHORT).show();
            }
        }
    }

    class FastChargeTask extends AsyncTask<String, Void, Integer> {

        @Override
        protected Integer doInBackground(String... params) {
            String fast_charge_data;
            String fast_charge_value_data;
            if(params[0]==null) {
                fast_charge_data = "0";
                fast_charge_value_data = null;
            } else if("0".equals(params[0])) {
                fast_charge_data = "1";
                fast_charge_value_data = null;
            } else {
                fast_charge_data = "2";
                fast_charge_value_data = params[0];
            }
            try {
                FileOutputStream fos = new FileOutputStream(FAST_CHARGE_FILE);
                fos.write(fast_charge_data.getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
            if(fast_charge_value_data != null) try {
                FileOutputStream fos = new FileOutputStream(CHARGE_LEVEL_FILE);
                fos.write(fast_charge_value_data.getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
            return 0;
        }

        @Override
        protected void onPostExecute(Integer result) {
            if(0 != result) {
                Toast.makeText(getActivity(), R.string.fail, Toast.LENGTH_SHORT).show();
            }
        }
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_x9180);

        ListPreference main_storage = (ListPreference)findPreference("main_storage");
        main_storage.setOnPreferenceChangeListener(this);

        ListPreference keys_order = (ListPreference)findPreference("keys_order");
        keys_order.setOnPreferenceChangeListener(this);

        ListPreference zram_size = (ListPreference)findPreference("zram_size");
        zram_size.setOnPreferenceChangeListener(this);

        ListPreference cpugov_balanced = (ListPreference)findPreference("cpugov_balanced");
        cpugov_balanced.setOnPreferenceChangeListener(this);

        ListPreference cpugov_powersave = (ListPreference)findPreference("cpugov_powersave");
        cpugov_powersave.setOnPreferenceChangeListener(this);

        fast_charge = (SwitchPreference)findPreference("fast_charge");
        fast_charge.setOnPreferenceChangeListener(this);

        palm2sleep = (SwitchPreference)findPreference("palm2sleep");
        palm2sleep.setOnPreferenceChangeListener(this);

        SwitchPreference cpuboost = (SwitchPreference)findPreference("cpu_boost_freq");
        cpuboost.setOnPreferenceChangeListener(this);

        SwitchPreference intelliplug_boost = (SwitchPreference)findPreference("cpu_boost_cores");
        intelliplug_boost.setOnPreferenceChangeListener(this);

        int planned_swap = SystemProperties.getInt("persist.storages.planned_swap", 0);
        int zram_planned_size = SystemProperties.getInt("persist.zram.planned_size", 128);
        main_storage.setValue(String.valueOf(planned_swap));
        zram_size.setValue(String.valueOf(zram_planned_size));

        charge_level = (ListPreference)findPreference("fast_charge_level");
        charge_level.setOnPreferenceChangeListener(this);

        {   // read avaliable cpu governors
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(CPU_GOVS_LIST));
                String line = br.readLine();

                if (line != null) {
                    String[] levels = line.split(" ");
                    cpugov_balanced.setEntries(levels);
                    cpugov_balanced.setEntryValues(levels);
                    cpugov_powersave.setEntries(levels);
                    cpugov_powersave.setEntryValues(levels);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
            cpugov_balanced.setValue(SystemProperties.get("persist.cpu.gov.balanced", "interactive"));
            cpugov_powersave.setValue(SystemProperties.get("persist.cpu.gov.powersave", "smartmax"));
        }

        {   // read avaliable fast charge levels
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(CHARGE_LEVELS_FILE));
                String line = br.readLine();

                if (line != null) {
                    String[] levels = line.split(" ");

                    String[] names = new String[levels.length + 1];
                    System.arraycopy(levels, 0, names, 1, levels.length);
                    names[0] = getResources().getStringArray(R.array.chargelevel_names)[0];

                    String[] values = new String[levels.length + 1];
                    System.arraycopy(levels, 0, values, 1, levels.length);
                    values[0] = getResources().getStringArray(R.array.chargelevel_values)[0];

                    charge_level.setEntries(names);
                    charge_level.setEntryValues(values);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }

        boolean fast_charge_custom_level = false;

        {
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(FAST_CHARGE_FILE));
                String line = br.readLine().trim();

                if (line != null) {
                    if("1".equals(line)) {
                        fast_charge.setChecked(true);
                        charge_level.setValue("0");
                    } else if("2".equals(line)) {
                        fast_charge.setChecked(true);
                        fast_charge_custom_level = true;
                    } else {
                        fast_charge.setChecked(false);
                        charge_level.setValue("0");
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }

        if(fast_charge_custom_level) {
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(CHARGE_LEVEL_FILE));
                String line = br.readLine().trim();

                if (line != null) {
                    charge_level.setValue(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }

        {
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(PALM2SLEEP_FILE));
                String line = br.readLine().trim();

                if (line != null) {
                    palm2sleep.setChecked("0x01".equals(line));
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }

        {
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(CPU_BOOST));
                String line = br.readLine().trim();

                if (line != null) {
                    cpuboost.setChecked("1".equals(line));
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }

        {
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(INTELLIPLUG_BOOST));
                String line = br.readLine().trim();

                if (line != null) {
                    intelliplug_boost.setChecked("1".equals(line));
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (br != null)
                    try {
                        br.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue)
    {
        switch(preference.getKey()) {
            case "main_storage":
                SystemProperties.set("persist.storages.planned_swap", (String) newValue);
                Toast.makeText(getActivity(), R.string.reboot_needed, Toast.LENGTH_LONG).show();
                break;
            case "zram_size":
                SystemProperties.set("persist.zram.planned_size", (String) newValue);
                Toast.makeText(getActivity(), R.string.reboot_needed, Toast.LENGTH_LONG).show();
                break;
            case "keys_order":
                new SysfsWriteTask().execute(new SysfsValue(KEYS_ARRAY_FILE,
                        "0".equals((String)newValue)?"139 172 158\n":"158 172 139\n"));
                break;
            case "fast_charge":
                String fast_charge_level = charge_level.getValue();
                new FastChargeTask().execute((!(Boolean)newValue)?null:fast_charge_level);
                break;
            case "fast_charge_level":
                boolean fast_charge_value = fast_charge.isChecked();
                new FastChargeTask().execute(!fast_charge_value?null:(String)newValue);
                break;
            case "palm2sleep":
                new SysfsWriteTask().execute(new SysfsValue(PALM2SLEEP_FILE,
                        ((Boolean)newValue)?"1":"0"));
                break;
            case "cpu_boost_freq":
                new SysfsWriteTask().execute(new SysfsValue(CPU_BOOST,
                        ((Boolean)newValue)?"1":"0"));
                break;
            case "cpu_boost_cores":
                new SysfsWriteTask().execute(new SysfsValue(INTELLIPLUG_BOOST,
                        ((Boolean)newValue)?"1":"0"));
                break;
            case "cpugov_balanced":
                SystemProperties.set("persist.cpu.gov.balanced", (String) newValue);
                SystemProperties.set("sys.perf.profile", SystemProperties.get("sys.perf.profile"));
                break;
            case "cpugov_powersave":
                SystemProperties.set("persist.cpu.gov.powersave", (String) newValue);
                SystemProperties.set("sys.perf.profile", SystemProperties.get("sys.perf.profile"));
                break;
            default:
                break;
        }
        return true;
    }
}
