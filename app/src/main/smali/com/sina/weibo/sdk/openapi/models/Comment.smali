.class public Lcom/sina/weibo/sdk/openapi/models/Comment;
.super Ljava/lang/Object;
.source "Comment.java"


# instance fields
.field public created_at:Ljava/lang/String;

.field public id:Ljava/lang/String;

.field public idstr:Ljava/lang/String;

.field public mid:Ljava/lang/String;

.field public reply_comment:Lcom/sina/weibo/sdk/openapi/models/Comment;

.field public source:Ljava/lang/String;

.field public status:Lcom/sina/weibo/sdk/openapi/models/Status;

.field public text:Ljava/lang/String;

.field public user:Lcom/sina/weibo/sdk/openapi/models/User;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Comment;
    .locals 2
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 49
    if-nez p0, :cond_0

    .line 50
    const/4 v0, 0x0

    .line 64
    :goto_0
    return-object v0

    .line 53
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Comment;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Comment;-><init>()V

    .line 54
    .local v0, "comment":Lcom/sina/weibo/sdk/openapi/models/Comment;
    const-string v1, "created_at"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->created_at:Ljava/lang/String;

    .line 55
    const-string v1, "id"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->id:Ljava/lang/String;

    .line 56
    const-string v1, "text"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->text:Ljava/lang/String;

    .line 57
    const-string v1, "source"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->source:Ljava/lang/String;

    .line 58
    const-string v1, "user"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/User;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/User;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->user:Lcom/sina/weibo/sdk/openapi/models/User;

    .line 59
    const-string v1, "mid"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->mid:Ljava/lang/String;

    .line 60
    const-string v1, "idstr"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->idstr:Ljava/lang/String;

    .line 61
    const-string v1, "status"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/Status;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Status;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->status:Lcom/sina/weibo/sdk/openapi/models/Status;

    .line 62
    const-string v1, "reply_comment"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/Comment;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Comment;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Comment;->reply_comment:Lcom/sina/weibo/sdk/openapi/models/Comment;

    goto :goto_0
.end method
