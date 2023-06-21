.class Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;
.super Ljava/lang/Object;
.source "QuickRegisterPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->submitRegistBottonEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    .line 322
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;)Lcom/digital/cloud/usercenter/page/QuickRegisterPage;
    .locals 1

    .prologue
    .line 322
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    return-object v0
.end method


# virtual methods
.method public Finished(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 326
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->access$6(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10$1;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 366
    return-void
.end method
