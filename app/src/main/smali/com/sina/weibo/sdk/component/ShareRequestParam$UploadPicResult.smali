.class public Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;
.super Ljava/lang/Object;
.source "ShareRequestParam.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/sina/weibo/sdk/component/ShareRequestParam;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "UploadPicResult"
.end annotation


# instance fields
.field private code:I

.field private picId:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 330
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 327
    const/4 v0, -0x2

    iput v0, p0, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;->code:I

    .line 330
    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;
    .locals 4
    .param p0, "resp"    # Ljava/lang/String;

    .prologue
    .line 341
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 342
    const/4 v1, 0x0

    .line 352
    :goto_0
    return-object v1

    .line 344
    :cond_0
    new-instance v1, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;-><init>()V

    .line 346
    .local v1, "result":Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 347
    .local v0, "obj":Lorg/json/JSONObject;
    const-string v2, "code"

    .line 348
    const/4 v3, -0x2

    .line 347
    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, v1, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;->code:I

    .line 349
    const-string v2, "data"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;->picId:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 350
    .end local v0    # "obj":Lorg/json/JSONObject;
    :catch_0
    move-exception v2

    goto :goto_0
.end method


# virtual methods
.method public getCode()I
    .locals 1

    .prologue
    .line 333
    iget v0, p0, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;->code:I

    return v0
.end method

.method public getPicId()Ljava/lang/String;
    .locals 1

    .prologue
    .line 337
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareRequestParam$UploadPicResult;->picId:Ljava/lang/String;

    return-object v0
.end method
