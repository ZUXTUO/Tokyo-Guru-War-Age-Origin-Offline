.class public Lcom/digitalsky/sdk/FreeSdk;
.super Ljava/lang/Object;
.source "FreeSdk.java"


# static fields
.field public static TAG:Ljava/lang/String;

.field private static instance:Lcom/digitalsky/sdk/FreeSdk;


# instance fields
.field private mActivity:Landroid/app/Activity;


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

    const-class v1, Lcom/digitalsky/sdk/FreeSdk;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/FreeSdk;->TAG:Ljava/lang/String;

    .line 17
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/FreeSdk;->instance:Lcom/digitalsky/sdk/FreeSdk;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private _init(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 30
    invoke-static {p1}, Lcom/digitalsky/sdk/common/Utils;->init(Landroid/content/Context;)V

    .line 31
    invoke-static {p1}, Lcom/digitalsky/sdk/common/Constant;->init(Landroid/content/Context;)V

    .line 32
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/sdk/PluginMgr;->init(Landroid/content/Context;)V

    .line 35
    return-void
.end method

.method public static getInstance()Lcom/digitalsky/sdk/FreeSdk;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/digitalsky/sdk/FreeSdk;->instance:Lcom/digitalsky/sdk/FreeSdk;

    if-nez v0, :cond_0

    .line 23
    new-instance v0, Lcom/digitalsky/sdk/FreeSdk;

    invoke-direct {v0}, Lcom/digitalsky/sdk/FreeSdk;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/FreeSdk;->instance:Lcom/digitalsky/sdk/FreeSdk;

    .line 25
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/FreeSdk;->instance:Lcom/digitalsky/sdk/FreeSdk;

    return-object v0
.end method

.method public static setSdkConfig(Ljava/lang/String;)V
    .locals 0
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 51
    invoke-static {p0}, Lcom/digitalsky/sdk/common/Constant;->config(Ljava/lang/String;)V

    .line 52
    return-void
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 122
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 125
    return-void

    .line 122
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 123
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0, p1, p2, p3}, Lcom/digitalsky/sdk/IActivity;->onActivityResult(IILandroid/content/Intent;)V

    goto :goto_0
.end method

.method public onAppAttachBaseContext(Landroid/content/Context;)V
    .locals 3
    .param p1, "base"    # Landroid/content/Context;

    .prologue
    .line 57
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/FreeSdk;->_init(Landroid/content/Context;)V

    .line 58
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIApplication()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 61
    return-void

    .line 58
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IApplication;

    .line 59
    .local v0, "iApplication":Lcom/digitalsky/sdk/IApplication;
    invoke-interface {v0, p1}, Lcom/digitalsky/sdk/IApplication;->onAppAttachBaseContext(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public onAppCreate(Landroid/app/Application;)V
    .locals 3
    .param p1, "app"    # Landroid/app/Application;

    .prologue
    .line 64
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIApplication()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 67
    return-void

    .line 64
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IApplication;

    .line 65
    .local v0, "iApplication":Lcom/digitalsky/sdk/IApplication;
    invoke-interface {v0, p1}, Lcom/digitalsky/sdk/IApplication;->onAppCreate(Landroid/app/Application;)V

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 3
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 128
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 131
    return-void

    .line 128
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 129
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0, p1}, Lcom/digitalsky/sdk/IActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    goto :goto_0
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 3
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 72
    iput-object p1, p0, Lcom/digitalsky/sdk/FreeSdk;->mActivity:Landroid/app/Activity;

    .line 74
    iget-object v1, p0, Lcom/digitalsky/sdk/FreeSdk;->mActivity:Landroid/app/Activity;

    invoke-static {v1}, Lcom/digitalsky/sdk/kefu/KeFuPage;->init(Landroid/app/Activity;)V

    .line 75
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getInstance()Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    move-result-object v1

    iget-object v2, p0, Lcom/digitalsky/sdk/FreeSdk;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1, v2}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->init(Landroid/app/Activity;)V

    .line 77
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 80
    return-void

    .line 77
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 78
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    iget-object v2, p0, Lcom/digitalsky/sdk/FreeSdk;->mActivity:Landroid/app/Activity;

    invoke-interface {v0, v2}, Lcom/digitalsky/sdk/IActivity;->onCreate(Landroid/app/Activity;)V

    goto :goto_0
.end method

.method public onDestroy()V
    .locals 3

    .prologue
    .line 116
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 119
    return-void

    .line 116
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 117
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onDestroy()V

    goto :goto_0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 140
    invoke-static {p1}, Lcom/digitalsky/sdk/kefu/KeFuPage;->onKeyDown(I)Z

    move-result v0

    return v0
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 134
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 137
    return-void

    .line 134
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 135
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0, p1}, Lcom/digitalsky/sdk/IActivity;->onNewIntent(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method public onPause()V
    .locals 3

    .prologue
    .line 103
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getInstance()Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->pause()V

    .line 104
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 107
    return-void

    .line 104
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 105
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onPause()V

    goto :goto_0
.end method

.method public onRestart()V
    .locals 3

    .prologue
    .line 83
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 86
    return-void

    .line 83
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 84
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onRestart()V

    goto :goto_0
.end method

.method public onResume()V
    .locals 3

    .prologue
    .line 95
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getInstance()Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->resume()V

    .line 97
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 100
    return-void

    .line 97
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 98
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onResume()V

    goto :goto_0
.end method

.method public onStart()V
    .locals 3

    .prologue
    .line 89
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 92
    return-void

    .line 89
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 90
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onStart()V

    goto :goto_0
.end method

.method public onStop()V
    .locals 3

    .prologue
    .line 110
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1}, Lcom/digitalsky/sdk/PluginMgr;->getIActivity()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 113
    return-void

    .line 110
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    .line 111
    .local v0, "iActivity":Lcom/digitalsky/sdk/IActivity;
    invoke-interface {v0}, Lcom/digitalsky/sdk/IActivity;->onStop()V

    goto :goto_0
.end method
