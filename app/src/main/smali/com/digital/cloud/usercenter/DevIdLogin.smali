.class public Lcom/digital/cloud/usercenter/DevIdLogin;
.super Ljava/lang/Object;
.source "DevIdLogin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;
    }
.end annotation


# static fields
.field static DevidLoginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

.field static GetDevidListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

.field public static MODULE_NAME:Ljava/lang/String;

.field private static mActivity:Landroid/app/Activity;

.field private static mDevid:Ljava/lang/String;

.field private static mIslogining:Z

.field private static mLoginResult:Ljava/lang/String;

.field private static mloginListener:Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 16
    sput-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->mActivity:Landroid/app/Activity;

    .line 17
    sput-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    .line 18
    const-string v0, "DevIdLogin"

    sput-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    .line 19
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mIslogining:Z

    .line 21
    sput-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->mLoginResult:Ljava/lang/String;

    .line 106
    new-instance v0, Lcom/digital/cloud/usercenter/DevIdLogin$1;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/DevIdLogin$1;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->GetDevidListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 130
    new-instance v0, Lcom/digital/cloud/usercenter/DevIdLogin$2;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/DevIdLogin$2;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->DevidLoginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 151
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 17
    sput-object p0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$1()V
    .locals 0

    .prologue
    .line 92
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->useDevidLogin()V

    return-void
.end method

.method static synthetic access$2(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 21
    sput-object p0, Lcom/digital/cloud/usercenter/DevIdLogin;->mLoginResult:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$3()Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mloginListener:Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;

    return-object v0
.end method

.method static synthetic access$4(Z)V
    .locals 0

    .prologue
    .line 19
    sput-boolean p0, Lcom/digital/cloud/usercenter/DevIdLogin;->mIslogining:Z

    return-void
.end method

.method private static getDevidAndLogin()V
    .locals 5

    .prologue
    .line 76
    sget-object v2, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 78
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 80
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "data"

    const-string v3, "tmp"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterGetDevIdUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    .line 86
    sget-object v4, Lcom/digital/cloud/usercenter/DevIdLogin;->GetDevidListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 85
    invoke-static {v2, v3, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 90
    :goto_1
    return-void

    .line 81
    :catch_0
    move-exception v1

    .line 82
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 88
    .end local v0    # "body":Lorg/json/JSONObject;
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->useDevidLogin()V

    goto :goto_1
.end method

.method public static getUserName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 42
    const-string v0, "string"

    const-string v1, "c_yk"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "context"    # Landroid/app/Activity;

    .prologue
    .line 25
    sput-object p0, Lcom/digital/cloud/usercenter/DevIdLogin;->mActivity:Landroid/app/Activity;

    .line 26
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->loadModuleInfo()V

    .line 27
    return-void
.end method

.method public static isAutoLogin()Z
    .locals 1

    .prologue
    .line 46
    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 47
    const/4 v0, 0x1

    .line 49
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static loadModuleInfo()V
    .locals 2

    .prologue
    .line 154
    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 155
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mActivity:Landroid/app/Activity;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    .line 157
    :cond_1
    return-void
.end method

.method public static login(Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;)V
    .locals 2
    .param p0, "listener"    # Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;

    .prologue
    .line 30
    sget-boolean v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mIslogining:Z

    if-eqz v0, :cond_0

    .line 32
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "DevIdLogin ing."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mIslogining:Z

    .line 37
    sput-object p0, Lcom/digital/cloud/usercenter/DevIdLogin;->mloginListener:Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;

    .line 38
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->getDevidAndLogin()V

    .line 39
    return-void
.end method

.method public static notifyResult()V
    .locals 19

    .prologue
    .line 54
    :try_start_0
    new-instance v18, Lorg/json/JSONObject;

    sget-object v5, Lcom/digital/cloud/usercenter/DevIdLogin;->mLoginResult:Ljava/lang/String;

    move-object/from16 v0, v18

    invoke-direct {v0, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 55
    .local v18, "root":Lorg/json/JSONObject;
    const-string v5, "result"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 56
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 57
    sget-object v5, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v5}, Lcom/digital/cloud/usercenter/AutoLogin;->setAutoLoginModule(Ljava/lang/String;)V

    .line 58
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->saveModuleInfo()V

    .line 59
    const-string v5, "msg"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 60
    .local v2, "msg":Ljava/lang/String;
    const-string v5, "openid"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 61
    .local v3, "openid":Ljava/lang/String;
    const-string v5, "access_token"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 62
    .local v4, "access_token":Ljava/lang/String;
    const-string v5, "register_mode"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 63
    .local v7, "mode":Ljava/lang/String;
    const-string v5, "state"

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v8

    .line 64
    .local v8, "state":I
    const/4 v5, 0x1

    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->getUserName()Ljava/lang/String;

    move-result-object v6

    invoke-static/range {v1 .. v8}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 72
    .end local v1    # "result":I
    .end local v2    # "msg":Ljava/lang/String;
    .end local v3    # "openid":Ljava/lang/String;
    .end local v4    # "access_token":Ljava/lang/String;
    .end local v7    # "mode":Ljava/lang/String;
    .end local v8    # "state":I
    :goto_0
    return-void

    .line 66
    .restart local v1    # "result":I
    :cond_0
    const-string v10, ""

    const-string v11, ""

    const-string v12, ""

    const/4 v13, 0x1

    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->getUserName()Ljava/lang/String;

    move-result-object v14

    const-string v15, ""

    const/16 v16, -0x1

    move v9, v1

    invoke-static/range {v9 .. v16}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 68
    .end local v1    # "result":I
    :catch_0
    move-exception v17

    .line 69
    .local v17, "e":Ljava/lang/Exception;
    invoke-virtual/range {v17 .. v17}, Ljava/lang/Exception;->printStackTrace()V

    .line 70
    sget v9, Lcom/digital/cloud/usercenter/ReturnCode;->FAIL:I

    const-string v10, ""

    const-string v11, ""

    const-string v12, ""

    const/4 v13, 0x1

    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->getUserName()Ljava/lang/String;

    move-result-object v14

    const-string v15, ""

    const/16 v16, -0x1

    invoke-static/range {v9 .. v16}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LoginResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;I)V

    goto :goto_0
.end method

.method private static saveModuleInfo()V
    .locals 3

    .prologue
    .line 160
    sget-object v0, Lcom/digital/cloud/usercenter/DevIdLogin;->mActivity:Landroid/app/Activity;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    sget-object v2, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 161
    return-void
.end method

.method private static useDevidLogin()V
    .locals 5

    .prologue
    .line 93
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 95
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "openid"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 96
    const-string v2, "app_id"

    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 97
    const-string v3, "devid"

    sget-object v2, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;

    if-nez v2, :cond_0

    const-string v2, ""

    :goto_0
    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 98
    sget-object v2, Lcom/digital/cloud/usercenter/DevIdLogin;->mActivity:Landroid/app/Activity;

    invoke-static {v2, v0}, Lcom/digital/cloud/usercenter/DeviceInfoWrap;->getDeviceinfo(Landroid/app/Activity;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 102
    :goto_1
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterDevIdLoginUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    .line 103
    sget-object v4, Lcom/digital/cloud/usercenter/DevIdLogin;->DevidLoginListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 102
    invoke-static {v2, v3, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 104
    return-void

    .line 97
    :cond_0
    :try_start_1
    sget-object v2, Lcom/digital/cloud/usercenter/DevIdLogin;->mDevid:Ljava/lang/String;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 99
    :catch_0
    move-exception v1

    .line 100
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method
