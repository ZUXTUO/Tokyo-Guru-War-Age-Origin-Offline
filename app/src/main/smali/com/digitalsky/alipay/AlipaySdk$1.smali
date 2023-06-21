.class Lcom/digitalsky/alipay/AlipaySdk$1;
.super Ljava/lang/Thread;
.source "AlipaySdk.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/alipay/AlipaySdk;->Pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/alipay/AlipaySdk;

.field private final synthetic val$money:I

.field private final synthetic val$order_id:Ljava/lang/String;

.field private final synthetic val$payInfo:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digitalsky/alipay/AlipaySdk;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    iput-object p2, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$payInfo:Ljava/lang/String;

    iput p3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$money:I

    iput-object p4, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$order_id:Ljava/lang/String;

    .line 103
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digitalsky/alipay/AlipaySdk$1;)Lcom/digitalsky/alipay/AlipaySdk;
    .locals 1

    .prologue
    .line 103
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 105
    new-instance v1, Lcom/alipay/sdk/app/PayTask;

    iget-object v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    invoke-static {v3}, Lcom/digitalsky/alipay/AlipaySdk;->access$0(Lcom/digitalsky/alipay/AlipaySdk;)Landroid/app/Activity;

    move-result-object v3

    invoke-direct {v1, v3}, Lcom/alipay/sdk/app/PayTask;-><init>(Landroid/app/Activity;)V

    .line 106
    .local v1, "alipay":Lcom/alipay/sdk/app/PayTask;
    iget-object v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$payInfo:Ljava/lang/String;

    const/4 v4, 0x1

    invoke-virtual {v1, v3, v4}, Lcom/alipay/sdk/app/PayTask;->pay(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    .line 109
    .local v2, "result":Ljava/lang/String;
    iget-object v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    invoke-static {v3}, Lcom/digitalsky/alipay/AlipaySdk;->access$1(Lcom/digitalsky/alipay/AlipaySdk;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    iget-object v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    const-string v4, "resultStatus={"

    const-string v5, "}"

    invoke-static {v3, v2, v4, v5}, Lcom/digitalsky/alipay/AlipaySdk;->access$2(Lcom/digitalsky/alipay/AlipaySdk;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 112
    .local v0, "ResultStatus":Ljava/lang/String;
    iget-object v3, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->this$0:Lcom/digitalsky/alipay/AlipaySdk;

    invoke-static {v3}, Lcom/digitalsky/alipay/AlipaySdk;->access$0(Lcom/digitalsky/alipay/AlipaySdk;)Landroid/app/Activity;

    move-result-object v3

    new-instance v4, Lcom/digitalsky/alipay/AlipaySdk$1$1;

    iget v5, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$money:I

    iget-object v6, p0, Lcom/digitalsky/alipay/AlipaySdk$1;->val$order_id:Ljava/lang/String;

    invoke-direct {v4, p0, v0, v5, v6}, Lcom/digitalsky/alipay/AlipaySdk$1$1;-><init>(Lcom/digitalsky/alipay/AlipaySdk$1;Ljava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v3, v4}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 133
    return-void
.end method
