.class Lcom/digital/cloud/usercenter/page/ResetPasswordPage$2;
.super Ljava/lang/Object;
.source "ResetPasswordPage.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$2;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 100
    if-eqz p2, :cond_0

    .line 101
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$2;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->access$0(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;)V

    .line 103
    :cond_0
    return-void
.end method
