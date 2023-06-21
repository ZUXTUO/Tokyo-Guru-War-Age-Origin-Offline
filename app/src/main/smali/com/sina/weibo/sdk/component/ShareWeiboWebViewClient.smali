.class Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;
.super Lcom/sina/weibo/sdk/component/WeiboWebViewClient;
.source "ShareWeiboWebViewClient.java"


# static fields
.field private static final RESP_PARAM_CODE:Ljava/lang/String; = "code"

.field private static final RESP_PARAM_MSG:Ljava/lang/String; = "msg"

.field private static final RESP_SUCC_CODE:Ljava/lang/String; = "0"


# instance fields
.field private mAct:Landroid/app/Activity;

.field private mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

.field private mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;


# direct methods
.method public constructor <init>(Landroid/app/Activity;Lcom/sina/weibo/sdk/component/ShareRequestParam;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "requestParam"    # Lcom/sina/weibo/sdk/component/ShareRequestParam;

    .prologue
    .line 25
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;-><init>()V

    .line 26
    iput-object p1, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    .line 27
    iput-object p2, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    .line 28
    invoke-virtual {p2}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->getAuthListener()Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 29
    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onPageFinishedCallBack(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 77
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 78
    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "favicon"    # Landroid/graphics/Bitmap;

    .prologue
    .line 33
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 34
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onPageStartedCallBack(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 37
    :cond_0
    invoke-super {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 38
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 82
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onReceivedErrorCallBack(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    .line 86
    :cond_0
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    iget-object v1, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->sendSdkErrorResponse(Landroid/app/Activity;Ljava/lang/String;)V

    .line 88
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    .line 89
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    invoke-virtual {v1}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->getAuthListenerKey()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    .line 88
    invoke-static {v0, v1, v2}, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;->closeBrowser(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    return-void
.end method

.method public onReceivedSslError(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V
    .locals 3
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "handler"    # Landroid/webkit/SslErrorHandler;
    .param p3, "error"    # Landroid/net/http/SslError;

    .prologue
    .line 94
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v0, :cond_0

    .line 95
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v0, p1, p2, p3}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->onReceivedSslErrorCallBack(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V

    .line 98
    :cond_0
    invoke-virtual {p2}, Landroid/webkit/SslErrorHandler;->cancel()V

    .line 99
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    iget-object v1, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    const-string v2, "ReceivedSslError"

    invoke-virtual {v0, v1, v2}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->sendSdkErrorResponse(Landroid/app/Activity;Ljava/lang/String;)V

    .line 101
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    .line 102
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    invoke-virtual {v1}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->getAuthListenerKey()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    .line 101
    invoke-static {v0, v1, v2}, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;->closeBrowser(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 103
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 6
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 42
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    if-eqz v3, :cond_0

    .line 43
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mCallBack:Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;

    invoke-interface {v3, p1, p2}, Lcom/sina/weibo/sdk/component/BrowserRequestCallBack;->shouldOverrideUrlLoadingCallBack(Landroid/webkit/WebView;Ljava/lang/String;)Z

    .line 46
    :cond_0
    const-string v3, "sinaweibo://browser/close"

    invoke-virtual {p2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 47
    invoke-static {p2}, Lcom/sina/weibo/sdk/utils/Utility;->parseUri(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    .line 48
    .local v0, "bundle":Landroid/os/Bundle;
    invoke-virtual {v0}, Landroid/os/Bundle;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 49
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    if-eqz v3, :cond_1

    .line 50
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    invoke-interface {v3, v0}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onComplete(Landroid/os/Bundle;)V

    .line 53
    :cond_1
    const-string v3, "code"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 54
    .local v1, "errCode":Ljava/lang/String;
    const-string v3, "msg"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 55
    .local v2, "errMsg":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 56
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    iget-object v4, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    invoke-virtual {v3, v4}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->sendSdkCancleResponse(Landroid/app/Activity;)V

    .line 64
    :goto_0
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    .line 65
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    invoke-virtual {v4}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->getAuthListenerKey()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    .line 64
    invoke-static {v3, v4, v5}, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;->closeBrowser(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    const/4 v3, 0x1

    .line 68
    .end local v0    # "bundle":Landroid/os/Bundle;
    .end local v1    # "errCode":Ljava/lang/String;
    .end local v2    # "errMsg":Ljava/lang/String;
    :goto_1
    return v3

    .line 58
    .restart local v0    # "bundle":Landroid/os/Bundle;
    .restart local v1    # "errCode":Ljava/lang/String;
    .restart local v2    # "errMsg":Ljava/lang/String;
    :cond_2
    const-string v3, "0"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 59
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    iget-object v4, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    invoke-virtual {v3, v4, v2}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->sendSdkErrorResponse(Landroid/app/Activity;Ljava/lang/String;)V

    goto :goto_0

    .line 61
    :cond_3
    iget-object v3, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mShareRequestParam:Lcom/sina/weibo/sdk/component/ShareRequestParam;

    iget-object v4, p0, Lcom/sina/weibo/sdk/component/ShareWeiboWebViewClient;->mAct:Landroid/app/Activity;

    invoke-virtual {v3, v4}, Lcom/sina/weibo/sdk/component/ShareRequestParam;->sendSdkOkResponse(Landroid/app/Activity;)V

    goto :goto_0

    .line 68
    .end local v0    # "bundle":Landroid/os/Bundle;
    .end local v1    # "errCode":Ljava/lang/String;
    .end local v2    # "errMsg":Ljava/lang/String;
    :cond_4
    invoke-super {p0, p1, p2}, Lcom/sina/weibo/sdk/component/WeiboWebViewClient;->shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z

    move-result v3

    goto :goto_1
.end method
