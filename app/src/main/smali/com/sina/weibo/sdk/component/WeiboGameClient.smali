.class Lcom/sina/weibo/sdk/component/WeiboGameClient;
.super Lcom/sina/weibo/sdk/component/WeiboWebViewClient;
.source "WeiboGameClient.java"


# instance fields
.field private mAct:Landroid/app/Activity;

.field private mGameRequestParam:Lcom/sina/weibo/sdk/component/GameRequestParam;

.field private mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;


# direct methods
.method public constructor <init>(Landroid/app/Activity;Lcom/sina/weibo/sdk/component/GameRequestParam;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "requestParam"    # Lcom/sina/weibo/sdk/component/GameRequestParam;

    .prologue
    .line 21
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;-><init>()V

    .line 22
    iput-object p1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mAct:Landroid/app/Activity;

    .line 23
    iput-object p2, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mGameRequestParam:Lcom/sina/weibo/sdk/component/GameRequestParam;

    .line 24
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mGameRequestParam:Lcom/sina/weibo/sdk/component/GameRequestParam;

    invoke-virtual {v0}, Lcom/sina/weibo/sdk/component/GameRequestParam;->getAuthListener()Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 25
    return-void
.end method

.method private handleRedirectUrl(Ljava/lang/String;)V
    .locals 6
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 98
    invoke-static {p1}, Lcom/sina/weibo/sdk/utils/Utility;->parseUrl(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v3

    .line 100
    .local v3, "values":Landroid/os/Bundle;
    const-string v4, "error"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1

    const-string v2, ""

    .line 101
    .local v2, "errorType":Ljava/lang/String;
    :goto_0
    const-string v4, "code"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 102
    .local v0, "errorCode":Ljava/lang/String;
    const-string v4, "msg"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 104
    .local v1, "errorDescription":Ljava/lang/String;
    if-nez v2, :cond_2

    if-nez v0, :cond_2

    .line 105
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    if-eqz v4, :cond_0

    .line 106
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    invoke-interface {v4, v3}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onComplete(Landroid/os/Bundle;)V

    .line 114
    :cond_0
    :goto_1
    return-void

    .line 100
    .end local v0    # "errorCode":Ljava/lang/String;
    .end local v1    # "errorDescription":Ljava/lang/String;
    .end local v2    # "errorType":Ljava/lang/String;
    :cond_1
    const-string v4, "error"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 109
    .restart local v0    # "errorCode":Ljava/lang/String;
    .restart local v1    # "errorDescription":Ljava/lang/String;
    .restart local v2    # "errorType":Ljava/lang/String;
    :cond_2
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    if-eqz v4, :cond_0

    .line 110
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 111
    new-instance v5, Lcom/sina/weibo/sdk/exception/WeiboAuthException;

    invoke-direct {v5, v0, v2, v1}, Lcom/sina/weibo/sdk/exception/WeiboAuthException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    invoke-interface {v4, v5}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onWeiboException(Lcom/sina/weibo/sdk/exception/WeiboException;)V

    goto :goto_1
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 68
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 69
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onPageFinishedCallBack(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 71
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 72
    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "favicon"    # Landroid/graphics/Bitmap;

    .prologue
    .line 29
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 30
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onPageStartedCallBack(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 33
    :cond_0
    invoke-super {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 34
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 76
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 77
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onReceivedErrorCallBack(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    .line 79
    :cond_0
    invoke-super {p0, p1, p2, p3, p4}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    .line 80
    return-void
.end method

.method public onReceivedSslError(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "handler"    # Landroid/webkit/SslErrorHandler;
    .param p3, "error"    # Landroid/net/http/SslError;

    .prologue
    .line 84
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 85
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onReceivedSslErrorCallBack(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V

    .line 87
    :cond_0
    invoke-super {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onReceivedSslError(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V

    .line 88
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 38
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v1, :cond_0

    .line 39
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v1, p1, p2}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->shouldOverrideUrlLoadingCallBack(Landroid/webkit/WebView;Ljava/lang/String;)Z

    .line 42
    :cond_0
    const-string v1, "sinaweibo://browser/close"

    invoke-virtual {p2, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 43
    invoke-static {p2}, Lcom/sina/weibo/sdk/utils/Utility;->parseUri(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    .line 44
    .local v0, "bundle":Landroid/os/Bundle;
    invoke-virtual {v0}, Landroid/os/Bundle;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    .line 45
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    if-eqz v1, :cond_1

    .line 46
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    invoke-interface {v1, v0}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onComplete(Landroid/os/Bundle;)V

    .line 60
    :cond_1
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mAct:Landroid/app/Activity;

    iget-object v2, p0, Lcom/sina/weibo/sdk/component/WeiboGameClient;->mGameRequestParam:Lcom/sina/weibo/sdk/component/GameRequestParam;

    invoke-virtual {v2}, Lcom/sina/weibo/sdk/component/GameRequestParam;->getAuthListenerKey()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;->closeBrowser(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    const/4 v1, 0x1

    .line 63
    .end local v0    # "bundle":Landroid/os/Bundle;
    :goto_0
    return v1

    :cond_2
    invoke-super {p0, p1, p2}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z

    move-result v1

    goto :goto_0
.end method
