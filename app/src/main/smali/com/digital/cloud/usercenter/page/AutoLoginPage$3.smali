.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 122
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$9(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/os/CountDownTimer;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 123
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$8(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    .line 124
    return-void
.end method
