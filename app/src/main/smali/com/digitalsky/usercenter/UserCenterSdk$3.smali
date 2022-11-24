.class Lcom/digitalsky/usercenter/UserCenterSdk$3;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/usercenter/UserCenterSdk;->showToolBar()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/usercenter/UserCenterSdk;


# direct methods
.method constructor <init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk$3;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 150
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk$3;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$1(Lcom/digitalsky/usercenter/UserCenterSdk;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "showToolBar"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 151
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setToolebarAutoShow(Z)V

    .line 152
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->onShowToolebar()V

    .line 154
    return-void
.end method
