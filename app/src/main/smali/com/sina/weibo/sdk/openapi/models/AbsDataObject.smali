.class public Lcom/sina/weibo/sdk/openapi/models/AbsDataObject;
.super Ljava/lang/Object;
.source "AbsDataObject.java"

# interfaces
.implements Lcom/sina/weibo/sdk/openapi/models/IParseable;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public parse(Ljava/lang/String;)Ljava/lang/Object;
    .locals 4
    .param p1, "parseString"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 34
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 45
    :goto_0
    return-object v2

    .line 39
    :cond_0
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 40
    .local v1, "object":Lorg/json/JSONObject;
    invoke-virtual {p0, v1}, Lcom/sina/weibo/sdk/openapi/models/AbsDataObject;->parse(Lorg/json/JSONObject;)Ljava/lang/Object;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 41
    .end local v1    # "object":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 42
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public parse(Lorg/json/JSONObject;)Ljava/lang/Object;
    .locals 1
    .param p1, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    const/4 v0, 0x0

    .line 50
    if-nez p1, :cond_0

    .line 54
    :cond_0
    return-object v0
.end method
