.class Lcom/digital/cloud/usercenter/page/QuickRegisterPage$2;
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$2;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 94
    if-eqz p2, :cond_0

    .line 95
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$2;->this$0:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->access$0(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;)V

    .line 97
    :cond_0
    return-void
.end method
