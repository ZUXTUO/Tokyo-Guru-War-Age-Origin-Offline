.class Lcom/digital/cloud/usercenter/page/ResetPasswordPage$1;
.super Ljava/lang/Object;
.source "ResetPasswordPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$1;->this$0:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 88
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    .line 89
    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    .line 90
    return-void
.end method