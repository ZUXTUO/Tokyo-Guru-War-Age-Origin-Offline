.class Lcom/digital/cloud/usercenter/toolbar/ToolBarController$1;
.super Ljava/lang/Object;
.source "ToolBarController.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->getToolBarConfig()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarController;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public asyncHttpRequestFinished(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 85
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "Get Items config"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 86
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-static {v0, p1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarController;Ljava/lang/String;)V

    .line 87
    return-void
.end method
