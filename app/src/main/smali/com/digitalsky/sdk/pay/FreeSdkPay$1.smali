.class Lcom/digitalsky/sdk/pay/FreeSdkPay$1;
.super Ljava/lang/Object;
.source "FreeSdkPay.java"

# interfaces
.implements Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/pay/FreeSdkPay;->setIPayListener(Lcom/digitalsky/sdk/common/Listener$ISdkCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/pay/FreeSdkPay;

.field private final synthetic val$listener:Lcom/digitalsky/sdk/common/Listener$ISdkCallback;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/pay/FreeSdkPay;Lcom/digitalsky/sdk/common/Listener$ISdkCallback;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPay$1;->this$0:Lcom/digitalsky/sdk/pay/FreeSdkPay;

    iput-object p2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPay$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ISdkCallback;

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V
    .locals 3
    .param p1, "code"    # I
    .param p2, "data"    # Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    .prologue
    .line 30
    sget-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, " -- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->data()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    iget-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPay$1;->val$listener:Lcom/digitalsky/sdk/common/Listener$ISdkCallback;

    invoke-virtual {p2}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->data()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Lcom/digitalsky/sdk/common/Listener$ISdkCallback;->onCallback(ILjava/lang/String;)V

    .line 32
    return-void
.end method
