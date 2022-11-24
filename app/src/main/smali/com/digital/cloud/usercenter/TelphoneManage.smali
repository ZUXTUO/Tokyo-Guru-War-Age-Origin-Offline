.class public Lcom/digital/cloud/usercenter/TelphoneManage;
.super Ljava/lang/Object;
.source "TelphoneManage.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;,
        Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;
    }
.end annotation


# static fields
.field private static AccountList:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;",
            ">;"
        }
    .end annotation
.end field

.field private static MODULE_NAME:Ljava/lang/String;

.field private static mActivity:Landroid/app/Activity;

.field private static mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

.field private static mIsManageing:Z

.field private static mListener:Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

.field static phoneNumberManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 14
    sput-object v1, Lcom/digital/cloud/usercenter/TelphoneManage;->mActivity:Landroid/app/Activity;

    .line 16
    const-string v0, "TelphoneManage"

    sput-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->MODULE_NAME:Ljava/lang/String;

    .line 18
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    .line 19
    sput-object v1, Lcom/digital/cloud/usercenter/TelphoneManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    .line 20
    sput-object v1, Lcom/digital/cloud/usercenter/TelphoneManage;->mListener:Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    .line 27
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    .line 127
    new-instance v0, Lcom/digital/cloud/usercenter/TelphoneManage$1;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/TelphoneManage$1;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 151
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mListener:Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    return-object v0
.end method

.method static synthetic access$1()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$2()Ljava/util/Map;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$3()Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    return-object v0
.end method

.method static synthetic access$4()V
    .locals 0

    .prologue
    .line 174
    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->saveModuleInfo()V

    return-void
.end method

.method static synthetic access$5(Z)V
    .locals 0

    .prologue
    .line 18
    sput-boolean p0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    return-void
.end method

.method public static deleteAccount(Ljava/lang/String;)V
    .locals 1
    .param p0, "phoneNumber"    # Ljava/lang/String;

    .prologue
    .line 104
    sget-object v0, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->saveModuleInfo()V

    .line 106
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
    .line 95
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 96
    .local v0, "phoneNumberList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    sget-object v2, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 100
    return-object v0

    .line 96
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 97
    .local v1, "v":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "context"    # Landroid/app/Activity;

    .prologue
    .line 35
    sput-object p0, Lcom/digital/cloud/usercenter/TelphoneManage;->mActivity:Landroid/app/Activity;

    .line 36
    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->loadModuleInfo()V

    .line 37
    return-void
.end method

.method private static loadModuleInfo()V
    .locals 9

    .prologue
    .line 154
    sget-object v6, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 155
    sget-object v6, Lcom/digital/cloud/usercenter/TelphoneManage;->mActivity:Landroid/app/Activity;

    sget-object v7, Lcom/digital/cloud/usercenter/TelphoneManage;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 158
    .local v5, "userInfo":Ljava/lang/String;
    :try_start_0
    sget-object v6, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->clear()V

    .line 159
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v5}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 160
    .local v3, "root":Lorg/json/JSONArray;
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lt v1, v6, :cond_1

    .line 172
    .end local v1    # "index":I
    .end local v3    # "root":Lorg/json/JSONArray;
    :cond_0
    :goto_1
    return-void

    .line 161
    .restart local v1    # "index":I
    .restart local v3    # "root":Lorg/json/JSONArray;
    :cond_1
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 162
    .local v4, "unit":Lorg/json/JSONObject;
    new-instance v2, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    invoke-direct {v2}, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;-><init>()V

    .line 163
    .local v2, "info":Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;
    const-string v6, "phoneNumber"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v2, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;

    .line 165
    sget-object v6, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    iget-object v7, v2, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;

    invoke-interface {v6, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 160
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 167
    .end local v1    # "index":I
    .end local v2    # "info":Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;
    .end local v3    # "root":Lorg/json/JSONArray;
    .end local v4    # "unit":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 169
    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "NDK_INFO"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "UserCenter  "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v8, Lcom/digital/cloud/usercenter/TelphoneManage;->MODULE_NAME:Ljava/lang/String;

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

.method public static phoneNumberBind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 5
    .param p0, "phoneNumber"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "vcode"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 42
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 44
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {p1}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 45
    .local v2, "pwdMd5":Ljava/lang/String;
    const-string v3, "openid"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    const-string v3, "access_token"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 47
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 48
    const-string v3, "telphone"

    invoke-virtual {v0, v3, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 49
    const-string v3, "login_pwd"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 50
    const-string v3, "vcode"

    invoke-virtual {v0, v3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    .end local v2    # "pwdMd5":Ljava/lang/String;
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterTelphoneBindUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, p3}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 58
    return-void

    .line 52
    :catch_0
    move-exception v1

    .line 53
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method private static phoneNumberManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "phoneNumber"    # Ljava/lang/String;
    .param p2, "pwd"    # Ljava/lang/String;
    .param p3, "vcode"    # Ljava/lang/String;

    .prologue
    .line 110
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 112
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {p2}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 113
    .local v2, "pwdMd5":Ljava/lang/String;
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 114
    const-string v3, "telphone"

    invoke-virtual {v0, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 115
    const-string v3, "pwd"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 116
    const-string v3, "vcode"

    invoke-virtual {v0, v3, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 117
    new-instance v3, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    invoke-direct {v3}, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;-><init>()V

    sput-object v3, Lcom/digital/cloud/usercenter/TelphoneManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    .line 118
    sget-object v3, Lcom/digital/cloud/usercenter/TelphoneManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    iput-object p1, v3, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 124
    .end local v2    # "pwdMd5":Ljava/lang/String;
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    invoke-static {p0, v3, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 125
    return-void

    .line 120
    :catch_0
    move-exception v1

    .line 121
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static phoneNumberPwdReset(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;)V
    .locals 2
    .param p0, "phoneNumber"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "vcode"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    .prologue
    .line 72
    sget-boolean v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    if-eqz v0, :cond_0

    .line 74
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "phoneNumberPwdReset ing."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    :goto_0
    return-void

    .line 77
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    .line 78
    sput-object p3, Lcom/digital/cloud/usercenter/TelphoneManage;->mListener:Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    .line 79
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterTelphonePwdResetisterUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0, p1, p2}, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static phoneNumberRegister(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;)V
    .locals 2
    .param p0, "phoneNumber"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "vcode"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    .prologue
    .line 61
    sget-boolean v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    if-eqz v0, :cond_0

    .line 63
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "phoneNumberRegister ing."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 69
    :goto_0
    return-void

    .line 66
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/TelphoneManage;->mIsManageing:Z

    .line 67
    sput-object p3, Lcom/digital/cloud/usercenter/TelphoneManage;->mListener:Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;

    .line 68
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterTelphoneRegisterUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0, p1, p2}, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static requestTelphoneVcode(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 4
    .param p0, "telphone"    # Ljava/lang/String;
    .param p1, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 83
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 85
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "telphone"

    invoke-virtual {v0, v2, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterTelphoneVcodeUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, p1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 92
    return-void

    .line 86
    :catch_0
    move-exception v1

    .line 87
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method private static saveModuleInfo()V
    .locals 7

    .prologue
    .line 175
    sget-object v4, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v4}, Ljava/util/Map;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 176
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 177
    .local v2, "userInfoJsonArray":Lorg/json/JSONArray;
    sget-object v4, Lcom/digital/cloud/usercenter/TelphoneManage;->AccountList:Ljava/util/Map;

    invoke-interface {v4}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 187
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 188
    sget-object v4, Lcom/digital/cloud/usercenter/TelphoneManage;->mActivity:Landroid/app/Activity;

    sget-object v5, Lcom/digital/cloud/usercenter/TelphoneManage;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v2}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v5, v6}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 191
    :cond_0
    return-void

    .line 177
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    .line 178
    .local v3, "v":Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 180
    .local v1, "unit":Lorg/json/JSONObject;
    :try_start_0
    const-string v5, "phoneNumber"

    iget-object v6, v3, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;

    invoke-virtual {v1, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 182
    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 183
    :catch_0
    move-exception v0

    .line 184
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
