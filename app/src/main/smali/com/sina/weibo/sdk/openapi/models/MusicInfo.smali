.class public Lcom/sina/weibo/sdk/openapi/models/MusicInfo;
.super Ljava/lang/Object;
.source "MusicInfo.java"


# instance fields
.field public album:Ljava/lang/String;

.field public author:Ljava/lang/String;

.field public playUrl:Ljava/lang/String;

.field public title:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/MusicInfo;
    .locals 2
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 40
    if-nez p0, :cond_0

    .line 41
    const/4 v0, 0x0

    .line 50
    :goto_0
    return-object v0

    .line 44
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;-><init>()V

    .line 45
    .local v0, "music":Lcom/sina/weibo/sdk/openapi/models/MusicInfo;
    const-string v1, "author"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;->author:Ljava/lang/String;

    .line 46
    const-string v1, "title"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;->title:Ljava/lang/String;

    .line 47
    const-string v1, "album"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;->album:Ljava/lang/String;

    .line 48
    const-string v1, "playUrl"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/MusicInfo;->playUrl:Ljava/lang/String;

    goto :goto_0
.end method

.method public static parser(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/MusicInfo;
    .locals 1
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 36
    const/4 v0, 0x0

    return-object v0
.end method
