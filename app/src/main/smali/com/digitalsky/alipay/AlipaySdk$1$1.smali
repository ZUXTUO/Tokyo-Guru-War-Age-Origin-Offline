.class Lcom/digitalsky/alipay/AlipaySdk$1$1;
.super Ljava/lang/Object;
.source "AlipaySdk.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/alipay/AlipaySdk$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

.field private final synthetic val$ResultStatus:Ljava/lang/String;

.field private final synthetic val$money:I

.field private final synthetic val$order_id:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digitalsky/alipay/AlipaySdk$1;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

    iput-object p2, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$ResultStatus:Ljava/lang/String;

    iput p3, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$money:I

    iput-object p4, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$order_id:Ljava/lang/String;

    .line 112
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/16 v6, 0xb

    .line 116
    const-string v0, "9000"

    iget-object v1, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$ResultStatus:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 117
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk$1;->access$0(Lcom/digitalsky/alipay/AlipaySdk$1;)Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk;->access$3(Lcom/digitalsky/alipay/AlipaySdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v0

    const/4 v1, 0x0

    .line 118
    new-instance v2, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    iget v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$money:I

    iget-object v4, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$order_id:Ljava/lang/String;

    const-string v5, ""

    invoke-direct {v2, v3, v4, v6, v5}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 117
    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 130
    :goto_0
    return-void

    .line 119
    :cond_0
    const-string v0, "6001"

    iget-object v1, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$ResultStatus:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 120
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk$1;->access$0(Lcom/digitalsky/alipay/AlipaySdk$1;)Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk;->access$3(Lcom/digitalsky/alipay/AlipaySdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v0

    const/4 v1, -0x2

    .line 121
    new-instance v2, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    iget v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$money:I

    iget-object v4, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$order_id:Ljava/lang/String;

    const-string v5, ""

    invoke-direct {v2, v3, v4, v6, v5}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 120
    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    goto :goto_0

    .line 122
    :cond_1
    const-string v0, "8000"

    iget-object v1, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$ResultStatus:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 123
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk$1;->access$0(Lcom/digitalsky/alipay/AlipaySdk$1;)Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk;->access$3(Lcom/digitalsky/alipay/AlipaySdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v0

    const/4 v1, -0x3

    .line 124
    new-instance v2, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    iget v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$money:I

    iget-object v4, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$order_id:Ljava/lang/String;

    const-string v5, ""

    invoke-direct {v2, v3, v4, v6, v5}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 123
    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    goto :goto_0

    .line 126
    :cond_2
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->this$1:Lcom/digitalsky/alipay/AlipaySdk$1;

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk$1;->access$0(Lcom/digitalsky/alipay/AlipaySdk$1;)Lcom/digitalsky/alipay/AlipaySdk;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/alipay/AlipaySdk;->access$3(Lcom/digitalsky/alipay/AlipaySdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-result-object v0

    const/4 v1, -0x1

    .line 127
    new-instance v2, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    iget v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$money:I

    iget-object v4, p0, Lcom/digitalsky/alipay/AlipaySdk$1$1;->val$order_id:Ljava/lang/String;

    const-string v5, ""

    invoke-direct {v2, v3, v4, v6, v5}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 126
    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    goto :goto_0
.end method
