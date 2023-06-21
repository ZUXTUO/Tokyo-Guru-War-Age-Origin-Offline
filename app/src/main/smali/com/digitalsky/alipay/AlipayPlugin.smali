.class public Lcom/digitalsky/alipay/AlipayPlugin;
.super Ljava/lang/Object;
.source "AlipayPlugin.java"

# interfaces
.implements Lcom/digitalsky/sdk/IActivity;
.implements Lcom/digitalsky/sdk/pay/IPay;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 58
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 64
    return-void
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 17
    invoke-static {}, Lcom/digitalsky/alipay/AlipaySdk;->getInstance()Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/alipay/AlipaySdk;->onCreate(Landroid/app/Activity;)V

    .line 18
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .prologue
    .line 52
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 70
    return-void
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 40
    return-void
.end method

.method public onRestart()V
    .locals 0

    .prologue
    .line 24
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 35
    return-void
.end method

.method public onStart()V
    .locals 0

    .prologue
    .line 30
    return-void
.end method

.method public onStop()V
    .locals 0

    .prologue
    .line 46
    return-void
.end method

.method public pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
    .locals 1
    .param p1, "request"    # Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    .prologue
    .line 75
    invoke-static {}, Lcom/digitalsky/alipay/AlipaySdk;->getInstance()Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/alipay/AlipaySdk;->Pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z

    move-result v0

    return v0
.end method

.method public setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V
    .locals 1
    .param p1, "listener"    # Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .prologue
    .line 80
    invoke-static {}, Lcom/digitalsky/alipay/AlipaySdk;->getInstance()Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/alipay/AlipaySdk;->setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V

    .line 82
    return-void
.end method
