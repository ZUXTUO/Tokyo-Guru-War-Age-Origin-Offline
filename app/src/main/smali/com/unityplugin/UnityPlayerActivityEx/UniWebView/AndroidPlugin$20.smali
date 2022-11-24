.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_UniWebViewSetBackButtonEnable(Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$enable:Z

.field private final synthetic val$name:Ljava/lang/String;


# direct methods
.method constructor <init>(ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-boolean p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;->val$enable:Z

    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;->val$name:Ljava/lang/String;

    .line 414
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 417
    const-string v1, "UniWebView"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "_UniWebViewSetBackButtonEnable:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-boolean v3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;->val$enable:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 418
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;->val$name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    .line 419
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz v0, :cond_0

    .line 420
    iget-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;->val$enable:Z

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->setBackButtonEnable(Z)V

    .line 422
    :cond_0
    return-void
.end method
