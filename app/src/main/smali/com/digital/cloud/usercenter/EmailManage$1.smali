.class Lcom/digital/cloud/usercenter/EmailManage$1;
.super Ljava/lang/Object;
.source "EmailManage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/EmailManage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 110
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 6
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 113
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter http return:"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 114
    invoke-static {}, Lcom/digital/cloud/usercenter/EmailManage;->access$0()Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    move-result-object v3

    invoke-interface {v3, p1}, Lcom/digital/cloud/usercenter/EmailManage$registerListener;->Finished(Ljava/lang/String;)V

    .line 116
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 117
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 118
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 119
    invoke-static {}, Lcom/digital/cloud/usercenter/EmailManage;->access$1()Landroid/app/Activity;

    move-result-object v3

    new-instance v4, Lcom/digital/cloud/usercenter/EmailManage$1$1;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/EmailManage$1$1;-><init>(Lcom/digital/cloud/usercenter/EmailManage$1;)V

    invoke-virtual {v3, v4}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 132
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :cond_0
    :goto_0
    const/4 v3, 0x0

    invoke-static {v3}, Lcom/digital/cloud/usercenter/EmailManage;->access$5(Z)V

    .line 133
    return-void

    .line 128
    :catch_0
    move-exception v0

    .line 129
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 130
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter emailManageListener Format fail"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
