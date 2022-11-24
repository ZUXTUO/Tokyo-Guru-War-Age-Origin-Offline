.class Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;
.super Ljava/lang/Object;
.source "FirstLoginPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/FirstLoginPage;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/FirstLoginPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;)Lcom/digital/cloud/usercenter/page/FirstLoginPage;
    .locals 1

    .prologue
    .line 34
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 75
    :goto_0
    return-void

    .line 40
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 41
    new-instance v0, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1$1;-><init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;)V

    invoke-static {v0}, Lcom/digital/cloud/usercenter/DevIdLogin;->login(Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;)V

    goto :goto_0
.end method
