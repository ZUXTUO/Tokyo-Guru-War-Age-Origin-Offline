.class public Lcom/digital/cloud/usercenter/UserInfo;
.super Ljava/lang/Object;
.source "UserInfo.java"


# instance fields
.field public isGuest:Z

.field public mode:Ljava/lang/String;

.field public msg:Ljava/lang/String;

.field public openid:Ljava/lang/String;

.field public state:I

.field public token:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    iput-boolean v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    .line 9
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    .line 10
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    .line 11
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->mode:Ljava/lang/String;

    .line 12
    const/4 v0, 0x5

    iput v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    .line 13
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->msg:Ljava/lang/String;

    .line 25
    iput-boolean v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    .line 26
    return-void
.end method

.method public constructor <init>(Lorg/json/JSONObject;)V
    .locals 3
    .param p1, "data"    # Lorg/json/JSONObject;

    .prologue
    const/4 v0, 0x1

    const/4 v2, 0x5

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    .line 9
    const-string v1, ""

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    .line 10
    const-string v1, ""

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    .line 11
    const-string v1, ""

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->mode:Ljava/lang/String;

    .line 12
    iput v2, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    .line 13
    const-string v1, ""

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->msg:Ljava/lang/String;

    .line 16
    const-string v1, "msg"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->msg:Ljava/lang/String;

    .line 17
    const-string v1, "openid"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    .line 18
    const-string v1, "accessToken"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    .line 19
    const-string v1, "state"

    invoke-virtual {p1, v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    .line 20
    const-string v1, "register_mode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->mode:Ljava/lang/String;

    .line 21
    iget v1, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    if-ne v1, v2, :cond_0

    :goto_0
    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    .line 22
    return-void

    .line 21
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public clear()V
    .locals 1

    .prologue
    .line 29
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->mode:Ljava/lang/String;

    .line 33
    const/4 v0, -0x1

    iput v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserInfo;->msg:Ljava/lang/String;

    .line 35
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 38
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 40
    .local v1, "root":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "guest"

    iget-boolean v3, p0, Lcom/digital/cloud/usercenter/UserInfo;->isGuest:Z

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 41
    const-string v2, "openid"

    iget-object v3, p0, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 42
    const-string v2, "token"

    iget-object v3, p0, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 43
    const-string v2, "account_state"

    iget v3, p0, Lcom/digital/cloud/usercenter/UserInfo;->state:I

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 49
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 44
    :catch_0
    move-exception v0

    .line 46
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
