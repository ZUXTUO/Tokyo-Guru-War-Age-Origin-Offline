.class Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor$InstallHandler;
.super Landroid/os/Handler;
.source "AppInstallCmdExecutor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "InstallHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;


# direct methods
.method public constructor <init>(Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;Landroid/os/Looper;)V
    .locals 0
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 71
    iput-object p1, p0, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor$InstallHandler;->this$0:Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;

    .line 72
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 73
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 77
    iget v0, p1, Landroid/os/Message;->what:I

    .line 78
    .local v0, "msgWhat":I
    packed-switch v0, :pswitch_data_0

    .line 89
    :goto_0
    return-void

    .line 80
    :pswitch_0
    iget-object v2, p0, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor$InstallHandler;->this$0:Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/sina/weibo/sdk/cmd/AppInstallCmd;

    invoke-static {v2, v1}, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;->access$1(Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;Lcom/sina/weibo/sdk/cmd/AppInstallCmd;)V

    goto :goto_0

    .line 83
    :pswitch_1
    iget-object v1, p0, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor$InstallHandler;->this$0:Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;

    invoke-static {v1}, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;->access$2(Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;)Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Looper;->quit()V

    .line 84
    iget-object v1, p0, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor$InstallHandler;->this$0:Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;->access$3(Lcom/sina/weibo/sdk/cmd/AppInstallCmdExecutor;Z)V

    goto :goto_0

    .line 78
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
