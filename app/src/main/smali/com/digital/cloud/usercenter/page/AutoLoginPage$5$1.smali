.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/AutoLogin$loginListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;
    .locals 1

    .prologue
    .line 149
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    return-object v0
.end method


# virtual methods
.method public Finished(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 153
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;

    invoke-direct {v1, p0, p1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 187
    return-void
.end method
