.class public Lorg/deviceinfo/DeviceInfo;
.super Ljava/lang/Object;
.source "DeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/deviceinfo/DeviceInfo$area;
    }
.end annotation


# static fields
.field private static TAG:Ljava/lang/String;

.field private static adid:Ljava/lang/String;

.field private static deviceInfoList:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static isInit:Z

.field private static mActivity:Landroid/app/Activity;

.field private static string2int:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 89
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/deviceinfo/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    .line 90
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    .line 91
    sput-object v1, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 92
    const-string v0, "NDK_INFO"

    sput-object v0, Lorg/deviceinfo/DeviceInfo;->TAG:Ljava/lang/String;

    .line 93
    const/4 v0, 0x0

    sput-boolean v0, Lorg/deviceinfo/DeviceInfo;->isInit:Z

    .line 94
    sput-object v1, Lorg/deviceinfo/DeviceInfo;->adid:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 91
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$1(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 94
    sput-object p0, Lorg/deviceinfo/DeviceInfo;->adid:Ljava/lang/String;

    return-void
.end method

.method public static get(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 153
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_0
    move-object v2, v3

    .line 267
    :cond_1
    :goto_0
    return-object v2

    .line 156
    :cond_2
    sget-object v4, Lorg/deviceinfo/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    invoke-interface {v4, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 157
    .local v2, "value":Ljava/lang/String;
    if-nez v2, :cond_1

    .line 161
    sget-object v4, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    invoke-interface {v4, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 162
    .local v1, "intKey":Ljava/lang/Integer;
    if-nez v1, :cond_3

    move-object v2, v3

    .line 163
    goto :goto_0

    .line 166
    :cond_3
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v4

    packed-switch v4, :pswitch_data_0

    :goto_1
    move-object v2, v3

    .line 267
    goto :goto_0

    .line 168
    :pswitch_0
    const-string v4, "ip"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getIP()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :pswitch_1
    move-object v2, v3

    .line 170
    goto :goto_0

    :pswitch_2
    move-object v2, v3

    .line 172
    goto :goto_0

    .line 174
    :pswitch_3
    const-string v4, "android_id"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAndroidID()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 176
    :pswitch_4
    const-string v4, "model"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getModel()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 178
    :pswitch_5
    const-string v4, "system_name"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSystemName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 180
    :pswitch_6
    const-string v4, "system_version"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSystemVersion()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 182
    :pswitch_7
    const-string v4, "operators"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getOperators()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 184
    :pswitch_8
    const-string v4, "mac"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getMac()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 186
    :pswitch_9
    const-string v4, "app_version"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAppVersionName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 188
    :pswitch_a
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getNetworkType()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 190
    :pswitch_b
    const-string v4, "sim_country"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSimCountry()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 192
    :pswitch_c
    const-string v4, "sim_serial"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSimSerial()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 194
    :pswitch_d
    const-string v4, "wifi_mac"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 196
    :pswitch_e
    const-string v4, "wifi_ssid"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiSSID()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 198
    :pswitch_f
    const-string v4, "country"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCountry()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 200
    :pswitch_10
    const-string v4, "currency_code"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCurrencyCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 202
    :pswitch_11
    const-string v4, "currency_symbol"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCurrencySymbol()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_12
    move-object v2, v3

    .line 204
    goto/16 :goto_0

    :pswitch_13
    move-object v2, v3

    .line 206
    goto/16 :goto_0

    .line 208
    :pswitch_14
    const-string v4, "lanuage"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getLanuage()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 210
    :pswitch_15
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getRamRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 212
    :pswitch_16
    const-string v4, "ram_total"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getRamTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 214
    :pswitch_17
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getRomRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 216
    :pswitch_18
    const-string v4, "rom_total"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getRomTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 218
    :pswitch_19
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSdCardRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 220
    :pswitch_1a
    const-string v4, "sd_card_total"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getSdCardTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 222
    :pswitch_1b
    const-string v4, "resolution"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getResolution()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 224
    :pswitch_1c
    const-string v4, "cpu_core"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCpuCore()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 226
    :pswitch_1d
    const-string v4, "cpu_ghz"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCpuGHZ()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 228
    :pswitch_1e
    const-string v4, "cpu_model"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCpuModel()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 230
    :pswitch_1f
    const-string v4, "cpu_serial"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getCpuSerial()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_20
    move-object v2, v3

    .line 232
    goto/16 :goto_0

    .line 234
    :pswitch_21
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getLongitude()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 236
    :pswitch_22
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getLatitude()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 238
    :pswitch_23
    const-string v4, "android_package_name"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAndroidPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 240
    :pswitch_24
    const-string v4, "app_version_code"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAppVersionCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 242
    :pswitch_25
    const-string v4, "app_version_name"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAppVersionName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_26
    move-object v2, v3

    .line 244
    goto/16 :goto_0

    .line 246
    :pswitch_27
    const-string v4, "device_name"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getDeviceName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 248
    :pswitch_28
    const-string v4, "machine_code"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getMachineCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_29
    move-object v2, v3

    .line 250
    goto/16 :goto_0

    .line 252
    :pswitch_2a
    const-string v4, "wifi_bssid"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiBssid()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 254
    :pswitch_2b
    const-string v4, "adid"

    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getAdid()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/deviceinfo/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_2c
    move-object v2, v3

    .line 256
    goto/16 :goto_0

    .line 258
    :pswitch_2d
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getRamAppUse()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto/16 :goto_0

    .line 262
    :catch_0
    move-exception v0

    .line 263
    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lorg/deviceinfo/DeviceInfo;->TAG:Ljava/lang/String;

    const-string v5, "DeviceInfo get error."

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 264
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto/16 :goto_1

    .line 166
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
        :pswitch_e
        :pswitch_f
        :pswitch_10
        :pswitch_11
        :pswitch_12
        :pswitch_13
        :pswitch_14
        :pswitch_15
        :pswitch_16
        :pswitch_17
        :pswitch_18
        :pswitch_19
        :pswitch_1a
        :pswitch_1b
        :pswitch_1c
        :pswitch_1d
        :pswitch_1e
        :pswitch_1f
        :pswitch_20
        :pswitch_21
        :pswitch_22
        :pswitch_23
        :pswitch_24
        :pswitch_25
        :pswitch_26
        :pswitch_27
        :pswitch_28
        :pswitch_29
        :pswitch_2a
        :pswitch_2b
        :pswitch_2c
        :pswitch_2d
    .end packed-switch
.end method

.method public static getAdid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 764
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->adid:Ljava/lang/String;

    return-object v0
.end method

.method public static getAndroidID()Ljava/lang/String;
    .locals 2

    .prologue
    .line 312
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 313
    const-string v1, "android_id"

    .line 312
    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAndroidPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 707
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAppVersionCode()Ljava/lang/String;
    .locals 4

    .prologue
    .line 714
    :try_start_0
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 715
    sget-object v2, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    .line 714
    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 715
    iget v1, v1, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 714
    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 719
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    return-object v1

    .line 716
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_0
    move-exception v0

    .line 717
    .restart local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 719
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static getAppVersionName()Ljava/lang/String;
    .locals 4

    .prologue
    .line 725
    :try_start_0
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 726
    sget-object v2, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    .line 725
    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 726
    iget-object v1, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 730
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    return-object v1

    .line 727
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_0
    move-exception v0

    .line 728
    .restart local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 730
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static getBrand()Ljava/lang/String;
    .locals 1

    .prologue
    .line 792
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    return-object v0
.end method

.method public static getCountry()Ljava/lang/String;
    .locals 1

    .prologue
    .line 414
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCpuCore()Ljava/lang/String;
    .locals 4

    .prologue
    .line 528
    :try_start_0
    new-instance v0, Ljava/io/File;

    const-string v3, "/sys/devices/system/cpu/"

    invoke-direct {v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 529
    .local v0, "dir":Ljava/io/File;
    new-instance v3, Lorg/deviceinfo/DeviceInfo$1CpuFilter;

    invoke-direct {v3}, Lorg/deviceinfo/DeviceInfo$1CpuFilter;-><init>()V

    invoke-virtual {v0, v3}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v2

    .line 530
    .local v2, "files":[Ljava/io/File;
    array-length v3, v2

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 533
    .end local v2    # "files":[Ljava/io/File;
    :goto_0
    return-object v3

    .line 531
    :catch_0
    move-exception v1

    .line 532
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 533
    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method public static getCpuGHZ()Ljava/lang/String;
    .locals 10

    .prologue
    const/4 v9, 0x0

    .line 541
    const/4 v7, 0x2

    :try_start_0
    new-array v0, v7, [Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "/system/bin/cat"

    aput-object v8, v0, v7

    const/4 v7, 0x1

    .line 542
    const-string v8, "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"

    aput-object v8, v0, v7

    .line 543
    .local v0, "args":[Ljava/lang/String;
    new-instance v1, Ljava/lang/ProcessBuilder;

    invoke-direct {v1, v0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 545
    .local v1, "cmd":Ljava/lang/ProcessBuilder;
    invoke-virtual {v1}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v5

    .line 546
    .local v5, "process":Ljava/lang/Process;
    new-instance v6, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/InputStreamReader;

    .line 547
    invoke-virtual {v5}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    .line 546
    invoke-direct {v6, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 548
    .local v6, "reader":Ljava/io/BufferedReader;
    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    .line 551
    .local v4, "line":Ljava/lang/String;
    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    int-to-float v7, v7

    const v8, 0x49742400    # 1000000.0f

    div-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Float;->toString(F)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v7

    .line 557
    .end local v1    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v4    # "line":Ljava/lang/String;
    .end local v5    # "process":Ljava/lang/Process;
    .end local v6    # "reader":Ljava/io/BufferedReader;
    :goto_0
    return-object v7

    .line 552
    :catch_0
    move-exception v3

    .line 553
    .local v3, "ex":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 557
    .end local v3    # "ex":Ljava/io/IOException;
    :goto_1
    invoke-static {v9}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    goto :goto_0

    .line 554
    :catch_1
    move-exception v2

    .line 555
    .local v2, "e":Ljava/lang/NumberFormatException;
    invoke-virtual {v2}, Ljava/lang/NumberFormatException;->printStackTrace()V

    goto :goto_1
.end method

.method public static getCpuModel()Ljava/lang/String;
    .locals 12

    .prologue
    .line 562
    const-string v8, ""

    .local v8, "strCPU":Ljava/lang/String;
    const/4 v0, 0x0

    .line 563
    .local v0, "cpuAddress":Ljava/lang/String;
    const/4 v4, 0x0

    .line 564
    .local v4, "ir":Ljava/io/InputStreamReader;
    const/4 v2, 0x0

    .line 566
    .local v2, "input":Ljava/io/LineNumberReader;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v9

    const-string v10, "cat /proc/cpuinfo"

    invoke-virtual {v9, v10}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v6

    .line 567
    .local v6, "pp":Ljava/lang/Process;
    new-instance v5, Ljava/io/InputStreamReader;

    invoke-virtual {v6}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v5, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 568
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .local v5, "ir":Ljava/io/InputStreamReader;
    :try_start_1
    new-instance v3, Ljava/io/LineNumberReader;

    invoke-direct {v3, v5}, Ljava/io/LineNumberReader;-><init>(Ljava/io/Reader;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 569
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .local v3, "input":Ljava/io/LineNumberReader;
    :try_start_2
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_5
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result-object v7

    .local v7, "str":Ljava/lang/String;
    :goto_0
    if-nez v7, :cond_2

    .line 581
    :goto_1
    if-eqz v3, :cond_0

    .line 582
    :try_start_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->close()V

    .line 583
    :cond_0
    if-eqz v5, :cond_7

    .line 584
    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .line 591
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :cond_1
    :goto_2
    return-object v0

    .line 571
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :cond_2
    :try_start_4
    const-string v9, "Processor"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    const/4 v10, -0x1

    if-le v9, v10, :cond_3

    .line 572
    const-string v9, ":"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    add-int/lit8 v9, v9, 0x1

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 573
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 574
    goto :goto_1

    .line 570
    :cond_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result-object v7

    .line 569
    goto :goto_0

    .line 577
    .end local v3    # "input":Ljava/io/LineNumberReader;
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :catch_0
    move-exception v1

    .line 578
    .local v1, "ex":Ljava/lang/Exception;
    :goto_3
    :try_start_5
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 581
    if-eqz v2, :cond_4

    .line 582
    :try_start_6
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 583
    :cond_4
    if-eqz v4, :cond_1

    .line 584
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_2

    .line 585
    :catch_1
    move-exception v1

    .line 586
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 587
    const-string v10, "java get cpu reader stream close exception!"

    invoke-virtual {v9, v10}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 588
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 579
    .end local v1    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v9

    .line 581
    :goto_4
    if-eqz v2, :cond_5

    .line 582
    :try_start_7
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 583
    :cond_5
    if-eqz v4, :cond_6

    .line 584
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    .line 590
    :cond_6
    :goto_5
    throw v9

    .line 585
    :catch_2
    move-exception v1

    .line 586
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v10, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 587
    const-string v11, "java get cpu reader stream close exception!"

    invoke-virtual {v10, v11}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 588
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_5

    .line 585
    .end local v1    # "ex":Ljava/lang/Exception;
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :catch_3
    move-exception v1

    .line 586
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 587
    const-string v10, "java get cpu reader stream close exception!"

    invoke-virtual {v9, v10}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 588
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .end local v1    # "ex":Ljava/lang/Exception;
    :cond_7
    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_2

    .line 579
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catchall_1
    move-exception v9

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_4

    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catchall_2
    move-exception v9

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_4

    .line 577
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_4
    move-exception v1

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_3

    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_5
    move-exception v1

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_3
.end method

.method public static getCpuSerial()Ljava/lang/String;
    .locals 12

    .prologue
    .line 596
    const-string v8, ""

    .local v8, "strCPU":Ljava/lang/String;
    const/4 v0, 0x0

    .line 597
    .local v0, "cpuAddress":Ljava/lang/String;
    const/4 v4, 0x0

    .line 598
    .local v4, "ir":Ljava/io/InputStreamReader;
    const/4 v2, 0x0

    .line 600
    .local v2, "input":Ljava/io/LineNumberReader;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v9

    const-string v10, "cat /proc/cpuinfo"

    invoke-virtual {v9, v10}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v6

    .line 601
    .local v6, "pp":Ljava/lang/Process;
    new-instance v5, Ljava/io/InputStreamReader;

    invoke-virtual {v6}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v5, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 602
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .local v5, "ir":Ljava/io/InputStreamReader;
    :try_start_1
    new-instance v3, Ljava/io/LineNumberReader;

    invoke-direct {v3, v5}, Ljava/io/LineNumberReader;-><init>(Ljava/io/Reader;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 603
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .local v3, "input":Ljava/io/LineNumberReader;
    :try_start_2
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_5
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result-object v7

    .local v7, "str":Ljava/lang/String;
    :goto_0
    if-nez v7, :cond_2

    .line 615
    :goto_1
    if-eqz v3, :cond_0

    .line 616
    :try_start_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->close()V

    .line 617
    :cond_0
    if-eqz v5, :cond_7

    .line 618
    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .line 625
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :cond_1
    :goto_2
    return-object v0

    .line 605
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :cond_2
    :try_start_4
    const-string v9, "Serial"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    const/4 v10, -0x1

    if-le v9, v10, :cond_3

    .line 606
    const-string v9, ":"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    add-int/lit8 v9, v9, 0x1

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 607
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 608
    goto :goto_1

    .line 604
    :cond_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result-object v7

    .line 603
    goto :goto_0

    .line 611
    .end local v3    # "input":Ljava/io/LineNumberReader;
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :catch_0
    move-exception v1

    .line 612
    .local v1, "ex":Ljava/lang/Exception;
    :goto_3
    :try_start_5
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 615
    if-eqz v2, :cond_4

    .line 616
    :try_start_6
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 617
    :cond_4
    if-eqz v4, :cond_1

    .line 618
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_2

    .line 619
    :catch_1
    move-exception v1

    .line 620
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 621
    const-string v10, "java get cpu reader stream close exception!"

    invoke-virtual {v9, v10}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 622
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 613
    .end local v1    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v9

    .line 615
    :goto_4
    if-eqz v2, :cond_5

    .line 616
    :try_start_7
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 617
    :cond_5
    if-eqz v4, :cond_6

    .line 618
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    .line 624
    :cond_6
    :goto_5
    throw v9

    .line 619
    :catch_2
    move-exception v1

    .line 620
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v10, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 621
    const-string v11, "java get cpu reader stream close exception!"

    invoke-virtual {v10, v11}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 622
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_5

    .line 619
    .end local v1    # "ex":Ljava/lang/Exception;
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :catch_3
    move-exception v1

    .line 620
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    .line 621
    const-string v10, "java get cpu reader stream close exception!"

    invoke-virtual {v9, v10}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 622
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .end local v1    # "ex":Ljava/lang/Exception;
    :cond_7
    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_2

    .line 613
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catchall_1
    move-exception v9

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_4

    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catchall_2
    move-exception v9

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_4

    .line 611
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_4
    move-exception v1

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_3

    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_5
    move-exception v1

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto :goto_3
.end method

.method public static getCurrencyCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 419
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Currency;->getInstance(Ljava/util/Locale;)Ljava/util/Currency;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Currency;->getCurrencyCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCurrencySymbol()Ljava/lang/String;
    .locals 1

    .prologue
    .line 424
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Currency;->getInstance(Ljava/util/Locale;)Ljava/util/Currency;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Currency;->getSymbol()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getDeviceName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 735
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getModel()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getIP()Ljava/lang/String;
    .locals 11

    .prologue
    .line 281
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v7

    invoke-virtual {v7}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v6

    .line 282
    .local v6, "wifiInfo":Landroid/net/wifi/WifiInfo;
    invoke-virtual {v6}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 283
    .local v3, "ipAddress":Ljava/lang/Integer;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v7

    if-eqz v7, :cond_0

    .line 284
    const-string v7, "%d.%d.%d.%d"

    const/4 v8, 0x4

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v10

    and-int/lit16 v10, v10, 0xff

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x1

    .line 285
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v10

    shr-int/lit8 v10, v10, 0x8

    and-int/lit16 v10, v10, 0xff

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x2

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v10

    shr-int/lit8 v10, v10, 0x10

    and-int/lit16 v10, v10, 0xff

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x3

    .line 286
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v10

    shr-int/lit8 v10, v10, 0x18

    and-int/lit16 v10, v10, 0xff

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    .line 284
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 307
    :goto_0
    return-object v7

    .line 290
    :cond_0
    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v5

    .line 291
    .local v5, "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_1
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v7

    if-nez v7, :cond_2

    .line 307
    .end local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :goto_1
    const/4 v7, 0x0

    goto :goto_0

    .line 292
    .restart local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_2
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/net/NetworkInterface;

    .line 293
    .local v4, "networkInterface":Ljava/net/NetworkInterface;
    invoke-virtual {v4}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v2

    .line 294
    .local v2, "inetAddressEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :cond_3
    invoke-interface {v2}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 295
    invoke-interface {v2}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/InetAddress;

    .line 296
    .local v1, "inetAddress":Ljava/net/InetAddress;
    invoke-virtual {v1}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v7

    if-nez v7, :cond_3

    .line 297
    invoke-virtual {v1}, Ljava/net/InetAddress;->isLinkLocalAddress()Z

    move-result v7

    if-nez v7, :cond_3

    .line 298
    invoke-virtual {v1}, Ljava/net/InetAddress;->isSiteLocalAddress()Z

    move-result v7

    if-eqz v7, :cond_3

    .line 299
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    goto :goto_0

    .line 303
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    .end local v2    # "inetAddressEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    .end local v4    # "networkInterface":Ljava/net/NetworkInterface;
    .end local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :catch_0
    move-exception v0

    .line 304
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1
.end method

.method public static getLanuage()Ljava/lang/String;
    .locals 1

    .prologue
    .line 429
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getLatitude()Ljava/lang/String;
    .locals 2

    .prologue
    .line 645
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getlocation()Lorg/deviceinfo/DeviceInfo$area;

    move-result-object v0

    iget-wide v0, v0, Lorg/deviceinfo/DeviceInfo$area;->mLatitude:D

    invoke-static {v0, v1}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getLongitude()Ljava/lang/String;
    .locals 2

    .prologue
    .line 640
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getlocation()Lorg/deviceinfo/DeviceInfo$area;

    move-result-object v0

    iget-wide v0, v0, Lorg/deviceinfo/DeviceInfo$area;->mLongitude:D

    invoke-static {v0, v1}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMac()Ljava/lang/String;
    .locals 1

    .prologue
    .line 339
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMachineCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 740
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getModel()Ljava/lang/String;
    .locals 1

    .prologue
    .line 318
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0
.end method

.method public static getNetworkType()Ljava/lang/String;
    .locals 6

    .prologue
    .line 344
    sget-object v4, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 345
    const-string v5, "connectivity"

    invoke-virtual {v4, v5}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 344
    check-cast v0, Landroid/net/ConnectivityManager;

    .line 347
    .local v0, "connectMgr":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 348
    .local v1, "info":Landroid/net/NetworkInfo;
    if-nez v1, :cond_0

    .line 349
    const-string v4, "UNKNOWN"

    .line 381
    :goto_0
    return-object v4

    .line 350
    :cond_0
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    .line 351
    .local v3, "type":I
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v2

    .line 353
    .local v2, "subtype":I
    const/4 v4, 0x1

    if-ne v3, v4, :cond_1

    .line 354
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "CONNECTED VIA WIFI"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 355
    const-string v4, "WIFI"

    goto :goto_0

    .line 356
    :cond_1
    if-nez v3, :cond_2

    .line 357
    packed-switch v2, :pswitch_data_0

    .line 377
    const-string v4, "UNKNOWN"

    goto :goto_0

    .line 363
    :pswitch_0
    const-string v4, "2G"

    goto :goto_0

    .line 373
    :pswitch_1
    const-string v4, "3G"

    goto :goto_0

    .line 375
    :pswitch_2
    const-string v4, "4G"

    goto :goto_0

    .line 381
    :cond_2
    const-string v4, "UNKNOWN"

    goto :goto_0

    .line 357
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method public static getOperators()Ljava/lang/String;
    .locals 1

    .prologue
    .line 334
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimOperatorName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getRamAppUse()Ljava/lang/String;
    .locals 3

    .prologue
    .line 770
    :try_start_0
    new-instance v1, Landroid/os/Debug$MemoryInfo;

    invoke-direct {v1}, Landroid/os/Debug$MemoryInfo;-><init>()V

    .line 771
    .local v1, "info":Landroid/os/Debug$MemoryInfo;
    invoke-static {v1}, Landroid/os/Debug;->getMemoryInfo(Landroid/os/Debug$MemoryInfo;)V

    .line 772
    invoke-virtual {v1}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 777
    :goto_0
    return-object v2

    .line 773
    :catch_0
    move-exception v0

    .line 774
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 777
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static getRamRem()Ljava/lang/String;
    .locals 6

    .prologue
    const-wide/16 v4, 0x400

    .line 434
    sget-object v2, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 435
    const-string v3, "activity"

    invoke-virtual {v2, v3}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 434
    check-cast v1, Landroid/app/ActivityManager;

    .line 436
    .local v1, "myActivityManager":Landroid/app/ActivityManager;
    new-instance v0, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v0}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    .line 437
    .local v0, "memoryInfo":Landroid/app/ActivityManager$MemoryInfo;
    invoke-virtual {v1, v0}, Landroid/app/ActivityManager;->getMemoryInfo(Landroid/app/ActivityManager$MemoryInfo;)V

    .line 438
    iget-wide v2, v0, Landroid/app/ActivityManager$MemoryInfo;->availMem:J

    div-long/2addr v2, v4

    div-long/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public static getRamTotal()Ljava/lang/String;
    .locals 12

    .prologue
    .line 443
    const-wide/16 v6, -0x1

    .line 444
    .local v6, "memtotal":J
    const/4 v3, 0x0

    .line 445
    .local v3, "fr":Ljava/io/FileReader;
    const/4 v5, 0x0

    .line 448
    .local v5, "reader":Ljava/io/BufferedReader;
    :try_start_0
    new-instance v4, Ljava/io/FileReader;

    const-string v10, "/proc/meminfo"

    invoke-direct {v4, v10}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 449
    .end local v3    # "fr":Ljava/io/FileReader;
    .local v4, "fr":Ljava/io/FileReader;
    if-eqz v4, :cond_3

    .line 450
    :try_start_1
    new-instance v8, Ljava/io/BufferedReader;

    const/16 v10, 0x2000

    invoke-direct {v8, v4, v10}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    .line 451
    .end local v5    # "reader":Ljava/io/BufferedReader;
    .local v8, "reader":Ljava/io/BufferedReader;
    if-eqz v8, :cond_2

    .line 452
    const/4 v9, 0x0

    .line 453
    .local v9, "str":Ljava/lang/String;
    :try_start_2
    invoke-virtual {v8}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v9

    .line 454
    const-string v10, "\\s+"

    invoke-virtual {v9, v10}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 455
    .local v0, "arrayOfString":[Ljava/lang/String;
    const/4 v10, 0x1

    aget-object v10, v0, v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->longValue()J
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3

    move-result-wide v6

    move-object v5, v8

    .end local v8    # "reader":Ljava/io/BufferedReader;
    .restart local v5    # "reader":Ljava/io/BufferedReader;
    move-object v3, v4

    .line 470
    .end local v0    # "arrayOfString":[Ljava/lang/String;
    .end local v4    # "fr":Ljava/io/FileReader;
    .end local v9    # "str":Ljava/lang/String;
    .restart local v3    # "fr":Ljava/io/FileReader;
    :cond_0
    :goto_0
    const-wide/16 v10, 0x400

    div-long v10, v6, v10

    invoke-static {v10, v11}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v10

    return-object v10

    .line 458
    :catch_0
    move-exception v1

    .line 459
    .local v1, "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 461
    if-eqz v5, :cond_1

    .line 462
    :try_start_3
    invoke-virtual {v5}, Ljava/io/BufferedReader;->close()V

    .line 463
    :cond_1
    if-eqz v3, :cond_0

    .line 464
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 465
    :catch_1
    move-exception v2

    .line 466
    .local v2, "ex":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 458
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "ex":Ljava/lang/Exception;
    .end local v3    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    :catch_2
    move-exception v1

    move-object v3, v4

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v3    # "fr":Ljava/io/FileReader;
    goto :goto_1

    .end local v3    # "fr":Ljava/io/FileReader;
    .end local v5    # "reader":Ljava/io/BufferedReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    .restart local v8    # "reader":Ljava/io/BufferedReader;
    .restart local v9    # "str":Ljava/lang/String;
    :catch_3
    move-exception v1

    move-object v5, v8

    .end local v8    # "reader":Ljava/io/BufferedReader;
    .restart local v5    # "reader":Ljava/io/BufferedReader;
    move-object v3, v4

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v3    # "fr":Ljava/io/FileReader;
    goto :goto_1

    .end local v3    # "fr":Ljava/io/FileReader;
    .end local v5    # "reader":Ljava/io/BufferedReader;
    .end local v9    # "str":Ljava/lang/String;
    .restart local v4    # "fr":Ljava/io/FileReader;
    .restart local v8    # "reader":Ljava/io/BufferedReader;
    :cond_2
    move-object v5, v8

    .end local v8    # "reader":Ljava/io/BufferedReader;
    .restart local v5    # "reader":Ljava/io/BufferedReader;
    move-object v3, v4

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v3    # "fr":Ljava/io/FileReader;
    goto :goto_0

    .end local v3    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    :cond_3
    move-object v3, v4

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v3    # "fr":Ljava/io/FileReader;
    goto :goto_0
.end method

.method public static getResolution()Ljava/lang/String;
    .locals 3

    .prologue
    .line 511
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 512
    .local v0, "display":Landroid/view/Display;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getRomRem()Ljava/lang/String;
    .locals 10

    .prologue
    const-wide/16 v8, 0x400

    .line 475
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v4

    .line 476
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 477
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 478
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 479
    .local v0, "availableBlocks":J
    mul-long v6, v0, v2

    div-long/2addr v6, v8

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method

.method public static getRomTotal()Ljava/lang/String;
    .locals 10

    .prologue
    const-wide/16 v8, 0x400

    .line 484
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v2

    .line 485
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 486
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 487
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 488
    .local v4, "totalBlocks":J
    mul-long v6, v4, v0

    div-long/2addr v6, v8

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method

.method public static getSdCardRem()Ljava/lang/String;
    .locals 10

    .prologue
    const-wide/16 v8, 0x400

    .line 493
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    .line 494
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 495
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 496
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 497
    .local v0, "availableBlocks":J
    mul-long v6, v0, v2

    div-long/2addr v6, v8

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method

.method public static getSdCardTotal()Ljava/lang/String;
    .locals 10

    .prologue
    const-wide/16 v8, 0x400

    .line 502
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    .line 503
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 504
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 505
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 506
    .local v4, "totalBlocks":J
    mul-long v6, v4, v0

    div-long/2addr v6, v8

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method

.method public static getSimCountry()Ljava/lang/String;
    .locals 1

    .prologue
    .line 386
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSimSerial()Ljava/lang/String;
    .locals 1

    .prologue
    .line 391
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSystemName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 323
    const-string v0, "Android"

    return-object v0
.end method

.method public static getSystemVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 328
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 329
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 328
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getTelephonyManager()Landroid/telephony/TelephonyManager;
    .locals 2

    .prologue
    .line 782
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 783
    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 782
    check-cast v0, Landroid/telephony/TelephonyManager;

    return-object v0
.end method

.method public static getWifiBssid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 745
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getWifiMac()Ljava/lang/String;
    .locals 2

    .prologue
    .line 396
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 397
    .local v0, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-eqz v0, :cond_0

    .line 398
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getBSSID()Ljava/lang/String;

    move-result-object v1

    .line 400
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private static getWifiManager()Landroid/net/wifi/WifiManager;
    .locals 2

    .prologue
    .line 787
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 788
    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 787
    check-cast v0, Landroid/net/wifi/WifiManager;

    return-object v0
.end method

.method public static getWifiSSID()Ljava/lang/String;
    .locals 2

    .prologue
    .line 405
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 406
    .local v0, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-eqz v0, :cond_0

    .line 407
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v1

    .line 409
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private static getlocation()Lorg/deviceinfo/DeviceInfo$area;
    .locals 12

    .prologue
    .line 649
    const-wide/16 v8, 0x0

    .line 650
    .local v8, "latitude":D
    const-wide/16 v10, 0x0

    .line 653
    .local v10, "longitude":D
    :try_start_0
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 654
    const-string v2, "location"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 653
    check-cast v0, Landroid/location/LocationManager;

    .line 655
    .local v0, "locationManager":Landroid/location/LocationManager;
    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 657
    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v7

    .line 658
    .local v7, "location":Landroid/location/Location;
    if-eqz v7, :cond_0

    .line 659
    invoke-virtual {v7}, Landroid/location/Location;->getLatitude()D

    move-result-wide v8

    .line 660
    invoke-virtual {v7}, Landroid/location/Location;->getLongitude()D
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v10

    .line 702
    .end local v0    # "locationManager":Landroid/location/LocationManager;
    .end local v7    # "location":Landroid/location/Location;
    :cond_0
    :goto_0
    new-instance v1, Lorg/deviceinfo/DeviceInfo$area;

    invoke-direct {v1, v8, v9, v10, v11}, Lorg/deviceinfo/DeviceInfo$area;-><init>(DD)V

    return-object v1

    .line 663
    .restart local v0    # "locationManager":Landroid/location/LocationManager;
    :cond_1
    :try_start_1
    new-instance v5, Lorg/deviceinfo/DeviceInfo$1;

    invoke-direct {v5}, Lorg/deviceinfo/DeviceInfo$1;-><init>()V

    .line 688
    .local v5, "locationListener":Landroid/location/LocationListener;
    const-string v1, "network"

    const-wide/16 v2, 0x3e8

    const/4 v4, 0x0

    .line 687
    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 691
    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v7

    .line 692
    .restart local v7    # "location":Landroid/location/Location;
    if-eqz v7, :cond_0

    .line 693
    invoke-virtual {v7}, Landroid/location/Location;->getLatitude()D

    move-result-wide v8

    .line 694
    invoke-virtual {v7}, Landroid/location/Location;->getLongitude()D
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-wide v10

    goto :goto_0

    .line 697
    .end local v0    # "locationManager":Landroid/location/LocationManager;
    .end local v5    # "locationListener":Landroid/location/LocationListener;
    .end local v7    # "location":Landroid/location/Location;
    :catch_0
    move-exception v6

    .line 698
    .local v6, "e":Ljava/lang/Exception;
    invoke-virtual {v6}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 4
    .param p0, "ctx"    # Landroid/app/Activity;

    .prologue
    .line 97
    sget-boolean v1, Lorg/deviceinfo/DeviceInfo;->isInit:Z

    if-eqz v1, :cond_0

    .line 150
    :goto_0
    return-void

    .line 100
    :cond_0
    const/4 v1, 0x1

    sput-boolean v1, Lorg/deviceinfo/DeviceInfo;->isInit:Z

    .line 101
    sput-object p0, Lorg/deviceinfo/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 102
    invoke-static {}, Lorg/deviceinfo/DeviceInfo;->initAdid()V

    .line 103
    const/4 v0, 0x0

    .line 104
    .local v0, "count":I
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ip"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "idfv"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 106
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "idfa"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 107
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "android_id"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 108
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "model"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 109
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "system_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "system_version"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "operators"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 112
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "mac"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 113
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 114
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "network"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 115
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sim_country"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sim_serial"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 117
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_mac"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 118
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_ssid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 119
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "country"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 120
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "currency_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 121
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "currency_symbol"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 122
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_bundle_id"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_build"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 124
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "lanuage"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 125
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 126
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 127
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "rom_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "rom_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sd_card_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sd_card_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 131
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "resolution"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_core"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_ghz"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 134
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_model"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 135
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_serial"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 136
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_type"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 137
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "longitude"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 138
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "latitude"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 139
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "android_package_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 142
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "area"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 143
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "device_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 144
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "machine_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 145
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "phone_number"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 146
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_bssid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 147
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "adid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 148
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "open_udid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 149
    sget-object v1, Lorg/deviceinfo/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_app_use"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0
.end method

.method private static initAdid()V
    .locals 2

    .prologue
    .line 750
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lorg/deviceinfo/DeviceInfo$2;

    invoke-direct {v1}, Lorg/deviceinfo/DeviceInfo$2;-><init>()V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 761
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 762
    return-void
.end method

.method private static saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 271
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 272
    sget-object v0, Lorg/deviceinfo/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 275
    .end local p1    # "value":Ljava/lang/String;
    :goto_0
    return-object p1

    .restart local p1    # "value":Ljava/lang/String;
    :cond_0
    const/4 p1, 0x0

    goto :goto_0
.end method
