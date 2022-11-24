.class public Lcom/sina/weibo/sdk/openapi/models/Geo;
.super Ljava/lang/Object;
.source "Geo.java"


# instance fields
.field public address:Ljava/lang/String;

.field public city:Ljava/lang/String;

.field public city_name:Ljava/lang/String;

.field public latitude:Ljava/lang/String;

.field public longitude:Ljava/lang/String;

.field public more:Ljava/lang/String;

.field public pinyin:Ljava/lang/String;

.field public province:Ljava/lang/String;

.field public province_name:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/Geo;
    .locals 4
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 52
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 53
    const/4 v1, 0x0

    .line 64
    :goto_0
    return-object v1

    .line 56
    :cond_0
    const/4 v1, 0x0

    .line 58
    .local v1, "geo":Lcom/sina/weibo/sdk/openapi/models/Geo;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 59
    .local v2, "jsonObject":Lorg/json/JSONObject;
    invoke-static {v2}, Lcom/sina/weibo/sdk/openapi/models/Geo;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Geo;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    .line 60
    .end local v2    # "jsonObject":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 61
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Geo;
    .locals 2
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 68
    if-nez p0, :cond_0

    .line 69
    const/4 v0, 0x0

    .line 83
    :goto_0
    return-object v0

    .line 72
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Geo;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Geo;-><init>()V

    .line 73
    .local v0, "geo":Lcom/sina/weibo/sdk/openapi/models/Geo;
    const-string v1, "longitude"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->longitude:Ljava/lang/String;

    .line 74
    const-string v1, "latitude"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->latitude:Ljava/lang/String;

    .line 75
    const-string v1, "city"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->city:Ljava/lang/String;

    .line 76
    const-string v1, "province"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->province:Ljava/lang/String;

    .line 77
    const-string v1, "city_name"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->city_name:Ljava/lang/String;

    .line 78
    const-string v1, "province_name"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->province_name:Ljava/lang/String;

    .line 79
    const-string v1, "address"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->address:Ljava/lang/String;

    .line 80
    const-string v1, "pinyin"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->pinyin:Ljava/lang/String;

    .line 81
    const-string v1, "more"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Geo;->more:Ljava/lang/String;

    goto :goto_0
.end method
