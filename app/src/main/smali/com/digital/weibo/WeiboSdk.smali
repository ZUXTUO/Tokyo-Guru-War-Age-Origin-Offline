.class public Lcom/digital/weibo/WeiboSdk;
.super Ljava/lang/Object;
.source "WeiboSdk.java"


# static fields
.field public static final REDIRECT_URL:Ljava/lang/String; = "https://api.weibo.com/oauth2/default.html"

.field public static final SCOPE:Ljava/lang/String; = ""

.field private static TAG:Ljava/lang/String;

.field static THUMB_SIZE:I

.field static accessToken:Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

.field static mActivity:Landroid/app/Activity;

.field static mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

.field static weibo_appkey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 33
    const-string v0, "2190725851"

    sput-object v0, Lcom/digital/weibo/WeiboSdk;->weibo_appkey:Ljava/lang/String;

    .line 34
    sput-object v1, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    .line 35
    const/16 v0, 0x96

    sput v0, Lcom/digital/weibo/WeiboSdk;->THUMB_SIZE:I

    .line 36
    sput-object v1, Lcom/digital/weibo/WeiboSdk;->accessToken:Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .line 39
    const-class v0, Lcom/digital/weibo/WeiboSdk;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Ljava/lang/String;
    .locals 1

    .prologue
    .line 39
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static bmpToByteArray(Landroid/graphics/Bitmap;Z)[B
    .locals 5
    .param p0, "bmp"    # Landroid/graphics/Bitmap;
    .param p1, "needRecycle"    # Z

    .prologue
    .line 222
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 224
    .local v1, "output":Ljava/io/ByteArrayOutputStream;
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x64

    invoke-virtual {p0, v3, v4, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 225
    if-eqz p1, :cond_0

    .line 226
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 229
    :cond_0
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 231
    .local v2, "result":[B
    :try_start_0
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 236
    :goto_0
    return-object v2

    .line 232
    :catch_0
    move-exception v0

    .line 233
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static checkInstall()Z
    .locals 1

    .prologue
    .line 63
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    invoke-interface {v0}, Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;->isWeiboAppInstalled()Z

    move-result v0

    return v0
.end method

.method public static init(Landroid/app/Activity;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;Landroid/os/Bundle;)V
    .locals 4
    .param p0, "act"    # Landroid/app/Activity;
    .param p1, "handler"    # Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 49
    sput-object p0, Lcom/digital/weibo/WeiboSdk;->mActivity:Landroid/app/Activity;

    .line 50
    invoke-static {}, Lcom/sina/weibo/sdk/utils/LogUtil;->enableLog()V

    .line 51
    sget-object v1, Lcom/digital/weibo/WeiboSdk;->mActivity:Landroid/app/Activity;

    sget-object v2, Lcom/digital/weibo/WeiboSdk;->weibo_appkey:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/sina/weibo/sdk/api/share/WeiboShareSDK;->createWeiboAPI(Landroid/content/Context;Ljava/lang/String;)Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    move-result-object v1

    sput-object v1, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    .line 52
    sget-object v1, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    invoke-interface {v1}, Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;->registerApp()Z

    move-result v0

    .line 53
    .local v0, "ret":Z
    sget-object v1, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "register "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 55
    if-eqz p2, :cond_0

    .line 56
    sget-object v1, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-interface {v1, v2, p1}, Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;->handleWeiboResponse(Landroid/content/Intent;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;)Z

    .line 59
    :cond_0
    return-void
.end method

.method public static onNewIntent(Landroid/content/Intent;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;)V
    .locals 1
    .param p0, "intent"    # Landroid/content/Intent;
    .param p1, "handler"    # Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;

    .prologue
    .line 198
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    invoke-interface {v0, p0, p1}, Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;->handleWeiboResponse(Landroid/content/Intent;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;)Z

    .line 199
    return-void
.end method

.method public static onResponse(Lcom/sina/weibo/sdk/api/share/BaseResponse;)V
    .locals 4
    .param p0, "baseResp"    # Lcom/sina/weibo/sdk/api/share/BaseResponse;

    .prologue
    const/4 v3, -0x1

    .line 202
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    const-string v1, "onResponse"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    if-eqz p0, :cond_0

    .line 204
    iget v0, p0, Lcom/sina/weibo/sdk/api/share/BaseResponse;->errCode:I

    packed-switch v0, :pswitch_data_0

    .line 219
    :goto_0
    return-void

    .line 206
    :pswitch_0
    const/4 v0, 0x0

    const-string v1, ""

    invoke-static {v0, v1}, Lcom/digital/weibo/WeiboSdk;->shareCallback(ILjava/lang/String;)V

    goto :goto_0

    .line 209
    :pswitch_1
    const-string v0, "cancel"

    invoke-static {v3, v0}, Lcom/digital/weibo/WeiboSdk;->shareCallback(ILjava/lang/String;)V

    goto :goto_0

    .line 212
    :pswitch_2
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "code: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/sina/weibo/sdk/api/share/BaseResponse;->errCode:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " msg: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/sina/weibo/sdk/api/share/BaseResponse;->errMsg:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 213
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/sina/weibo/sdk/api/share/BaseResponse;->errMsg:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/digital/weibo/WeiboSdk;->shareCallback(ILjava/lang/String;)V

    goto :goto_0

    .line 217
    :cond_0
    const-string v0, "fail"

    invoke-static {v3, v0}, Lcom/digital/weibo/WeiboSdk;->shareCallback(ILjava/lang/String;)V

    goto :goto_0

    .line 204
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private static sendRequest(Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;)Z
    .locals 6
    .param p0, "req"    # Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;

    .prologue
    .line 170
    new-instance v3, Lcom/sina/weibo/sdk/auth/AuthInfo;

    sget-object v0, Lcom/digital/weibo/WeiboSdk;->mActivity:Landroid/app/Activity;

    sget-object v1, Lcom/digital/weibo/WeiboSdk;->weibo_appkey:Ljava/lang/String;

    const-string v2, "https://api.weibo.com/oauth2/default.html"

    const-string v5, ""

    invoke-direct {v3, v0, v1, v2, v5}, Lcom/sina/weibo/sdk/auth/AuthInfo;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 171
    .local v3, "authInfo":Lcom/sina/weibo/sdk/auth/AuthInfo;
    const-string v4, ""

    .line 172
    .local v4, "token":Ljava/lang/String;
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->accessToken:Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    if-eqz v0, :cond_0

    .line 173
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->accessToken:Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    invoke-virtual {v0}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->getToken()Ljava/lang/String;

    move-result-object v4

    .line 176
    :cond_0
    sget-object v0, Lcom/digital/weibo/WeiboSdk;->mWeiboShareAPI:Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;

    sget-object v1, Lcom/digital/weibo/WeiboSdk;->mActivity:Landroid/app/Activity;

    new-instance v5, Lcom/digital/weibo/WeiboSdk$1;

    invoke-direct {v5}, Lcom/digital/weibo/WeiboSdk$1;-><init>()V

    move-object v2, p0

    invoke-interface/range {v0 .. v5}, Lcom/sina/weibo/sdk/api/share/IWeiboShareAPI;->sendRequest(Landroid/app/Activity;Lcom/sina/weibo/sdk/api/share/BaseRequest;Lcom/sina/weibo/sdk/auth/AuthInfo;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)Z

    move-result v0

    return v0
.end method

.method private static shareCallback(ILjava/lang/String;)V
    .locals 4
    .param p0, "state"    # I
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 43
    sget-object v1, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "shareCallback "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "|@|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 45
    .local v0, "params":Ljava/lang/String;
    const-string v1, "_UserCenter"

    const-string v2, "weibo_shareCallback"

    invoke-static {v1, v2, v0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    return-void
.end method

.method public static sharePhoto(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 8
    .param p0, "text"    # Ljava/lang/String;
    .param p1, "picPath"    # Ljava/lang/String;

    .prologue
    .line 89
    new-instance v5, Ljava/lang/StringBuilder;

    sget-object v6, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "_PHOTO"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, " "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 91
    new-instance v4, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    invoke-direct {v4}, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;-><init>()V

    .line 93
    .local v4, "weiboMessage":Lcom/sina/weibo/sdk/api/WeiboMultiMessage;
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 94
    new-instance v3, Lcom/sina/weibo/sdk/api/TextObject;

    invoke-direct {v3}, Lcom/sina/weibo/sdk/api/TextObject;-><init>()V

    .line 95
    .local v3, "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    iput-object p0, v3, Lcom/sina/weibo/sdk/api/TextObject;->text:Ljava/lang/String;

    .line 96
    iput-object v3, v4, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;->textObject:Lcom/sina/weibo/sdk/api/TextObject;

    .line 99
    .end local v3    # "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 100
    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 101
    .local v0, "bmp":Landroid/graphics/Bitmap;
    if-eqz v0, :cond_1

    .line 102
    new-instance v1, Lcom/sina/weibo/sdk/api/ImageObject;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/api/ImageObject;-><init>()V

    .line 103
    .local v1, "imageObject":Lcom/sina/weibo/sdk/api/ImageObject;
    invoke-virtual {v1, v0}, Lcom/sina/weibo/sdk/api/ImageObject;->setImageObject(Landroid/graphics/Bitmap;)V

    .line 104
    iput-object v1, v4, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;->imageObject:Lcom/sina/weibo/sdk/api/ImageObject;

    .line 105
    new-instance v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;

    invoke-direct {v2}, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;-><init>()V

    .line 107
    .local v2, "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->transaction:Ljava/lang/String;

    .line 108
    iput-object v4, v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->multiMessage:Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    .line 112
    invoke-static {v2}, Lcom/digital/weibo/WeiboSdk;->sendRequest(Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;)Z

    move-result v5

    .line 115
    .end local v0    # "bmp":Landroid/graphics/Bitmap;
    .end local v1    # "imageObject":Lcom/sina/weibo/sdk/api/ImageObject;
    .end local v2    # "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    :goto_0
    return v5

    :cond_1
    const/4 v5, 0x0

    goto :goto_0
.end method

.method public static shareText(Ljava/lang/String;)Z
    .locals 6
    .param p0, "text"    # Ljava/lang/String;

    .prologue
    .line 68
    new-instance v3, Ljava/lang/StringBuilder;

    sget-object v4, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "_TEXT"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 69
    new-instance v2, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    invoke-direct {v2}, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;-><init>()V

    .line 71
    .local v2, "weiboMessage":Lcom/sina/weibo/sdk/api/WeiboMultiMessage;
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    .line 72
    new-instance v1, Lcom/sina/weibo/sdk/api/TextObject;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/api/TextObject;-><init>()V

    .line 73
    .local v1, "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    iput-object p0, v1, Lcom/sina/weibo/sdk/api/TextObject;->text:Ljava/lang/String;

    .line 74
    iput-object v1, v2, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;->textObject:Lcom/sina/weibo/sdk/api/TextObject;

    .line 75
    new-instance v0, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;-><init>()V

    .line 77
    .local v0, "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v0, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->transaction:Ljava/lang/String;

    .line 78
    iput-object v2, v0, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->multiMessage:Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    .line 82
    invoke-static {v0}, Lcom/digital/weibo/WeiboSdk;->sendRequest(Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;)Z

    move-result v3

    .line 85
    .end local v0    # "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    .end local v1    # "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    :goto_0
    return v3

    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public static shareWeb(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 11
    .param p0, "text"    # Ljava/lang/String;
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "desc"    # Ljava/lang/String;
    .param p3, "url"    # Ljava/lang/String;
    .param p4, "thumbPath"    # Ljava/lang/String;

    .prologue
    .line 119
    new-instance v8, Ljava/lang/StringBuilder;

    sget-object v9, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, "_WEB"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, " "

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    new-instance v7, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    invoke-direct {v7}, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;-><init>()V

    .line 123
    .local v7, "weiboMessage":Lcom/sina/weibo/sdk/api/WeiboMultiMessage;
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_0

    .line 124
    new-instance v4, Lcom/sina/weibo/sdk/api/TextObject;

    invoke-direct {v4}, Lcom/sina/weibo/sdk/api/TextObject;-><init>()V

    .line 125
    .local v4, "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    iput-object p0, v4, Lcom/sina/weibo/sdk/api/TextObject;->text:Ljava/lang/String;

    .line 126
    iput-object v4, v7, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;->textObject:Lcom/sina/weibo/sdk/api/TextObject;

    .line 129
    .end local v4    # "textObject":Lcom/sina/weibo/sdk/api/TextObject;
    :cond_0
    if-eqz p3, :cond_6

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_6

    .line 130
    new-instance v1, Lcom/sina/weibo/sdk/api/WebpageObject;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/api/WebpageObject;-><init>()V

    .line 131
    .local v1, "mediaObject":Lcom/sina/weibo/sdk/api/WebpageObject;
    invoke-static {}, Lcom/sina/weibo/sdk/utils/Utility;->generateGUID()Ljava/lang/String;

    move-result-object v8

    iput-object v8, v1, Lcom/sina/weibo/sdk/api/WebpageObject;->identify:Ljava/lang/String;

    .line 132
    iput-object p3, v1, Lcom/sina/weibo/sdk/api/WebpageObject;->actionUrl:Ljava/lang/String;

    .line 134
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_1

    .line 135
    iput-object p1, v1, Lcom/sina/weibo/sdk/api/WebpageObject;->title:Ljava/lang/String;

    .line 136
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_2

    .line 137
    iput-object p2, v1, Lcom/sina/weibo/sdk/api/WebpageObject;->description:Ljava/lang/String;

    .line 138
    :cond_2
    if-eqz p4, :cond_3

    invoke-virtual {p4}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_3

    .line 139
    invoke-static {p4}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 140
    .local v0, "bmp":Landroid/graphics/Bitmap;
    if-eqz v0, :cond_3

    .line 141
    sget v3, Lcom/digital/weibo/WeiboSdk;->THUMB_SIZE:I

    .local v3, "size":I
    :goto_0
    const/16 v8, 0x50

    if-ge v3, v8, :cond_4

    .line 151
    :goto_1
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    .line 155
    .end local v0    # "bmp":Landroid/graphics/Bitmap;
    .end local v3    # "size":I
    :cond_3
    iput-object v1, v7, Lcom/sina/weibo/sdk/api/WeiboMultiMessage;->mediaObject:Lcom/sina/weibo/sdk/api/BaseMediaObject;

    .line 156
    new-instance v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;

    invoke-direct {v2}, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;-><init>()V

    .line 158
    .local v2, "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v8

    iput-object v8, v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->transaction:Ljava/lang/String;

    .line 159
    iput-object v7, v2, Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;->multiMessage:Lcom/sina/weibo/sdk/api/WeiboMultiMessage;

    .line 163
    invoke-static {v2}, Lcom/digital/weibo/WeiboSdk;->sendRequest(Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;)Z

    move-result v8

    .line 166
    .end local v1    # "mediaObject":Lcom/sina/weibo/sdk/api/WebpageObject;
    .end local v2    # "request":Lcom/sina/weibo/sdk/api/share/SendMultiMessageToWeiboRequest;
    :goto_2
    return v8

    .line 142
    .restart local v0    # "bmp":Landroid/graphics/Bitmap;
    .restart local v1    # "mediaObject":Lcom/sina/weibo/sdk/api/WebpageObject;
    .restart local v3    # "size":I
    :cond_4
    sget-object v8, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 143
    const/4 v8, 0x1

    invoke-static {v0, v3, v3, v8}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v5

    .line 144
    .local v5, "thumbBmp":Landroid/graphics/Bitmap;
    const/4 v8, 0x1

    invoke-static {v5, v8}, Lcom/digital/weibo/WeiboSdk;->bmpToByteArray(Landroid/graphics/Bitmap;Z)[B

    move-result-object v6

    .line 145
    .local v6, "thumbData":[B
    sget-object v8, Lcom/digital/weibo/WeiboSdk;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    array-length v10, v6

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 146
    array-length v8, v6

    const v9, 0x8000

    if-ge v8, v9, :cond_5

    .line 147
    iput-object v6, v1, Lcom/sina/weibo/sdk/api/WebpageObject;->thumbData:[B

    goto :goto_1

    .line 141
    :cond_5
    add-int/lit8 v3, v3, -0x1e

    goto :goto_0

    .line 166
    .end local v0    # "bmp":Landroid/graphics/Bitmap;
    .end local v1    # "mediaObject":Lcom/sina/weibo/sdk/api/WebpageObject;
    .end local v3    # "size":I
    .end local v5    # "thumbBmp":Landroid/graphics/Bitmap;
    .end local v6    # "thumbData":[B
    :cond_6
    const/4 v8, 0x0

    goto :goto_2
.end method
