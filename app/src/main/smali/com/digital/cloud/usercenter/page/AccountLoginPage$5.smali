.class Lcom/digital/cloud/usercenter/page/AccountLoginPage$5;
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$5;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 138
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "arg0"    # Landroid/view/View;

    .prologue
    .line 142
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage$5;->this$0:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->access$5(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/app/Activity;

    move-result-object v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/ClausePage;->show(Landroid/app/Activity;)V

    .line 143
    return-void
.end method
