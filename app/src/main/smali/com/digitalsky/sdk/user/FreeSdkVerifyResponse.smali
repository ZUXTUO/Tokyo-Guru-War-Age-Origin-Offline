.class public Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;
.super Ljava/lang/Object;
.source "FreeSdkVerifyResponse.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public access_token:Ljava/lang/String;

.field public authorization_code:Ljava/lang/String;

.field public expiration:Ljava/lang/String;

.field public ext:Ljava/lang/String;

.field public msg:Ljava/lang/String;

.field public name:Ljava/lang/String;

.field public openid:Ljava/lang/String;

.field public platform_type:I

.field public result:I

.field public session_id:Ljava/lang/String;

.field public token:Ljava/lang/String;

.field public uid:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    const/4 v5, -0x1

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    iput v5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->result:I

    .line 13
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->msg:Ljava/lang/String;

    .line 15
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->openid:Ljava/lang/String;

    .line 16
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->access_token:Ljava/lang/String;

    .line 18
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->uid:Ljava/lang/String;

    .line 19
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->name:Ljava/lang/String;

    .line 20
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->token:Ljava/lang/String;

    .line 21
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->expiration:Ljava/lang/String;

    .line 22
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->authorization_code:Ljava/lang/String;

    .line 23
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->session_id:Ljava/lang/String;

    .line 25
    iput v5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->platform_type:I

    .line 26
    const-string v3, ""

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->ext:Ljava/lang/String;

    .line 28
    new-instance v3, Ljava/lang/StringBuilder;

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v4, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->TAG:Ljava/lang/String;

    .line 32
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 33
    .local v1, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    iput v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->result:I

    .line 34
    const-string v3, "msg"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->msg:Ljava/lang/String;

    .line 35
    const-string v3, "openid"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->openid:Ljava/lang/String;

    .line 36
    const-string v3, "access_token"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->access_token:Ljava/lang/String;

    .line 38
    const-string v3, "verify_json_data"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 40
    .local v2, "verify_json_data":Lorg/json/JSONObject;
    if-eqz v2, :cond_0

    .line 41
    const-string v3, "uid"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->uid:Ljava/lang/String;

    .line 42
    const-string v3, "name"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->name:Ljava/lang/String;

    .line 43
    const-string v3, "token"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->token:Ljava/lang/String;

    .line 44
    const-string v3, "expiration"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->expiration:Ljava/lang/String;

    .line 45
    const-string v3, "authorization_code"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->authorization_code:Ljava/lang/String;

    .line 46
    const-string v3, "session_id"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->session_id:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    .end local v1    # "root":Lorg/json/JSONObject;
    .end local v2    # "verify_json_data":Lorg/json/JSONObject;
    :cond_0
    :goto_0
    return-void

    .line 48
    :catch_0
    move-exception v0

    .line 49
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 50
    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    iput v5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->result:I

    .line 52
    iput-object p1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->msg:Ljava/lang/String;

    goto :goto_0
.end method


# virtual methods
.method public data()Ljava/lang/String;
    .locals 4

    .prologue
    .line 59
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 61
    .local v0, "data":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "openid"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->openid:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    const-string v2, "token"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->access_token:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 63
    const-string v2, "msg"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->msg:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 64
    const-string v2, "ext"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->ext:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 65
    const-string v2, "plat"

    iget v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->platform_type:I

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 70
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 66
    :catch_0
    move-exception v1

    .line 68
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
