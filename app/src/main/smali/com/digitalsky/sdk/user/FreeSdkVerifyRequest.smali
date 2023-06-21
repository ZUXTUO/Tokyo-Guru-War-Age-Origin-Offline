.class public Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
.super Ljava/lang/Object;
.source "FreeSdkVerifyRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public access_token:Ljava/lang/String;

.field public authorization_code:Ljava/lang/String;

.field public code:I

.field public expiration:Ljava/lang/String;

.field public ext:Ljava/lang/String;

.field public name:Ljava/lang/String;

.field public openid:Ljava/lang/String;

.field public platform_type:I

.field public session_id:Ljava/lang/String;

.field public skipVerfy:Z

.field public token:Ljava/lang/String;

.field public uid:Ljava/lang/String;

.field public userip:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, -0x1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    .line 18
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    .line 24
    const-string v0, "127.0.0.1"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 35
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 41
    return-void
.end method

.method public constructor <init>(IILjava/lang/String;)V
    .locals 3
    .param p1, "ret"    # I
    .param p2, "platType"    # I
    .param p3, "in_ext"    # Ljava/lang/String;

    .prologue
    const/4 v2, -0x1

    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    .line 18
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    .line 24
    const-string v0, "127.0.0.1"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 35
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 63
    iput p2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 64
    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 65
    iput p1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 66
    return-void
.end method

.method public constructor <init>(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "ret"    # I
    .param p2, "platType"    # I
    .param p3, "tx_openid"    # Ljava/lang/String;
    .param p4, "tx_token"    # Ljava/lang/String;
    .param p5, "in_ext"    # Ljava/lang/String;

    .prologue
    const/4 v2, -0x1

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    .line 18
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    .line 24
    const-string v0, "127.0.0.1"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 35
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 44
    iput p2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 45
    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 46
    iput-object p5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 47
    iput p1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 48
    return-void
.end method

.method public constructor <init>(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "ret"    # I
    .param p2, "platType"    # I
    .param p3, "o_uid"    # Ljava/lang/String;
    .param p4, "o_name"    # Ljava/lang/String;
    .param p5, "o_token"    # Ljava/lang/String;
    .param p6, "o_expiration"    # Ljava/lang/String;
    .param p7, "o_authorization_code"    # Ljava/lang/String;
    .param p8, "o_session_id"    # Ljava/lang/String;
    .param p9, "in_ext"    # Ljava/lang/String;

    .prologue
    const/4 v2, -0x1

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    .line 18
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    .line 24
    const-string v0, "127.0.0.1"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 35
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 51
    iput p2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 52
    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 53
    iput-object p4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 54
    iput-object p5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 55
    iput-object p6, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 56
    iput-object p7, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 57
    iput-object p8, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 58
    iput-object p9, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 59
    iput p1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 60
    return-void
.end method

.method public constructor <init>(IILjava/lang/String;Z)V
    .locals 3
    .param p1, "ret"    # I
    .param p2, "platType"    # I
    .param p3, "in_ext"    # Ljava/lang/String;
    .param p4, "skip"    # Z

    .prologue
    const/4 v2, -0x1

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    .line 18
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    .line 24
    const-string v0, "127.0.0.1"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 35
    iput v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 69
    iput p2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    .line 70
    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    .line 71
    iput p1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    .line 72
    iput-boolean p4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 73
    return-void
.end method


# virtual methods
.method public data()Ljava/lang/String;
    .locals 4

    .prologue
    .line 125
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 127
    .local v1, "ret":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "plat"

    iget v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 128
    iget v2, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->code:I

    if-nez v2, :cond_0

    .line 129
    const-string v2, "ext"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 137
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 131
    :cond_0
    :try_start_1
    const-string v2, "msg"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 133
    :catch_0
    move-exception v0

    .line 135
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public toVerifyData()[B
    .locals 7

    .prologue
    .line 107
    invoke-virtual {p0}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->toVerifyJsonStr()Ljava/lang/String;

    move-result-object v4

    .line 108
    .local v4, "verrfyData":Ljava/lang/String;
    iget-object v5, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 109
    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    sget-object v6, Lcom/digitalsky/sdk/common/Constant;->APP_KEY:[B

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/XXTEA;->encrypt([B[B)[B

    move-result-object v0

    .line 110
    .local v0, "data":[B
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 112
    .local v2, "head":Lorg/json/JSONObject;
    :try_start_0
    const-string v5, "app_id"

    sget-object v6, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 113
    const-string v5, "version"

    sget-object v6, Lcom/digitalsky/sdk/common/Constant;->VERSION:Ljava/lang/String;

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 117
    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    array-length v5, v5

    add-int/lit8 v5, v5, 0x1

    array-length v6, v0

    add-int/2addr v5, v6

    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 118
    .local v3, "tmp":Ljava/nio/ByteBuffer;
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 119
    const/4 v5, 0x0

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 120
    invoke-virtual {v3, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 121
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v5

    return-object v5

    .line 114
    .end local v3    # "tmp":Ljava/nio/ByteBuffer;
    :catch_0
    move-exception v1

    .line 115
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public toVerifyJsonStr()Ljava/lang/String;
    .locals 5

    .prologue
    .line 76
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 78
    .local v0, "data":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "app_id"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 79
    const-string v3, "platform_type"

    iget v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 80
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 81
    .local v2, "verify_json_data":Lorg/json/JSONObject;
    const-string v3, "app_id"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 82
    const-string v3, "platform_type"

    iget v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 83
    iget v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    const v4, 0x186a0

    if-eq v3, v4, :cond_0

    iget v3, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    const v4, 0x186a1

    if-ne v3, v4, :cond_1

    .line 84
    :cond_0
    const-string v3, "openid"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->openid:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 85
    const-string v3, "openkey"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 86
    const-string v3, "access_token"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->access_token:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 88
    const-string v3, "userip"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->userip:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 97
    :goto_0
    const-string v3, "verify_json_data"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 103
    .end local v2    # "verify_json_data":Lorg/json/JSONObject;
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 90
    .restart local v2    # "verify_json_data":Lorg/json/JSONObject;
    :cond_1
    :try_start_1
    const-string v3, "uid"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->uid:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 91
    const-string v3, "name"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->name:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 92
    const-string v3, "token"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->token:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 93
    const-string v3, "expiration"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->expiration:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 94
    const-string v3, "authorization_code"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->authorization_code:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 95
    const-string v3, "session_id"

    iget-object v4, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->session_id:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 98
    .end local v2    # "verify_json_data":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    .line 100
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method
