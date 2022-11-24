.class Lcom/digitalsky/sdk/common/Utils$1;
.super Ljava/lang/Object;
.source "Utils.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/common/Utils;->verify(Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$callback:Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;

.field private final synthetic val$data:Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/common/Utils$1;->val$data:Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    iput-object p2, p0, Lcom/digitalsky/sdk/common/Utils$1;->val$callback:Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 2
    .param p1, "ret"    # Ljava/lang/String;

    .prologue
    .line 52
    new-instance v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    invoke-direct {v0, p1}, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;-><init>(Ljava/lang/String;)V

    .line 53
    .local v0, "res":Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;
    iget-object v1, p0, Lcom/digitalsky/sdk/common/Utils$1;->val$data:Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    iget v1, v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    iput v1, v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->platform_type:I

    .line 54
    iget-object v1, p0, Lcom/digitalsky/sdk/common/Utils$1;->val$data:Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    iget-object v1, v1, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    iput-object v1, v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->ext:Ljava/lang/String;

    .line 55
    iget-object v1, p0, Lcom/digitalsky/sdk/common/Utils$1;->val$callback:Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;

    invoke-interface {v1, v0}, Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;->onCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V

    .line 56
    return-void
.end method
