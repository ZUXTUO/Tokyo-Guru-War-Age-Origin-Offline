.class public Lcom/digitalsky/payeco/PayecoSdk;
.super Ljava/lang/Object;
.source "PayecoSdk.java"


# static fields
.field private static final BROADCAST_PAY_END:Ljava/lang/String; = "com.digitalsky.payeco.broadcast"

.field private static _instance:Lcom/digitalsky/payeco/PayecoSdk;


# instance fields
.field private Pay_Environment:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mActivity:Landroid/app/Activity;

.field private mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

.field private payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 37
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/payeco/PayecoSdk;->_instance:Lcom/digitalsky/payeco/PayecoSdk;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    .line 25
    new-instance v0, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;

    invoke-direct {v0}, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 26
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/payeco/PayecoSdk;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->TAG:Ljava/lang/String;

    .line 28
    const-string v0, "01"

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->Pay_Environment:Ljava/lang/String;

    .line 22
    return-void
.end method

.method private _payment(Ljava/lang/String;ILjava/lang/String;)V
    .locals 9
    .param p1, "jsonString"    # Ljava/lang/String;
    .param p2, "money"    # I
    .param p3, "order"    # Ljava/lang/String;

    .prologue
    const/4 v8, -0x1

    .line 144
    new-instance v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const/16 v6, 0xf

    const-string v7, ""

    invoke-direct {v5, p2, p3, v6, v7}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    iput-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    .line 145
    if-nez p1, :cond_0

    .line 146
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const-string v6, "order sdk null"

    iput-object v6, v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 147
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    iget-object v6, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    invoke-interface {v5, v8, v6}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 181
    :goto_0
    return-void

    .line 152
    :cond_0
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 153
    .local v3, "json":Lorg/json/JSONObject;
    const-string v5, "MerchOrderId"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    .line 154
    .local v0, "MerchOrderId":I
    const-string v5, "MerchOrderId"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 155
    const-string v5, "MerchOrderId"

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 168
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    .line 171
    .local v4, "upPayReqString":Ljava/lang/String;
    new-instance v2, Landroid/content/Intent;

    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    const-class v6, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {v2, v5, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 172
    .local v2, "intent":Landroid/content/Intent;
    const-string v5, "upPay.Req"

    invoke-virtual {v2, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 173
    const-string v5, "Broadcast"

    const-string v6, "com.digitalsky.payeco.broadcast"

    invoke-virtual {v2, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 174
    const-string v5, "Environment"

    iget-object v6, p0, Lcom/digitalsky/payeco/PayecoSdk;->Pay_Environment:Ljava/lang/String;

    invoke-virtual {v2, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 176
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    invoke-virtual {v5, v2}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 177
    .end local v0    # "MerchOrderId":I
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "json":Lorg/json/JSONObject;
    .end local v4    # "upPayReqString":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 178
    .local v1, "e":Ljava/lang/Exception;
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 179
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    iget-object v6, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    invoke-interface {v5, v8, v6}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    goto :goto_0
.end method

.method static synthetic access$0(Lcom/digitalsky/payeco/PayecoSdk;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->resp:Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;
    .locals 1

    .prologue
    .line 25
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    return-object v0
.end method

.method public static getInstance()Lcom/digitalsky/payeco/PayecoSdk;
    .locals 1

    .prologue
    .line 42
    sget-object v0, Lcom/digitalsky/payeco/PayecoSdk;->_instance:Lcom/digitalsky/payeco/PayecoSdk;

    if-nez v0, :cond_0

    .line 43
    new-instance v0, Lcom/digitalsky/payeco/PayecoSdk;

    invoke-direct {v0}, Lcom/digitalsky/payeco/PayecoSdk;-><init>()V

    sput-object v0, Lcom/digitalsky/payeco/PayecoSdk;->_instance:Lcom/digitalsky/payeco/PayecoSdk;

    .line 45
    :cond_0
    sget-object v0, Lcom/digitalsky/payeco/PayecoSdk;->_instance:Lcom/digitalsky/payeco/PayecoSdk;

    return-object v0
.end method

.method private initPayecoPayBroadcastReceiver()V
    .locals 1

    .prologue
    .line 98
    new-instance v0, Lcom/digitalsky/payeco/PayecoSdk$1;

    invoke-direct {v0, p0}, Lcom/digitalsky/payeco/PayecoSdk$1;-><init>(Lcom/digitalsky/payeco/PayecoSdk;)V

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 140
    return-void
.end method

.method private registerPayecoPayBroadcastReceiver()V
    .locals 3

    .prologue
    .line 78
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 79
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.digitalsky.payeco.broadcast"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 80
    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 81
    iget-object v1, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    iget-object v2, p0, Lcom/digitalsky/payeco/PayecoSdk;->payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/app/Activity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 82
    return-void
.end method

.method private unRegisterPayecoPayBroadcastReceiver()V
    .locals 2

    .prologue
    .line 90
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 91
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    iget-object v1, p0, Lcom/digitalsky/payeco/PayecoSdk;->payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/app/Activity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 92
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->payecoPayBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 94
    :cond_0
    return-void
.end method


# virtual methods
.method public Pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
    .locals 9
    .param p1, "request"    # Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    .prologue
    const/4 v8, 0x1

    .line 55
    iget-object v3, p0, Lcom/digitalsky/payeco/PayecoSdk;->TAG:Ljava/lang/String;

    const-string v4, "pay"

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    iget v0, p1, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    .line 57
    .local v0, "money":I
    iget-object v2, p1, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderSdk:Ljava/lang/String;

    .line 58
    .local v2, "order_sdk":Ljava/lang/String;
    iget-object v1, p1, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    .line 59
    .local v1, "order_id":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 60
    :cond_0
    iget-object v3, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    const/4 v4, -0x7

    .line 61
    new-instance v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const/16 v6, 0xf

    const-string v7, "para error"

    invoke-direct {v5, v0, v1, v6, v7}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 60
    invoke-interface {v3, v4, v5}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 65
    :goto_0
    return v8

    .line 64
    :cond_1
    invoke-direct {p0, v2, v0, v1}, Lcom/digitalsky/payeco/PayecoSdk;->_payment(Ljava/lang/String;ILjava/lang/String;)V

    goto :goto_0
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 185
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->TAG:Ljava/lang/String;

    const-string v1, "init enter ------"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 186
    iput-object p1, p0, Lcom/digitalsky/payeco/PayecoSdk;->mActivity:Landroid/app/Activity;

    .line 188
    invoke-direct {p0}, Lcom/digitalsky/payeco/PayecoSdk;->initPayecoPayBroadcastReceiver()V

    .line 191
    invoke-direct {p0}, Lcom/digitalsky/payeco/PayecoSdk;->registerPayecoPayBroadcastReceiver()V

    .line 192
    iget-object v0, p0, Lcom/digitalsky/payeco/PayecoSdk;->TAG:Ljava/lang/String;

    const-string v1, "init leave ------"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 193
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .prologue
    .line 69
    invoke-direct {p0}, Lcom/digitalsky/payeco/PayecoSdk;->unRegisterPayecoPayBroadcastReceiver()V

    .line 70
    return-void
.end method

.method public setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V
    .locals 0
    .param p1, "listener"    # Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .prologue
    .line 50
    iput-object p1, p0, Lcom/digitalsky/payeco/PayecoSdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 51
    return-void
.end method
