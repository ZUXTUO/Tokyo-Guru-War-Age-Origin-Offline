.class public Lcom/digital/cloud/usercenter/page/ClausePage;
.super Landroid/app/Activity;
.source "ClausePage.java"


# static fields
.field private static mActivity:Landroid/app/Activity;

.field private static mCloseButton:Landroid/widget/ImageButton;

.field private static mWebView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 21
    sput-object v0, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    .line 22
    sput-object v0, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    .line 23
    sput-object v0, Lcom/digital/cloud/usercenter/page/ClausePage;->mCloseButton:Landroid/widget/ImageButton;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static close()V
    .locals 1

    .prologue
    .line 103
    sget-object v0, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 104
    sget-object v0, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    .line 105
    :cond_0
    return-void
.end method

.method public static show(Landroid/app/Activity;)V
    .locals 2
    .param p0, "parentActivity"    # Landroid/app/Activity;

    .prologue
    .line 98
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/digital/cloud/usercenter/page/ClausePage;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 99
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 100
    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "b"    # Landroid/os/Bundle;

    .prologue
    .line 27
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 28
    invoke-static {}, Lcom/digital/cloud/usercenter/page/ClausePage;->close()V

    .line 29
    sput-object p0, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    .line 30
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/page/ClausePage;->showPage()V

    .line 31
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 133
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ClausePage onDestroy"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 135
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 121
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ClausePage onPause"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 123
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 115
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ClausePage onResume"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 116
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 117
    return-void
.end method

.method protected onStart()V
    .locals 2

    .prologue
    .line 109
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ClausePage onStart"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 111
    return-void
.end method

.method protected onStop()V
    .locals 2

    .prologue
    .line 127
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ClausePage onStop"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 128
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 129
    return-void
.end method

.method public showPage()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 34
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    const-string v2, "layout"

    const-string v3, "tool_bar_main_page"

    invoke-static {v2, v3}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Activity;->setContentView(I)V

    .line 35
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 36
    .local v0, "tool_bar_main_page_view":Landroid/view/View;
    const-string v1, "id"

    const-string v2, "webView1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/webkit/WebView;

    sput-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    .line 38
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0xb

    if-lt v1, v2, :cond_0

    .line 40
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    const-string v2, "searchBoxJavaBridge_"

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 41
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    const-string v2, "accessibility"

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 42
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    const-string v2, "accessibilityTraversal"

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 45
    :cond_0
    const-string v1, "id"

    const-string v2, "imageButton1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    sput-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mCloseButton:Landroid/widget/ImageButton;

    .line 46
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mCloseButton:Landroid/widget/ImageButton;

    new-instance v2, Lcom/digital/cloud/usercenter/page/ClausePage$1;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/ClausePage$1;-><init>(Lcom/digital/cloud/usercenter/page/ClausePage;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 55
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "web "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolClauseUrl:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 56
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 57
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    .line 58
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 59
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 60
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    new-instance v2, Lcom/digital/cloud/usercenter/page/ClausePage$2;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/ClausePage$2;-><init>(Lcom/digital/cloud/usercenter/page/ClausePage;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 94
    sget-object v1, Lcom/digital/cloud/usercenter/page/ClausePage;->mWebView:Landroid/webkit/WebView;

    sget-object v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolClauseUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 95
    return-void
.end method
