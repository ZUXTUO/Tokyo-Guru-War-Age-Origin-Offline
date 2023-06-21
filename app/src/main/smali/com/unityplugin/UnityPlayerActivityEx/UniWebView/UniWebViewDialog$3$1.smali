.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;
.super Ljava/lang/Object;
.source "UniWebViewDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->onJsAlert(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

.field private final synthetic val$result:Landroid/webkit/JsResult;


# direct methods
.method constructor <init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/webkit/JsResult;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;->this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;->val$result:Landroid/webkit/JsResult;

    .line 429
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "id"    # I

    .prologue
    .line 431
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 432
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;->val$result:Landroid/webkit/JsResult;

    invoke-virtual {v0}, Landroid/webkit/JsResult;->confirm()V

    .line 433
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;->this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->access$0(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V

    .line 434
    return-void
.end method
