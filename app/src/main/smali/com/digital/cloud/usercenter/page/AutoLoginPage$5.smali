.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginShow()V
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 142
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;
    .locals 1

    .prologue
    .line 142
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 146
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$10(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 189
    :goto_0
    return-void

    .line 148
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 149
    new-instance v0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)V

    invoke-static {v0}, Lcom/digital/cloud/usercenter/AutoLogin;->login(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V

    goto :goto_0
.end method
