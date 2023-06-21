.class public Lcom/sina/weibo/sdk/openapi/models/User;
.super Ljava/lang/Object;
.source "User.java"


# instance fields
.field public allow_all_act_msg:Z

.field public allow_all_comment:Z

.field public avatar_hd:Ljava/lang/String;

.field public avatar_large:Ljava/lang/String;

.field public bi_followers_count:I

.field public block_word:Ljava/lang/String;

.field public city:I

.field public created_at:Ljava/lang/String;

.field public description:Ljava/lang/String;

.field public domain:Ljava/lang/String;

.field public favourites_count:I

.field public follow_me:Z

.field public followers_count:I

.field public following:Z

.field public friends_count:I

.field public gender:Ljava/lang/String;

.field public geo_enabled:Z

.field public id:Ljava/lang/String;

.field public idstr:Ljava/lang/String;

.field public lang:Ljava/lang/String;

.field public location:Ljava/lang/String;

.field public mbrank:Ljava/lang/String;

.field public mbtype:Ljava/lang/String;

.field public name:Ljava/lang/String;

.field public online_status:I

.field public profile_image_url:Ljava/lang/String;

.field public profile_url:Ljava/lang/String;

.field public province:I

.field public remark:Ljava/lang/String;

.field public screen_name:Ljava/lang/String;

.field public star:Ljava/lang/String;

.field public status:Lcom/sina/weibo/sdk/openapi/models/Status;

.field public statuses_count:I

.field public url:Ljava/lang/String;

.field public verified:Z

.field public verified_reason:Ljava/lang/String;

.field public verified_type:I

.field public weihao:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/User;
    .locals 3
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 107
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 108
    .local v1, "jsonObject":Lorg/json/JSONObject;
    invoke-static {v1}, Lcom/sina/weibo/sdk/openapi/models/User;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/User;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 113
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :goto_0
    return-object v2

    .line 109
    :catch_0
    move-exception v0

    .line 110
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 113
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/User;
    .locals 5
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    const/4 v4, -0x1

    const/4 v3, 0x0

    .line 117
    if-nez p0, :cond_0

    .line 118
    const/4 v0, 0x0

    .line 163
    :goto_0
    return-object v0

    .line 121
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/User;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/User;-><init>()V

    .line 122
    .local v0, "user":Lcom/sina/weibo/sdk/openapi/models/User;
    const-string v1, "id"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->id:Ljava/lang/String;

    .line 123
    const-string v1, "idstr"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->idstr:Ljava/lang/String;

    .line 124
    const-string v1, "screen_name"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->screen_name:Ljava/lang/String;

    .line 125
    const-string v1, "name"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->name:Ljava/lang/String;

    .line 126
    const-string v1, "province"

    invoke-virtual {p0, v1, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->province:I

    .line 127
    const-string v1, "city"

    invoke-virtual {p0, v1, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->city:I

    .line 128
    const-string v1, "location"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->location:Ljava/lang/String;

    .line 129
    const-string v1, "description"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->description:Ljava/lang/String;

    .line 130
    const-string v1, "url"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->url:Ljava/lang/String;

    .line 131
    const-string v1, "profile_image_url"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->profile_image_url:Ljava/lang/String;

    .line 132
    const-string v1, "profile_url"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->profile_url:Ljava/lang/String;

    .line 133
    const-string v1, "domain"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->domain:Ljava/lang/String;

    .line 134
    const-string v1, "weihao"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->weihao:Ljava/lang/String;

    .line 135
    const-string v1, "gender"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->gender:Ljava/lang/String;

    .line 136
    const-string v1, "followers_count"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->followers_count:I

    .line 137
    const-string v1, "friends_count"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->friends_count:I

    .line 138
    const-string v1, "statuses_count"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->statuses_count:I

    .line 139
    const-string v1, "favourites_count"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->favourites_count:I

    .line 140
    const-string v1, "created_at"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->created_at:Ljava/lang/String;

    .line 141
    const-string v1, "following"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->following:Z

    .line 142
    const-string v1, "allow_all_act_msg"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->allow_all_act_msg:Z

    .line 143
    const-string v1, "geo_enabled"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->geo_enabled:Z

    .line 144
    const-string v1, "verified"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->verified:Z

    .line 145
    const-string v1, "verified_type"

    invoke-virtual {p0, v1, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->verified_type:I

    .line 146
    const-string v1, "remark"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->remark:Ljava/lang/String;

    .line 148
    const-string v1, "allow_all_comment"

    const/4 v2, 0x1

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->allow_all_comment:Z

    .line 149
    const-string v1, "avatar_large"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->avatar_large:Ljava/lang/String;

    .line 150
    const-string v1, "avatar_hd"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->avatar_hd:Ljava/lang/String;

    .line 151
    const-string v1, "verified_reason"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->verified_reason:Ljava/lang/String;

    .line 152
    const-string v1, "follow_me"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->follow_me:Z

    .line 153
    const-string v1, "online_status"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->online_status:I

    .line 154
    const-string v1, "bi_followers_count"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->bi_followers_count:I

    .line 155
    const-string v1, "lang"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->lang:Ljava/lang/String;

    .line 158
    const-string v1, "star"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->star:Ljava/lang/String;

    .line 159
    const-string v1, "mbtype"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->mbtype:Ljava/lang/String;

    .line 160
    const-string v1, "mbrank"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->mbrank:Ljava/lang/String;

    .line 161
    const-string v1, "block_word"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/User;->block_word:Ljava/lang/String;

    goto/16 :goto_0
.end method
