.class public Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;
.super Landroid/webkit/WebChromeClient;
.source "UniWebChromeClient.java"


# instance fields
.field LayoutParameters:Landroid/widget/FrameLayout$LayoutParams;

.field private _customView:Landroid/view/View;

.field private _customViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

.field private _customViewContainer:Landroid/widget/FrameLayout;

.field private _uniWebViewLayout:Landroid/widget/FrameLayout;


# direct methods
.method public constructor <init>(Landroid/widget/FrameLayout;)V
    .locals 2
    .param p1, "oriLayout"    # Landroid/widget/FrameLayout;

    .prologue
    const/4 v1, -0x1

    .line 22
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    .line 15
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    .line 16
    invoke-direct {v0, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->LayoutParameters:Landroid/widget/FrameLayout$LayoutParams;

    .line 23
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_uniWebViewLayout:Landroid/widget/FrameLayout;

    .line 24
    return-void
.end method


# virtual methods
.method public ToggleFullScreen(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewCustomViewActivity;)V
    .locals 2
    .param p1, "activity"    # Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewCustomViewActivity;

    .prologue
    .line 39
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    .line 40
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_uniWebViewLayout:Landroid/widget/FrameLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 41
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->LayoutParameters:Landroid/widget/FrameLayout$LayoutParams;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 42
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->LayoutParameters:Landroid/widget/FrameLayout$LayoutParams;

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 43
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 44
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 45
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    invoke-virtual {p1, v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewCustomViewActivity;->setContentView(Landroid/view/View;)V

    .line 46
    return-void
.end method

.method public onHideCustomView()V
    .locals 3

    .prologue
    const/16 v2, 0x8

    .line 50
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    if-eqz v0, :cond_0

    .line 51
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    .line 52
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 53
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    .line 54
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewContainer:Landroid/widget/FrameLayout;

    invoke-virtual {v0, v2}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 55
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    invoke-interface {v0}, Landroid/webkit/WebChromeClient$CustomViewCallback;->onCustomViewHidden()V

    .line 56
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_uniWebViewLayout:Landroid/widget/FrameLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 58
    :cond_0
    return-void
.end method

.method public onShowCustomView(Landroid/view/View;Landroid/webkit/WebChromeClient$CustomViewCallback;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/webkit/WebChromeClient$CustomViewCallback;

    .prologue
    .line 29
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customView:Landroid/view/View;

    .line 30
    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;->_customViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    .line 32
    sput-object p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewCustomViewActivity;->currentFullScreenClient:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;

    .line 33
    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    const-class v2, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewCustomViewActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 34
    .local v0, "intent":Landroid/content/Intent;
    sget-object v1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 35
    return-void
.end method
