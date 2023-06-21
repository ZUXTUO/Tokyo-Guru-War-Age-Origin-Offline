.class public Lcom/digitalsky/sdk/pay/DefaultPay;
.super Ljava/lang/Object;
.source "DefaultPay.java"

# interfaces
.implements Lcom/digitalsky/sdk/pay/IPay;


# instance fields
.field private mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    new-instance v0, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;

    invoke-direct {v0}, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/DefaultPay;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 8
    return-void
.end method


# virtual methods
.method public pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
    .locals 6
    .param p1, "request"    # Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    .prologue
    const/4 v5, 0x0

    .line 15
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "call pay "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 16
    iget-object v0, p0, Lcom/digitalsky/sdk/pay/DefaultPay;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    const/4 v1, -0x1

    .line 17
    new-instance v2, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const-string v3, ""

    const-string v4, "default pay callback"

    invoke-direct {v2, v5, v3, v5, v4}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 16
    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 18
    const/4 v0, 0x1

    return v0
.end method

.method public setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V
    .locals 0
    .param p1, "listener"    # Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .prologue
    .line 24
    iput-object p1, p0, Lcom/digitalsky/sdk/pay/DefaultPay;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 25
    return-void
.end method
