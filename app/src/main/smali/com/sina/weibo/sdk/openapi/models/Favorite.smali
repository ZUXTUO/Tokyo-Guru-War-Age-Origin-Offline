.class public Lcom/sina/weibo/sdk/openapi/models/Favorite;
.super Ljava/lang/Object;
.source "Favorite.java"


# instance fields
.field public favorited_time:Ljava/lang/String;

.field public status:Lcom/sina/weibo/sdk/openapi/models/Status;

.field public tags:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/sina/weibo/sdk/openapi/models/Tag;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/Favorite;
    .locals 3
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 42
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 43
    .local v1, "object":Lorg/json/JSONObject;
    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/Favorite;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Favorite;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 48
    .end local v1    # "object":Lorg/json/JSONObject;
    :goto_0
    return-object v2

    .line 44
    :catch_0
    move-exception v0

    .line 45
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 48
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Favorite;
    .locals 6
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 52
    if-nez p0, :cond_1

    .line 53
    const/4 v0, 0x0

    .line 69
    :cond_0
    return-object v0

    .line 56
    :cond_1
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Favorite;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Favorite;-><init>()V

    .line 57
    .local v0, "favorite":Lcom/sina/weibo/sdk/openapi/models/Favorite;
    const-string v4, "status"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-static {v4}, Lcom/sina/weibo/sdk/openapi/models/Status;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Status;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Favorite;->status:Lcom/sina/weibo/sdk/openapi/models/Status;

    .line 58
    const-string v4, "favorited_time"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Favorite;->favorited_time:Ljava/lang/String;

    .line 60
    const-string v4, "tags"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 61
    .local v2, "jsonArray":Lorg/json/JSONArray;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 62
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 63
    .local v3, "length":I
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Favorite;->tags:Ljava/util/ArrayList;

    .line 64
    const/4 v1, 0x0

    .local v1, "ix":I
    :goto_0
    if-ge v1, v3, :cond_0

    .line 65
    iget-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Favorite;->tags:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/Tag;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Tag;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 64
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method
