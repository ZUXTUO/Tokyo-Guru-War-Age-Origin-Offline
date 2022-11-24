.class public Lcom/digitalsky/sdk/user/DefaultUser;
.super Ljava/lang/Object;
.source "DefaultUser.java"

# interfaces
.implements Lcom/digitalsky/sdk/user/IUser;
.implements Lcom/digitalsky/sdk/IActivity;


# instance fields
.field private DevLoginUrl:Ljava/lang/String;

.field private GenDevIdUrl:Ljava/lang/String;

.field private SETTING_NAME:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mActivity:Landroid/app/Activity;

.field private mDevId:Ljava/lang/String;

.field private mDialog:Landroid/app/ProgressDialog;

.field private mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    new-instance v0, Lcom/digitalsky/sdk/user/UserListener$DefaultUserCallback;

    invoke-direct {v0}, Lcom/digitalsky/sdk/user/UserListener$DefaultUserCallback;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .line 24
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/DefaultUser;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->TAG:Ljava/lang/String;

    .line 25
    iput-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mActivity:Landroid/app/Activity;

    .line 150
    const-string v0, "http://l.ucenter.ppgame.com/gen_devid"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->GenDevIdUrl:Ljava/lang/String;

    .line 151
    const-string v0, "http://l.ucenter.ppgame.com/devid_login"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->DevLoginUrl:Ljava/lang/String;

    .line 152
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    .line 153
    const-string v0, "FREESDK_SETTING"

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->SETTING_NAME:Ljava/lang/String;

    .line 154
    iput-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    .line 21
    return-void
.end method

.method private LoadSetting()V
    .locals 4

    .prologue
    .line 157
    iget-object v1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mActivity:Landroid/app/Activity;

    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->SETTING_NAME:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 158
    .local v0, "settings":Landroid/content/SharedPreferences;
    const-string v1, "DEV_ID"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    .line 159
    return-void
.end method

.method private ReqData(Ljava/lang/String;)[B
    .locals 5
    .param p1, "in"    # Ljava/lang/String;

    .prologue
    .line 256
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_KEY:[B

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/XXTEA;->encrypt([B[B)[B

    move-result-object v0

    .line 257
    .local v0, "data":[B
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 259
    .local v1, "head":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "app_id"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 260
    const-string v3, "version"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->VERSION:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 263
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    array-length v3, v3

    add-int/lit8 v3, v3, 0x1

    array-length v4, v0

    add-int/2addr v3, v4

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 264
    .local v2, "tmp":Ljava/nio/ByteBuffer;
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 265
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 266
    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 267
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v3

    return-object v3

    .line 261
    .end local v2    # "tmp":Ljava/nio/ByteBuffer;
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method private SaveSetting()V
    .locals 5

    .prologue
    .line 162
    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mActivity:Landroid/app/Activity;

    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser;->SETTING_NAME:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 163
    .local v1, "settings":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 164
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v2, "DEV_ID"

    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 165
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 166
    return-void
.end method

.method private _devLogin()V
    .locals 4

    .prologue
    .line 214
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 216
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "openid"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 217
    const-string v2, "app_id"

    sget-object v3, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 218
    const-string v3, "devid"

    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    if-nez v2, :cond_0

    const-string v2, ""

    :goto_0
    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/digitalsky/sdk/user/DefaultUser;->ReqData(Ljava/lang/String;)[B

    move-result-object v1

    .line 222
    .local v1, "data":[B
    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->DevLoginUrl:Ljava/lang/String;

    new-instance v3, Lcom/digitalsky/sdk/user/DefaultUser$2;

    invoke-direct {v3, p0}, Lcom/digitalsky/sdk/user/DefaultUser$2;-><init>(Lcom/digitalsky/sdk/user/DefaultUser;)V

    invoke-static {v2, v1, v3}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 240
    return-void

    .line 218
    .end local v1    # "data":[B
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 219
    :catch_0
    move-exception v2

    goto :goto_1
.end method

.method private _genDevId()V
    .locals 4

    .prologue
    .line 185
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 188
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "data"

    const-string v3, "tmp"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 191
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/digitalsky/sdk/user/DefaultUser;->ReqData(Ljava/lang/String;)[B

    move-result-object v1

    .line 192
    .local v1, "data":[B
    iget-object v2, p0, Lcom/digitalsky/sdk/user/DefaultUser;->GenDevIdUrl:Ljava/lang/String;

    new-instance v3, Lcom/digitalsky/sdk/user/DefaultUser$1;

    invoke-direct {v3, p0}, Lcom/digitalsky/sdk/user/DefaultUser$1;-><init>(Lcom/digitalsky/sdk/user/DefaultUser;)V

    invoke-static {v2, v1, v3}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 211
    return-void

    .line 189
    .end local v1    # "data":[B
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method static synthetic access$0(Lcom/digitalsky/sdk/user/DefaultUser;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 152
    iput-object p1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$1(Lcom/digitalsky/sdk/user/DefaultUser;)V
    .locals 0

    .prologue
    .line 161
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->SaveSetting()V

    return-void
.end method

.method static synthetic access$2(Lcom/digitalsky/sdk/user/DefaultUser;)V
    .locals 0

    .prologue
    .line 213
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->_devLogin()V

    return-void
.end method

.method static synthetic access$3(Lcom/digitalsky/sdk/user/DefaultUser;ILjava/lang/String;)V
    .locals 0

    .prologue
    .line 242
    invoke-direct {p0, p1, p2}, Lcom/digitalsky/sdk/user/DefaultUser;->loginFail(ILjava/lang/String;)V

    return-void
.end method

.method static synthetic access$4(Lcom/digitalsky/sdk/user/DefaultUser;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 247
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/user/DefaultUser;->loginSuccess(Ljava/lang/String;)V

    return-void
.end method

.method private devLogin()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 169
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 170
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->LoadSetting()V

    .line 172
    :cond_0
    new-instance v0, Landroid/app/ProgressDialog;

    iget-object v1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    .line 173
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    .line 174
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    .line 175
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    const-string v1, "Loging ......"

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 176
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    .line 177
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDevId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 178
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->_genDevId()V

    .line 182
    :goto_0
    return-void

    .line 180
    :cond_1
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->_devLogin()V

    goto :goto_0
.end method

.method private loginFail(ILjava/lang/String;)V
    .locals 4
    .param p1, "result"    # I
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 243
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    .line 244
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    const/4 v1, -0x1

    new-instance v2, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    const/4 v3, 0x0

    invoke-direct {v2, p1, v3, p2}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v1, v2}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V

    .line 245
    return-void
.end method

.method private loginSuccess(Ljava/lang/String;)V
    .locals 3
    .param p1, "ret"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 248
    iget-object v1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v1}, Landroid/app/ProgressDialog;->dismiss()V

    .line 249
    new-instance v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;

    .line 250
    const/4 v1, 0x1

    .line 249
    invoke-direct {v0, v2, v2, p1, v1}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;-><init>(IILjava/lang/String;Z)V

    .line 251
    .local v0, "req_success":Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    iget-object v1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    invoke-interface {v1, v2, v0}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V

    .line 252
    return-void
.end method


# virtual methods
.method public add_info(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "k"    # Ljava/lang/String;
    .param p2, "v"    # Ljava/lang/String;

    .prologue
    .line 273
    const/4 v0, 0x0

    return v0
.end method

.method public enterPlatform(I)Z
    .locals 2
    .param p1, "index"    # I

    .prologue
    .line 50
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "call enterPlatform: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 51
    const/4 v0, 0x1

    return v0
.end method

.method public exit()Z
    .locals 1

    .prologue
    .line 74
    const-string v0, "call exit "

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 75
    const/4 v0, 0x1

    return v0
.end method

.method public hideToolBar()Z
    .locals 1

    .prologue
    .line 68
    const-string v0, "call hideToolBar "

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 69
    const/4 v0, 0x1

    return v0
.end method

.method public login(Ljava/lang/String;)Z
    .locals 2
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    .line 30
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "call login "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 31
    invoke-direct {p0}, Lcom/digitalsky/sdk/user/DefaultUser;->devLogin()V

    .line 32
    const/4 v0, 0x1

    return v0
.end method

.method public loginCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V
    .locals 0
    .param p1, "res"    # Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    .prologue
    .line 88
    return-void
.end method

.method public logout()Z
    .locals 1

    .prologue
    .line 37
    const-string v0, "call logout"

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 38
    iget-object v0, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    invoke-interface {v0}, Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;->onLogoutCallback()V

    .line 39
    const/4 v0, 0x1

    return v0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 136
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 142
    return-void
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 93
    iput-object p1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mActivity:Landroid/app/Activity;

    .line 94
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .prologue
    .line 130
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 148
    return-void
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 118
    return-void
.end method

.method public onRestart()V
    .locals 0

    .prologue
    .line 100
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 112
    return-void
.end method

.method public onStart()V
    .locals 0

    .prologue
    .line 106
    return-void
.end method

.method public onStop()V
    .locals 0

    .prologue
    .line 124
    return-void
.end method

.method public setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V
    .locals 0
    .param p1, "listener"    # Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .prologue
    .line 81
    iput-object p1, p0, Lcom/digitalsky/sdk/user/DefaultUser;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .line 82
    return-void
.end method

.method public showToolBar()Z
    .locals 1

    .prologue
    .line 62
    const-string v0, "call showToolBar "

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 63
    const/4 v0, 0x1

    return v0
.end method

.method public submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z
    .locals 2
    .param p1, "data"    # Lcom/digitalsky/sdk/user/SubmitData;

    .prologue
    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "call submitInfo "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 57
    const/4 v0, 0x1

    return v0
.end method

.method public switchAccount()Z
    .locals 1

    .prologue
    .line 44
    const-string v0, "call switchAccount "

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 45
    const/4 v0, 0x1

    return v0
.end method
