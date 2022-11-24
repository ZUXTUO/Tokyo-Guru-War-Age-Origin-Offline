.class Lcom/digitalsky/payeco/PayecoSdk$1;
.super Landroid/content/BroadcastReceiver;
.source "PayecoSdk.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/payeco/PayecoSdk;->initPayecoPayBroadcastReceiver()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/payeco/PayecoSdk;


# direct methods
.method constructor <init>(Lcom/digitalsky/payeco/PayecoSdk;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    .line 98
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v8, -0x1

    .line 103
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 104
    .local v0, "action":Ljava/lang/String;
    const-string v5, "com.digitalsky.payeco.broadcast"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 105
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$0(Lcom/digitalsky/payeco/PayecoSdk;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "\u63a5\u6536\u5230\u5e7f\u64ad\uff0c\u4f46\u4e0e\u6ce8\u518c\u7684\u540d\u79f0\u4e0d\u4e00\u81f4["

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    :goto_0
    return-void

    .line 110
    :cond_0
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v5

    const-string v6, "upPay.Rsp"

    invoke-virtual {v5, v6}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 113
    .local v3, "result":Ljava/lang/String;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 114
    .local v2, "json":Lorg/json/JSONObject;
    const-string v4, ""

    .line 115
    .local v4, "ret":Ljava/lang/String;
    const-string v5, "respCode"

    invoke-virtual {v2, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    const-string v5, "0000"

    const-string v6, "respCode"

    invoke-virtual {v2, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 116
    :cond_1
    const-string v5, "respCode"

    invoke-virtual {v2, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 120
    const-string v5, "respCode"

    invoke-virtual {v2, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 121
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$0(Lcom/digitalsky/payeco/PayecoSdk;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "respCode"

    invoke-virtual {v2, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 129
    :goto_1
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    move-result-object v5

    iput-object v4, v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 130
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$2(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v5

    const/4 v6, -0x1

    iget-object v7, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v7}, Lcom/digitalsky/payeco/PayecoSdk;->access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    move-result-object v7

    invoke-interface {v5, v6, v7}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 134
    .end local v2    # "json":Lorg/json/JSONObject;
    .end local v4    # "ret":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 135
    .local v1, "e":Lorg/json/JSONException;
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    move-result-object v5

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 136
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$2(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v5

    iget-object v6, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v6}, Lcom/digitalsky/payeco/PayecoSdk;->access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    move-result-object v6

    invoke-interface {v5, v8, v6}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    goto :goto_0

    .line 126
    .end local v1    # "e":Lorg/json/JSONException;
    .restart local v2    # "json":Lorg/json/JSONObject;
    .restart local v4    # "ret":Ljava/lang/String;
    :cond_2
    :try_start_1
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "\u8fd4\u56de\u6570\u636e\u6709\u8bef:"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 127
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$0(Lcom/digitalsky/payeco/PayecoSdk;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "\u8fd4\u56de\u6570\u636e\u6709\u8bef:"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 133
    :cond_3
    iget-object v5, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v5}, Lcom/digitalsky/payeco/PayecoSdk;->access$2(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v5

    const/4 v6, 0x0

    iget-object v7, p0, Lcom/digitalsky/payeco/PayecoSdk$1;->this$0:Lcom/digitalsky/payeco/PayecoSdk;

    invoke-static {v7}, Lcom/digitalsky/payeco/PayecoSdk;->access$1(Lcom/digitalsky/payeco/PayecoSdk;)Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    move-result-object v7

    invoke-interface {v5, v6, v7}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method
