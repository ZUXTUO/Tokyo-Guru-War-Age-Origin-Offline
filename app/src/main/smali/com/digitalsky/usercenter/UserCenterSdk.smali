.class public Lcom/digitalsky/usercenter/UserCenterSdk;
.super Ljava/lang/Object;
.source "UserCenterSdk.java"


# static fields
.field static _instance:Lcom/digitalsky/usercenter/UserCenterSdk;

.field private static mActivity:Landroid/app/Activity;


# instance fields
.field private APP_ID:Ljava/lang/String;

.field private APP_KEY:Ljava/lang/String;

.field private CONFIG_NAME:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->_instance:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 26
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const-string v0, "freesdk.config"

    iput-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->CONFIG_NAME:Ljava/lang/String;

    .line 27
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_ID:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_KEY:Ljava/lang/String;

    .line 32
    new-instance v0, Lcom/digitalsky/sdk/user/UserListener$DefaultUserCallback;

    invoke-direct {v0}, Lcom/digitalsky/sdk/user/UserListener$DefaultUserCallback;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .line 20
    return-void
.end method

.method static synthetic access$0(Lcom/digitalsky/usercenter/UserCenterSdk;)Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;
    .locals 1

    .prologue
    .line 32
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digitalsky/usercenter/UserCenterSdk;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;
    .locals 1

    .prologue
    .line 40
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->_instance:Lcom/digitalsky/usercenter/UserCenterSdk;

    if-nez v0, :cond_0

    .line 41
    new-instance v0, Lcom/digitalsky/usercenter/UserCenterSdk;

    invoke-direct {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;-><init>()V

    sput-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->_instance:Lcom/digitalsky/usercenter/UserCenterSdk;

    .line 42
    :cond_0
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->_instance:Lcom/digitalsky/usercenter/UserCenterSdk;

    return-object v0
.end method

.method private loadconfig(Landroid/app/Activity;)V
    .locals 5
    .param p1, "context"    # Landroid/app/Activity;

    .prologue
    .line 46
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 48
    .local v0, "config":Ljava/util/Properties;
    :try_start_0
    invoke-virtual {p1}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    iget-object v3, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->CONFIG_NAME:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 49
    const-string v2, "APP_ID"

    invoke-virtual {v0, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_ID:Ljava/lang/String;

    .line 50
    const-string v2, "APP_KEY"

    invoke-virtual {v0, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_KEY:Ljava/lang/String;

    .line 51
    iget-object v2, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "APP_ID:\u3000"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_ID:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " --- APP_KEY: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_KEY:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 58
    :goto_0
    return-void

    .line 52
    :catch_0
    move-exception v1

    .line 54
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 55
    .end local v1    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v1

    .line 56
    .local v1, "e":Ljava/lang/NumberFormatException;
    invoke-virtual {v1}, Ljava/lang/NumberFormatException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public add_info(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "k"    # Ljava/lang/String;
    .param p2, "v"    # Ljava/lang/String;

    .prologue
    .line 197
    invoke-static {p1, p2}, Lcom/digital/cloud/usercenter/UserCenterActivity;->add_info(Ljava/lang/String;Ljava/lang/String;)V

    .line 198
    const/4 v0, 0x1

    return v0
.end method

.method public enterPlatform(I)V
    .locals 2
    .param p1, "index"    # I

    .prologue
    .line 186
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    new-instance v1, Lcom/digitalsky/usercenter/UserCenterSdk$5;

    invoke-direct {v1, p0, p1}, Lcom/digitalsky/usercenter/UserCenterSdk$5;-><init>(Lcom/digitalsky/usercenter/UserCenterSdk;I)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 194
    return-void
.end method

.method public hideToolBar()Z
    .locals 2

    .prologue
    .line 161
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    new-instance v1, Lcom/digitalsky/usercenter/UserCenterSdk$4;

    invoke-direct {v1, p0}, Lcom/digitalsky/usercenter/UserCenterSdk$4;-><init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 172
    const/4 v0, 0x1

    return v0
.end method

.method public init(Landroid/app/Activity;)V
    .locals 4
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 61
    sput-object p1, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    .line 62
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    invoke-direct {p0, v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->loadconfig(Landroid/app/Activity;)V

    .line 63
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    iget-object v1, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_ID:Ljava/lang/String;

    iget-object v2, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->APP_KEY:Ljava/lang/String;

    const-string v3, ""

    invoke-static {v0, v1, v2, v3}, Lcom/digital/cloud/usercenter/UserCenterActivity;->init(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 64
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setClause(Z)V

    .line 65
    return-void
.end method

.method public login()Z
    .locals 2

    .prologue
    .line 69
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    const-string v1, "login"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    new-instance v0, Lcom/digitalsky/usercenter/UserCenterSdk$1;

    invoke-direct {v0, p0}, Lcom/digitalsky/usercenter/UserCenterSdk$1;-><init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V

    .line 103
    new-instance v1, Lcom/digitalsky/usercenter/UserCenterSdk$2;

    invoke-direct {v1, p0}, Lcom/digitalsky/usercenter/UserCenterSdk$2;-><init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V

    .line 70
    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->login(Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterResultListener;Lcom/digital/cloud/usercenter/UserCenterActivity$UserCenterLogout;)Z

    .line 111
    const/4 v0, 0x1

    return v0
.end method

.method public logout()Z
    .locals 2

    .prologue
    .line 116
    iget-object v0, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    const-string v1, "logout"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 117
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->logout()Z

    .line 118
    const/4 v0, 0x1

    return v0
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 181
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->onHideToolebar()V

    .line 183
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 176
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->onShowToolebar()V

    .line 178
    return-void
.end method

.method public setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V
    .locals 0
    .param p1, "listener"    # Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .prologue
    .line 36
    iput-object p1, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->mUserCallback:Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .line 37
    return-void
.end method

.method public showToolBar()Z
    .locals 2

    .prologue
    .line 146
    sget-object v0, Lcom/digitalsky/usercenter/UserCenterSdk;->mActivity:Landroid/app/Activity;

    new-instance v1, Lcom/digitalsky/usercenter/UserCenterSdk$3;

    invoke-direct {v1, p0}, Lcom/digitalsky/usercenter/UserCenterSdk$3;-><init>(Lcom/digitalsky/usercenter/UserCenterSdk;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 157
    const/4 v0, 0x1

    return v0
.end method

.method public submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z
    .locals 8
    .param p1, "data"    # Lcom/digitalsky/sdk/user/SubmitData;

    .prologue
    .line 122
    iget-object v5, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "submitInfo: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 124
    :try_start_0
    sget-object v5, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ADD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    invoke-virtual {v5}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->value()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p1, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 125
    iget-object v3, p1, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;

    .line 126
    .local v3, "obj":Lorg/json/JSONObject;
    if-eqz v3, :cond_0

    .line 127
    invoke-virtual {v3}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    .line 128
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 142
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    .end local v3    # "obj":Lorg/json/JSONObject;
    :cond_0
    :goto_1
    const/4 v5, 0x1

    return v5

    .line 129
    .restart local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    .restart local v3    # "obj":Lorg/json/JSONObject;
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 130
    .local v2, "key":Ljava/lang/String;
    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 131
    .local v4, "value":Ljava/lang/String;
    iget-object v5, p0, Lcom/digitalsky/usercenter/UserCenterSdk;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, " -- "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 132
    invoke-static {v2, v4}, Lcom/digital/cloud/usercenter/UserCenterActivity;->add_info(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 137
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "obj":Lorg/json/JSONObject;
    .end local v4    # "value":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 139
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method
