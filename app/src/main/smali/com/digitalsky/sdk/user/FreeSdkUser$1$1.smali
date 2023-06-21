.class Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;
.super Ljava/lang/Object;
.source "FreeSdkUser.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/user/FreeSdkUser$1;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digitalsky/sdk/user/FreeSdkUser$1;

.field private final synthetic val$entry:Ljava/util/Map$Entry;

.field private final synthetic val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/user/FreeSdkUser$1;Ljava/util/Map$Entry;Lcom/digitalsky/sdk/common/Listener$ILoginCallback;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;->this$1:Lcom/digitalsky/sdk/user/FreeSdkUser$1;

    iput-object p2, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;->val$entry:Ljava/util/Map$Entry;

    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V
    .locals 3
    .param p1, "res"    # Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    .prologue
    .line 41
    sget-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    iget v2, p1, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->result:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, " -- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->data()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    iget-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;->val$entry:Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/user/IUser;

    invoke-interface {v0, p1}, Lcom/digitalsky/sdk/user/IUser;->loginCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V

    .line 43
    iget-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    iget v1, p1, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->result:I

    invoke-virtual {p1}, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->data()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/common/Listener$ILoginCallback;->onLoginCallback(ILjava/lang/String;)V

    .line 44
    iget-object v0, p1, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->openid:Ljava/lang/String;

    iget-object v1, p1, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->access_token:Ljava/lang/String;

    const-string v2, ""

    invoke-static {v0, v1, v2}, Lcom/digitalsky/sdk/kefu/KeFuPage;->addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    return-void
.end method
