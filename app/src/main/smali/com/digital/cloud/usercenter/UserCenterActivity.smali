.class public Lcom/digital/cloud/usercenter/UserCenterActivity;
.super Landroid/app/Activity;
.source "UserCenterActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;,
        Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;
    }
.end annotation


# static fields
.field private static mActivity:Landroid/app/Activity;

.field private static mAlreadyNotifyLogin:Z

.field private static mIsInit:Z

.field private static mIsLoginSuccess:Z

.field private static mIsRuning:Z

.field private static mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

.field private static mLoginResult:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;

.field private static mLogoutCallback:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

.field private static mParentActivity:Landroid/app/Activity;

.field private static mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

.field private static mVersion:Ljava/lang/String;


# instance fields
.field private mPageManager:Lcom/digital/cloud/usercenter/page/PageManager;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 38
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    .line 39
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mActivity:Landroid/app/Activity;

    .line 40
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    .line 41
    const-string v0, "1.0"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mVersion:Ljava/lang/String;

    .line 42
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoginResult:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;

    .line 43
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLogoutCallback:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

    .line 44
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mAlreadyNotifyLogin:Z

    .line 45
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    .line 46
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsRuning:Z

    .line 47
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsInit:Z

    .line 48
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 25
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 37
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mPageManager:Lcom/digital/cloud/usercenter/page/PageManager;

    .line 25
    return-void
.end method

.method public static LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V
    .locals 4
    .param p0, "result"    # I
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "openid"    # Ljava/lang/String;
    .param p3, "accessToken"    # Ljava/lang/String;
    .param p4, "isGuest"    # Z
    .param p5, "account"    # Ljava/lang/String;
    .param p6, "register_mode"    # Ljava/lang/String;
    .param p7, "state"    # I

    .prologue
    const/4 v3, 0x1

    .line 266
    sget-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mAlreadyNotifyLogin:Z

    if-eqz v2, :cond_0

    .line 291
    :goto_0
    return-void

    .line 268
    :cond_0
    sput-boolean v3, Lcom/digital/cloud/usercenter/UserCenterActivity;->mAlreadyNotifyLogin:Z

    .line 269
    const/4 v2, 0x0

    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsRuning:Z

    .line 270
    if-nez p0, :cond_1

    .line 271
    sput-boolean v3, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    .line 273
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v2, v3, p4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->init(Landroid/app/Activity;Z)V

    .line 274
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v2, p2, p3, p5}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 277
    :cond_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 279
    .local v1, "root":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "result"

    invoke-virtual {v1, v2, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 280
    const-string v2, "msg"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 281
    const-string v2, "openid"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 282
    const-string v2, "accessToken"

    invoke-virtual {v1, v2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 283
    const-string v2, "state"

    invoke-virtual {v1, v2, p7}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 284
    const-string v2, "register_mode"

    invoke-virtual {v1, v2, p6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 288
    :goto_1
    new-instance v2, Lcom/digital/cloud/usercenter/UserInfo;

    invoke-direct {v2, v1}, Lcom/digital/cloud/usercenter/UserInfo;-><init>(Lorg/json/JSONObject;)V

    sput-object v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    .line 289
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoginResult:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;->result(Ljava/lang/String;)V

    .line 290
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->finish()V

    goto :goto_0

    .line 285
    :catch_0
    move-exception v0

    .line 286
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public static LogoutResponse()V
    .locals 1

    .prologue
    .line 298
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    .line 299
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/UserInfo;->clear()V

    .line 300
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->cancelAutoLogin()V

    .line 301
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->cleanUrlParam()V

    .line 302
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLogoutCallback:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

    if-eqz v0, :cond_0

    .line 303
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLogoutCallback:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;->finish()V

    .line 304
    :cond_0
    return-void
.end method

.method public static PayResponse(ILjava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p0, "state"    # I
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "money"    # I
    .param p3, "orderid"    # Ljava/lang/String;

    .prologue
    .line 295
    return-void
.end method

.method public static QuickRegisterPageConfig(ZZ)V
    .locals 0
    .param p0, "tel"    # Z
    .param p1, "email"    # Z

    .prologue
    .line 195
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->showPageSelect(ZZ)V

    .line 196
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->showPageSelect(ZZ)V

    .line 197
    return-void
.end method

.method public static add_info(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 164
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/UserCenterConfig;->handleConfig(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 165
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->addUrlParam(Ljava/lang/String;Ljava/lang/String;)V

    .line 166
    const-string v0, "language"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 167
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterConfig;->sLanguage:Ljava/lang/String;

    .line 170
    :cond_0
    return-void
.end method

.method private applyCompat()V
    .locals 3

    .prologue
    const/16 v2, 0x400

    .line 77
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    .line 81
    :goto_0
    return-void

    .line 80
    :cond_0
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2, v2}, Landroid/view/Window;->setFlags(II)V

    goto :goto_0
.end method

.method public static createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 7
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "httpBody"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 246
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 247
    .local v3, "tmp":Lorg/json/JSONObject;
    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->sLanguage:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 248
    const-string v4, "language"

    sget-object v5, Lcom/digital/cloud/usercenter/UserCenterConfig;->sLanguage:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 250
    :cond_0
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 256
    .end local v3    # "tmp":Lorg/json/JSONObject;
    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    sget-object v5, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppKey:[B

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/XXTEA;->encrypt([B[B)[B

    move-result-object v1

    .line 257
    .local v1, "data":[B
    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->packageRequestData([B)[B

    move-result-object v0

    .line 261
    .local v0, "body":[B
    invoke-static {p0, v0, p2}, Lcom/digital/cloud/usercenter/MyHttpClient;->asyncHttpRequest(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 262
    return-void

    .line 251
    .end local v0    # "body":[B
    .end local v1    # "data":[B
    :catch_0
    move-exception v2

    .line 253
    .local v2, "e":Ljava/lang/Exception;
    const-string v4, "NDK_INFO"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static emailBind(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 0
    .param p0, "email"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 353
    invoke-static {p0, p1, p2}, Lcom/digital/cloud/usercenter/EmailManage;->emailBind(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 354
    return-void
.end method

.method public static getToolBarUrl(I)Ljava/lang/String;
    .locals 1
    .param p0, "index"    # I

    .prologue
    .line 334
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    if-eqz v0, :cond_0

    .line 335
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v0, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->getToolBarPageUrl(I)Ljava/lang/String;

    move-result-object v0

    .line 336
    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public static getUserInfo()Ljava/lang/String;
    .locals 1

    .prologue
    .line 357
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/UserInfo;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static hideLoading()V
    .locals 1

    .prologue
    .line 71
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    if-eqz v0, :cond_0

    .line 72
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    invoke-virtual {v0}, Lcom/digital/cloud/utils/LoadingDialog;->dismiss()V

    .line 74
    :cond_0
    return-void
.end method

.method public static init(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "context"    # Landroid/app/Activity;
    .param p1, "appid"    # Ljava/lang/String;
    .param p2, "appkey"    # Ljava/lang/String;
    .param p3, "platformType"    # Ljava/lang/String;

    .prologue
    .line 85
    const-string v0, "1"

    invoke-static {p0, p1, p2, p3, v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->init(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 86
    return-void
.end method

.method public static init(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p0, "context"    # Landroid/app/Activity;
    .param p1, "appid"    # Ljava/lang/String;
    .param p2, "appkey"    # Ljava/lang/String;
    .param p3, "platformType"    # Ljava/lang/String;
    .param p4, "channelId"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 89
    sget-boolean v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsInit:Z

    if-eqz v1, :cond_0

    .line 90
    const-string v1, "NDK_INFO"

    const-string v2, "Already init."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 117
    :goto_0
    return-void

    .line 93
    :cond_0
    const/4 v1, 0x1

    sput-boolean v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsInit:Z

    .line 95
    sput-object p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    .line 96
    const/16 v1, 0x10

    new-array v0, v1, [B

    .line 97
    .local v0, "tmp":[B
    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v2, v0

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    array-length v3, v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v1, v4, v0, v4, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 99
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->APPIdentifying:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 100
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->APPIdentifying:Ljava/lang/String;

    .line 102
    :cond_1
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->init(Landroid/content/res/Resources;Ljava/lang/String;)V

    .line 104
    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppKey:[B

    .line 105
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    .line 106
    sput-object p3, Lcom/digital/cloud/usercenter/UserCenterConfig;->PlatformType:Ljava/lang/String;

    .line 107
    sput-object p4, Lcom/digital/cloud/usercenter/UserCenterConfig;->ChannelID:Ljava/lang/String;

    .line 109
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/DevIdLogin;->init(Landroid/app/Activity;)V

    .line 110
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/AutoLogin;->init(Landroid/app/Activity;)V

    .line 111
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/NormalLogin;->init(Landroid/app/Activity;)V

    .line 112
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/TelphoneManage;->init(Landroid/app/Activity;)V

    .line 113
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/EmailManage;->init(Landroid/app/Activity;)V

    .line 115
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->orientation:I

    sput v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->Orientation:I

    .line 116
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Orientation "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->Orientation:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static isAlreadyNotify()Z
    .locals 1

    .prologue
    .line 340
    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mAlreadyNotifyLogin:Z

    return v0
.end method

.method public static login(Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;)Z
    .locals 4
    .param p0, "loginCallback"    # Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;
    .param p1, "logoutCallback"    # Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

    .prologue
    const/4 v3, 0x1

    .line 128
    sget-boolean v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsRuning:Z

    if-eqz v1, :cond_0

    .line 129
    const-string v1, "NDK_INFO"

    const-string v2, "Already run."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 139
    :goto_0
    return v3

    .line 132
    :cond_0
    sput-boolean v3, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsRuning:Z

    .line 133
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/UserInfo;->clear()V

    .line 135
    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    const-class v2, Lcom/digital/cloud/usercenter/UserCenterActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 136
    .local v0, "intent":Landroid/content/Intent;
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 137
    sput-object p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoginResult:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;

    .line 138
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLogoutCallback:Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;

    goto :goto_0
.end method

.method public static logout()Z
    .locals 1

    .prologue
    .line 143
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LogoutResponse()V

    .line 144
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->onHideToolebar()V

    .line 145
    const/4 v0, 0x1

    return v0
.end method

.method public static onHideToolebar()V
    .locals 1

    .prologue
    .line 320
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    if-eqz v0, :cond_0

    .line 321
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->hideToolBar()V

    .line 322
    :cond_0
    return-void
.end method

.method public static onShowToolebar()V
    .locals 1

    .prologue
    .line 307
    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->tool_bar_auto_show:Z

    if-nez v0, :cond_1

    .line 312
    :cond_0
    :goto_0
    return-void

    .line 310
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    if-eqz v0, :cond_0

    .line 311
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->showToolBar()V

    goto :goto_0
.end method

.method public static onShowToolebarForce()V
    .locals 1

    .prologue
    .line 315
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    if-eqz v0, :cond_0

    .line 316
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->showToolBar()V

    .line 317
    :cond_0
    return-void
.end method

.method public static open_user_center()Z
    .locals 1

    .prologue
    .line 156
    const/4 v0, 0x0

    return v0
.end method

.method public static packageRequestData([B)[B
    .locals 6
    .param p0, "data"    # [B

    .prologue
    .line 227
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 229
    .local v1, "head":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 230
    const-string v3, "version"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterActivity;->mVersion:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 235
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    array-length v3, v3

    add-int/lit8 v3, v3, 0x1

    array-length v4, p0

    add-int/2addr v3, v4

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 236
    .local v2, "tmp":Ljava/nio/ByteBuffer;
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 237
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 238
    invoke-virtual {v2, p0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 239
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter buff len:"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 240
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v3

    return-object v3

    .line 231
    .end local v2    # "tmp":Ljava/nio/ByteBuffer;
    :catch_0
    move-exception v0

    .line 232
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static payment(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p0, "money"    # I
    .param p1, "product_id"    # Ljava/lang/String;
    .param p2, "product_name"    # Ljava/lang/String;
    .param p3, "serverid"    # Ljava/lang/String;
    .param p4, "charid"    # Ljava/lang/String;
    .param p5, "accountid"    # Ljava/lang/String;

    .prologue
    .line 150
    const-string v0, "NDK_INFO"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "UserCenter money:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " product_id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " product_name:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 151
    const-string v2, " serverid:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " charid:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " accountid:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 150
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 152
    const/4 v0, 0x0

    return v0
.end method

.method public static setAppIdentifying(Ljava/lang/String;)V
    .locals 0
    .param p0, "i"    # Ljava/lang/String;

    .prologue
    .line 120
    sput-object p0, Lcom/digital/cloud/usercenter/UserCenterConfig;->APPIdentifying:Ljava/lang/String;

    .line 121
    return-void
.end method

.method public static setClause(Z)V
    .locals 0
    .param p0, "isShow"    # Z

    .prologue
    .line 200
    invoke-static {p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->setClause(Z)V

    .line 201
    return-void
.end method

.method public static setHideGuest(Z)V
    .locals 0
    .param p0, "isHide"    # Z

    .prologue
    .line 208
    sput-boolean p0, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    .line 209
    return-void
.end method

.method public static setLanguage(Ljava/lang/String;)V
    .locals 5
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    .line 173
    const-string v2, "NDK_INFO"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "setLanguage: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 175
    :try_start_0
    new-instance v1, Ljava/util/Locale;

    invoke-direct {v1, p0}, Ljava/util/Locale;-><init>(Ljava/lang/String;)V

    .line 176
    .local v1, "locale":Ljava/util/Locale;
    const-string v2, "cn"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 177
    new-instance v1, Ljava/util/Locale;

    .end local v1    # "locale":Ljava/util/Locale;
    const-string v2, "zh"

    const-string v3, "CN"

    invoke-direct {v1, v2, v3}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 183
    .restart local v1    # "locale":Ljava/util/Locale;
    :cond_0
    :goto_0
    invoke-static {v1}, Ljava/util/Locale;->setDefault(Ljava/util/Locale;)V

    .line 184
    new-instance v0, Landroid/content/res/Configuration;

    invoke-direct {v0}, Landroid/content/res/Configuration;-><init>()V

    .line 185
    .local v0, "config":Landroid/content/res/Configuration;
    iput-object v1, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 186
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 187
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    .line 186
    invoke-virtual {v2, v0, v3}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 192
    .end local v0    # "config":Landroid/content/res/Configuration;
    .end local v1    # "locale":Ljava/util/Locale;
    :goto_1
    return-void

    .line 178
    .restart local v1    # "locale":Ljava/util/Locale;
    :cond_1
    const-string v2, "tw"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 179
    new-instance v1, Ljava/util/Locale;

    .end local v1    # "locale":Ljava/util/Locale;
    const-string v2, "zh"

    const-string v3, "TW"

    invoke-direct {v1, v2, v3}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 180
    .restart local v1    # "locale":Ljava/util/Locale;
    goto :goto_0

    :cond_2
    const-string v2, "kr"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 181
    new-instance v1, Ljava/util/Locale;

    .end local v1    # "locale":Ljava/util/Locale;
    const-string v2, "ko"

    invoke-direct {v1, v2}, Ljava/util/Locale;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .restart local v1    # "locale":Ljava/util/Locale;
    goto :goto_0

    .line 189
    .end local v1    # "locale":Ljava/util/Locale;
    :catch_0
    move-exception v2

    goto :goto_1
.end method

.method public static setToolebarAutoShow(Z)V
    .locals 0
    .param p0, "show"    # Z

    .prologue
    .line 325
    sput-boolean p0, Lcom/digital/cloud/usercenter/UserCenterConfig;->tool_bar_auto_show:Z

    .line 326
    return-void
.end method

.method public static setUserCenterArea(Ljava/lang/String;)V
    .locals 0
    .param p0, "area"    # Ljava/lang/String;

    .prologue
    .line 204
    invoke-static {p0}, Lcom/digital/cloud/usercenter/UserCenterConfig;->setArea(Ljava/lang/String;)V

    .line 205
    return-void
.end method

.method public static showLoading()V
    .locals 1

    .prologue
    .line 65
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    if-eqz v0, :cond_0

    .line 66
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    invoke-virtual {v0}, Lcom/digital/cloud/utils/LoadingDialog;->show()V

    .line 68
    :cond_0
    return-void
.end method

.method public static showToolBarPage(I)V
    .locals 1
    .param p0, "index"    # I

    .prologue
    .line 329
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsLoginSuccess:Z

    if-eqz v0, :cond_0

    .line 330
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mToolBarController:Lcom/digital/cloud/usercenter/toolbar/ToolBarController;

    invoke-virtual {v0, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->showToolBarPage(I)V

    .line 331
    :cond_0
    return-void
.end method

.method public static switch_account()Z
    .locals 1

    .prologue
    .line 160
    const/4 v0, 0x0

    return v0
.end method

.method public static telBind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 0
    .param p0, "phoneNumber"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "vcode"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 345
    invoke-static {p0, p1, p2, p3}, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberBind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 346
    return-void
.end method

.method public static telVcode(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 0
    .param p0, "phoneNumber"    # Ljava/lang/String;
    .param p1, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 349
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/TelphoneManage;->requestTelphoneVcode(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 350
    return-void
.end method

.method public static toString(I)Ljava/lang/String;
    .locals 1
    .param p0, "res"    # I

    .prologue
    .line 213
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 214
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v0, p0}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 216
    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public static version()Ljava/lang/String;
    .locals 1

    .prologue
    .line 124
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mVersion:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "b"    # Landroid/os/Bundle;

    .prologue
    const/4 v2, 0x0

    .line 52
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 54
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->applyCompat()V

    .line 55
    const-string v0, "style"

    const-string v1, "MyDialog"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setTheme(I)V

    .line 56
    sput-object p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mActivity:Landroid/app/Activity;

    .line 57
    invoke-static {p0}, Lcom/digital/cloud/utils/LoadingDialog;->create(Landroid/content/Context;)Lcom/digital/cloud/utils/LoadingDialog;

    move-result-object v0

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mLoadingDialog:Lcom/digital/cloud/utils/LoadingDialog;

    .line 58
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showPage()V

    .line 59
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_0

    .line 60
    invoke-virtual {p0, v2}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setFinishOnTouchOutside(Z)V

    .line 61
    :cond_0
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterActivity;->mAlreadyNotifyLogin:Z

    .line 62
    return-void
.end method

.method protected onDestroy()V
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 386
    const-string v0, "NDK_INFO"

    const-string v1, "UserCenter onDestroy"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 387
    sget v0, Lcom/digital/cloud/usercenter/ReturnCode;->USER_CANCEL:I

    const-string v1, "User Cancel"

    const-string v2, ""

    const-string v3, ""

    const-string v5, ""

    const-string v6, ""

    const/4 v7, -0x1

    invoke-static/range {v0 .. v7}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 389
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 390
    sput-boolean v4, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsInit:Z

    .line 391
    sput-boolean v4, Lcom/digital/cloud/usercenter/UserCenterActivity;->mIsRuning:Z

    .line 392
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 374
    const-string v0, "NDK_INFO"

    const-string v1, "UserCenter onPause"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 375
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 376
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 368
    const-string v0, "NDK_INFO"

    const-string v1, "UserCenter onResume"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 369
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 370
    return-void
.end method

.method protected onStart()V
    .locals 2

    .prologue
    .line 362
    const-string v0, "NDK_INFO"

    const-string v1, "UserCenter onStart"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 363
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 364
    return-void
.end method

.method protected onStop()V
    .locals 2

    .prologue
    .line 380
    const-string v0, "NDK_INFO"

    const-string v1, "UserCenter onStop"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 381
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 382
    return-void
.end method

.method public showPage()V
    .locals 2

    .prologue
    .line 220
    iget-object v0, p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mPageManager:Lcom/digital/cloud/usercenter/page/PageManager;

    if-nez v0, :cond_0

    .line 221
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterActivity;->mParentActivity:Landroid/app/Activity;

    invoke-direct {v0, p0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;-><init>(Landroid/app/Activity;Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mPageManager:Lcom/digital/cloud/usercenter/page/PageManager;

    .line 223
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/UserCenterActivity;->mPageManager:Lcom/digital/cloud/usercenter/page/PageManager;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/page/PageManager;->show()V

    .line 224
    return-void
.end method
