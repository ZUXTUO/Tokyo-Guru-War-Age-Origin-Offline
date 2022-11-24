.class public Lcom/digital/cloud/usercenter/NormalLogin;
.super Ljava/lang/Object;
.source "NormalLogin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/NormalLogin$loginListener;
    }
.end annotation


# static fields
.field public static MODULE_NAME:Ljava/lang/String;

.field static authListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

.field static loginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

.field private static mAccessToken:Ljava/lang/String;

.field private static mAccountList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;"
        }
    .end annotation
.end field

.field private static mActivity:Landroid/app/Activity;

.field private static mAuthListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

.field private static mIslogining:Z

.field private static mLoginIdenitfy:Ljava/lang/String;

.field private static mLoginResult:Z

.field private static mMode:Ljava/lang/String;

.field private static mOpenid:Ljava/lang/String;

.field private static mState:I

.field private static mloginListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 20
    const-string v0, "NormalLogin"

    sput-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    .line 21
    sput-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    .line 24
    sput-boolean v2, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    .line 26
    sput-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    .line 27
    sput-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    .line 28
    sput-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    .line 29
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mMode:Ljava/lang/String;

    .line 30
    const/4 v0, -0x1

    sput v0, Lcom/digital/cloud/usercenter/NormalLogin;->mState:I

    .line 31
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    .line 33
    sput-boolean v2, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginResult:Z

    .line 127
    new-instance v0, Lcom/digital/cloud/usercenter/NormalLogin$1;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/NormalLogin$1;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->authListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 149
    new-instance v0, Lcom/digital/cloud/usercenter/NormalLogin$2;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/NormalLogin$2;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->loginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 174
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static IdentifyExist(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 4
    .param p0, "login_identify"    # Ljava/lang/String;
    .param p1, "callback"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 177
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 179
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "identify"

    invoke-virtual {v0, v2, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 184
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterIdentifyExistUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, p1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 186
    return-void

    .line 180
    :catch_0
    move-exception v1

    .line 181
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method static synthetic access$0(Z)V
    .locals 0

    .prologue
    .line 33
    sput-boolean p0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginResult:Z

    return-void
.end method

.method static synthetic access$1()Lcom/digital/cloud/usercenter/NormalLogin$loginListener;
    .locals 1

    .prologue
    .line 23
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAuthListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    return-object v0
.end method

.method static synthetic access$2(Z)V
    .locals 0

    .prologue
    .line 24
    sput-boolean p0, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    return-void
.end method

.method static synthetic access$3(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 26
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$4(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 27
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$5(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 29
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mMode:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$6(I)V
    .locals 0

    .prologue
    .line 30
    sput p0, Lcom/digital/cloud/usercenter/NormalLogin;->mState:I

    return-void
.end method

.method static synthetic access$7()Lcom/digital/cloud/usercenter/NormalLogin$loginListener;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mloginListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    return-object v0
.end method

.method public static autoLogin(Lcom/digital/cloud/usercenter/NormalLogin$loginListener;)V
    .locals 5
    .param p0, "callback"    # Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    .prologue
    .line 66
    sget-boolean v2, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    if-eqz v2, :cond_0

    .line 68
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v3, "NormalLogin ing."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->isAutoLogin()Z

    move-result v2

    if-nez v2, :cond_1

    .line 73
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v3, "NormalLogin auth no id."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 93
    :goto_0
    return-void

    .line 77
    :cond_1
    const/4 v2, 0x0

    sput-boolean v2, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginResult:Z

    .line 78
    const/4 v2, 0x1

    sput-boolean v2, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    .line 80
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 82
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "app_id"

    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 83
    const-string v2, "openid"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 84
    const-string v2, "access_token"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 85
    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    invoke-static {v2, v0}, Lcom/digital/cloud/usercenter/DeviceInfoWrap;->getDeviceinfo(Landroid/app/Activity;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 89
    :goto_1
    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "NormalLogin auth"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mAuthListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    .line 91
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterAuthUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    .line 92
    sget-object v4, Lcom/digital/cloud/usercenter/NormalLogin;->authListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 91
    invoke-static {v2, v3, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    goto :goto_0

    .line 86
    :catch_0
    move-exception v1

    .line 87
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public static deleteAccount(I)V
    .locals 1
    .param p0, "index"    # I

    .prologue
    .line 194
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/digital/cloud/usercenter/AccountInfo;->delete(Ljava/util/ArrayList;I)V

    .line 195
    return-void
.end method

.method public static getAccount(I)Lcom/digital/cloud/usercenter/AccountInfo;
    .locals 1
    .param p0, "index"    # I

    .prologue
    .line 199
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/digital/cloud/usercenter/AccountInfo;->get(Ljava/util/ArrayList;I)Lcom/digital/cloud/usercenter/AccountInfo;

    move-result-object v0

    return-object v0
.end method

.method public static getAccounts()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 189
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    return-object v0
.end method

.method public static getUserName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 42
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/CommonTool;->isEmail(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 43
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 45
    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "context"    # Landroid/app/Activity;

    .prologue
    .line 37
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    .line 38
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->loadModuleInfo()V

    .line 39
    return-void
.end method

.method public static isAutoLogin()Z
    .locals 1

    .prologue
    .line 49
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 50
    const/4 v0, 0x1

    .line 52
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static loadModuleInfo()V
    .locals 6

    .prologue
    .line 204
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    if-eqz v3, :cond_0

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 205
    :cond_0
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    sget-object v4, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 208
    .local v1, "moduleInfo":Ljava/lang/String;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 209
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "loginIdenitfy"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    .line 210
    const-string v3, "openid"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    .line 211
    const-string v3, "accessToken"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    .line 212
    const-string v3, "state"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v3

    sput v3, Lcom/digital/cloud/usercenter/NormalLogin;->mState:I

    .line 213
    const-string v3, "register_mode"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mMode:Ljava/lang/String;

    .line 214
    const-string v3, "accounts"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    invoke-static {v3}, Lcom/digital/cloud/usercenter/AccountInfo;->toList(Lorg/json/JSONArray;)Ljava/util/ArrayList;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 220
    .end local v2    # "root":Lorg/json/JSONObject;
    :cond_1
    :goto_0
    return-void

    .line 215
    :catch_0
    move-exception v0

    .line 217
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter  Load "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v5, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " LocalData Format fail."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static normalLogin(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/NormalLogin$loginListener;)V
    .locals 6
    .param p0, "login_identify"    # Ljava/lang/String;
    .param p1, "openid"    # Ljava/lang/String;
    .param p2, "login_pwd"    # Ljava/lang/String;
    .param p3, "encrypt_mode"    # Ljava/lang/String;
    .param p4, "callback"    # Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    .prologue
    .line 97
    sget-boolean v3, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    if-eqz v3, :cond_0

    .line 99
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "NormalLogin ing."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    :goto_0
    return-void

    .line 103
    :cond_0
    new-instance v0, Lcom/digital/cloud/usercenter/AccountInfo;

    invoke-direct {v0, p0, p2}, Lcom/digital/cloud/usercenter/AccountInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    .local v0, "account":Lcom/digital/cloud/usercenter/AccountInfo;
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    invoke-static {v3, v0}, Lcom/digital/cloud/usercenter/AccountInfo;->Add(Ljava/util/ArrayList;Lcom/digital/cloud/usercenter/AccountInfo;)V

    .line 105
    const/4 v3, 0x0

    sput-boolean v3, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginResult:Z

    .line 106
    const/4 v3, 0x1

    sput-boolean v3, Lcom/digital/cloud/usercenter/NormalLogin;->mIslogining:Z

    .line 107
    sput-object p0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    .line 109
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 111
    .local v1, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 112
    const-string v3, "login_identify"

    invoke-virtual {v1, v3, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 113
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 114
    const-string v3, "openid"

    invoke-virtual {v1, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 115
    :cond_1
    const-string v3, "login_pwd"

    invoke-static {p2}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 116
    const-string v3, "encrypt_mode"

    invoke-virtual {v1, v3, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 117
    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    invoke-static {v3, v1}, Lcom/digital/cloud/usercenter/DeviceInfoWrap;->getDeviceinfo(Landroid/app/Activity;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 121
    :goto_1
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "NormalLogin "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    sput-object p4, Lcom/digital/cloud/usercenter/NormalLogin;->mloginListener:Lcom/digital/cloud/usercenter/NormalLogin$loginListener;

    .line 123
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterNormalLoginUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    .line 124
    sget-object v5, Lcom/digital/cloud/usercenter/NormalLogin;->loginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 123
    invoke-static {v3, v4, v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    goto :goto_0

    .line 118
    :catch_0
    move-exception v2

    .line 119
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public static notifyResult()V
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 56
    sget-boolean v0, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginResult:Z

    if-eqz v0, :cond_0

    .line 57
    sget-object v0, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/AutoLogin;->setAutoLoginModule(Ljava/lang/String;)V

    .line 58
    sget v0, Lcom/digital/cloud/usercenter/ReturnCode;->SUCCESS:I

    const-string v1, ""

    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->getUserName()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Lcom/digital/cloud/usercenter/NormalLogin;->mMode:Ljava/lang/String;

    .line 59
    sget v7, Lcom/digital/cloud/usercenter/NormalLogin;->mState:I

    .line 58
    invoke-static/range {v0 .. v7}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 63
    :goto_0
    return-void

    .line 61
    :cond_0
    sget v0, Lcom/digital/cloud/usercenter/ReturnCode;->FAIL:I

    const-string v1, ""

    const-string v2, ""

    const-string v3, ""

    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->getUserName()Ljava/lang/String;

    move-result-object v5

    const-string v6, ""

    const/4 v7, -0x1

    invoke-static/range {v0 .. v7}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V

    goto :goto_0
.end method

.method public static saveModuleInfo()V
    .locals 5

    .prologue
    .line 223
    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 224
    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 226
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 227
    .local v1, "root":Lorg/json/JSONObject;
    const-string v2, "loginIdenitfy"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mLoginIdenitfy:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 228
    const-string v2, "openid"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mOpenid:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 229
    const-string v2, "accessToken"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 230
    const-string v2, "state"

    sget v3, Lcom/digital/cloud/usercenter/NormalLogin;->mState:I

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 231
    const-string v2, "register_mode"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mMode:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 232
    const-string v2, "accounts"

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->mAccountList:Ljava/util/ArrayList;

    invoke-static {v3}, Lcom/digital/cloud/usercenter/AccountInfo;->toJsonArr(Ljava/util/ArrayList;)Lorg/json/JSONArray;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 233
    sget-object v2, Lcom/digital/cloud/usercenter/NormalLogin;->mActivity:Landroid/app/Activity;

    sget-object v3, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 239
    :cond_0
    :goto_0
    return-void

    .line 234
    :catch_0
    move-exception v0

    .line 235
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 236
    const-string v2, "NDK_INFO"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "UserCenter  Save "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v4, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " LocalData Format fail."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
