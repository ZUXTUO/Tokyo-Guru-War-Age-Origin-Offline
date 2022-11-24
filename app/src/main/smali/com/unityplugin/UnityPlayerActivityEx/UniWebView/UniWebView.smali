.class public Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;
.super Landroid/webkit/WebView;
.source "UniWebView.java"


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "SetJavaScriptEnabled"
    }
.end annotation


# static fields
.field public static customUserAgent:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x0

    const/4 v4, -0x1

    const/4 v3, 0x1

    .line 22
    invoke-direct {p0, p1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    .line 23
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    .line 24
    .local v0, "webSettings":Landroid/webkit/WebSettings;
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 25
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 26
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 27
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 28
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setGeolocationEnabled(Z)V

    .line 30
    sget-object v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->customUserAgent:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->customUserAgent:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 31
    sget-object v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->customUserAgent:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    .line 34
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x8

    if-lt v1, v2, :cond_1

    .line 35
    sget-object v1, Landroid/webkit/WebSettings$PluginState;->ON:Landroid/webkit/WebSettings$PluginState;

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setPluginState(Landroid/webkit/WebSettings$PluginState;)V

    .line 38
    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0xb

    if-lt v1, v2, :cond_2

    .line 39
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 44
    :cond_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x10

    if-lt v1, v2, :cond_3

    .line 45
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setAllowFileAccessFromFileURLs(Z)V

    .line 46
    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setAllowUniversalAccessFromFileURLs(Z)V

    .line 49
    :cond_3
    invoke-virtual {p0, v5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setScrollBarStyle(I)V

    .line 50
    invoke-virtual {p0, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setVerticalScrollbarOverlay(Z)V

    .line 51
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v1, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 52
    return-void
.end method


# virtual methods
.method public updateTransparent(Z)V
    .locals 4
    .param p1, "transparent"    # Z

    .prologue
    const/4 v3, 0x0

    const/16 v2, 0xb

    const/4 v1, 0x0

    .line 55
    if-eqz p1, :cond_1

    .line 56
    invoke-virtual {p0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setBackgroundColor(I)V

    .line 57
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_0

    .line 58
    const/4 v0, 0x1

    invoke-virtual {p0, v0, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setLayerType(ILandroid/graphics/Paint;)V

    .line 66
    :cond_0
    :goto_0
    return-void

    .line 61
    :cond_1
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setBackgroundColor(I)V

    .line 62
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_0

    .line 63
    invoke-virtual {p0, v1, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setLayerType(ILandroid/graphics/Paint;)V

    goto :goto_0
.end method
