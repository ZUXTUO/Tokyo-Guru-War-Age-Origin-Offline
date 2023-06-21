.class public Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;
.super Ljava/lang/Object;
.source "PayListener.java"

# interfaces
.implements Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digitalsky/sdk/pay/PayListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DefaultPayCallback"
.end annotation


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;->TAG:Ljava/lang/String;

    .line 14
    return-void
.end method


# virtual methods
.method public onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V
    .locals 2
    .param p1, "code"    # I
    .param p2, "data"    # Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    .prologue
    .line 21
    iget-object v0, p0, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;->TAG:Ljava/lang/String;

    const-string v1, "OnPayCallback not set"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 22
    return-void
.end method
