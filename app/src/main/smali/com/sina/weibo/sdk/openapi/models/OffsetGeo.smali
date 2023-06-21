.class public Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;
.super Ljava/lang/Object;
.source "OffsetGeo.java"


# instance fields
.field public Geos:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/sina/weibo/sdk/openapi/models/Coordinate;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;
    .locals 8
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 38
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 39
    const/4 v5, 0x0

    .line 59
    :cond_0
    :goto_0
    return-object v5

    .line 42
    :cond_1
    new-instance v5, Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;

    invoke-direct {v5}, Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;-><init>()V

    .line 44
    .local v5, "offsetGeo":Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 46
    .local v3, "jsonObject":Lorg/json/JSONObject;
    const-string v6, "geos"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 47
    .local v2, "jsonArray":Lorg/json/JSONArray;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_0

    .line 48
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    .line 49
    .local v4, "length":I
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v4}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v6, v5, Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;->Geos:Ljava/util/ArrayList;

    .line 50
    const/4 v1, 0x0

    .local v1, "ix":I
    :goto_1
    if-ge v1, v4, :cond_0

    .line 51
    iget-object v6, v5, Lcom/sina/weibo/sdk/openapi/models/OffsetGeo;->Geos:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    invoke-static {v7}, Lcom/sina/weibo/sdk/openapi/models/Coordinate;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Coordinate;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 50
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 55
    .end local v1    # "ix":I
    .end local v2    # "jsonArray":Lorg/json/JSONArray;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v4    # "length":I
    :catch_0
    move-exception v0

    .line 56
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
