.class Lcom/digitalsky/usercenter/UserCenterSdk$1;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/usercenter/UserCenterSdk;->login()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/usercenter/UserCenterSdk;


# direct methods
.method constructor <init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk$1;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public result(Ljava/lang/String;)V
    .locals 11
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    const/4 v10, -0x1

    const/4 v9, 0x0

    .line 76
    :try_start_0
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 77
    .local v5, "root":Lorg/json/JSONObject;
    const-string v6, "result"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    .line 78
    .local v4, "result":I
    if-nez v4, :cond_0

    .line 79
    const-string v6, "accessToken"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 80
    .local v0, "accessToken":Ljava/lang/String;
    const-string v6, "access_token"

    invoke-virtual {v5, v6, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 81
    new-instance v3, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    const/4 v6, 0x0

    const/4 v7, 0x0

    .line 82
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    .line 81
    invoke-direct {v3, v6, v7, v8}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;-><init>(IILjava/lang/String;)V

    .line 83
    .local v3, "req_success":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    const/4 v6, 0x1

    iput-boolean v6, v3, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    .line 84
    iget-object v6, p0, Lcom/digitalsky/usercenter/UserCenterSdk$1;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v6}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$0(Lcom/digitalsky/usercenter/UserCenterSdk;)Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    move-result-object v6

    const/4 v7, 0x0

    invoke-interface {v6, v7, v3}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V

    .line 102
    .end local v0    # "accessToken":Ljava/lang/String;
    .end local v3    # "req_success":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    .end local v4    # "result":I
    .end local v5    # "root":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 86
    .restart local v4    # "result":I
    .restart local v5    # "root":Lorg/json/JSONObject;
    :cond_0
    new-instance v2, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    const/4 v6, -0x1

    const/4 v7, 0x0

    .line 87
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    .line 86
    invoke-direct {v2, v6, v7, v8}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;-><init>(IILjava/lang/String;)V

    .line 88
    .local v2, "req_fali":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    iget-object v6, p0, Lcom/digitalsky/usercenter/UserCenterSdk$1;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v6}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$0(Lcom/digitalsky/usercenter/UserCenterSdk;)Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    move-result-object v6

    const/4 v7, -0x1

    invoke-interface {v6, v7, v2}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 93
    .end local v2    # "req_fali":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    .end local v4    # "result":I
    .end local v5    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    .line 94
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    .line 95
    new-instance v2, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    .line 96
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 95
    invoke-direct {v2, v10, v9, v6}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;-><init>(IILjava/lang/String;)V

    .line 97
    .restart local v2    # "req_fali":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    iget-object v6, p0, Lcom/digitalsky/usercenter/UserCenterSdk$1;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v6}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$0(Lcom/digitalsky/usercenter/UserCenterSdk;)Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    move-result-object v6

    invoke-interface {v6, v10, v2}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V

    goto :goto_0
.end method
