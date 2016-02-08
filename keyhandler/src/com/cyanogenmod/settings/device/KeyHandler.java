/*
 * Copyright (C) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.app.ActivityManagerNative;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.SystemClock;
import android.provider.Settings;
import android.text.TextUtils;
import android.view.KeyEvent;

import cyanogenmod.providers.CMSettings;

import com.android.internal.os.DeviceKeyHandler;
import com.android.internal.widget.LockPatternUtils;

public class KeyHandler implements DeviceKeyHandler {

    private static final String TAG = KeyHandler.class.getSimpleName();
    private static final int GESTURE_REQUEST = 1;

    // Supported scancodes
    private static final int KEY_DOUBLE_TAP = 68;

    private Intent mPendingIntent;
    private LockPatternUtils mLockPatternUtils;
    private final Context mContext;
    private final PowerManager mPowerManager;
    private Handler mHandler;
    private SensorManager mSensorManager;
    private Sensor mProximitySensor;
    WakeLock mProximityWakeLock;
    private int mProximityTimeOut;
    private boolean mProximityWakeSupported;

    public KeyHandler(Context context) {
        mContext = context;
        mPowerManager = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        mLockPatternUtils = new LockPatternUtils(context);

        IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_USER_PRESENT);
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        context.registerReceiver(mReceiver, filter);
        mHandler = new Handler();

        final Resources resources = mContext.getResources();
        mProximityTimeOut = resources.getInteger(
                org.cyanogenmod.platform.internal.R.integer.config_proximityCheckTimeout);
        mProximityWakeSupported = resources.getBoolean(
                org.cyanogenmod.platform.internal.R.bool.config_proximityCheckOnWake);

        if (mProximityWakeSupported) {
            mSensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
            mProximitySensor = mSensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY);
            mProximityWakeLock = mPowerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
                    "ProximityWakeLock");
        }
    }

    private BroadcastReceiver mReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null) {
                return;
            }
            String action = intent.getAction();
            if (TextUtils.equals(action, Intent.ACTION_USER_PRESENT)) {
                if (mPendingIntent != null) {
                    try {
                        mContext.startActivity(mPendingIntent);
                    } catch (ActivityNotFoundException e) {
                    }
                    mPendingIntent = null;
                }
            } else if (TextUtils.equals(action, Intent.ACTION_SCREEN_OFF)) {
                mPendingIntent = null;
            }
        }
    };

    public boolean handleKeyEvent(KeyEvent event) {
        if (event.getAction() != KeyEvent.ACTION_UP) {
            return false;
        }
        boolean isKeySupported = (event.getScanCode() == KEY_DOUBLE_TAP);
        if (isKeySupported) {
            if (event.getScanCode() == KEY_DOUBLE_TAP && !mPowerManager.isScreenOn()) {
                mPowerManager.wakeUpWithProximityCheck(SystemClock.uptimeMillis(), "wakeup-gesture-proximity");
                return true;
            }
            Message msg = getMessageForKeyEvent(event);
            boolean defaultProximity = mContext.getResources().getBoolean(
                org.cyanogenmod.platform.internal.R.bool.config_proximityCheckOnWakeEnabledByDefault);
            boolean proximityWakeCheckEnabled = CMSettings.System.getInt(mContext.getContentResolver(),
                    CMSettings.System.PROXIMITY_ON_WAKE, defaultProximity ? 1 : 0) == 1;
            if (mProximityWakeSupported && proximityWakeCheckEnabled && mProximitySensor != null) {
                mHandler.sendMessageDelayed(msg, mProximityTimeOut);
                processEvent(event);
            } else {
                mHandler.sendMessage(msg);
            }
        }
        return isKeySupported;
    }

    private Message getMessageForKeyEvent(KeyEvent keyEvent) {
        Message msg = mHandler.obtainMessage(GESTURE_REQUEST);
        msg.obj = keyEvent;
        return msg;
    }

    private void processEvent(final KeyEvent keyEvent) {
        mProximityWakeLock.acquire();
        mSensorManager.registerListener(new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent event) {
                mProximityWakeLock.release();
                mSensorManager.unregisterListener(this);
                if (!mHandler.hasMessages(GESTURE_REQUEST)) {
                    // The sensor took to long, ignoring.
                    return;
                }
                mHandler.removeMessages(GESTURE_REQUEST);
                if (event.values[0] == mProximitySensor.getMaximumRange()) {
                    Message msg = getMessageForKeyEvent(keyEvent);
                    mHandler.sendMessage(msg);
                }
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int accuracy) {}

        }, mProximitySensor, SensorManager.SENSOR_DELAY_FASTEST);
    }

}
