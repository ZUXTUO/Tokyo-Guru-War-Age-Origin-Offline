.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;
.super Landroid/os/CountDownTimer;
.source "AutoLoginPage.java"


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

.field private final synthetic val$mDlz:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;JJLjava/lang/String;)V
    .locals 0
    .param p2, "$anonymous0"    # J
    .param p4, "$anonymous1"    # J

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    iput-object p6, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->val$mDlz:Ljava/lang/String;

    .line 83
    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 4

    .prologue
    .line 102
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->isAlreadyNotify()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 113
    :goto_0
    return-void

    .line 104
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$6(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 105
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$7(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v1

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/digital/cloud/usercenter/page/PageManager;->setAccountState(IZ)V

    .line 106
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "string"

    const-string v3, "c_hyhl"

    invoke-static {v2, v3}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v2}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->getUserName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showWelcome(Ljava/lang/String;)V

    .line 107
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->notifyResult()V

    goto :goto_0

    .line 109
    :cond_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_zddlcs"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 111
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$8(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    goto :goto_0
.end method

.method public onTick(J)V
    .locals 3
    .param p1, "millisUntilFinished"    # J

    .prologue
    .line 87
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$4(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V

    .line 88
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 89
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$5(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->val$mDlz:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, ".  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 98
    :cond_0
    :goto_0
    return-void

    .line 90
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    .line 91
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$5(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->val$mDlz:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, ".. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 92
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v0

    const/4 v1, 0x3

    if-ne v0, v1, :cond_3

    .line 93
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$5(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->val$mDlz:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "..."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 94
    :cond_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    .line 95
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$5(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->val$mDlz:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "   "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 96
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$4(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V

    goto :goto_0
.end method
