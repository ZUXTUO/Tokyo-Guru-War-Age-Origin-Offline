.class public Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;
.super Lcom/unity3d/player/UnityPlayerNativeActivity;
.source "AndroidPlugin.java"


# static fields
.field public static final FILECHOOSER_RESULTCODE:I = 0x1

.field protected static final LOG_TAG:Ljava/lang/String; = "UniWebView"

.field protected static _uploadMessages:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Lcom/unity3d/player/UnityPlayerNativeActivity;-><init>()V

    return-void
.end method

.method public static _UniWebViewAddJavaScript(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "js"    # Ljava/lang/String;

    .prologue
    .line 266
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$10;

    invoke-direct {v0, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$10;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 276
    return-void
.end method

.method public static _UniWebViewAddUrlScheme(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "scheme"    # Ljava/lang/String;

    .prologue
    .line 453
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$23;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$23;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 463
    return-void
.end method

.method public static _UniWebViewChangeSize(Ljava/lang/String;IIII)V
    .locals 6
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "top"    # I
    .param p2, "left"    # I
    .param p3, "bottom"    # I
    .param p4, "right"    # I

    .prologue
    .line 214
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$6;-><init>(Ljava/lang/String;IIII)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 224
    return-void
.end method

.method public static _UniWebViewCleanCache(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 279
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$11;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$11;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 289
    return-void
.end method

.method public static _UniWebViewCleanCookie(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 292
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;

    invoke-direct {v0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 312
    return-void
.end method

.method public static _UniWebViewDestroy(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 315
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$13;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$13;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 325
    return-void
.end method

.method public static _UniWebViewDismiss(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 240
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$8;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$8;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 250
    return-void
.end method

.method public static _UniWebViewEvaluatingJavaScript(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "js"    # Ljava/lang/String;

    .prologue
    .line 253
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$9;

    invoke-direct {v0, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$9;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 263
    return-void
.end method

.method public static _UniWebViewGetCurrentUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 406
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    .line 407
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz v0, :cond_0

    .line 408
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getUrl()Ljava/lang/String;

    move-result-object v1

    .line 410
    :goto_0
    return-object v1

    :cond_0
    const-string v1, ""

    goto :goto_0
.end method

.method public static _UniWebViewGetUserAgent(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 496
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    move-result-object v0

    .line 497
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz v0, :cond_0

    .line 498
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getUserAgent()Ljava/lang/String;

    move-result-object v1

    .line 500
    :goto_0
    return-object v1

    :cond_0
    const-string v1, ""

    goto :goto_0
.end method

.method public static _UniWebViewGoBack(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 367
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$17;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$17;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 377
    return-void
.end method

.method public static _UniWebViewGoForward(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 380
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$18;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$18;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 390
    return-void
.end method

.method public static _UniWebViewInit(Ljava/lang/String;IIII)V
    .locals 6
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "top"    # I
    .param p2, "left"    # I
    .param p3, "bottom"    # I
    .param p4, "right"    # I

    .prologue
    .line 102
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p0

    invoke-direct/range {v0 .. v5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$2;-><init>(IIIILjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 170
    return-void
.end method

.method public static _UniWebViewLoad(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 174
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$3;

    invoke-direct {v0, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$3;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 184
    return-void
.end method

.method public static _UniWebViewLoadHTMLString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "htmlString"    # Ljava/lang/String;
    .param p2, "baseURL"    # Ljava/lang/String;

    .prologue
    .line 393
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$19;

    invoke-direct {v0, p0, p1, p2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$19;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 403
    return-void
.end method

.method public static _UniWebViewReload(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 187
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$4;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$4;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 197
    return-void
.end method

.method public static _UniWebViewRemoveUrlScheme(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "scheme"    # Ljava/lang/String;

    .prologue
    .line 466
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$24;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$24;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 476
    return-void
.end method

.method public static _UniWebViewSetBackButtonEnable(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "enable"    # Z

    .prologue
    .line 414
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$20;-><init>(ZLjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 424
    return-void
.end method

.method public static _UniWebViewSetBounces(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "enable"    # Z

    .prologue
    .line 427
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$21;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$21;-><init>(ZLjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 437
    return-void
.end method

.method public static _UniWebViewSetSpinnerShowWhenLoading(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "show"    # Z

    .prologue
    .line 341
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$15;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$15;-><init>(ZLjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 351
    return-void
.end method

.method public static _UniWebViewSetSpinnerText(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 354
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$16;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$16;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 364
    return-void
.end method

.method public static _UniWebViewSetUserAgent(Ljava/lang/String;)V
    .locals 0
    .param p0, "userAgent"    # Ljava/lang/String;

    .prologue
    .line 492
    sput-object p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->customUserAgent:Ljava/lang/String;

    .line 493
    return-void
.end method

.method public static _UniWebViewSetZoomEnable(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "enable"    # Z

    .prologue
    .line 440
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$22;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$22;-><init>(ZLjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 450
    return-void
.end method

.method public static _UniWebViewShow(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 227
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$7;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$7;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 237
    return-void
.end method

.method public static _UniWebViewStop(Ljava/lang/String;)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 200
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$5;

    invoke-direct {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$5;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 210
    return-void
.end method

.method public static _UniWebViewTransparentBackground(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "transparent"    # Z

    .prologue
    .line 328
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$14;

    invoke-direct {v0, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$14;-><init>(Ljava/lang/String;Z)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 338
    return-void
.end method

.method public static _UniWebViewUseWideViewPort(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "use"    # Z

    .prologue
    .line 479
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$25;

    invoke-direct {v0, p1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$25;-><init>(ZLjava/lang/String;)V

    invoke-static {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->runSafelyOnUiThread(Ljava/lang/Runnable;)V

    .line 489
    return-void
.end method

.method public static getUnityActivity_()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 32
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    return-object v0
.end method

.method protected static runSafelyOnUiThread(Ljava/lang/Runnable;)V
    .locals 2
    .param p0, "r"    # Ljava/lang/Runnable;

    .prologue
    .line 504
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$26;

    invoke-direct {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$26;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 513
    return-void
.end method

.method public static setUploadMessage(Landroid/webkit/ValueCallback;)V
    .locals 0
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
    .line 36
    .local p0, "message":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    sput-object p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_uploadMessages:Landroid/webkit/ValueCallback;

    .line 37
    return-void
.end method


# virtual methods
.method protected ShowAllWebViewDialogs(Z)V
    .locals 6
    .param p1, "show"    # Z

    .prologue
    .line 516
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->getShowingWebViewDialogs()Ljava/util/ArrayList;

    move-result-object v1

    .line 517
    .local v1, "webViewDialogs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;>;"
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 528
    return-void

    .line 517
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 518
    .local v0, "webViewDialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    if-eqz p1, :cond_1

    .line 519
    const-string v3, "UniWebView"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "goForeGround"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 520
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->goForeGround()V

    .line 521
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->HideSystemUI()V

    goto :goto_0

    .line 523
    :cond_1
    const-string v3, "UniWebView"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "goBackGround"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 524
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->goBackGround()V

    .line 525
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->HideSystemUI()V

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v1, 0x0

    .line 90
    invoke-super {p0, p1, p2, p3}, Lcom/unity3d/player/UnityPlayerNativeActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 91
    const/4 v2, 0x1

    if-ne p1, v2, :cond_1

    .line 93
    sget-object v2, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_uploadMessages:Landroid/webkit/ValueCallback;

    if-eqz v2, :cond_1

    .line 94
    if-eqz p3, :cond_0

    const/4 v2, -0x1

    if-eq p2, v2, :cond_2

    :cond_0
    move-object v0, v1

    .line 95
    .local v0, "result":Landroid/net/Uri;
    :goto_0
    sget-object v2, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_uploadMessages:Landroid/webkit/ValueCallback;

    invoke-interface {v2, v0}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 96
    sput-object v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_uploadMessages:Landroid/webkit/ValueCallback;

    .line 99
    .end local v0    # "result":Landroid/net/Uri;
    :cond_1
    return-void

    .line 94
    :cond_2
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 4
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 80
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerNativeActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 81
    const-string v1, "UniWebView"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Rotation: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, p1, Landroid/content/res/Configuration;->orientation:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->allDialogs()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 86
    return-void

    .line 82
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 83
    .local v0, "dialog":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->updateContentSize()V

    .line 84
    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->HideSystemUI()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 41
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerNativeActivity;->onCreate(Landroid/os/Bundle;)V

    .line 42
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->getUnityActivity_()Landroid/app/Activity;

    move-result-object v0

    invoke-static {v0}, Landroid/webkit/CookieSyncManager;->createInstance(Landroid/content/Context;)Landroid/webkit/CookieSyncManager;

    .line 43
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 50
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerNativeActivity;->onPause()V

    .line 51
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->ShowAllWebViewDialogs(Z)V

    .line 53
    invoke-static {}, Landroid/webkit/CookieSyncManager;->getInstance()Landroid/webkit/CookieSyncManager;

    move-result-object v0

    .line 54
    .local v0, "manager":Landroid/webkit/CookieSyncManager;
    if-eqz v0, :cond_0

    .line 55
    invoke-virtual {v0}, Landroid/webkit/CookieSyncManager;->stopSync()V

    .line 57
    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 6

    .prologue
    .line 61
    invoke-super {p0}, Lcom/unity3d/player/UnityPlayerNativeActivity;->onResume()V

    .line 62
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->ShowAllWebViewDialogs(Z)V

    .line 65
    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$1;

    invoke-direct {v2, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$1;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;)V

    .line 70
    const-wide/16 v4, 0xc8

    .line 65
    invoke-virtual {v1, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 72
    invoke-static {}, Landroid/webkit/CookieSyncManager;->getInstance()Landroid/webkit/CookieSyncManager;

    move-result-object v0

    .line 73
    .local v0, "manager":Landroid/webkit/CookieSyncManager;
    if-eqz v0, :cond_0

    .line 74
    invoke-virtual {v0}, Landroid/webkit/CookieSyncManager;->startSync()V

    .line 76
    :cond_0
    return-void
.end method
