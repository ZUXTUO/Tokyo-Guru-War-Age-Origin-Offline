.class public Lcom/sina/weibo/sdk/openapi/models/Poi;
.super Ljava/lang/Object;
.source "Poi.java"


# instance fields
.field public address:Ljava/lang/String;

.field public category:Ljava/lang/String;

.field public category_name:Ljava/lang/String;

.field public categorys:Ljava/lang/String;

.field public checkin_num:Ljava/lang/String;

.field public checkin_user_num:Ljava/lang/String;

.field public city:Ljava/lang/String;

.field public country:Ljava/lang/String;

.field public distance:Ljava/lang/String;

.field public icon:Ljava/lang/String;

.field public lat:Ljava/lang/String;

.field public lon:Ljava/lang/String;

.field public phone:Ljava/lang/String;

.field public photo_num:Ljava/lang/String;

.field public poiid:Ljava/lang/String;

.field public postcode:Ljava/lang/String;

.field public province:Ljava/lang/String;

.field public tip_num:Ljava/lang/String;

.field public title:Ljava/lang/String;

.field public todo_num:Ljava/lang/String;

.field public url:Ljava/lang/String;

.field public weibo_id:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/Poi;
    .locals 4
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 78
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 79
    const/4 v2, 0x0

    .line 90
    :goto_0
    return-object v2

    .line 82
    :cond_0
    const/4 v2, 0x0

    .line 84
    .local v2, "poi":Lcom/sina/weibo/sdk/openapi/models/Poi;
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 85
    .local v1, "jsonObject":Lorg/json/JSONObject;
    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/Poi;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Poi;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 86
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 87
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Poi;
    .locals 2
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 94
    if-nez p0, :cond_0

    .line 95
    const/4 v0, 0x0

    .line 122
    :goto_0
    return-object v0

    .line 98
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Poi;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Poi;-><init>()V

    .line 99
    .local v0, "poi":Lcom/sina/weibo/sdk/openapi/models/Poi;
    const-string v1, "poiid"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->poiid:Ljava/lang/String;

    .line 100
    const-string v1, "title"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->title:Ljava/lang/String;

    .line 101
    const-string v1, "address"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->address:Ljava/lang/String;

    .line 102
    const-string v1, "lon"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->lon:Ljava/lang/String;

    .line 103
    const-string v1, "lat"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->lat:Ljava/lang/String;

    .line 104
    const-string v1, "category"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->category:Ljava/lang/String;

    .line 105
    const-string v1, "city"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->city:Ljava/lang/String;

    .line 106
    const-string v1, "province"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->province:Ljava/lang/String;

    .line 107
    const-string v1, "country"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->country:Ljava/lang/String;

    .line 108
    const-string v1, "url"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->url:Ljava/lang/String;

    .line 109
    const-string v1, "phone"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->phone:Ljava/lang/String;

    .line 110
    const-string v1, "postcode"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->postcode:Ljava/lang/String;

    .line 111
    const-string v1, "weibo_id"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->weibo_id:Ljava/lang/String;

    .line 112
    const-string v1, "categorys"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->categorys:Ljava/lang/String;

    .line 113
    const-string v1, "category_name"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->category_name:Ljava/lang/String;

    .line 114
    const-string v1, "icon"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->icon:Ljava/lang/String;

    .line 115
    const-string v1, "checkin_num"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->checkin_num:Ljava/lang/String;

    .line 116
    const-string v1, "checkin_user_num"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->checkin_user_num:Ljava/lang/String;

    .line 117
    const-string v1, "tip_num"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->tip_num:Ljava/lang/String;

    .line 118
    const-string v1, "photo_num"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->photo_num:Ljava/lang/String;

    .line 119
    const-string v1, "todo_num"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->todo_num:Ljava/lang/String;

    .line 120
    const-string v1, "distance"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Poi;->distance:Ljava/lang/String;

    goto/16 :goto_0
.end method
