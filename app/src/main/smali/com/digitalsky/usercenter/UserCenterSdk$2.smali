.class Lcom/digitalsky/usercenter/UserCenterSdk$2;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/usercenter/UserCenterSdk;->login()Z
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
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk$2;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public finish()V
    .locals 1

    .prologue
    .line 107
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk$2;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-static {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->access$0(Lcom/digitalsky/usercenter/UserCenterSdk;)Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    move-result-object v0

    invoke-interface {v0}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLogoutCallback()V

    .line 108
    return-void
.end method
