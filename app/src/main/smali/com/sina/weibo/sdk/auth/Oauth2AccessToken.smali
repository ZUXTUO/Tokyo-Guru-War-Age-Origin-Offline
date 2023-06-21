.class public Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
.super Ljava/lang/Object;
.source "Oauth2AccessToken.java"


# static fields
.field public static final KEY_ACCESS_TOKEN:Ljava/lang/String; = "access_token"

.field public static final KEY_EXPIRES_IN:Ljava/lang/String; = "expires_in"

.field public static final KEY_PHONE_NUM:Ljava/lang/String; = "phone_num"

.field public static final KEY_REFRESH_TOKEN:Ljava/lang/String; = "refresh_token"

.field public static final KEY_UID:Ljava/lang/String; = "uid"


# instance fields
.field private mAccessToken:Ljava/lang/String;

.field private mExpiresTime:J

.field private mPhoneNum:Ljava/lang/String;

.field private mRefreshToken:Ljava/lang/String;

.field private mUid:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    .line 44
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    .line 46
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    .line 48
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 51
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    .line 58
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 4
    .param p1, "responseText"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const-string v2, ""

    iput-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    .line 44
    const-string v2, ""

    iput-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    .line 46
    const-string v2, ""

    iput-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    .line 48
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 51
    const-string v2, ""

    iput-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    .line 68
    if-eqz p1, :cond_0

    .line 69
    const-string v2, "{"

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_0

    .line 71
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 72
    .local v1, "json":Lorg/json/JSONObject;
    const-string v2, "uid"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setUid(Ljava/lang/String;)V

    .line 73
    const-string v2, "access_token"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setToken(Ljava/lang/String;)V

    .line 74
    const-string v2, "expires_in"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setExpiresIn(Ljava/lang/String;)V

    .line 75
    const-string v2, "refresh_token"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setRefreshToken(Ljava/lang/String;)V

    .line 76
    const-string v2, "phone_num"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setPhoneNum(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 83
    .end local v1    # "json":Lorg/json/JSONObject;
    :cond_0
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "accessToken"    # Ljava/lang/String;
    .param p2, "expiresIn"    # Ljava/lang/String;

    .prologue
    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    .line 44
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    .line 46
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    .line 48
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 51
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    .line 92
    iput-object p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    .line 93
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 94
    if-eqz p2, :cond_0

    .line 95
    iget-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    invoke-static {p2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    mul-long/2addr v2, v4

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 97
    :cond_0
    return-void
.end method

.method private static getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "bundle"    # Landroid/os/Bundle;
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;

    .prologue
    .line 283
    if-eqz p0, :cond_1

    .line 284
    invoke-virtual {p0, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 285
    .local v0, "value":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 288
    .end local v0    # "value":Ljava/lang/String;
    :goto_0
    return-object v0

    .restart local v0    # "value":Ljava/lang/String;
    :cond_0
    move-object v0, p2

    .line 285
    goto :goto_0

    .end local v0    # "value":Ljava/lang/String;
    :cond_1
    move-object v0, p2

    .line 288
    goto :goto_0
.end method

.method public static parseAccessToken(Landroid/os/Bundle;)Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    .locals 3
    .param p0, "bundle"    # Landroid/os/Bundle;

    .prologue
    .line 136
    if-eqz p0, :cond_0

    .line 137
    new-instance v0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;-><init>()V

    .line 138
    .local v0, "accessToken":Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    const-string v1, "uid"

    const-string v2, ""

    invoke-static {p0, v1, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setUid(Ljava/lang/String;)V

    .line 139
    const-string v1, "access_token"

    const-string v2, ""

    invoke-static {p0, v1, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setToken(Ljava/lang/String;)V

    .line 140
    const-string v1, "expires_in"

    const-string v2, ""

    invoke-static {p0, v1, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setExpiresIn(Ljava/lang/String;)V

    .line 141
    const-string v1, "refresh_token"

    const-string v2, ""

    invoke-static {p0, v1, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setRefreshToken(Ljava/lang/String;)V

    .line 142
    const-string v1, "phone_num"

    const-string v2, ""

    invoke-static {p0, v1, v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setPhoneNum(Ljava/lang/String;)V

    .line 147
    .end local v0    # "accessToken":Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseAccessToken(Ljava/lang/String;)Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    .locals 4
    .param p0, "responseJsonText"    # Ljava/lang/String;

    .prologue
    .line 107
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 108
    const-string v3, "{"

    invoke-virtual {p0, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    if-ltz v3, :cond_0

    .line 110
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 111
    .local v1, "json":Lorg/json/JSONObject;
    new-instance v2, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    invoke-direct {v2}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;-><init>()V

    .line 112
    .local v2, "token":Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    const-string v3, "uid"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setUid(Ljava/lang/String;)V

    .line 113
    const-string v3, "access_token"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setToken(Ljava/lang/String;)V

    .line 114
    const-string v3, "expires_in"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setExpiresIn(Ljava/lang/String;)V

    .line 115
    const-string v3, "refresh_token"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setRefreshToken(Ljava/lang/String;)V

    .line 116
    const-string v3, "phone_num"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setPhoneNum(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    .end local v1    # "json":Lorg/json/JSONObject;
    .end local v2    # "token":Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;
    :goto_0
    return-object v2

    .line 119
    :catch_0
    move-exception v0

    .line 120
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 125
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private setPhoneNum(Ljava/lang/String;)V
    .locals 0
    .param p1, "mPhoneNum"    # Ljava/lang/String;

    .prologue
    .line 301
    iput-object p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    .line 302
    return-void
.end method


# virtual methods
.method public getExpiresTime()J
    .locals 2

    .prologue
    .line 245
    iget-wide v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    return-wide v0
.end method

.method public getPhoneNum()Ljava/lang/String;
    .locals 1

    .prologue
    .line 297
    iget-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    return-object v0
.end method

.method public getRefreshToken()Ljava/lang/String;
    .locals 1

    .prologue
    .line 228
    iget-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    return-object v0
.end method

.method public getToken()Ljava/lang/String;
    .locals 1

    .prologue
    .line 212
    iget-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    return-object v0
.end method

.method public getUid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 196
    iget-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    return-object v0
.end method

.method public isSessionValid()Z
    .locals 1

    .prologue
    .line 156
    iget-object v0, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public setExpiresIn(Ljava/lang/String;)V
    .locals 6
    .param p1, "expiresIn"    # Ljava/lang/String;

    .prologue
    .line 264
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "0"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 265
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    mul-long/2addr v2, v4

    add-long/2addr v0, v2

    invoke-virtual {p0, v0, v1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->setExpiresTime(J)V

    .line 267
    :cond_0
    return-void
.end method

.method public setExpiresTime(J)V
    .locals 1
    .param p1, "mExpiresTime"    # J

    .prologue
    .line 255
    iput-wide p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    .line 256
    return-void
.end method

.method public setRefreshToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "refreshToken"    # Ljava/lang/String;

    .prologue
    .line 237
    iput-object p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    .line 238
    return-void
.end method

.method public setToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "mToken"    # Ljava/lang/String;

    .prologue
    .line 221
    iput-object p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    .line 222
    return-void
.end method

.method public setUid(Ljava/lang/String;)V
    .locals 0
    .param p1, "uid"    # Ljava/lang/String;

    .prologue
    .line 205
    iput-object p1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    .line 206
    return-void
.end method

.method public toBundle()Landroid/os/Bundle;
    .locals 4

    .prologue
    .line 169
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 170
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "uid"

    iget-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 171
    const-string v1, "access_token"

    iget-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 172
    const-string v1, "refresh_token"

    iget-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 173
    const-string v1, "expires_in"

    iget-wide v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 174
    const-string v1, "phone_num"

    iget-object v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 175
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 183
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "uid: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mUid:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 184
    const-string v1, "access_token"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 185
    const-string v1, "refresh_token"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mRefreshToken:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 186
    const-string v1, "phone_num"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mPhoneNum:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 187
    const-string v1, "expires_in"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v2, p0, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->mExpiresTime:J

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 183
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
