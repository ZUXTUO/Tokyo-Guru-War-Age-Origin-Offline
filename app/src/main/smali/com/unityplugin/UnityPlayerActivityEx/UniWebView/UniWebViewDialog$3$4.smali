.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;
.super Ljava/lang/Object;
.source "UniWebViewDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->onJsPrompt(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsPromptResult;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

.field private final synthetic val$input:Landroid/widget/EditText;

.field private final synthetic val$result:Landroid/webkit/JsPromptResult;


# direct methods
.method constructor <init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/widget/EditText;Landroid/webkit/JsPromptResult;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->val$input:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->val$result:Landroid/webkit/JsPromptResult;

    .line 488
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 490
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->val$input:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 491
    .local v0, "editable":Landroid/text/Editable;
    const-string v1, ""

    .line 492
    .local v1, "value":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 493
    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 495
    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 496
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->val$result:Landroid/webkit/JsPromptResult;

    invoke-virtual {v2, v1}, Landroid/webkit/JsPromptResult;->confirm(Ljava/lang/String;)V

    .line 497
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;->this$1:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

    invoke-static {v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->access$0(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v2, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V

    .line 498
    return-void
.end method
