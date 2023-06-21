.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;
.super Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;
.source "UniWebViewDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->createWebView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;


# direct methods
.method constructor <init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/widget/FrameLayout;)V
    .locals 0
    .param p2, "$anonymous0"    # Landroid/widget/FrameLayout;

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 389
    invoke-direct {p0, p2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;-><init>(Landroid/widget/FrameLayout;)V

    return-void
.end method

.method static synthetic access$0(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    .locals 1

    .prologue
    .line 389
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    return-object v0
.end method


# virtual methods
.method public onGeolocationPermissionsShowPrompt(Ljava/lang/String;Landroid/webkit/GeolocationPermissions$Callback;)V
    .locals 2
    .param p1, "origin"    # Ljava/lang/String;
    .param p2, "callback"    # Landroid/webkit/GeolocationPermissions$Callback;

    .prologue
    .line 515
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-interface {p2, p1, v0, v1}, Landroid/webkit/GeolocationPermissions$Callback;->invoke(Ljava/lang/String;ZZ)V

    .line 516
    return-void
.end method

.method public onJsAlert(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
    .locals 6
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/webkit/JsResult;

    .prologue
    const/16 v5, 0x8

    .line 423
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 424
    .local v0, "alertDialogBuilder":Landroid/app/AlertDialog$Builder;
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 425
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 426
    invoke-virtual {v2, p3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 427
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 428
    const v3, 0x1080027

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 429
    const v3, 0x104000a

    new-instance v4, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;

    invoke-direct {v4, p0, p4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$1;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/webkit/JsResult;)V

    invoke-virtual {v2, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 435
    invoke-virtual {v2}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v2

    .line 424
    invoke-static {v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V

    .line 437
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x13

    if-lt v1, v2, :cond_0

    .line 438
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v5, v5}, Landroid/view/Window;->setFlags(II)V

    .line 439
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 440
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    .line 441
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v2

    .line 440
    invoke-virtual {v1, v2}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 442
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v5}, Landroid/view/Window;->clearFlags(I)V

    .line 447
    :goto_0
    const/4 v1, 0x1

    return v1

    .line 444
    :cond_0
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-static {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    goto :goto_0
.end method

.method public onJsConfirm(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
    .locals 5
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/webkit/JsResult;

    .prologue
    .line 452
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 453
    .local v0, "alertDialogBuilder":Landroid/app/AlertDialog$Builder;
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 454
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 455
    invoke-virtual {v2, p3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 456
    const v3, 0x108009b

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 457
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 458
    const v3, 0x1040013

    new-instance v4, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$2;

    invoke-direct {v4, p0, p4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$2;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/webkit/JsResult;)V

    invoke-virtual {v2, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 465
    const v3, 0x1040009

    new-instance v4, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$3;

    invoke-direct {v4, p0, p4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$3;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/webkit/JsResult;)V

    invoke-virtual {v2, v3, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 471
    invoke-virtual {v2}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v2

    .line 453
    invoke-static {v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V

    .line 472
    const/4 v1, 0x1

    return v1
.end method

.method public onJsPrompt(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsPromptResult;)Z
    .locals 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "defaultValue"    # Ljava/lang/String;
    .param p5, "result"    # Landroid/webkit/JsPromptResult;

    .prologue
    .line 477
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 479
    .local v0, "alertDialogBuilder":Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 480
    invoke-virtual {v2, p3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 481
    const v3, 0x108009b

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 482
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    .line 484
    new-instance v1, Landroid/widget/EditText;

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 485
    .local v1, "input":Landroid/widget/EditText;
    invoke-virtual {v1}, Landroid/widget/EditText;->setSingleLine()V

    .line 486
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 488
    const v2, 0x1040013

    new-instance v3, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;

    invoke-direct {v3, p0, v1, p5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$4;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/widget/EditText;Landroid/webkit/JsPromptResult;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 501
    const v2, 0x1040009

    new-instance v3, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$5;

    invoke-direct {v3, p0, p5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3$5;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;Landroid/webkit/JsPromptResult;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 508
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V

    .line 510
    const/4 v2, 0x1

    return v2
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 394
    .local p1, "uploadMsg":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    invoke-static {p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->setUploadMessage(Landroid/webkit/ValueCallback;)V

    .line 395
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 396
    .local v0, "i":Landroid/content/Intent;
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 397
    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 398
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v1

    const-string v2, "File Chooser"

    invoke-static {v0, v2}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    .line 399
    return-void
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;)V
    .locals 4
    .param p1, "uploadMsg"    # Landroid/webkit/ValueCallback;
    .param p2, "acceptType"    # Ljava/lang/String;

    .prologue
    .line 403
    invoke-static {p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->setUploadMessage(Landroid/webkit/ValueCallback;)V

    .line 404
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 405
    .local v0, "i":Landroid/content/Intent;
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 406
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 407
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v1

    .line 408
    const-string v2, "File Browser"

    invoke-static {v0, v2}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v2

    .line 409
    const/4 v3, 0x1

    .line 407
    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    .line 410
    return-void
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p2, "acceptType"    # Ljava/lang/String;
    .param p3, "capture"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 414
    .local p1, "uploadMsg":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    invoke-static {p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->setUploadMessage(Landroid/webkit/ValueCallback;)V

    .line 415
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 416
    .local v0, "i":Landroid/content/Intent;
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 417
    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 418
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v1

    const-string v2, "File Chooser"

    invoke-static {v0, v2}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    .line 419
    return-void
.end method
