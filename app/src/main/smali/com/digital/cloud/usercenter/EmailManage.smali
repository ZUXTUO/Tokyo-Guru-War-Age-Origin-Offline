.class public Lcom/digital/cloud/usercenter/EmailManage;
.super Ljava/lang/Object;
.source "EmailManage.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;,
        Lcom/digital/cloud/usercenter/EmailManage$registerListener;
    }
.end annotation


# static fields
.field private static AccountList:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;",
            ">;"
        }
    .end annotation
.end field

.field public static MODULE_NAME:Ljava/lang/String;

.field static emailManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

.field private static mActivity:Landroid/app/Activity;

.field private static mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

.field private static mIsManageing:Z

.field private static mListener:Lcom/digital/cloud/usercenter/EmailManage$registerListener;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 14
    sput-object v1, Lcom/digital/cloud/usercenter/EmailManage;->mActivity:Landroid/app/Activity;

    .line 16
    const-string v0, "EmailManage"

    sput-object v0, Lcom/digital/cloud/usercenter/EmailManage;->MODULE_NAME:Ljava/lang/String;

    .line 18
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    .line 19
    sput-object v1, Lcom/digital/cloud/usercenter/EmailManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    .line 20
    sput-object v1, Lcom/digital/cloud/usercenter/EmailManage;->mListener:Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    .line 27
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    .line 110
    new-instance v0, Lcom/digital/cloud/usercenter/EmailManage$1;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/EmailManage$1;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/EmailManage;->emailManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 134
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static EmailPwdReset(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/EmailManage$registerListener;)V
    .locals 1
    .param p0, "email"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    .prologue
    .line 50
    sget-boolean v0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    if-eqz v0, :cond_0

    .line 57
    :goto_0
    return-void

    .line 54
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    .line 55
    sput-object p2, Lcom/digital/cloud/usercenter/EmailManage;->mListener:Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    .line 56
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterEmailResetUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0, p1}, Lcom/digital/cloud/usercenter/EmailManage;->emailManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static EmailRegister(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/EmailManage$registerListener;)V
    .locals 1
    .param p0, "email"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    .prologue
    .line 40
    sget-boolean v0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    if-eqz v0, :cond_0

    .line 47
    :goto_0
    return-void

    .line 44
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    .line 45
    sput-object p2, Lcom/digital/cloud/usercenter/EmailManage;->mListener:Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    .line 46
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterEmailRegisterUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0, p1}, Lcom/digital/cloud/usercenter/EmailManage;->emailManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method static synthetic access$0()Lcom/digital/cloud/usercenter/EmailManage$registerListener;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/digital/cloud/usercenter/EmailManage;->mListener:Lcom/digital/cloud/usercenter/EmailManage$registerListener;

    return-object v0
.end method

.method static synthetic access$1()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lcom/digital/cloud/usercenter/EmailManage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$2()Ljava/util/Map;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$3()Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lcom/digital/cloud/usercenter/EmailManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    return-object v0
.end method

.method static synthetic access$4()V
    .locals 0

    .prologue
    .line 157
    invoke-static {}, Lcom/digital/cloud/usercenter/EmailManage;->saveModuleInfo()V

    return-void
.end method

.method static synthetic access$5(Z)V
    .locals 0

    .prologue
    .line 18
    sput-boolean p0, Lcom/digital/cloud/usercenter/EmailManage;->mIsManageing:Z

    return-void
.end method

.method public static deleteAccount(Ljava/lang/String;)V
    .locals 1
    .param p0, "email"    # Ljava/lang/String;

    .prologue
    .line 88
    sget-object v0, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    invoke-static {}, Lcom/digital/cloud/usercenter/EmailManage;->saveModuleInfo()V

    .line 90
    return-void
.end method

.method public static emailBind(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 5
    .param p0, "email"    # Ljava/lang/String;
    .param p1, "pwd"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 61
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 63
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {p1}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 64
    .local v2, "pwdMd5":Ljava/lang/String;
    const-string v3, "openid"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/UserInfo;->openid:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 65
    const-string v3, "access_token"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/UserInfo;->token:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 66
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 67
    const-string v3, "email"

    invoke-virtual {v0, v3, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 68
    const-string v3, "login_pwd"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 74
    .end local v2    # "pwdMd5":Ljava/lang/String;
    :goto_0
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenterEmailBindUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, p2}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 76
    return-void

    .line 70
    :catch_0
    move-exception v1

    .line 71
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method private static emailManageRequest(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "email"    # Ljava/lang/String;
    .param p2, "pwd"    # Ljava/lang/String;

    .prologue
    .line 94
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 96
    .local v0, "body":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {p2}, Lcom/digital/cloud/usercenter/Md5;->stringToMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 97
    .local v2, "pwdMd5":Ljava/lang/String;
    const-string v3, "app_id"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 98
    const-string v3, "email"

    invoke-virtual {v0, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 99
    const-string v3, "pwd"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 100
    new-instance v3, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    invoke-direct {v3}, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;-><init>()V

    sput-object v3, Lcom/digital/cloud/usercenter/EmailManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    .line 101
    sget-object v3, Lcom/digital/cloud/usercenter/EmailManage;->mCurrentRegisterInfo:Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    iput-object p1, v3, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;->email:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 107
    .end local v2    # "pwdMd5":Ljava/lang/String;
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/EmailManage;->emailManageListener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    invoke-static {p0, v3, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->createUserCenterHttpRequest(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 108
    return-void

    .line 103
    :catch_0
    move-exception v1

    .line 104
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
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
    .line 79
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 80
    .local v0, "emailList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    sget-object v2, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 84
    return-object v0

    .line 80
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 81
    .local v1, "v":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "context"    # Landroid/app/Activity;

    .prologue
    .line 35
    sput-object p0, Lcom/digital/cloud/usercenter/EmailManage;->mActivity:Landroid/app/Activity;

    .line 36
    invoke-static {}, Lcom/digital/cloud/usercenter/EmailManage;->loadModuleInfo()V

    .line 37
    return-void
.end method

.method private static loadModuleInfo()V
    .locals 9

    .prologue
    .line 137
    sget-object v6, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 138
    sget-object v6, Lcom/digital/cloud/usercenter/EmailManage;->mActivity:Landroid/app/Activity;

    sget-object v7, Lcom/digital/cloud/usercenter/EmailManage;->MODULE_NAME:Ljava/lang/String;

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/LocalData;->loadLocalData(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 141
    .local v5, "userInfo":Ljava/lang/String;
    :try_start_0
    sget-object v6, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->clear()V

    .line 142
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v5}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 143
    .local v3, "root":Lorg/json/JSONArray;
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lt v1, v6, :cond_1

    .line 155
    .end local v1    # "index":I
    .end local v3    # "root":Lorg/json/JSONArray;
    :cond_0
    :goto_1
    return-void

    .line 144
    .restart local v1    # "index":I
    .restart local v3    # "root":Lorg/json/JSONArray;
    :cond_1
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 145
    .local v4, "unit":Lorg/json/JSONObject;
    new-instance v2, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    invoke-direct {v2}, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;-><init>()V

    .line 146
    .local v2, "info":Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;
    const-string v6, "email"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v2, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;->email:Ljava/lang/String;

    .line 148
    sget-object v6, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    iget-object v7, v2, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;->email:Ljava/lang/String;

    invoke-interface {v6, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 143
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 150
    .end local v1    # "index":I
    .end local v2    # "info":Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;
    .end local v3    # "root":Lorg/json/JSONArray;
    .end local v4    # "unit":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 152
    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "NDK_INFO"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "UserCenter  "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v8, Lcom/digital/cloud/usercenter/EmailManage;->MODULE_NAME:Ljava/lang/String;

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

.method private static saveModuleInfo()V
    .locals 7

    .prologue
    .line 158
    sget-object v4, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v4}, Ljava/util/Map;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 159
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 160
    .local v2, "userInfoJsonArray":Lorg/json/JSONArray;
    sget-object v4, Lcom/digital/cloud/usercenter/EmailManage;->AccountList:Ljava/util/Map;

    invoke-interface {v4}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 170
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 171
    sget-object v4, Lcom/digital/cloud/usercenter/EmailManage;->mActivity:Landroid/app/Activity;

    sget-object v5, Lcom/digital/cloud/usercenter/EmailManage;->MODULE_NAME:Ljava/lang/String;

    invoke-virtual {v2}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v5, v6}, Lcom/digital/cloud/usercenter/LocalData;->saveLocalData(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 174
    :cond_0
    return-void

    .line 160
    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;

    .line 161
    .local v3, "v":Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 163
    .local v1, "unit":Lorg/json/JSONObject;
    :try_start_0
    const-string v5, "email"

    iget-object v6, v3, Lcom/digital/cloud/usercenter/EmailManage$AccountInfo;->email:Ljava/lang/String;

    invoke-virtual {v1, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 165
    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 166
    :catch_0
    move-exception v0

    .line 167
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
