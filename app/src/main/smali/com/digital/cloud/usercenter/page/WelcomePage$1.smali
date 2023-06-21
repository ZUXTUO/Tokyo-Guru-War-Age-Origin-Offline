.class Lcom/digital/cloud/usercenter/page/WelcomePage$1;
.super Ljava/lang/Object;
.source "WelcomePage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/WelcomePage;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/WelcomePage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/WelcomePage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/WelcomePage$1;->this$0:Lcom/digital/cloud/usercenter/page/WelcomePage;

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/WelcomePage$1;->this$0:Lcom/digital/cloud/usercenter/page/WelcomePage;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/page/WelcomePage;->finish()V

    .line 24
    return-void
.end method
