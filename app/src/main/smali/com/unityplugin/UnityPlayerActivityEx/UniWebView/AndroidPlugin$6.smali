.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_UniWebViewChangeSize(Ljava/lang/String;IIII)V
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
.method constructor <init>(Ljava/lang/String;IIII)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$name:Ljava/lang/String;

    iput p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$top:I

    iput p3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$left:I

    iput p4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$bottom:I

    iput p5, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$right:I

    .line 214
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 217
    const-string v1, "UniWebView"

    const-string v2, "_UniWebViewChangeSize"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 218
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    .line 219
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz v0, :cond_0

    .line 220
    iget v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$top:I

    iget v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$left:I

    iget v3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$bottom:I

    iget v4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;->val$right:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->changeSize(IIII)V

    .line 222
    :cond_0
    return-void
.end method
