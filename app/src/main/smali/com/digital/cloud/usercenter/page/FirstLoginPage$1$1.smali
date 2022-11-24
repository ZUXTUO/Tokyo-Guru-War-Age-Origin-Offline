.class Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;
.super Ljava/lang/Object;
.source "FirstLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;)Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;

    return-object v0
.end method


# virtual methods
.method public finish(Ljava/lang/String;)V
    .locals 3
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 45
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DevIdLogin.login:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 46
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;->access$0(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;)Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    move-result-object v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1$1;-><init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 73
    return-void
.end method
