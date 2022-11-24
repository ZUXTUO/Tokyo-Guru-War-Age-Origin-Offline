.class public Lcom/sina/weibo/sdk/openapi/models/Group;
.super Ljava/lang/Object;
.source "Group.java"


# static fields
.field public static final GROUP_ID_ALL:Ljava/lang/String; = "1"


# instance fields
.field public createAtTime:Ljava/lang/String;

.field public description:Ljava/lang/String;

.field public id:Ljava/lang/String;

.field public idStr:Ljava/lang/String;

.field public like_count:I

.field public member_count:I

.field public mode:Ljava/lang/String;

.field public name:Ljava/lang/String;

.field public profile_image_url:Ljava/lang/String;

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

.field public user:Lcom/sina/weibo/sdk/openapi/models/User;

.field public visible:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Group;
    .locals 6
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 59
    if-nez p0, :cond_1

    .line 60
    const/4 v0, 0x0

    .line 85
    :cond_0
    return-object v0

    .line 63
    :cond_1
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Group;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Group;-><init>()V

    .line 64
    .local v0, "group":Lcom/sina/weibo/sdk/openapi/models/Group;
    const-string v4, "user"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-static {v4}, Lcom/sina/weibo/sdk/openapi/models/User;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/User;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->user:Lcom/sina/weibo/sdk/openapi/models/User;

    .line 65
    const-string v4, "id"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->id:Ljava/lang/String;

    .line 66
    const-string v4, "idstr"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->idStr:Ljava/lang/String;

    .line 67
    const-string v4, "name"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->name:Ljava/lang/String;

    .line 68
    const-string v4, "mode"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->mode:Ljava/lang/String;

    .line 69
    const-string v4, "visible"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v4

    iput v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->visible:I

    .line 70
    const-string v4, "like_count"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v4

    iput v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->like_count:I

    .line 71
    const-string v4, "member_count"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v4

    iput v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->member_count:I

    .line 72
    const-string v4, "description"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->description:Ljava/lang/String;

    .line 73
    const-string v4, "profile_image_url"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->profile_image_url:Ljava/lang/String;

    .line 74
    const-string v4, "create_time"

    const-string v5, ""

    invoke-virtual {p0, v4, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->createAtTime:Ljava/lang/String;

    .line 76
    const-string v4, "tags"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 77
    .local v2, "jsonArray":Lorg/json/JSONArray;
    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 78
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 79
    .local v3, "length":I
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->tags:Ljava/util/ArrayList;

    .line 80
    const/4 v1, 0x0

    .local v1, "ix":I
    :goto_0
    if-ge v1, v3, :cond_0

    .line 81
    iget-object v4, v0, Lcom/sina/weibo/sdk/openapi/models/Group;->tags:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/Tag;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Tag;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 80
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method
