.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$18;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_UniWebViewGoForward(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$name:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$18;->val$name:Ljava/lang/String;

    .line 380
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 383
    const-string v1, "UniWebView"

    const-string v2, "_UniWebViewGoForward"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 384
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$18;->val$name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    .line 385
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz v0, :cond_0

    .line 386
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->goForward()Z

    .line 388
    :cond_0
    return-void
.end method
