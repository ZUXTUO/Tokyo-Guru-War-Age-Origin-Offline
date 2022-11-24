.class Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;
.super Ljava/lang/Object;
.source "QuickRegisterPage.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    .line 158
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "arg0"    # Landroid/widget/CompoundButton;
    .param p2, "arg1"    # Z

    .prologue
    .line 162
    if-eqz p2, :cond_0

    .line 163
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->access$4(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    .line 168
    :goto_0
    return-void

    .line 165
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->access$4(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;

    move-result-object v0

    new-instance v1, Landroid/text/method/PasswordTransformationMethod;

    invoke-direct {v1}, Landroid/text/method/PasswordTransformationMethod;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    goto :goto_0
.end method
