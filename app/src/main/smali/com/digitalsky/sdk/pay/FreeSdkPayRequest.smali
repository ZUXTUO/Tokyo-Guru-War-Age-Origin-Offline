.class public Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;
.super Ljava/lang/Object;
.source "FreeSdkPayRequest.java"


# static fields
.field public static final KEY_BALANCE:Ljava/lang/String; = "balance"

.field public static final KEY_MONEY:Ljava/lang/String; = "money"

.field public static final KEY_ORDER_CHANNEL:Ljava/lang/String; = "orderChannel"

.field public static final KEY_ORDER_ID:Ljava/lang/String; = "orderId"

.field public static final KEY_PARTY_NAME:Ljava/lang/String; = "partyName"

.field public static final KEY_PRODUCT_DESC:Ljava/lang/String; = "productDesc"

.field public static final KEY_PRODUCT_ID:Ljava/lang/String; = "productId"

.field public static final KEY_PRODUCT_NAME:Ljava/lang/String; = "productName"

.field public static final KEY_RATE:Ljava/lang/String; = "rate"

.field public static final KEY_ROLE_ID:Ljava/lang/String; = "roleId"

.field public static final KEY_ROLE_LEVEL:Ljava/lang/String; = "roleLevel"

.field public static final KEY_ROLE_NAME:Ljava/lang/String; = "roleName"

.field public static final KEY_VIP_LEVEL:Ljava/lang/String; = "vipLevel"

.field public static final KEY_ZONE_ID:Ljava/lang/String; = "zoneId"

.field public static final KEY_ZONE_NAME:Ljava/lang/String; = "zoneName"

.field private static TAG:Ljava/lang/String;


# instance fields
.field public balance:I

.field public money:I

.field public orderId:Ljava/lang/String;

.field public orderSdk:Ljava/lang/String;

.field public partyName:Ljava/lang/String;

.field public productDesc:Ljava/lang/String;

.field public productId:Ljava/lang/String;

.field public productName:Ljava/lang/String;

.field public rate:I

.field public roleId:Ljava/lang/String;

.field public roleLevel:Ljava/lang/String;

.field public roleName:Ljava/lang/String;

.field public vipLevel:I

.field public zoneId:Ljava/lang/String;

.field public zoneName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 28
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productId:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productName:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productDesc:Ljava/lang/String;

    .line 34
    const/16 v0, 0xa

    iput v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->rate:I

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderSdk:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleId:Ljava/lang/String;

    .line 38
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleName:Ljava/lang/String;

    .line 39
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleLevel:Ljava/lang/String;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneId:Ljava/lang/String;

    .line 41
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneName:Ljava/lang/String;

    .line 42
    iput v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->balance:I

    .line 43
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->partyName:Ljava/lang/String;

    .line 44
    iput v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->vipLevel:I

    .line 48
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 5
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    const/16 v4, 0xa

    const/4 v3, 0x0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    .line 31
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productId:Ljava/lang/String;

    .line 32
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productName:Ljava/lang/String;

    .line 33
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productDesc:Ljava/lang/String;

    .line 34
    iput v4, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->rate:I

    .line 35
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    .line 36
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderSdk:Ljava/lang/String;

    .line 37
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleId:Ljava/lang/String;

    .line 38
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleName:Ljava/lang/String;

    .line 39
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleLevel:Ljava/lang/String;

    .line 40
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneId:Ljava/lang/String;

    .line 41
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneName:Ljava/lang/String;

    .line 42
    iput v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->balance:I

    .line 43
    const-string v2, ""

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->partyName:Ljava/lang/String;

    .line 44
    iput v3, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->vipLevel:I

    .line 53
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 54
    .local v1, "req":Lorg/json/JSONObject;
    const-string v2, "money"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    .line 55
    const-string v2, "productId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productId:Ljava/lang/String;

    .line 56
    const-string v2, "productName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productName:Ljava/lang/String;

    .line 57
    const-string v2, "productDesc"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productDesc:Ljava/lang/String;

    .line 58
    const-string v2, "rate"

    const/16 v3, 0xa

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->rate:I

    .line 59
    const-string v2, "orderId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    .line 60
    const-string v2, "orderChannel"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderSdk:Ljava/lang/String;

    .line 61
    const-string v2, "roleId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleId:Ljava/lang/String;

    .line 62
    const-string v2, "roleName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleName:Ljava/lang/String;

    .line 63
    const-string v2, "roleLevel"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleLevel:Ljava/lang/String;

    .line 64
    const-string v2, "zoneId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneId:Ljava/lang/String;

    .line 65
    const-string v2, "zoneName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneName:Ljava/lang/String;

    .line 66
    const-string v2, "balance"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->balance:I

    .line 67
    const-string v2, "partyName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->partyName:Ljava/lang/String;

    .line 68
    const-string v2, "vipLevel"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->vipLevel:I
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 75
    .end local v1    # "req":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 70
    :catch_0
    move-exception v0

    .line 72
    .local v0, "e":Lorg/json/JSONException;
    sget-object v2, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, " --- "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 80
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "money:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "productId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "productName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 81
    const-string v1, "productDesc:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productDesc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "rate:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->rate:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "orderId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 82
    const-string v1, "orderChannel:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderSdk:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 83
    const-string v1, "roleLevel:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->roleLevel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "zoneId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "zoneName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->zoneName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 84
    const-string v1, "balance:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->balance:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "partyName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->partyName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "vipLevel:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->vipLevel:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 80
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
