.class Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;
.super Ljava/lang/Object;
.source "ResetPasswordPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeBottonEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 280
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;)Lcom/digital/cloud/usercenter/page/ResetPasswordPage;
    .locals 1

    .prologue
    .line 280
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    return-object v0
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 3
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 284
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "vcodeBottonEvent http return:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 285
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 284
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 286
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->access$6(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9$1;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 314
    return-void
.end method
