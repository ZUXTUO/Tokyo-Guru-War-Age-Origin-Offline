.class Lcom/digital/cloud/usercenter/NormalLogin$2;
.super Ljava/lang/Object;
.source "NormalLogin.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/NormalLogin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 6
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 152
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter NormalLogin return:"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 155
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 156
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 157
    const-string v3, "openid"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$3(Ljava/lang/String;)V

    .line 158
    const-string v3, "access_token"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$4(Ljava/lang/String;)V

    .line 159
    const-string v3, "register_mode"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$5(Ljava/lang/String;)V

    .line 160
    const-string v3, "state"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v3

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$6(I)V

    .line 161
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->saveModuleInfo()V

    .line 162
    const/4 v3, 0x1

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$0(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 171
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->access$7()Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    move-result-object v3

    invoke-interface {v3, p1}, Lcom/digital/cloud/usercenter/NormalLogin$loginListener;->finish(Ljava/lang/String;)V

    .line 172
    const/4 v3, 0x0

    invoke-static {v3}, Lcom/digital/cloud/usercenter/NormalLogin;->access$2(Z)V

    .line 173
    return-void

    .line 164
    .restart local v1    # "result":I
    .restart local v2    # "root":Lorg/json/JSONObject;
    :cond_0
    :try_start_1
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "NormalLogin fail: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digital/cloud/utils/ErrorReport;->log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 166
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 167
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 168
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "NormalLogin error: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digital/cloud/utils/ErrorReport;->log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
