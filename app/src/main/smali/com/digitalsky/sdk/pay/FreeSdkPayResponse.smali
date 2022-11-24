.class public Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;
.super Ljava/lang/Object;
.source "FreeSdkPayResponse.java"


# static fields
.field public static final KEY_MONEY:Ljava/lang/String; = "money"

.field public static final KEY_MSG:Ljava/lang/String; = "msg"

.field public static final KEY_ORDER_ID:Ljava/lang/String; = "orderId"

.field public static final KEY_PLATFORM:Ljava/lang/String; = "plat"


# instance fields
.field private money:I

.field public msg:Ljava/lang/String;

.field private orderId:Ljava/lang/String;

.field private plat:I


# direct methods
.method public constructor <init>(ILjava/lang/String;ILjava/lang/String;)V
    .locals 2
    .param p1, "in_money"    # I
    .param p2, "in_orderId"    # Ljava/lang/String;
    .param p3, "in_plat"    # I
    .param p4, "in_msg"    # Ljava/lang/String;

    .prologue
    const/4 v1, -0x1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    iput v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->money:I

    .line 14
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 15
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->orderId:Ljava/lang/String;

    .line 16
    iput v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->plat:I

    .line 19
    iput p1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->money:I

    .line 20
    iput-object p4, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    .line 21
    iput-object p2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->orderId:Ljava/lang/String;

    .line 22
    iput p3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->plat:I

    .line 23
    return-void
.end method


# virtual methods
.method public data()Ljava/lang/String;
    .locals 4

    .prologue
    .line 26
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 29
    .local v0, "data":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "money"

    iget v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->money:I

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 30
    const-string v2, "msg"

    iget-object v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->msg:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 31
    const-string v2, "orderId"

    iget-object v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->orderId:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 32
    const-string v2, "plat"

    iget v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;->plat:I

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 37
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 33
    :catch_0
    move-exception v1

    .line 35
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
