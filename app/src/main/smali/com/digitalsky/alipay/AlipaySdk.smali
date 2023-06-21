.class public Lcom/digitalsky/alipay/AlipaySdk;
.super Ljava/lang/Object;
.source "AlipaySdk.java"


# static fields
.field private static _instance:Lcom/digitalsky/alipay/AlipaySdk;


# instance fields
.field private TAG:Ljava/lang/String;

.field private mContext:Landroid/app/Activity;

.field private mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 27
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/alipay/AlipaySdk;->_instance:Lcom/digitalsky/alipay/AlipaySdk;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->mContext:Landroid/app/Activity;

    .line 24
    new-instance v0, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;

    invoke-direct {v0}, Lcom/digitalsky/sdk/pay/PayListener$DefaultPayCallback;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 25
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/alipay/AlipaySdk;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->TAG:Ljava/lang/String;

    .line 21
    return-void
.end method

.method private ResultToJson(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 145
    const-string v5, "resultStatus={"

    const-string v6, "}"

    invoke-direct {p0, p1, v5, v6}, Lcom/digitalsky/alipay/AlipaySdk;->getContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 146
    .local v0, "ResultStatus":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 147
    :cond_0
    new-instance v5, Ljava/lang/String;

    invoke-direct {v5}, Ljava/lang/String;-><init>()V

    .line 162
    :goto_0
    return-object v5

    .line 148
    :cond_1
    const-string v5, "memo={"

    const-string v6, "}"

    invoke-direct {p0, p1, v5, v6}, Lcom/digitalsky/alipay/AlipaySdk;->getContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 149
    .local v2, "memo":Ljava/lang/String;
    const-string v5, "result={"

    const-string v6, "}"

    invoke-direct {p0, p1, v5, v6}, Lcom/digitalsky/alipay/AlipaySdk;->getContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 151
    .local v3, "result":Ljava/lang/String;
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 153
    .local v4, "root":Lorg/json/JSONObject;
    :try_start_0
    const-string v5, "ResultStatus"

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 154
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_2

    .line 155
    const-string v5, "ResultStatus"

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 156
    :cond_2
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_3

    .line 157
    const-string v5, "result"

    invoke-virtual {v4, v5, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 162
    :cond_3
    :goto_1
    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_0

    .line 158
    :catch_0
    move-exception v1

    .line 159
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method static synthetic access$0(Lcom/digitalsky/alipay/AlipaySdk;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->mContext:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digitalsky/alipay/AlipaySdk;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 25
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digitalsky/alipay/AlipaySdk;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 165
    invoke-direct {p0, p1, p2, p3}, Lcom/digitalsky/alipay/AlipaySdk;->getContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$3(Lcom/digitalsky/alipay/AlipaySdk;)Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;
    .locals 1

    .prologue
    .line 24
    iget-object v0, p0, Lcom/digitalsky/alipay/AlipaySdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    return-object v0
.end method

.method private getContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "src"    # Ljava/lang/String;
    .param p2, "startTag"    # Ljava/lang/String;
    .param p3, "endTag"    # Ljava/lang/String;

    .prologue
    .line 166
    const/4 v0, 0x0

    .line 167
    .local v0, "content":Ljava/lang/String;
    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .line 168
    .local v3, "start":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v3, v4

    .line 171
    if-eqz p3, :cond_0

    .line 172
    :try_start_0
    invoke-virtual {p1, p3, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v2

    .line 173
    .local v2, "end":I
    invoke-virtual {p1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 181
    .end local v2    # "end":I
    :goto_0
    return-object v0

    .line 175
    :cond_0
    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 177
    :catch_0
    move-exception v1

    .line 178
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static getInstance()Lcom/digitalsky/alipay/AlipaySdk;
    .locals 1

    .prologue
    .line 30
    sget-object v0, Lcom/digitalsky/alipay/AlipaySdk;->_instance:Lcom/digitalsky/alipay/AlipaySdk;

    if-nez v0, :cond_0

    .line 31
    new-instance v0, Lcom/digitalsky/alipay/AlipaySdk;

    invoke-direct {v0}, Lcom/digitalsky/alipay/AlipaySdk;-><init>()V

    sput-object v0, Lcom/digitalsky/alipay/AlipaySdk;->_instance:Lcom/digitalsky/alipay/AlipaySdk;

    .line 33
    :cond_0
    sget-object v0, Lcom/digitalsky/alipay/AlipaySdk;->_instance:Lcom/digitalsky/alipay/AlipaySdk;

    return-object v0
.end method

.method public static getSignType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 203
    const-string v0, "sign_type=\"RSA\""

    return-object v0
.end method

.method public static sign(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "content"    # Ljava/lang/String;
    .param p1, "RSA_PRIVATE"    # Ljava/lang/String;

    .prologue
    .line 194
    invoke-static {p0, p1}, Lcom/digitalsky/alipay/Rsa;->sign(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public GetVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 48
    new-instance v0, Lcom/alipay/sdk/app/PayTask;

    iget-object v1, p0, Lcom/digitalsky/alipay/AlipaySdk;->mContext:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/alipay/sdk/app/PayTask;-><init>(Landroid/app/Activity;)V

    .line 49
    .local v0, "payTask":Lcom/alipay/sdk/app/PayTask;
    invoke-virtual {v0}, Lcom/alipay/sdk/app/PayTask;->getVersion()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public Pay(Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;)Z
    .locals 27
    .param p1, "request"    # Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;

    .prologue
    .line 54
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/digitalsky/alipay/AlipaySdk;->TAG:Ljava/lang/String;

    move-object/from16 v22, v0

    const-string v23, "pay"

    invoke-static/range {v22 .. v23}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    move-object/from16 v0, p1

    iget v6, v0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->money:I

    .line 56
    .local v6, "money":I
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productName:Ljava/lang/String;

    move-object/from16 v16, v0

    .line 57
    .local v16, "product_name":Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v15, v0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->productDesc:Ljava/lang/String;

    .line 58
    .local v15, "product_des":Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v9, v0, Lcom/digitalsky/sdk/pay/FreeSdkPayRequest;->orderId:Ljava/lang/String;

    .line 59
    .local v9, "order_id":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-nez v22, :cond_0

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-nez v22, :cond_0

    invoke-virtual {v15}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-eqz v22, :cond_1

    .line 60
    :cond_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/digitalsky/alipay/AlipaySdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-object/from16 v22, v0

    const/16 v23, -0x7

    .line 61
    new-instance v24, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const/16 v25, 0xb

    const-string v26, "para error"

    move-object/from16 v0, v24

    move/from16 v1, v25

    move-object/from16 v2, v26

    invoke-direct {v0, v6, v9, v1, v2}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 60
    invoke-interface/range {v22 .. v24}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 62
    const/16 v22, 0x1

    .line 141
    :goto_0
    return v22

    .line 66
    :cond_1
    :try_start_0
    const-string v14, "MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBALI9csz77qkibbiEYtRF0FsKZLrOdQCi4YAzz0IHIMNJ7cZFyVsSJmKDVIQNfiXB1sQtQLTCLez1jdFNIQ6fF3kxBUxScLvF222Y+2TloysqIBlB6kVt8dk+0L13fHlVSHplnSCrhCyCaPD3Hlbd1uTb1MpfNoPQBHS66vjGHH3DAgMBAAECgYEApl5c7aCqYAzWxUgsx15y4MeOxh83buSZ/4RcjJECr8Ytvsgc7ni+g216UdgWSz/nKy3iG9az7140hYyssm0lBlc1RKy5nDsN6esr3Ezyn7MOPA1kjAZmG97v291HLZMsdXuroPV4O6m5hAMyXU3rRSoZ1S4M8kC4QvJTM6Vkn8ECQQDZ6DYa1JJMHeo7NAbf5bNs8u/ii27ZUnkT9XtPO6j/rTeQHZrqGq2pO3z7f5HAB3sCO1PwEIG5zkLqJIAl+b9bAkEA0WYOOVutP2B0AvEZ/SyEHosGVoM9t9nFWrus9+m41rpYCujptB2kq/4BaduZk0lzGe8sPo+eF/m/vZDcyxavuQJBANbI8nujx8hLPFO6xoPuz9q14wm0UkDX8AxiTXcd4UiTHk9pPwc94KsMvfbQGYPkW7UpcWURgCz7SC2uaLoF4D0CQQC/Uha283t0h4UX1wBe4JiKa43L57exTmjSQN2F2edHUhT1St+U8OyvNLJH7RwBhb+Dt5JeSswwrcExy7TgXgcJAkEAxAuSLKNDgf8IRbQmET/LqWC1PTopCR849Zq29bv6UtSGDaN84NK+43SYltfyA3PnehI3c3bRu1s2akrGBPiD4A=="

    .line 67
    .local v14, "private_key":Ljava/lang/String;
    const-string v11, "2088801184219754"

    .line 68
    .local v11, "partner":Ljava/lang/String;
    const-string v17, "wangying@xindong100.com"

    .line 69
    .local v17, "seller_id":Ljava/lang/String;
    const-string v18, "mobile.securitypay.pay"

    .line 70
    .local v18, "service":Ljava/lang/String;
    const-string v3, "utf-8"

    .line 71
    .local v3, "_input_charset":Ljava/lang/String;
    const-string v13, "1"

    .line 72
    .local v13, "payment_type":Ljava/lang/String;
    const-string v7, "http://pay.ppgame.com:8081/PayCenter/alipay_notify"

    .line 74
    .local v7, "notify_url":Ljava/lang/String;
    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v21

    .line 75
    .local v21, "total_fee":Ljava/lang/String;
    const-string v21, "0.01"

    .line 76
    move-object v4, v15

    .line 77
    .local v4, "body":Ljava/lang/String;
    move-object v10, v9

    .line 78
    .local v10, "out_trade_no":Ljava/lang/String;
    move-object/from16 v20, v16

    .line 80
    .local v20, "subject":Ljava/lang/String;
    if-eqz v21, :cond_2

    invoke-virtual/range {v21 .. v21}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-nez v22, :cond_2

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-nez v22, :cond_2

    if-eqz v10, :cond_2

    .line 81
    invoke-virtual {v10}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-nez v22, :cond_2

    if-eqz v20, :cond_2

    invoke-virtual/range {v20 .. v20}, Ljava/lang/String;->isEmpty()Z

    move-result v22

    if-eqz v22, :cond_3

    .line 82
    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/digitalsky/alipay/AlipaySdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    move-object/from16 v22, v0

    const/16 v23, -0x1

    .line 83
    new-instance v24, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;

    const/16 v25, 0xb

    const-string v26, "creat order fail"

    move-object/from16 v0, v24

    move/from16 v1, v25

    move-object/from16 v2, v26

    invoke-direct {v0, v6, v9, v1, v2}, Lcom/digitalsky/sdk/pay/FreeSdkPayResponse;-><init>(ILjava/lang/String;ILjava/lang/String;)V

    .line 82
    invoke-interface/range {v22 .. v24}, Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;->onCallback(ILcom/digitalsky/sdk/pay/FreeSdkPayResponse;)V

    .line 84
    const/16 v22, 0x1

    goto :goto_0

    .line 87
    :cond_3
    new-instance v22, Ljava/lang/StringBuilder;

    const-string v23, "partner=\""

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, v22

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 88
    .local v8, "orderInfo":Ljava/lang/String;
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&seller_id=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 89
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&total_fee=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 90
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&body=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 91
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&service=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 92
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&_input_charset=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 93
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&out_trade_no=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 94
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&subject=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 95
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&payment_type=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 96
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&notify_url=\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 97
    invoke-static {v8, v14}, Lcom/digitalsky/alipay/AlipaySdk;->sign(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .line 98
    .local v19, "sign":Ljava/lang/String;
    const-string v22, "UTF-8"

    move-object/from16 v0, v19

    move-object/from16 v1, v22

    invoke-static {v0, v1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .line 99
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-direct/range {v22 .. v23}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v23, "&sign="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "\""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "&"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-static {}, Lcom/digitalsky/alipay/AlipaySdk;->getSignType()Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 101
    move-object v12, v8

    .line 103
    .local v12, "payInfo":Ljava/lang/String;
    new-instance v22, Lcom/digitalsky/alipay/AlipaySdk$1;

    move-object/from16 v0, v22

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v12, v6, v9}, Lcom/digitalsky/alipay/AlipaySdk$1;-><init>(Lcom/digitalsky/alipay/AlipaySdk;Ljava/lang/String;ILjava/lang/String;)V

    .line 134
    invoke-virtual/range {v22 .. v22}, Lcom/digitalsky/alipay/AlipaySdk$1;->start()V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 136
    const/16 v22, 0x1

    goto/16 :goto_0

    .line 137
    .end local v3    # "_input_charset":Ljava/lang/String;
    .end local v4    # "body":Ljava/lang/String;
    .end local v7    # "notify_url":Ljava/lang/String;
    .end local v8    # "orderInfo":Ljava/lang/String;
    .end local v10    # "out_trade_no":Ljava/lang/String;
    .end local v11    # "partner":Ljava/lang/String;
    .end local v12    # "payInfo":Ljava/lang/String;
    .end local v13    # "payment_type":Ljava/lang/String;
    .end local v14    # "private_key":Ljava/lang/String;
    .end local v17    # "seller_id":Ljava/lang/String;
    .end local v18    # "service":Ljava/lang/String;
    .end local v19    # "sign":Ljava/lang/String;
    .end local v20    # "subject":Ljava/lang/String;
    .end local v21    # "total_fee":Ljava/lang/String;
    :catch_0
    move-exception v5

    .line 138
    .local v5, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v5}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 141
    const/16 v22, 0x1

    goto/16 :goto_0
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 0
    .param p1, "context"    # Landroid/app/Activity;

    .prologue
    .line 42
    iput-object p1, p0, Lcom/digitalsky/alipay/AlipaySdk;->mContext:Landroid/app/Activity;

    .line 43
    return-void
.end method

.method public setPayListener(Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;)V
    .locals 0
    .param p1, "listener"    # Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .prologue
    .line 38
    iput-object p1, p0, Lcom/digitalsky/alipay/AlipaySdk;->mPayCallback:Lcom/digitalsky/sdk/pay/PayListener$OnPayCallback;

    .line 39
    return-void
.end method
