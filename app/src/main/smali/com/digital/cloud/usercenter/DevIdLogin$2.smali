.class Lcom/digital/cloud/usercenter/DevIdLogin$2;
.super Ljava/lang/Object;
.source "DevIdLogin.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/DevIdLogin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 130
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 6
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 133
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter http return:"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    if-nez p1, :cond_0

    .line 136
    sget-object v3, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    const-string v4, "DevidLogin error return null"

    invoke-static {v3, v4}, Lcom/digital/cloud/utils/ErrorReport;->log(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    :cond_0
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 139
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 140
    .local v1, "result":I
    if-eqz v1, :cond_1

    .line 141
    const-string v3, ""

    invoke-static {v3}, Lcom/digital/cloud/usercenter/DevIdLogin;->access$0(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 147
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :cond_1
    :goto_0
    invoke-static {p1}, Lcom/digital/cloud/usercenter/DevIdLogin;->access$2(Ljava/lang/String;)V

    .line 148
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->access$3()Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;

    move-result-object v3

    invoke-interface {v3, p1}, Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;->finish(Ljava/lang/String;)V

    .line 149
    const/4 v3, 0x0

    invoke-static {v3}, Lcom/digital/cloud/usercenter/DevIdLogin;->access$4(Z)V

    .line 150
    return-void

    .line 143
    :catch_0
    move-exception v0

    .line 145
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
