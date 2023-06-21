.class public Lcom/digitalsky/sdk/sanalyze/DeviceInfo;
.super Ljava/lang/Object;
.source "DeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;
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
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 87
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    .line 88
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    .line 89
    sput-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 90
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    .line 91
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->isInit:Z

    .line 92
    sput-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->adid:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static get(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 151
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_0
    move-object v2, v3

    .line 265
    :cond_1
    :goto_0
    return-object v2

    .line 154
    :cond_2
    sget-object v4, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    invoke-interface {v4, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 155
    .local v2, "value":Ljava/lang/String;
    if-nez v2, :cond_1

    .line 159
    sget-object v4, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    invoke-interface {v4, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 160
    .local v1, "intKey":Ljava/lang/Integer;
    if-nez v1, :cond_3

    move-object v2, v3

    .line 161
    goto :goto_0

    .line 164
    :cond_3
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v4

    packed-switch v4, :pswitch_data_0

    :goto_1
    move-object v2, v3

    .line 265
    goto :goto_0

    .line 166
    :pswitch_0
    const-string v4, "ip"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getIP()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :pswitch_1
    move-object v2, v3

    .line 168
    goto :goto_0

    :pswitch_2
    move-object v2, v3

    .line 170
    goto :goto_0

    .line 172
    :pswitch_3
    const-string v4, "android_id"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAndroidID()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 174
    :pswitch_4
    const-string v4, "model"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getModel()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 176
    :pswitch_5
    const-string v4, "system_name"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSystemName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 178
    :pswitch_6
    const-string v4, "system_version"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSystemVersion()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 180
    :pswitch_7
    const-string v4, "operators"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getOperators()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 182
    :pswitch_8
    const-string v4, "mac"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getMac()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 184
    :pswitch_9
    const-string v4, "app_version"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAppVersionName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 186
    :pswitch_a
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getNetworkType()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 188
    :pswitch_b
    const-string v4, "sim_country"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSimCountry()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 190
    :pswitch_c
    const-string v4, "sim_serial"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSimSerial()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 192
    :pswitch_d
    const-string v4, "wifi_mac"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 194
    :pswitch_e
    const-string v4, "wifi_ssid"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiSSID()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 196
    :pswitch_f
    const-string v4, "country"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCountry()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 198
    :pswitch_10
    const-string v4, "currency_code"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCurrencyCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 200
    :pswitch_11
    const-string v4, "currency_symbol"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCurrencySymbol()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_12
    move-object v2, v3

    .line 202
    goto/16 :goto_0

    :pswitch_13
    move-object v2, v3

    .line 204
    goto/16 :goto_0

    .line 206
    :pswitch_14
    const-string v4, "lanuage"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getLanuage()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 208
    :pswitch_15
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getRamRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 210
    :pswitch_16
    const-string v4, "ram_total"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getRamTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 212
    :pswitch_17
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getRomRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 214
    :pswitch_18
    const-string v4, "rom_total"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getRomTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 216
    :pswitch_19
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSdCardRem()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 218
    :pswitch_1a
    const-string v4, "sd_card_total"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getSdCardTotal()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 220
    :pswitch_1b
    const-string v4, "resolution"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getResolution()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 222
    :pswitch_1c
    const-string v4, "cpu_core"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCpuCore()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 224
    :pswitch_1d
    const-string v4, "cpu_ghz"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCpuGHZ()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 226
    :pswitch_1e
    const-string v4, "cpu_model"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCpuModel()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 228
    :pswitch_1f
    const-string v4, "cpu_serial"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getCpuSerial()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_20
    move-object v2, v3

    .line 230
    goto/16 :goto_0

    .line 232
    :pswitch_21
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getLongitude()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 234
    :pswitch_22
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getLatitude()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 236
    :pswitch_23
    const-string v4, "android_package_name"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAndroidPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 238
    :pswitch_24
    const-string v4, "app_version_code"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAppVersionCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 240
    :pswitch_25
    const-string v4, "app_version_name"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAppVersionName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_26
    move-object v2, v3

    .line 242
    goto/16 :goto_0

    .line 244
    :pswitch_27
    const-string v4, "device_name"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getDeviceName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 246
    :pswitch_28
    const-string v4, "machine_code"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getMachineCode()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_29
    move-object v2, v3

    .line 248
    goto/16 :goto_0

    .line 250
    :pswitch_2a
    const-string v4, "wifi_bssid"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiBssid()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    .line 252
    :pswitch_2b
    const-string v4, "adid"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getAdid()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_0

    :pswitch_2c
    move-object v2, v3

    .line 254
    goto/16 :goto_0

    .line 256
    :pswitch_2d
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getRamAppUse()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto/16 :goto_0

    .line 260
    :catch_0
    move-exception v0

    .line 261
    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DeviceInfo get error."

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 164
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
    .line 751
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->adid:Ljava/lang/String;

    return-object v0
.end method

.method public static getAndroidID()Ljava/lang/String;
    .locals 2

    .prologue
    .line 308
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAndroidPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 694
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAppVersionCode()Ljava/lang/String;
    .locals 4

    .prologue
    .line 701
    :try_start_0
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    sget-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 700
    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 705
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    return-object v1

    .line 702
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_0
    move-exception v0

    .line 703
    .restart local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 705
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static getAppVersionName()Ljava/lang/String;
    .locals 4

    .prologue
    .line 711
    :try_start_0
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    sget-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 715
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    return-object v1

    .line 712
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_0
    move-exception v0

    .line 713
    .restart local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 715
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static getBrand()Ljava/lang/String;
    .locals 1

    .prologue
    .line 776
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    return-object v0
.end method

.method public static getCountry()Ljava/lang/String;
    .locals 1

    .prologue
    .line 407
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCpuCore()Ljava/lang/String;
    .locals 6

    .prologue
    .line 520
    :try_start_0
    new-instance v0, Ljava/io/File;

    const-string v3, "/sys/devices/system/cpu/"

    invoke-direct {v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 521
    .local v0, "dir":Ljava/io/File;
    new-instance v3, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$1CpuFilter;

    invoke-direct {v3}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$1CpuFilter;-><init>()V

    invoke-virtual {v0, v3}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v2

    .line 522
    .local v2, "files":[Ljava/io/File;
    array-length v3, v2

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 525
    .end local v2    # "files":[Ljava/io/File;
    :goto_0
    return-object v3

    .line 523
    :catch_0
    move-exception v1

    .line 524
    .local v1, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 525
    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method public static getCpuGHZ()Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v10, 0x0

    .line 533
    const/4 v7, 0x2

    :try_start_0
    new-array v0, v7, [Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "/system/bin/cat"

    aput-object v8, v0, v7

    const/4 v7, 0x1

    const-string v8, "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"

    aput-object v8, v0, v7

    .line 534
    .local v0, "args":[Ljava/lang/String;
    new-instance v1, Ljava/lang/ProcessBuilder;

    invoke-direct {v1, v0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 536
    .local v1, "cmd":Ljava/lang/ProcessBuilder;
    invoke-virtual {v1}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v5

    .line 537
    .local v5, "process":Ljava/lang/Process;
    new-instance v6, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/InputStreamReader;

    invoke-virtual {v5}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v6, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 538
    .local v6, "reader":Ljava/io/BufferedReader;
    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    .line 541
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

    .line 547
    .end local v1    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v4    # "line":Ljava/lang/String;
    .end local v5    # "process":Ljava/lang/Process;
    .end local v6    # "reader":Ljava/io/BufferedReader;
    :goto_0
    return-object v7

    .line 542
    :catch_0
    move-exception v3

    .line 543
    .local v3, "ex":Ljava/io/IOException;
    sget-object v7, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 547
    .end local v3    # "ex":Ljava/io/IOException;
    :goto_1
    invoke-static {v10}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    goto :goto_0

    .line 544
    :catch_1
    move-exception v2

    .line 545
    .local v2, "e":Ljava/lang/NumberFormatException;
    sget-object v7, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/NumberFormatException;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static getCpuModel()Ljava/lang/String;
    .locals 13

    .prologue
    .line 552
    const-string v8, ""

    .local v8, "strCPU":Ljava/lang/String;
    const/4 v0, 0x0

    .line 553
    .local v0, "cpuAddress":Ljava/lang/String;
    const/4 v4, 0x0

    .line 554
    .local v4, "ir":Ljava/io/InputStreamReader;
    const/4 v2, 0x0

    .line 556
    .local v2, "input":Ljava/io/LineNumberReader;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v9

    const-string v10, "cat /proc/cpuinfo"

    invoke-virtual {v9, v10}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v6

    .line 557
    .local v6, "pp":Ljava/lang/Process;
    new-instance v5, Ljava/io/InputStreamReader;

    invoke-virtual {v6}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v5, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 558
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .local v5, "ir":Ljava/io/InputStreamReader;
    :try_start_1
    new-instance v3, Ljava/io/LineNumberReader;

    invoke-direct {v3, v5}, Ljava/io/LineNumberReader;-><init>(Ljava/io/Reader;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 559
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

    .line 570
    :goto_1
    if-eqz v3, :cond_0

    .line 571
    :try_start_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->close()V

    .line 572
    :cond_0
    if-eqz v5, :cond_7

    .line 573
    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .line 578
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :cond_1
    :goto_2
    return-object v0

    .line 560
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

    .line 561
    const-string v9, ":"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    add-int/lit8 v9, v9, 0x1

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 562
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 563
    goto :goto_1

    .line 559
    :cond_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result-object v7

    goto :goto_0

    .line 566
    .end local v3    # "input":Ljava/io/LineNumberReader;
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :catch_0
    move-exception v1

    .line 567
    .local v1, "ex":Ljava/lang/Exception;
    :goto_3
    :try_start_5
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 570
    if-eqz v2, :cond_4

    .line 571
    :try_start_6
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 572
    :cond_4
    if-eqz v4, :cond_1

    .line 573
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_2

    .line 574
    :catch_1
    move-exception v1

    .line 575
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 568
    .end local v1    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v9

    .line 570
    :goto_4
    if-eqz v2, :cond_5

    .line 571
    :try_start_7
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 572
    :cond_5
    if-eqz v4, :cond_6

    .line 573
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    .line 577
    :cond_6
    :goto_5
    throw v9

    .line 574
    :catch_2
    move-exception v1

    .line 575
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v10, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_5

    .line 574
    .end local v1    # "ex":Ljava/lang/Exception;
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :catch_3
    move-exception v1

    .line 575
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .end local v1    # "ex":Ljava/lang/Exception;
    :cond_7
    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto/16 :goto_2

    .line 568
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

    .line 566
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_4
    move-exception v1

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto/16 :goto_3

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
    goto/16 :goto_3
.end method

.method public static getCpuSerial()Ljava/lang/String;
    .locals 13

    .prologue
    .line 583
    const-string v8, ""

    .local v8, "strCPU":Ljava/lang/String;
    const/4 v0, 0x0

    .line 584
    .local v0, "cpuAddress":Ljava/lang/String;
    const/4 v4, 0x0

    .line 585
    .local v4, "ir":Ljava/io/InputStreamReader;
    const/4 v2, 0x0

    .line 587
    .local v2, "input":Ljava/io/LineNumberReader;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v9

    const-string v10, "cat /proc/cpuinfo"

    invoke-virtual {v9, v10}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v6

    .line 588
    .local v6, "pp":Ljava/lang/Process;
    new-instance v5, Ljava/io/InputStreamReader;

    invoke-virtual {v6}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v5, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 589
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .local v5, "ir":Ljava/io/InputStreamReader;
    :try_start_1
    new-instance v3, Ljava/io/LineNumberReader;

    invoke-direct {v3, v5}, Ljava/io/LineNumberReader;-><init>(Ljava/io/Reader;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 590
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

    .line 601
    :goto_1
    if-eqz v3, :cond_0

    .line 602
    :try_start_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->close()V

    .line 603
    :cond_0
    if-eqz v5, :cond_7

    .line 604
    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .line 610
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :cond_1
    :goto_2
    return-object v0

    .line 591
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

    .line 592
    const-string v9, ":"

    invoke-virtual {v7, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    add-int/lit8 v9, v9, 0x1

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 593
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 594
    goto :goto_1

    .line 590
    :cond_3
    invoke-virtual {v3}, Ljava/io/LineNumberReader;->readLine()Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result-object v7

    goto :goto_0

    .line 597
    .end local v3    # "input":Ljava/io/LineNumberReader;
    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .end local v6    # "pp":Ljava/lang/Process;
    .end local v7    # "str":Ljava/lang/String;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    :catch_0
    move-exception v1

    .line 598
    .local v1, "ex":Ljava/lang/Exception;
    :goto_3
    :try_start_5
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 601
    if-eqz v2, :cond_4

    .line 602
    :try_start_6
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 603
    :cond_4
    if-eqz v4, :cond_1

    .line 604
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_2

    .line 605
    :catch_1
    move-exception v1

    .line 607
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 599
    .end local v1    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v9

    .line 601
    :goto_4
    if-eqz v2, :cond_5

    .line 602
    :try_start_7
    invoke-virtual {v2}, Ljava/io/LineNumberReader;->close()V

    .line 603
    :cond_5
    if-eqz v4, :cond_6

    .line 604
    invoke-virtual {v4}, Ljava/io/InputStreamReader;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    .line 609
    :cond_6
    :goto_5
    throw v9

    .line 605
    :catch_2
    move-exception v1

    .line 607
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v10, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_5

    .line 605
    .end local v1    # "ex":Ljava/lang/Exception;
    .end local v2    # "input":Ljava/io/LineNumberReader;
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v6    # "pp":Ljava/lang/Process;
    .restart local v7    # "str":Ljava/lang/String;
    :catch_3
    move-exception v1

    .line 607
    .restart local v1    # "ex":Ljava/lang/Exception;
    sget-object v9, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .end local v1    # "ex":Ljava/lang/Exception;
    :cond_7
    move-object v2, v3

    .end local v3    # "input":Ljava/io/LineNumberReader;
    .restart local v2    # "input":Ljava/io/LineNumberReader;
    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto/16 :goto_2

    .line 599
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

    .line 597
    .end local v4    # "ir":Ljava/io/InputStreamReader;
    .restart local v5    # "ir":Ljava/io/InputStreamReader;
    :catch_4
    move-exception v1

    move-object v4, v5

    .end local v5    # "ir":Ljava/io/InputStreamReader;
    .restart local v4    # "ir":Ljava/io/InputStreamReader;
    goto/16 :goto_3

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
    goto/16 :goto_3
.end method

.method public static getCurrencyCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 412
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
    .line 417
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
    .line 720
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getModel()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getIP()Ljava/lang/String;
    .locals 11

    .prologue
    .line 279
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v7

    invoke-virtual {v7}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v6

    .line 280
    .local v6, "wifiInfo":Landroid/net/wifi/WifiInfo;
    invoke-virtual {v6}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 281
    .local v3, "ipAddress":Ljava/lang/Integer;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v7

    if-eqz v7, :cond_0

    .line 282
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

    .line 283
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v10

    shr-int/lit8 v10, v10, 0x18

    and-int/lit16 v10, v10, 0xff

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    .line 282
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 303
    :goto_0
    return-object v7

    .line 287
    :cond_0
    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v5

    .line 288
    .local v5, "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_1
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v7

    if-nez v7, :cond_2

    .line 303
    .end local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :goto_1
    const/4 v7, 0x0

    goto :goto_0

    .line 289
    .restart local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_2
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/net/NetworkInterface;

    .line 290
    .local v4, "networkInterface":Ljava/net/NetworkInterface;
    invoke-virtual {v4}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v2

    .line 291
    .local v2, "inetAddressEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :cond_3
    invoke-interface {v2}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 292
    invoke-interface {v2}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/InetAddress;

    .line 293
    .local v1, "inetAddress":Ljava/net/InetAddress;
    invoke-virtual {v1}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v7

    if-nez v7, :cond_3

    invoke-virtual {v1}, Ljava/net/InetAddress;->isLinkLocalAddress()Z

    move-result v7

    if-nez v7, :cond_3

    .line 294
    invoke-virtual {v1}, Ljava/net/InetAddress;->isSiteLocalAddress()Z

    move-result v7

    if-eqz v7, :cond_3

    .line 295
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    goto :goto_0

    .line 299
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    .end local v2    # "inetAddressEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    .end local v4    # "networkInterface":Ljava/net/NetworkInterface;
    .end local v5    # "networkInterfaceEnumeration":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :catch_0
    move-exception v0

    .line 300
    .local v0, "e":Ljava/lang/Exception;
    sget-object v7, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static getLanuage()Ljava/lang/String;
    .locals 1

    .prologue
    .line 422
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

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
    .line 630
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getlocation()Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;

    move-result-object v0

    iget-wide v0, v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLatitude:D

    invoke-static {v0, v1}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getLongitude()Ljava/lang/String;
    .locals 2

    .prologue
    .line 625
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getlocation()Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;

    move-result-object v0

    iget-wide v0, v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLongitude:D

    invoke-static {v0, v1}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMac()Ljava/lang/String;
    .locals 1

    .prologue
    .line 333
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

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
    .line 725
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getModel()Ljava/lang/String;
    .locals 1

    .prologue
    .line 313
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0
.end method

.method public static getNetworkType()Ljava/lang/String;
    .locals 6

    .prologue
    .line 338
    sget-object v4, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    const-string v5, "connectivity"

    invoke-virtual {v4, v5}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 340
    .local v0, "connectMgr":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 341
    .local v1, "info":Landroid/net/NetworkInfo;
    if-nez v1, :cond_0

    .line 342
    const-string v4, "UNKNOWN"

    .line 374
    :goto_0
    return-object v4

    .line 343
    :cond_0
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    .line 344
    .local v3, "type":I
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v2

    .line 346
    .local v2, "subtype":I
    const/4 v4, 0x1

    if-ne v3, v4, :cond_1

    .line 347
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "CONNECTED VIA WIFI"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 348
    const-string v4, "WIFI"

    goto :goto_0

    .line 349
    :cond_1
    if-nez v3, :cond_2

    .line 350
    packed-switch v2, :pswitch_data_0

    .line 370
    const-string v4, "UNKNOWN"

    goto :goto_0

    .line 356
    :pswitch_0
    const-string v4, "2G"

    goto :goto_0

    .line 366
    :pswitch_1
    const-string v4, "3G"

    goto :goto_0

    .line 368
    :pswitch_2
    const-string v4, "4G"

    goto :goto_0

    .line 374
    :cond_2
    const-string v4, "UNKNOWN"

    goto :goto_0

    .line 350
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
    .line 328
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimOperatorName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getRamAppUse()Ljava/lang/String;
    .locals 5

    .prologue
    .line 757
    :try_start_0
    new-instance v1, Landroid/os/Debug$MemoryInfo;

    invoke-direct {v1}, Landroid/os/Debug$MemoryInfo;-><init>()V

    .line 758
    .local v1, "info":Landroid/os/Debug$MemoryInfo;
    invoke-static {v1}, Landroid/os/Debug;->getMemoryInfo(Landroid/os/Debug$MemoryInfo;)V

    .line 759
    invoke-virtual {v1}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 764
    :goto_0
    return-object v2

    .line 760
    :catch_0
    move-exception v0

    .line 761
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 764
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static getRamRem()Ljava/lang/String;
    .locals 6

    .prologue
    const-wide/16 v4, 0x400

    .line 427
    sget-object v2, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    const-string v3, "activity"

    invoke-virtual {v2, v3}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    .line 428
    .local v1, "myActivityManager":Landroid/app/ActivityManager;
    new-instance v0, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v0}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    .line 429
    .local v0, "memoryInfo":Landroid/app/ActivityManager$MemoryInfo;
    invoke-virtual {v1, v0}, Landroid/app/ActivityManager;->getMemoryInfo(Landroid/app/ActivityManager$MemoryInfo;)V

    .line 430
    iget-wide v2, v0, Landroid/app/ActivityManager$MemoryInfo;->availMem:J

    div-long/2addr v2, v4

    div-long/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public static getRamTotal()Ljava/lang/String;
    .locals 13

    .prologue
    .line 435
    const-wide/16 v6, -0x1

    .line 436
    .local v6, "memtotal":J
    const/4 v3, 0x0

    .line 437
    .local v3, "fr":Ljava/io/FileReader;
    const/4 v5, 0x0

    .line 440
    .local v5, "reader":Ljava/io/BufferedReader;
    :try_start_0
    new-instance v4, Ljava/io/FileReader;

    const-string v10, "/proc/meminfo"

    invoke-direct {v4, v10}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 441
    .end local v3    # "fr":Ljava/io/FileReader;
    .local v4, "fr":Ljava/io/FileReader;
    if-eqz v4, :cond_3

    .line 442
    :try_start_1
    new-instance v8, Ljava/io/BufferedReader;

    const/16 v10, 0x2000

    invoke-direct {v8, v4, v10}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    .line 443
    .end local v5    # "reader":Ljava/io/BufferedReader;
    .local v8, "reader":Ljava/io/BufferedReader;
    if-eqz v8, :cond_2

    .line 444
    const/4 v9, 0x0

    .line 445
    .local v9, "str":Ljava/lang/String;
    :try_start_2
    invoke-virtual {v8}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v9

    .line 446
    const-string v10, "\\s+"

    invoke-virtual {v9, v10}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 447
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

    .line 462
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

    .line 450
    :catch_0
    move-exception v1

    .line 451
    .local v1, "e":Ljava/lang/Exception;
    :goto_1
    sget-object v10, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 453
    if-eqz v5, :cond_1

    .line 454
    :try_start_3
    invoke-virtual {v5}, Ljava/io/BufferedReader;->close()V

    .line 455
    :cond_1
    if-eqz v3, :cond_0

    .line 456
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 457
    :catch_1
    move-exception v2

    .line 458
    .local v2, "ex":Ljava/lang/Exception;
    sget-object v10, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 450
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
    .line 503
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 504
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

    .line 467
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v4

    .line 468
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 469
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 470
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 471
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

    .line 476
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v2

    .line 477
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 478
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 479
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 480
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

    .line 485
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    .line 486
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 487
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 488
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 489
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

    .line 494
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    .line 495
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 496
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 497
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 498
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
    .line 379
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSimSerial()Ljava/lang/String;
    .locals 1

    .prologue
    .line 384
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSystemName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 318
    const-string v0, "Android"

    return-object v0
.end method

.method public static getSystemVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 323
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getTelephonyManager()Landroid/telephony/TelephonyManager;
    .locals 2

    .prologue
    .line 768
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    return-object v0
.end method

.method public static getWifiBssid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 730
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiMac()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getWifiMac()Ljava/lang/String;
    .locals 2

    .prologue
    .line 389
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 390
    .local v0, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-eqz v0, :cond_0

    .line 391
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getBSSID()Ljava/lang/String;

    move-result-object v1

    .line 393
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private static getWifiManager()Landroid/net/wifi/WifiManager;
    .locals 2

    .prologue
    .line 772
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    return-object v0
.end method

.method public static getWifiSSID()Ljava/lang/String;
    .locals 2

    .prologue
    .line 398
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getWifiManager()Landroid/net/wifi/WifiManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 399
    .local v0, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-eqz v0, :cond_0

    .line 400
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v1

    .line 402
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private static getlocation()Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;
    .locals 10

    .prologue
    .line 636
    const-wide/16 v2, 0x0

    .line 637
    .local v2, "latitude":D
    const-wide/16 v6, 0x0

    .line 640
    .local v6, "longitude":D
    :try_start_0
    sget-object v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    const-string v8, "location"

    invoke-virtual {v5, v8}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/location/LocationManager;

    .line 641
    .local v4, "locationManager":Landroid/location/LocationManager;
    const-string v5, "gps"

    invoke-virtual {v4, v5}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 642
    const-string v5, "gps"

    invoke-virtual {v4, v5}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    .line 643
    .local v1, "location":Landroid/location/Location;
    if-eqz v1, :cond_0

    .line 644
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    .line 645
    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v6

    .line 647
    sget-object v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, " -- -- "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 649
    :cond_0
    sget-object v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, " -- -- -- "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 689
    .end local v1    # "location":Landroid/location/Location;
    .end local v4    # "locationManager":Landroid/location/LocationManager;
    :cond_1
    :goto_0
    new-instance v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;

    invoke-direct {v5, v2, v3, v6, v7}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;-><init>(DD)V

    return-object v5

    .line 676
    .restart local v4    # "locationManager":Landroid/location/LocationManager;
    :cond_2
    :try_start_1
    const-string v5, "network"

    invoke-virtual {v4, v5}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    .line 677
    .restart local v1    # "location":Landroid/location/Location;
    if-eqz v1, :cond_1

    .line 678
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    .line 679
    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v6

    .line 680
    sget-object v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, " -- "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 683
    .end local v1    # "location":Landroid/location/Location;
    .end local v4    # "locationManager":Landroid/location/LocationManager;
    :catch_0
    move-exception v0

    .line 684
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 685
    sget-object v5, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "getlocation Exception"

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 4
    .param p0, "ctx"    # Landroid/app/Activity;

    .prologue
    .line 95
    sget-boolean v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->isInit:Z

    if-eqz v1, :cond_0

    .line 148
    :goto_0
    return-void

    .line 98
    :cond_0
    const/4 v1, 0x1

    sput-boolean v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->isInit:Z

    .line 99
    sput-object p0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->mActivity:Landroid/app/Activity;

    .line 100
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->initAdid()V

    .line 101
    const/4 v0, 0x0

    .line 102
    .local v0, "count":I
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ip"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 103
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "idfv"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 104
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "idfa"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "android_id"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 106
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "model"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 107
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "system_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 108
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "system_version"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 109
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "operators"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "mac"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 112
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "network"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 113
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sim_country"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 114
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sim_serial"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 115
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_mac"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_ssid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 117
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "country"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 118
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "currency_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 119
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "currency_symbol"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 120
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_bundle_id"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 121
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_build"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 122
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "lanuage"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 124
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 125
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "rom_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 126
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "rom_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 127
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sd_card_rem"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "sd_card_total"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "resolution"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_core"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 131
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_ghz"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_model"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_serial"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 134
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "cpu_type"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 135
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "longitude"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 136
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "latitude"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 137
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "android_package_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 138
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 139
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "app_version_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "area"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "device_name"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 142
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "machine_code"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 143
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "phone_number"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 144
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "wifi_bssid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 145
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "adid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 146
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "open_udid"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 147
    sget-object v1, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->string2int:Ljava/util/Map;

    const-string v2, "ram_app_use"

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0
.end method

.method private static initAdid()V
    .locals 0

    .prologue
    .line 748
    return-void
.end method

.method private static saveValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 269
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 270
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->deviceInfoList:Ljava/util/Map;

    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 273
    .end local p1    # "value":Ljava/lang/String;
    :goto_0
    return-object p1

    .restart local p1    # "value":Ljava/lang/String;
    :cond_0
    const/4 p1, 0x0

    goto :goto_0
.end method
