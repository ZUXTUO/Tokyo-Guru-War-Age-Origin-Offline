.class Lcom/digitalsky/usercenter/UserCenterSdk$4;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/usercenter/UserCenterSdk;->hideToolBar()Z
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
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk$4;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 161
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 165
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk$4;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$1(Lcom/digitalsky/usercenter/UserCenterSdk;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "hideToolBar"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 166
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setToolebarAutoShow(Z)V

    .line 167
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->onHideToolebar()V

    .line 169
    return-void
.end method
