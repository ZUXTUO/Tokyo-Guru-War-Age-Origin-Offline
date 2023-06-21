.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/AutoLogin$loginListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AutoLoginPage;->autoLoginShow()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    return-object v0
.end method


# virtual methods
.method public Finished(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 58
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 75
    return-void
.end method
