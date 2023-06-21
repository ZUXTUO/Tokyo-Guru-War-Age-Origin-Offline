.class public Lcom/sina/weibo/sdk/openapi/models/Tag;
.super Ljava/lang/Object;
.source "Tag.java"


# instance fields
.field public id:I

.field public tag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Tag;
    .locals 3
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 35
    if-nez p0, :cond_0

    .line 36
    const/4 v0, 0x0

    .line 43
    :goto_0
    return-object v0

    .line 39
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Tag;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Tag;-><init>()V

    .line 40
    .local v0, "tag":Lcom/sina/weibo/sdk/openapi/models/Tag;
    const-string v1, "id"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/Tag;->id:I

    .line 41
    const-string v1, "tag"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Tag;->tag:Ljava/lang/String;

    goto :goto_0
.end method
