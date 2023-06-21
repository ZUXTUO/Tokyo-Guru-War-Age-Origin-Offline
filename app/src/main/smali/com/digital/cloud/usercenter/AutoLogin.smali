.class public Lcom/digital/cloud/usercenter/AutoLogin;
.super Ljava/lang/Object;
.source "AutoLogin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/AutoLogin$loginListener;
    }
.end annotation


# static fields
.field public static MODULE_NAME:Ljava/lang/String;

.field private static mActivity:Landroid/app/Activity;

.field private static mAutoLoginModule:Ljava/lang/String;

.field private static mIsAutoLogin:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 14
    const-string v0, "AutoLogin"

    sput-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    .line 15
    sput-object v1, Lcom/digital/cloud/usercenter/AutoLogin;->mActivity:Landroid/app/Activity;

    .line 16
    sput-object v1, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    .line 17
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static cancelAutoLogin()V
    .locals 1

    .prologue
    .line 97
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    .line 98
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->saveModuleInfo()V

    .line 99
    return-void
.end method

.method public static getUserName()Ljava/lang/String;
    .locals 3

    .prologue
    .line 25
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 26
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 27
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->getUserName()Ljava/lang/String;

    move-result-object v0

    .line 33
    :goto_0
    return-object v0

    .line 28
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 29
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "string"

    const-string v2, "c_ndqw"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->getUserName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 30
    const-string v1, "string"

    const-string v2, "c_zh"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 29
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 33
    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "context"    # Landroid/app/Activity;

    .prologue
    .line 20
    sput-object p0, Lcom/digital/cloud/usercenter/AutoLogin;->mActivity:Landroid/app/Activity;

    .line 21
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->loadModuleInfo()V

    .line 22
    return-void
.end method

.method public static isAutoLogin()Z
    .locals 2

    .prologue
    .line 47
    sget-boolean v0, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    if-eqz v0, :cond_1

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 48
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 49
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->isAutoLogin()Z

    move-result v0

    .line 55
    :goto_0
    return v0

    .line 50
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    if-nez v0, :cond_1

    .line 51
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->isAutoLogin()Z

    move-result v0

    goto :goto_0

    .line 55
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isGuestLogin()Z
    .locals 2

    .prologue
    .line 37
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 38
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 39
    const/4 v0, 0x1

    .line 43
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static loadModuleInfo()V
    .locals 6

    .prologue
    .line 102
    sget-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v3, :cond_0

    sget-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 103
    :cond_0
    sget-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->mActivity:Landroid/app/Activity;

    sget-object v4, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 106
    .local v2, "userInfo":Ljava/lang/String;
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 107
    .local v1, "root":Lorg/json/JSONObject;
    sget-boolean v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    if-eqz v3, :cond_2

    .line 108
    sget-object v3, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    const-string v4, "autoLoginModule"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 118
    .end local v1    # "root":Lorg/json/JSONObject;
    :cond_1
    :goto_0
    return-void

    .line 110
    .restart local v1    # "root":Lorg/json/JSONObject;
    :cond_2
    const-string v3, "autoLoginModule"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    .line 111
    const-string v3, "isAutoLogin"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    sput-boolean v3, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    .line 112
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter  Load "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v5, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " LocalData:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 113
    .end local v1    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 115
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "NDK_INFO"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "UserCenter  "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v5, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

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

.method public static login(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V
    .locals 2
    .param p0, "listener"    # Lcom/digital/cloud/usercenter/AutoLogin$loginListener;

    .prologue
    .line 59
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 60
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 61
    new-instance v0, Lcom/digital/cloud/usercenter/AutoLogin$1;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/AutoLogin$1;-><init>(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V

    invoke-static {v0}, Lcom/digital/cloud/usercenter/NormalLogin;->autoLogin(Lcom/digital/cloud/usercenter/NormalLogin$loginListener;)V

    .line 78
    :cond_0
    :goto_0
    return-void

    .line 68
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 69
    new-instance v0, Lcom/digital/cloud/usercenter/AutoLogin$2;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/AutoLogin$2;-><init>(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V

    invoke-static {v0}, Lcom/digital/cloud/usercenter/DevIdLogin;->login(Lcom/digital/cloud/usercenter/DevIdLogin$loginListener;)V

    goto :goto_0
.end method

.method public static notifyResult()V
    .locals 2

    .prologue
    .line 81
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 82
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/NormalLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 83
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->notifyResult()V

    .line 88
    :cond_0
    :goto_0
    return-void

    .line 84
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    sget-object v1, Lcom/digital/cloud/usercenter/DevIdLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 85
    invoke-static {}, Lcom/digital/cloud/usercenter/DevIdLogin;->notifyResult()V

    goto :goto_0
.end method

.method private static saveModuleInfo()V
    .locals 5

    .prologue
    .line 121
    sget-object v2, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    if-eqz v2, :cond_0

    .line 123
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 124
    .local v1, "root":Lorg/json/JSONObject;
    const-string v2, "autoLoginModule"

    sget-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 125
    const-string v2, "isAutoLogin"

    sget-boolean v3, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 126
    sget-object v2, Lcom/digital/cloud/usercenter/AutoLogin;->mActivity:Landroid/app/Activity;

    sget-object v3, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 127
    const-string v2, "NDK_INFO"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "UserCenter  Save "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v4, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " LocalData:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 134
    :cond_0
    :goto_0
    return-void

    .line 128
    :catch_0
    move-exception v0

    .line 129
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 130
    const-string v2, "NDK_INFO"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "UserCenter  Save "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v4, Lcom/digital/cloud/usercenter/AutoLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static setAutoLoginModule(Ljava/lang/String;)V
    .locals 1
    .param p0, "module"    # Ljava/lang/String;

    .prologue
    .line 91
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/AutoLogin;->mIsAutoLogin:Z

    .line 92
    sput-object p0, Lcom/digital/cloud/usercenter/AutoLogin;->mAutoLoginModule:Ljava/lang/String;

    .line 93
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->saveModuleInfo()V

    .line 94
    return-void
.end method
