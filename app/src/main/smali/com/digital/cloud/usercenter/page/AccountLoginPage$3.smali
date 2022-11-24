.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;
.super Ljava/lang/Object;
.source "AccountLoginPage.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 1
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 103
    if-eqz p2, :cond_0

    .line 104
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$2(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ListPopupWindow;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/ListPopupWindow;->show()V

    .line 108
    :goto_0
    return-void

    .line 106
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$2(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ListPopupWindow;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/ListPopupWindow;->dismiss()V

    goto :goto_0
.end method
