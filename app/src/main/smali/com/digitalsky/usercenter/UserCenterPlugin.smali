.class public Lcom/digitalsky/usercenter/UserCenterPlugin;
.super Ljava/lang/Object;
.source "UserCenterPlugin.java"

# interfaces
.implements Lcom/digitalsky/sdk/user/IUser;
.implements Lcom/digitalsky/sdk/IActivity;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public add_info(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "k"    # Ljava/lang/String;
    .param p2, "v"    # Ljava/lang/String;

    .prologue
    .line 140
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/digitalsky/usercenter/UserCenterSdk;->add_info(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public enterPlatform(I)Z
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 121
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/usercenter/UserCenterSdk;->enterPlatform(I)V

    .line 122
    const/4 v0, 0x1

    return v0
.end method

.method public exit()Z
    .locals 1

    .prologue
    .line 98
    const/4 v0, 0x0

    return v0
.end method

.method public hideToolBar()Z
    .locals 1

    .prologue
    .line 134
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->hideToolBar()Z

    move-result v0

    return v0
.end method

.method public login(Ljava/lang/String;)Z
    .locals 1
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    .line 80
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->login()Z

    move-result v0

    return v0
.end method

.method public loginCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V
    .locals 0
    .param p1, "res"    # Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    .prologue
    .line 111
    return-void
.end method

.method public logout()Z
    .locals 1

    .prologue
    .line 86
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->logout()Z

    move-result v0

    return v0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 63
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 69
    return-void
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 20
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/usercenter/UserCenterSdk;->init(Landroid/app/Activity;)V

    .line 21
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .prologue
    .line 57
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 75
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 43
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->onPause()V

    .line 45
    return-void
.end method

.method public onRestart()V
    .locals 0

    .prologue
    .line 27
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 38
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->onResume()V

    .line 39
    return-void
.end method

.method public onStart()V
    .locals 0

    .prologue
    .line 33
    return-void
.end method

.method public onStop()V
    .locals 0

    .prologue
    .line 51
    return-void
.end method

.method public setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V
    .locals 1
    .param p1, "listener"    # Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;

    .prologue
    .line 104
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/usercenter/UserCenterSdk;->setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V

    .line 105
    return-void
.end method

.method public showToolBar()Z
    .locals 1

    .prologue
    .line 128
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0}, Lcom/digitalsky/usercenter/UserCenterSdk;->showToolBar()Z

    move-result v0

    return v0
.end method

.method public submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z
    .locals 1
    .param p1, "info"    # Lcom/digitalsky/sdk/user/SubmitData;

    .prologue
    .line 92
    invoke-static {}, Lcom/digitalsky/usercenter/UserCenterSdk;->getInstance()Lcom/digitalsky/usercenter/UserCenterSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/usercenter/UserCenterSdk;->submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z

    move-result v0

    return v0
.end method

.method public switchAccount()Z
    .locals 1

    .prologue
    .line 116
    const/4 v0, 0x0

    return v0
.end method
