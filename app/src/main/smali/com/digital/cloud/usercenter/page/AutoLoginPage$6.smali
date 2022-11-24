.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$6;
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$6;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 192
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 196
    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    if-eqz v0, :cond_0

    .line 197
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    .line 200
    :goto_0
    return-void

    .line 199
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    goto :goto_0
.end method
