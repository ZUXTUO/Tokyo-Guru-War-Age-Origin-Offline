.class Lcom/digital/cloud/usercenter/UsernameLogin$1;
.super Ljava/lang/Object;
.source "UsernameLogin.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/UsernameLogin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 163
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 9
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 166
    const-string v6, "NDK_INFO"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "UserCenter http return:"

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 168
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 169
    .local v4, "root":Lorg/json/JSONObject;
    const-string v6, "result"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    .line 170
    .local v3, "result":I
    const-string v6, "msg"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 171
    .local v1, "msg":Ljava/lang/String;
    const-string v6, "openid"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 172
    .local v2, "openid":Ljava/lang/String;
    const-string v6, "username"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 173
    .local v5, "username":Ljava/lang/String;
    if-nez v3, :cond_0

    .line 174
    invoke-static {}, Lcom/digital/cloud/usercenter/UsernameLogin;->access$0()Landroid/app/Activity;

    move-result-object v6

    new-instance v7, Lcom/digital/cloud/usercenter/UsernameLogin$1$1;

    invoke-direct {v7, p0}, Lcom/digital/cloud/usercenter/UsernameLogin$1$1;-><init>(Lcom/digital/cloud/usercenter/UsernameLogin$1;)V

    invoke-virtual {v6, v7}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 187
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "openid":Ljava/lang/String;
    .end local v3    # "result":I
    .end local v4    # "root":Lorg/json/JSONObject;
    .end local v5    # "username":Ljava/lang/String;
    :cond_0
    :goto_0
    const/4 v6, 0x0

    invoke-static {v6}, Lcom/digital/cloud/usercenter/UsernameLogin;->access$4(Z)V

    .line 188
    return-void

    .line 183
    :catch_0
    move-exception v0

    .line 184
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 185
    const-string v6, "NDK_INFO"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "UserCenter UsernameRegister Format fail"

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
