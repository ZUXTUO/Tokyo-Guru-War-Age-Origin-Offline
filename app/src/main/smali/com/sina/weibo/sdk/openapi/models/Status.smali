.class public Lcom/sina/weibo/sdk/openapi/models/Status;
.super Ljava/lang/Object;
.source "Status.java"


# instance fields
.field public attitudes_count:I

.field public bmiddle_pic:Ljava/lang/String;

.field public comments_count:I

.field public created_at:Ljava/lang/String;

.field public favorited:Z

.field public geo:Lcom/sina/weibo/sdk/openapi/models/Geo;

.field public id:Ljava/lang/String;

.field public idstr:Ljava/lang/String;

.field public in_reply_to_screen_name:Ljava/lang/String;

.field public in_reply_to_status_id:Ljava/lang/String;

.field public in_reply_to_user_id:Ljava/lang/String;

.field public mid:Ljava/lang/String;

.field public mlevel:I

.field public original_pic:Ljava/lang/String;

.field public pic_urls:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public reposts_count:I

.field public retweeted_status:Lcom/sina/weibo/sdk/openapi/models/Status;

.field public source:Ljava/lang/String;

.field public text:Ljava/lang/String;

.field public thumbnail_pic:Ljava/lang/String;

.field public truncated:Z

.field public user:Lcom/sina/weibo/sdk/openapi/models/User;

.field public visible:Lcom/sina/weibo/sdk/openapi/models/Visible;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/Status;
    .locals 3
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 88
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 89
    .local v1, "jsonObject":Lorg/json/JSONObject;
    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/Status;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Status;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 94
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :goto_0
    return-object v2

    .line 90
    :catch_0
    move-exception v0

    .line 91
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 94
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Status;
    .locals 7
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    const/4 v6, 0x0

    .line 98
    if-nez p0, :cond_1

    .line 99
    const/4 v3, 0x0

    .line 144
    :cond_0
    return-object v3

    .line 102
    :cond_1
    new-instance v3, Lcom/sina/weibo/sdk/openapi/models/Status;

    invoke-direct {v3}, Lcom/sina/weibo/sdk/openapi/models/Status;-><init>()V

    .line 103
    .local v3, "status":Lcom/sina/weibo/sdk/openapi/models/Status;
    const-string v5, "created_at"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->created_at:Ljava/lang/String;

    .line 104
    const-string v5, "id"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->id:Ljava/lang/String;

    .line 105
    const-string v5, "mid"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->mid:Ljava/lang/String;

    .line 106
    const-string v5, "idstr"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->idstr:Ljava/lang/String;

    .line 107
    const-string v5, "text"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->text:Ljava/lang/String;

    .line 108
    const-string v5, "source"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->source:Ljava/lang/String;

    .line 109
    const-string v5, "favorited"

    invoke-virtual {p0, v5, v6}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v5

    iput-boolean v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->favorited:Z

    .line 110
    const-string v5, "truncated"

    invoke-virtual {p0, v5, v6}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v5

    iput-boolean v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->truncated:Z

    .line 113
    const-string v5, "in_reply_to_status_id"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->in_reply_to_status_id:Ljava/lang/String;

    .line 114
    const-string v5, "in_reply_to_user_id"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->in_reply_to_user_id:Ljava/lang/String;

    .line 115
    const-string v5, "in_reply_to_screen_name"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->in_reply_to_screen_name:Ljava/lang/String;

    .line 117
    const-string v5, "thumbnail_pic"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->thumbnail_pic:Ljava/lang/String;

    .line 118
    const-string v5, "bmiddle_pic"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->bmiddle_pic:Ljava/lang/String;

    .line 119
    const-string v5, "original_pic"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->original_pic:Ljava/lang/String;

    .line 120
    const-string v5, "geo"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/Geo;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Geo;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->geo:Lcom/sina/weibo/sdk/openapi/models/Geo;

    .line 121
    const-string v5, "user"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/User;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/User;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->user:Lcom/sina/weibo/sdk/openapi/models/User;

    .line 122
    const-string v5, "retweeted_status"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/Status;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Status;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->retweeted_status:Lcom/sina/weibo/sdk/openapi/models/Status;

    .line 123
    const-string v5, "reposts_count"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v5

    iput v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->reposts_count:I

    .line 124
    const-string v5, "comments_count"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v5

    iput v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->comments_count:I

    .line 125
    const-string v5, "attitudes_count"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v5

    iput v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->attitudes_count:I

    .line 126
    const-string v5, "mlevel"

    const/4 v6, -0x1

    invoke-virtual {p0, v5, v6}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v5

    iput v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->mlevel:I

    .line 127
    const-string v5, "visible"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5}, Lcom/sina/weibo/sdk/openapi/models/Visible;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Visible;

    move-result-object v5

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->visible:Lcom/sina/weibo/sdk/openapi/models/Visible;

    .line 129
    const-string v5, "pic_urls"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 130
    .local v2, "picUrlsArray":Lorg/json/JSONArray;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 131
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    .line 132
    .local v1, "length":I
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->pic_urls:Ljava/util/ArrayList;

    .line 133
    const/4 v4, 0x0

    .line 134
    .local v4, "tmpObject":Lorg/json/JSONObject;
    const/4 v0, 0x0

    .local v0, "ix":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 135
    invoke-virtual {v2, v0}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 136
    if-eqz v4, :cond_2

    .line 137
    iget-object v5, v3, Lcom/sina/weibo/sdk/openapi/models/Status;->pic_urls:Ljava/util/ArrayList;

    const-string v6, "thumbnail_pic"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 134
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
