.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_UniWebViewInit(Ljava/lang/String;IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$bottom:I

.field private final synthetic val$left:I

.field private final synthetic val$name:Ljava/lang/String;

.field private final synthetic val$right:I

.field private final synthetic val$top:I


# direct methods
.method constructor <init>(IIIILjava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$top:I

    iput p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$left:I

    iput p3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$bottom:I

    iput p4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$right:I

    iput-object p5, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$name:Ljava/lang/String;

    .line 102
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 105
    const-string v2, "UniWebView"

    const-string v3, "_UniWebViewInit"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 106
    new-instance v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2$1;

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$name:Ljava/lang/String;

    invoke-direct {v1, p0, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2$1;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;Ljava/lang/String;)V

    .line 165
    .local v1, "listener":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v2

    invoke-direct {v0, v2, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;-><init>(Landroid/content/Context;Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;)V

    .line 166
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    iget v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$top:I

    iget v3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$left:I

    iget v4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$bottom:I

    iget v5, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$right:I

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->changeSize(IIII)V

    .line 167
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v2

    iget-object v3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;->val$name:Ljava/lang/String;

    invoke-virtual {v2, v3, v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->setUniWebView(Ljava/lang/String;Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    .line 168
    return-void
.end method
