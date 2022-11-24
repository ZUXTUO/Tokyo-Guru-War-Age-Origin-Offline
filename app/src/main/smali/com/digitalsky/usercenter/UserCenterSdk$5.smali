.class Lcom/digitalsky/usercenter/UserCenterSdk$5;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/usercenter/UserCenterSdk;->enterPlatform(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

.field private final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/digitalsky/usercenter/UserCenterSdk;I)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk$5;->this$0:Lcom/digitalsky/usercenter/UserCenterSdk;

    iput p2, p0, Lcom/digitalsky/usercenter/UserCenterSdk$5;->val$index:I

    .line 186
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 190
    iget v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk$5;->val$index:I

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showToolBarPage(I)V

    .line 191
    return-void
.end method
