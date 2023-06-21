.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$6;
.super Ljava/lang/Object;
.source "AccountLoginPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AccountLoginPage;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$6;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 157
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 161
    invoke-static {}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$6()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$6;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$7(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/CheckBox;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-nez v0, :cond_0

    .line 162
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    .line 163
    const-string v1, "string"

    const-string v2, "c_ydfwtk"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 167
    :goto_0
    return-void

    .line 165
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->QuickRegisterPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    goto :goto_0
.end method
