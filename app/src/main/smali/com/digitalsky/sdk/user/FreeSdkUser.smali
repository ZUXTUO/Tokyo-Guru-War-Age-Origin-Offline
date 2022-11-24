.class public Lcom/digitalsky/sdk/user/FreeSdkUser;
.super Ljava/lang/Object;
.source "FreeSdkUser.java"


# static fields
.field public static TAG:Ljava/lang/String;

.field private static instance:Lcom/digitalsky/sdk/user/FreeSdkUser;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 16
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/FreeSdkUser;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    .line 17
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->instance:Lcom/digitalsky/sdk/user/FreeSdkUser;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static add_info(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "k"    # Ljava/lang/String;
    .param p1, "v"    # Ljava/lang/String;

    .prologue
    .line 129
    const-string v0, ""

    invoke-static {v0, p0, p1}, Lcom/digitalsky/sdk/user/FreeSdkUser;->add_info(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static add_info(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "k"    # Ljava/lang/String;
    .param p2, "v"    # Ljava/lang/String;

    .prologue
    .line 133
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0, p1, p2}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_add_info(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static enterPlatform(I)Z
    .locals 1
    .param p0, "index"    # I

    .prologue
    .line 168
    const-string v0, ""

    invoke-static {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->enterPlatform(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public static enterPlatform(Ljava/lang/String;I)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "index"    # I

    .prologue
    .line 172
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_enterPlatform(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public static exit()Z
    .locals 1

    .prologue
    .line 186
    const-string v0, ""

    invoke-static {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->exit(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static exit(Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;

    .prologue
    .line 190
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_exit(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->instance:Lcom/digitalsky/sdk/user/FreeSdkUser;

    if-nez v0, :cond_0

    .line 21
    new-instance v0, Lcom/digitalsky/sdk/user/FreeSdkUser;

    invoke-direct {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->instance:Lcom/digitalsky/sdk/user/FreeSdkUser;

    .line 23
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/user/FreeSdkUser;->instance:Lcom/digitalsky/sdk/user/FreeSdkUser;

    return-object v0
.end method

.method public static hideToolBar()Z
    .locals 1

    .prologue
    .line 222
    const-string v0, ""

    invoke-static {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->hideToolBar(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static hideToolBar(Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;

    .prologue
    .line 226
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_hideToolBar(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static login(Ljava/lang/String;)Z
    .locals 1
    .param p0, "type"    # Ljava/lang/String;

    .prologue
    .line 64
    const-string v0, ""

    invoke-static {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->login(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static login(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    .line 68
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_login(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static logout()Z
    .locals 1

    .prologue
    .line 87
    const-string v0, ""

    invoke-static {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->logout(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static logout(Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;

    .prologue
    .line 91
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_logout(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static openKefu()Z
    .locals 1

    .prologue
    .line 240
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->openKeFuWebPage()V

    .line 241
    const/4 v0, 0x1

    return v0
.end method

.method public static showToolBar()Z
    .locals 1

    .prologue
    .line 204
    const-string v0, ""

    invoke-static {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->showToolBar(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static showToolBar(Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;

    .prologue
    .line 208
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_showToolBar(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static submitInfo(Ljava/lang/String;)Z
    .locals 1
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 105
    const-string v0, ""

    invoke-static {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->submitInfo(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static submitInfo(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 109
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    new-instance v1, Lcom/digitalsky/sdk/user/SubmitData;

    invoke-direct {v1, p1}, Lcom/digitalsky/sdk/user/SubmitData;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0, v1}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_submitInfo(Ljava/lang/String;Lcom/digitalsky/sdk/user/SubmitData;)Z

    move-result v0

    return v0
.end method

.method public static switchAccount()Z
    .locals 1

    .prologue
    .line 150
    const-string v0, ""

    invoke-static {v0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->switchAccount(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static switchAccount(Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;

    .prologue
    .line 154
    invoke-static {}, Lcom/digitalsky/sdk/user/FreeSdkUser;->getInstance()Lcom/digitalsky/sdk/user/FreeSdkUser;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/user/FreeSdkUser;->_switchAccount(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method public _add_info(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "k"    # Ljava/lang/String;
    .param p3, "v"    # Ljava/lang/String;

    .prologue
    .line 138
    invoke-static {p2, p3}, Lcom/digitalsky/sdk/kefu/KeFuPage;->addUrlParam(Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 140
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 141
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 142
    invoke-interface {v0, p2, p3}, Lcom/digitalsky/sdk/user/IUser;->add_info(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    .line 146
    :goto_0
    return v1

    .line 144
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 146
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _enterPlatform(Ljava/lang/String;I)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "index"    # I

    .prologue
    .line 176
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 177
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 178
    invoke-interface {v0, p2}, Lcom/digitalsky/sdk/user/IUser;->enterPlatform(I)Z

    move-result v1

    .line 182
    :goto_0
    return v1

    .line 180
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 182
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _exit(Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 194
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 195
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 196
    invoke-interface {v0}, Lcom/digitalsky/sdk/user/IUser;->exit()Z

    move-result v1

    .line 200
    :goto_0
    return v1

    .line 198
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 200
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _hideToolBar(Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 230
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 231
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 232
    invoke-interface {v0}, Lcom/digitalsky/sdk/user/IUser;->hideToolBar()Z

    move-result v1

    .line 236
    :goto_0
    return v1

    .line 234
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 236
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _login(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "type"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 72
    sget-boolean v2, Lcom/digitalsky/sdk/common/Constant;->SDK_INIT:Z

    if-nez v2, :cond_0

    .line 73
    sget-object v2, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "call DsSdk init first:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    :goto_0
    return v1

    .line 77
    :cond_0
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 78
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_1

    .line 79
    invoke-interface {v0, p2}, Lcom/digitalsky/sdk/user/IUser;->login(Ljava/lang/String;)Z

    move-result v1

    goto :goto_0

    .line 81
    :cond_1
    sget-object v2, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "IUser not found:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public _logout(Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 95
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 96
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 97
    invoke-interface {v0}, Lcom/digitalsky/sdk/user/IUser;->logout()Z

    move-result v1

    .line 101
    :goto_0
    return v1

    .line 99
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 101
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _showToolBar(Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 212
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 213
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 214
    invoke-interface {v0}, Lcom/digitalsky/sdk/user/IUser;->showToolBar()Z

    move-result v1

    .line 218
    :goto_0
    return v1

    .line 216
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 218
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _submitInfo(Ljava/lang/String;Lcom/digitalsky/sdk/user/SubmitData;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "data"    # Lcom/digitalsky/sdk/user/SubmitData;

    .prologue
    .line 114
    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ADD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    invoke-virtual {v1}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->value()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p2, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 115
    iget-object v1, p2, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;

    invoke-static {v1}, Lcom/digitalsky/sdk/kefu/KeFuPage;->submitInfo(Lorg/json/JSONObject;)Z

    .line 118
    :cond_0
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 119
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_1

    .line 120
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 121
    invoke-interface {v0, p2}, Lcom/digitalsky/sdk/user/IUser;->submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z

    move-result v1

    .line 125
    :goto_0
    return v1

    .line 123
    :cond_1
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 125
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public _switchAccount(Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 158
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;

    move-result-object v0

    .line 159
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz v0, :cond_0

    .line 160
    invoke-interface {v0}, Lcom/digitalsky/sdk/user/IUser;->switchAccount()Z

    move-result v1

    .line 164
    :goto_0
    return v1

    .line 162
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/user/FreeSdkUser;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IUser not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setIUserListener(Lcom/digitalsky/sdk/common/Listener$ILoginCallback;)V
    .locals 4
    .param p1, "listener"    # Lcom/digitalsky/sdk/common/Listener$ILoginCallback;

    .prologue
    .line 28
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIUsers()Ljava/util/TreeMap;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/TreeMap;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    .line 57
    return-void

    .line 28
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 29
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/digitalsky/sdk/user/IUser;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/digitalsky/sdk/user/IUser;

    new-instance v3, Lcom/digitalsky/sdk/user/FreeSdkUser$1;

    invoke-direct {v3, p0, p1, v0}, Lcom/digitalsky/sdk/user/FreeSdkUser$1;-><init>(Lcom/digitalsky/sdk/user/FreeSdkUser;Lcom/digitalsky/sdk/common/Listener$ILoginCallback;Ljava/util/Map$Entry;)V

    invoke-interface {v1, v3}, Lcom/digitalsky/sdk/user/IUser;->setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V

    goto :goto_0
.end method
