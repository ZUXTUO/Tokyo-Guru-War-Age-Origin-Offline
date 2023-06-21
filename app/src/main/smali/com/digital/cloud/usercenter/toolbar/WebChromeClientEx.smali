.class public Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;
.super Landroid/webkit/WebChromeClient;
.source "WebChromeClientEx.java"


# instance fields
.field private mActivity:Landroid/app/Activity;

.field private mFileUploadCallbackNew:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback",
            "<[",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field

.field private mFileUploadCallbackOld:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field

.field private requestId:I


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 2
    .param p1, "act"    # Landroid/app/Activity;

    .prologue
    const/4 v1, 0x0

    .line 18
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    .line 13
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    .line 14
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    .line 15
    const/16 v0, 0x49c1

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->requestId:I

    .line 16
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mActivity:Landroid/app/Activity;

    .line 19
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mActivity:Landroid/app/Activity;

    .line 20
    return-void
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 4
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "intent"    # Landroid/content/Intent;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 64
    const-string v0, "error"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 65
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->requestId:I

    if-ne p1, v0, :cond_0

    .line 66
    const/4 v0, -0x1

    if-ne p2, v0, :cond_2

    .line 67
    if-eqz p3, :cond_0

    .line 68
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    if-eqz v0, :cond_1

    .line 69
    const-string v0, "error"

    const-string v1, "onActivityResult 1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 71
    iput-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    .line 88
    :cond_0
    :goto_0
    return-void

    .line 72
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    invoke-static {p2, p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->parseResult(ILandroid/content/Intent;)[Landroid/net/Uri;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 75
    iput-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    goto :goto_0

    .line 79
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    if-eqz v0, :cond_3

    .line 80
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    invoke-interface {v0, v3}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 81
    iput-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    goto :goto_0

    .line 82
    :cond_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    invoke-interface {v0, v3}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 84
    iput-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    goto :goto_0
.end method

.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .locals 1
    .param p1, "webView"    # Landroid/webkit/WebView;
    .param p3, "fileChooserParams"    # Landroid/webkit/WebChromeClient$FileChooserParams;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Landroid/webkit/ValueCallback",
            "<[",
            "Landroid/net/Uri;",
            ">;",
            "Landroid/webkit/WebChromeClient$FileChooserParams;",
            ")Z"
        }
    .end annotation

    .prologue
    .line 45
    .local p2, "filePathCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<[Landroid/net/Uri;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p2}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->openFileInput(Landroid/webkit/ValueCallback;Landroid/webkit/ValueCallback;)V

    .line 46
    const/4 v0, 0x1

    return v0
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;)V
    .locals 1
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
    .line 24
    .local p1, "uploadMsg":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;)V

    .line 25
    return-void
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;)V
    .locals 1
    .param p2, "acceptType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 30
    .local p1, "uploadMsg":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    return-void
.end method

.method public openFileChooser(Landroid/webkit/ValueCallback;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
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
    .line 37
    .local p1, "uploadMsg":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->openFileInput(Landroid/webkit/ValueCallback;Landroid/webkit/ValueCallback;)V

    .line 38
    return-void
.end method

.method protected openFileInput(Landroid/webkit/ValueCallback;Landroid/webkit/ValueCallback;)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/ValueCallback",
            "<",
            "Landroid/net/Uri;",
            ">;",
            "Landroid/webkit/ValueCallback",
            "<[",
            "Landroid/net/Uri;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 52
    .local p1, "fileUploadCallbackOld":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Landroid/net/Uri;>;"
    .local p2, "fileUploadCallbackNew":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<[Landroid/net/Uri;>;"
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackOld:Landroid/webkit/ValueCallback;

    .line 53
    iput-object p2, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mFileUploadCallbackNew:Landroid/webkit/ValueCallback;

    .line 54
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 55
    .local v0, "i":Landroid/content/Intent;
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 56
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 58
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->mActivity:Landroid/app/Activity;

    const-string v2, ""

    invoke-static {v0, v2}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v2

    iget v3, p0, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->requestId:I

    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    .line 60
    return-void
.end method
