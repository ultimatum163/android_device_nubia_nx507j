#
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_PACKAGES := $(filter-out BluetoothExt \
    Development \
    Profiles \
    VoicePlus \
    Basic \
    Launcher3 \
    AudioFX \
    CMWallpapers \
    CMFileManager \
    CMUpdater \
    CMAccount \
    CMHome \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers \
    PhotoTable \
    SoundRecorder \
    PhotoPhase \
    LatinIME \
    Stk \
    CellBroadcastReceiver \
    WhisperPush \
    Terminal \
    BasicDreams \
    Calendar \
    CalendarProvider \
    CaptivePortalLogin \
    Email \
    Exchange2 \
    ExternalStorageProvider \
    InputDevices \
    Launcher2 \
    PicoTts \
    PacProcessor \
    PrintSpooler \
    ProxyHandler \
    QuickSearchBox \
    SharedStorageBackup \
    BackupRestoreConfirmation \
    HTMLViewer \
    Shell \
    WAPPushManager \
    Music \
    MusicFX \
    OneTimeInitializer \
    nano, $(PRODUCT_PACKAGES))

