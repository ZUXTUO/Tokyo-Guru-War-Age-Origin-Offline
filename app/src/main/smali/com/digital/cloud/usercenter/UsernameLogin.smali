.class public Lcom/digital/cloud/usercenter/UsernameLogin;
.super Ljava/lang/Object;
.source "UsernameLogin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    }
.end annotation


# static fields
.field private static AccountList:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;",
            ">;"
        }
    .end annotation
.end field

.field public static MODULE_NAME:Ljava/lang/String;

.field private static instance:Lcom/digital/cloud/usercenter/UsernameLogin;

.field private static mActivity:Landroid/app/Activity;

.field private static mAppId:Ljava/lang/String;

.field private static mCurrentLoginInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

.field private static mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

.field private static mIsRegistering:Z

.field private static mIslogining:Z

.field private static mUserCenterNormalLoginUrl:Ljava/lang/String;

.field private static mUserCenterUsernameRegisterUrl:Ljava/lang/String;

.field static usernameRegisterListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 18
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mActivity:Landroid/app/Activity;

    .line 19
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mAppId:Ljava/lang/String;

    .line 21
    const-string v0, "UsernameLogin"

    sput-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->MODULE_NAME:Ljava/lang/String;

    .line 23
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mUserCenterUsernameRegisterUrl:Ljava/lang/String;

    .line 24
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mUserCenterNormalLoginUrl:Ljava/lang/String;

    .line 25
    sput-boolean v2, Lcom/digital/cloud/usercenter/UsernameLogin;->mIslogining:Z

    .line 26
    sput-boolean v2, Lcom/digital/cloud/usercenter/UsernameLogin;->mIsRegistering:Z

    .line 27
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentLoginInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    .line 28
    sput-object v1, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    .line 33
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    .line 34
    new-instance v0, Lcom/digital/cloud/usercenter/UsernameLogin;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/UsernameLogin;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->instance:Lcom/digital/cloud/usercenter/UsernameLogin;

    .line 163
    new-instance v0, Lcom/digital/cloud/usercenter/UsernameLogin$1;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/UsernameLogin$1;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->usernameRegisterListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 189
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 18
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$1()Ljava/util/Map;
    .locals 1

    .prologue
    .line 33
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$2()Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    .locals 1

    .prologue
    .line 28
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    return-object v0
.end method

.method static synthetic access$3()V
    .locals 0

    .prologue
    .line 140
    invoke-static {}, Lcom/digital/cloud/usercenter/UsernameLogin;->saveUsernameInfo()V

    return-void
.end method

.method static synthetic access$4(Z)V
    .locals 0

    .prologue
    .line 26
    sput-boolean p0, Lcom/digital/cloud/usercenter/UsernameLogin;->mIsRegistering:Z

    return-void
.end method

.method public static deleteAccount(Ljava/lang/String;)V
    .locals 1
    .param p0, "username"    # Ljava/lang/String;

    .prologue
    .line 93
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 94
    invoke-static {}, Lcom/digital/cloud/usercenter/UsernameLogin;->saveUsernameInfo()V

    .line 95
    return-void
.end method

.method public static getAccountList()Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 84
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 85
    .local v0, "usernameList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    sget-object v2, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 89
    return-object v0

    .line 85
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 86
    .local v1, "v":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private static loadUsernameInfo()V
    .locals 9

    .prologue
    .line 120
    sget-object v6, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 121
    sget-object v6, Lcom/digital/cloud/usercenter/UsernameLogin;->mActivity:Landroid/app/Activity;

    sget-object v7, Lcom/digital/cloud/usercenter/UsernameLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 124
    .local v5, "userInfo":Ljava/lang/String;
    :try_start_0
    sget-object v6, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->clear()V

    .line 125
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v5}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 126
    .local v3, "root":Lorg/json/JSONArray;
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lt v1, v6, :cond_1

    .line 138
    .end local v1    # "index":I
    .end local v3    # "root":Lorg/json/JSONArray;
    :cond_0
    :goto_1
    return-void

    .line 127
    .restart local v1    # "index":I
    .restart local v3    # "root":Lorg/json/JSONArray;
    :cond_1
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 128
    .local v4, "unit":Lorg/json/JSONObject;
    new-instance v2, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    invoke-direct {v2}, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;-><init>()V

    .line 129
    .local v2, "info":Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    const-string v6, "username"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v2, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    .line 130
    const-string v6, "pwdMd5"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v2, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->pwdMd5:Ljava/lang/String;

    .line 131
    sget-object v6, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    iget-object v7, v2, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    invoke-interface {v6, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 126
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 133
    .end local v1    # "index":I
    .end local v2    # "info":Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    .end local v3    # "root":Lorg/json/JSONArray;
    .end local v4    # "unit":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 135
    const-string v6, "NDK_INFO"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "UserCenter  "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v8, Lcom/digital/cloud/usercenter/UsernameLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " LocalData Format fail."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private static saveUsernameInfo()V
    .locals 8

    .prologue
    .line 141
    sget-object v5, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v5}, Ljava/util/Map;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 142
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 143
    .local v3, "userInfoJsonArray":Lorg/json/JSONArray;
    sget-object v5, Lcom/digital/cloud/usercenter/UsernameLogin;->AccountList:Ljava/util/Map;

    invoke-interface {v5}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_1

    .line 153
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2}, Ljava/lang/String;-><init>()V

    .line 154
    .local v2, "userInfoJson":Ljava/lang/String;
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-gtz v5, :cond_2

    .line 160
    :cond_0
    :goto_1
    return-void

    .line 143
    .end local v2    # "userInfoJson":Ljava/lang/String;
    :cond_1
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    .line 144
    .local v4, "v":Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 146
    .local v1, "unit":Lorg/json/JSONObject;
    :try_start_0
    const-string v6, "username"

    iget-object v7, v4, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    invoke-virtual {v1, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 147
    const-string v6, "pwdMd5"

    iget-object v7, v4, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->pwdMd5:Ljava/lang/String;

    invoke-virtual {v1, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 148
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 149
    :catch_0
    move-exception v0

    .line 150
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 158
    .end local v0    # "e":Lorg/json/JSONException;
    .end local v1    # "unit":Lorg/json/JSONObject;
    .end local v4    # "v":Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
    .restart local v2    # "userInfoJson":Ljava/lang/String;
    :cond_2
    sget-object v5, Lcom/digital/cloud/usercenter/UsernameLogin;->mActivity:Landroid/app/Activity;

    sget-object v6, Lcom/digital/cloud/usercenter/UsernameLogin;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v5, v6, v2}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method private static userNameRegisterRequest(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p0, "username"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;

    .prologue
    .line 100
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 102
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {p1}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 103
    .local v2, "pwdMd5":Ljava/lang/String;
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UsernameLogin;->mAppId:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 104
    const-string v3, "channel_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->ChannelID:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 105
    const-string v3, "username"

    invoke-virtual {v0, v3, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 106
    const-string v3, "pwd"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 107
    const-string v3, "encrypt_mode"

    const-string v4, "md5"

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 108
    new-instance v3, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    invoke-direct {v3}, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;-><init>()V

    sput-object v3, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    .line 109
    sget-object v3, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    iput-object p0, v3, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    .line 110
    sget-object v3, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    iput-object v2, v3, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->pwdMd5:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 115
    .end local v2    # "pwdMd5":Ljava/lang/String;
    :goto_0
    sget-object v3, Lcom/digital/cloud/usercenter/UsernameLogin;->mUserCenterUsernameRegisterUrl:Ljava/lang/String;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/digital/cloud/usercenter/UsernameLogin;->usernameRegisterListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    invoke-static {v3, v4, v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 116
    return-void

    .line 111
    :catch_0
    move-exception v1

    .line 112
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static usernameRegister(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "username"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;

    .prologue
    .line 45
    sget-boolean v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mIsRegistering:Z

    if-eqz v0, :cond_0

    .line 51
    :goto_0
    return-void

    .line 49
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mIsRegistering:Z

    .line 50
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/UsernameLogin;->userNameRegisterRequest(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static usernamelogin(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p0, "username"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;

    .prologue
    .line 54
    sget-boolean v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mIslogining:Z

    if-eqz v0, :cond_0

    .line 81
    :goto_0
    return-void

    .line 58
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mIslogining:Z

    .line 59
    new-instance v0, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentLoginInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    .line 60
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentLoginInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    iput-object p0, v0, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    .line 61
    sget-object v0, Lcom/digital/cloud/usercenter/UsernameLogin;->mCurrentLoginInfo:Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;

    invoke-static {p1}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->pwdMd5:Ljava/lang/String;

    goto :goto_0
.end method


# virtual methods
.method public init(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "context"    # Landroid/app/Activity;
    .param p2, "appid"    # Ljava/lang/String;
    .param p3, "getDevidUrl"    # Ljava/lang/String;
    .param p4, "DevidLoginUrl"    # Ljava/lang/String;

    .prologue
    .line 38
    sput-object p1, Lcom/digital/cloud/usercenter/UsernameLogin;->mActivity:Landroid/app/Activity;

    .line 39
    sput-object p2, Lcom/digital/cloud/usercenter/UsernameLogin;->mAppId:Ljava/lang/String;

    .line 40
    sput-object p3, Lcom/digital/cloud/usercenter/UsernameLogin;->mUserCenterUsernameRegisterUrl:Ljava/lang/String;

    .line 41
    sput-object p4, Lcom/digital/cloud/usercenter/UsernameLogin;->mUserCenterNormalLoginUrl:Ljava/lang/String;

    .line 42
    return-void
.end method
