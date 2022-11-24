.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 193
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;)Lcom/digital/cloud/usercenter/page/AccountLoginPage;
    .locals 1

    .prologue
    .line 193
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v1, 0x1

    .line 197
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$8(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 265
    :goto_0
    return-void

    .line 200
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-ge v0, v1, :cond_2

    .line 201
    :cond_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    .line 202
    const-string v1, "string"

    const-string v2, "c_zhmmbnwk"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 206
    :cond_2
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 207
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, ""

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "md5"

    .line 208
    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9$1;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9$1;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;)V

    .line 207
    invoke-static {v0, v1, v2, v3, v4}, Lcom/digital/cloud/usercenter/NormalLogin;->normalLogin(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/NormalLogin$loginListener;)V

    goto :goto_0
.end method
