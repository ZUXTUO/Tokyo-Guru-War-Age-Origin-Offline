.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;
.super Ljava/lang/Object;
.source "AccountLoginPage.java"

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 3
    .param p1, "arg0"    # Landroid/view/View;
    .param p2, "arg1"    # Z

    .prologue
    .line 120
    if-eqz p2, :cond_0

    .line 121
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$4(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ImageView;

    move-result-object v0

    const-string v1, "drawable"

    const-string v2, "user_center_panda_close"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 126
    :goto_0
    return-void

    .line 123
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$4(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ImageView;

    move-result-object v0

    const-string v1, "drawable"

    const-string v2, "user_center_title_log"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0
.end method
