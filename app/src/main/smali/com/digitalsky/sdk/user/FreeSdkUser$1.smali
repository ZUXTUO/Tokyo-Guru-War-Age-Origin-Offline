.class Lcom/digitalsky/sdk/user/FreeSdkUser$1;
.super Ljava/lang/Object;
.source "FreeSdkUser.java"

# interfaces
.implements Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/user/FreeSdkUser;->setIUserListener(Lcom/digitalsky/sdk/common/Listener$ILoginCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/user/FreeSdkUser;

.field private final synthetic val$entry:Ljava/util/Map$Entry;

.field private final synthetic val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/user/FreeSdkUser;Lcom/digitalsky/sdk/common/Listener$ILoginCallback;Ljava/util/Map$Entry;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->this$0:Lcom/digitalsky/sdk/user/FreeSdkUser;

    iput-object p2, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    iput-object p3, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$entry:Ljava/util/Map$Entry;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V
    .locals 3
    .param p1, "code"    # I
    .param p2, "data"    # Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    .prologue
    .line 33
    if-eqz p1, :cond_0

    .line 34
    sget-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, " -- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->data()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 35
    iget-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    invoke-virtual {p2}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->data()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Lcom/digitalsky/sdk/common/Listener$ILoginCallback;->onLoginCallback(ILjava/lang/String;)V

    .line 48
    :goto_0
    return-void

    .line 37
    :cond_0
    new-instance v0, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;

    iget-object v1, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$entry:Ljava/util/Map$Entry;

    iget-object v2, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    invoke-direct {v0, p0, v1, v2}, Lcom/digitalsky/sdk/user/FreeSdkUser$1$1;-><init>(Lcom/digitalsky/sdk/user/FreeSdkUser$1;Ljava/util/Map$Entry;Lcom/digitalsky/sdk/common/Listener$ILoginCallback;)V

    invoke-static {p2, v0}, Lcom/digitalsky/sdk/common/Utils;->verify(Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;)V

    goto :goto_0
.end method

.method public onLogoutCallback()V
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/digitalsky/sdk/user/FreeSdkUser$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    invoke-interface {v0}, Lcom/digitalsky/sdk/common/Listener$ILoginCallback;->onLogoutCallback()V

    .line 54
    return-void
.end method
