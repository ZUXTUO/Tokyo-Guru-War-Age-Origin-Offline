.class Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;
.super Ljava/lang/Object;
.source "ResetPasswordPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->submitPwdResetBottonEvent()V
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 337
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public Finished(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 341
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->access$6(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10$1;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 376
    return-void
.end method
