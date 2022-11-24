.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;
.super Ljava/lang/Object;
.source "AccountLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onChange(Lcom/digital/cloud/usercenter/AccountInfo;)V
    .locals 2
    .param p1, "info"    # Lcom/digital/cloud/usercenter/AccountInfo;

    .prologue
    .line 76
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p1, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 77
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p1, Lcom/digital/cloud/usercenter/AccountInfo;->mPwd:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 78
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$2(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ListPopupWindow;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/ListPopupWindow;->dismiss()V

    .line 79
    return-void
.end method
