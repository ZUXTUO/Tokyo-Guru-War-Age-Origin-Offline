.class public Lcom/digitalsky/sdk/pay/FreeSdkPay;
.super Ljava/lang/Object;
.source "FreeSdkPay.java"


# static fields
.field public static TAG:Ljava/lang/String;

.field private static instance:Lcom/digitalsky/sdk/pay/FreeSdkPay;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 13
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/pay/FreeSdkPay;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->TAG:Ljava/lang/String;

    .line 14
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->instance:Lcom/digitalsky/sdk/pay/FreeSdkPay;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/digitalsky/sdk/pay/FreeSdkPay;
    .locals 1

    .prologue
    .line 17
    sget-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->instance:Lcom/digitalsky/sdk/pay/FreeSdkPay;

    if-nez v0, :cond_0

    .line 18
    new-instance v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;

    invoke-direct {v0}, Lcom/digitalsky/sdk/pay/FreeSdkPay;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->instance:Lcom/digitalsky/sdk/pay/FreeSdkPay;

    .line 20
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPay;->instance:Lcom/digitalsky/sdk/pay/FreeSdkPay;

    return-object v0
.end method

.method public static pay(Ljava/lang/String;)Z
    .locals 1
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 57
    const-string v0, ""

    invoke-static {v0, p0}, Lcom/digitalsky/sdk/pay/FreeSdkPay;->pay(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static pay(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 52
    invoke-static {}, Lcom/digitalsky/sdk/pay/FreeSdkPay;->getInstance()Lcom/digitalsky/sdk/pay/FreeSdkPay;

    move-result-object v0

    new-instance v1, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    invoke-direct {v1, p1}, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0, v1}, Lcom/digitalsky/sdk/pay/FreeSdkPay;->_pay(Ljava/lang/String;Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method public _pay(Ljava/lang/String;Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "req"    # Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    .prologue
    .line 41
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIPay(Ljava/lang/String;)Lcom/digitalsky/sdk/pay/IPay;

    move-result-object v0

    .line 42
    .local v0, "pay":Lcom/digitalsky/sdk/pay/IPay;
    if-eqz v0, :cond_0

    .line 43
    sget-object v1, Lcom/digitalsky/sdk/pay/FreeSdkPay;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    invoke-interface {v0, p2}, Lcom/digitalsky/sdk/pay/IPay;->pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z

    move-result v1

    .line 48
    :goto_0
    return v1

    .line 46
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/pay/FreeSdkPay;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IPay not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setIPayListener(Lcom/digitalsky/sdk/common/Listener$ISdkCallback;)V
    .locals 4
    .param p1, "listener"    # Lcom/digitalsky/sdk/common/Listener$ISdkCallback;

    .prologue
    .line 24
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIPays()Ljava/util/TreeMap;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/TreeMap;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    .line 35
    return-void

    .line 24
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 25
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/digitalsky/sdk/pay/IPay;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/digitalsky/sdk/pay/IPay;

    new-instance v3, Lcom/digitalsky/sdk/pay/FreeSdkPay$1;

    invoke-direct {v3, p0, p1}, Lcom/digitalsky/sdk/pay/FreeSdkPay$1;-><init>(Lcom/digitalsky/sdk/pay/FreeSdkPay;Lcom/digitalsky/sdk/common/Listener$ISdkCallback;)V

    invoke-interface {v1, v3}, Lcom/digitalsky/sdk/pay/IPay;->setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V

    goto :goto_0
.end method
