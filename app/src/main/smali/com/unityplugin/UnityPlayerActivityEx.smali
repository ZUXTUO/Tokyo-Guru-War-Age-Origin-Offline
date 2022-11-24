.class public Lcom/unityplugin/UnityPlayerActivityEx;
.super Lcom/unity3d/player/UnityPlayerActivity;
.source "UnityPlayerActivityEx.java"

# interfaces
.implements Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;


# static fields
.field public static mContext:Landroid/content/Context;

.field public static mTag:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 32
    const/4 v0, 0x0

    sput-object v0, Lcom/unityplugin/UnityPlayerActivityEx;->mContext:Landroid/content/Context;

    .line 33
    const-class v0, Lcom/unityplugin/UnityPlayerActivityEx;

    invoke-virtual {v0}, Ljava/lang/Class;->getPackage()Ljava/lang/Package;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Package;->getName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/unityplugin/UnityPlayerActivityEx;->mTag:Ljava/lang/String;

    .line 195
    const-string v0, "game"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 196
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/unity3d/player/UnityPlayerActivity;-><init>()V

    return-void
.end method

.method private native init_apk_reader(Landroid/content/res/AssetManager;)I
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 166
    invoke-super {p0, p1, p2, p3}, Lcom/unity3d/player/UnityPlayerActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 167
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/digitalsky/sdk/FreeSdk;->onActivityResult(IILandroid/content/Intent;)V

    .line 168
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 173
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 174
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/sdk/FreeSdk;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 175
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 8
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v7, 0x2

    .line 39
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerActivity;->onCreate(Landroid/os/Bundle;)V

    .line 41
    sput-object p0, Lcom/unityplugin/UnityPlayerActivityEx;->mContext:Landroid/content/Context;

    .line 44
    sget-object v4, Lcom/unityplugin/UnityPlayerActivityEx;->mTag:Ljava/lang/String;

    const-string v5, "[UnityPlayerActivityEx onCreate] called!"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 46
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/unityplugin/UnityPlayerActivityEx;->init_apk_reader(Landroid/content/res/AssetManager;)I

    .line 48
    const/4 v3, 0x0

    .line 49
    .local v3, "info":Landroid/content/pm/ActivityInfo;
    const-string v0, ""

    .line 50
    .local v0, "appId":Ljava/lang/String;
    const-string v1, ""

    .line 52
    .local v1, "appSecret":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx;->getComponentName()Landroid/content/ComponentName;

    move-result-object v5

    const/16 v6, 0x80

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 58
    :goto_0
    if-eqz v3, :cond_1

    .line 59
    iget-object v4, v3, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    const-string v5, "appId"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 60
    iget-object v4, v3, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    const-string v5, "appSecret"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 62
    const-string v4, "m_"

    invoke-virtual {v0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_0

    .line 63
    invoke-virtual {v0, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 66
    :cond_0
    const-string v4, "m_"

    invoke-virtual {v1, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_1

    .line 67
    invoke-virtual {v1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 70
    :cond_1
    sget-object v4, Lcom/unityplugin/UnityPlayerActivityEx;->mTag:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "[UnityPlayerActivityEx onCreate] appId: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " appSecret: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v4

    invoke-virtual {v4, p0}, Lcom/digitalsky/sdk/FreeSdk;->onCreate(Landroid/app/Activity;)V

    .line 74
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v4

    new-instance v5, Lcom/unityplugin/UnityPlayerActivityEx$1;

    invoke-direct {v5, p0}, Lcom/unityplugin/UnityPlayerActivityEx$1;-><init>(Lcom/unityplugin/UnityPlayerActivityEx;)V

    invoke-virtual {v4, v5}, Lcom/digitalsky/sdk/user/FreeSdkUser;->setIUserListener(Lcom/digitalsky/sdk/common/Listener$ILoginCallback;)V

    .line 91
    invoke-static {}, Lcom/digitalsky/sdk/pay/FreeSdkPay;->getInstance()Lcom/digitalsky/sdk/pay/FreeSdkPay;

    move-result-object v4

    new-instance v5, Lcom/unityplugin/UnityPlayerActivityEx$2;

    invoke-direct {v5, p0}, Lcom/unityplugin/UnityPlayerActivityEx$2;-><init>(Lcom/unityplugin/UnityPlayerActivityEx;)V

    invoke-virtual {v4, v5}, Lcom/digitalsky/sdk/pay/FreeSdkPay;->setIPayListener(Lcom/digitalsky/sdk/common/Listener$ISdkCallback;)V

    .line 103
    invoke-static {p0, p0, p1}, Lcom/digital/weibo/WeiboSdk;->init(Landroid/app/Activity;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;Landroid/os/Bundle;)V

    .line 104
    invoke-static {p0}, Lcom/digital/wechat/WechatSdk;->init(Landroid/app/Activity;)V

    .line 105
    return-void

    .line 53
    :catch_0
    move-exception v2

    .line 55
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v2}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    .line 150
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onDestroy()V

    .line 151
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onDestroy()V

    .line 153
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "arg0"    # I
    .param p2, "arg1"    # Landroid/view/KeyEvent;

    .prologue
    .line 158
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/digitalsky/sdk/FreeSdk;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 159
    const/4 v0, 0x1

    .line 160
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1, p2}, Lcom/unity3d/player/UnityPlayerActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 180
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerActivity;->onNewIntent(Landroid/content/Intent;)V

    .line 181
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/sdk/FreeSdk;->onNewIntent(Landroid/content/Intent;)V

    .line 182
    invoke-static {p1, p0}, Lcom/digital/weibo/WeiboSdk;->onNewIntent(Landroid/content/Intent;Lcom/sina/weibo/sdk/api/share/IWeiboHandler$Response;)V

    .line 183
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 132
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onPause()V

    .line 134
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onPause()V

    .line 136
    sget-object v0, Lcom/unityplugin/UnityPlayerActivityEx;->mTag:Ljava/lang/String;

    const-string v1, "[UnityPlayerActivityEx onPause] called!"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 138
    return-void
.end method

.method public onResponse(Lcom/sina/weibo/sdk/api/share/BaseResponse;)V
    .locals 0
    .param p1, "arg0"    # Lcom/sina/weibo/sdk/api/share/BaseResponse;

    .prologue
    .line 188
    invoke-static {p1}, Lcom/digital/weibo/WeiboSdk;->onResponse(Lcom/sina/weibo/sdk/api/share/BaseResponse;)V

    .line 189
    return-void
.end method

.method protected onRestart()V
    .locals 1

    .prologue
    .line 110
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onRestart()V

    .line 111
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onRestart()V

    .line 112
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 123
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onResume()V

    .line 124
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onResume()V

    .line 126
    sget-object v0, Lcom/unityplugin/UnityPlayerActivityEx;->mTag:Ljava/lang/String;

    const-string v1, "[UnityPlayerActivityEx onResume] called!"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 128
    return-void
.end method

.method protected onStart()V
    .locals 1

    .prologue
    .line 117
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onStart()V

    .line 118
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onStart()V

    .line 119
    return-void
.end method

.method protected onStop()V
    .locals 1

    .prologue
    .line 143
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerActivity;->onStop()V

    .line 144
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdk;->onStop()V

    .line 145
    return-void
.end method
