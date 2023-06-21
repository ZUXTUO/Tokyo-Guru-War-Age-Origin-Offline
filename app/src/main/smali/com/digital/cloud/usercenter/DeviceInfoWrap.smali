.class public Lcom/digital/cloud/usercenter/DeviceInfoWrap;
.super Ljava/lang/Object;
.source "DeviceInfoWrap.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 2
    .param p0, "obj"    # Lorg/json/JSONObject;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 12
    invoke-static {p1}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 13
    .local v1, "val":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 15
    :try_start_0
    invoke-virtual {p0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 20
    :cond_0
    :goto_0
    return-void

    .line 16
    :catch_0
    move-exception v0

    .line 17
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getClientIP()Ljava/lang/String;
    .locals 1

    .prologue
    .line 67
    const-string v0, ""

    return-object v0
.end method

.method public static getDeviceinfo(Landroid/app/Activity;Lorg/json/JSONObject;)V
    .locals 0
    .param p0, "ctx"    # Landroid/app/Activity;
    .param p1, "root"    # Lorg/json/JSONObject;

    .prologue
    .line 60
    return-void
.end method

.method public static getLocalinfo()Ljava/lang/String;
    .locals 1

    .prologue
    .line 63
    const-string v0, ""

    return-object v0
.end method
