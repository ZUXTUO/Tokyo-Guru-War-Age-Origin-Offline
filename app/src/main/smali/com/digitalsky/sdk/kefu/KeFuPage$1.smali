.class Lcom/digitalsky/sdk/kefu/KeFuPage$1;
.super Ljava/lang/Object;
.source "KeFuPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/kefu/KeFuPage;->openKeFuWebPage()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    const/4 v3, -0x1

    .line 110
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v0

    if-nez v0, :cond_0

    .line 111
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$1()Landroid/app/Activity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-static {v0}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$2(Landroid/widget/LinearLayout;)V

    .line 112
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$1()Landroid/app/Activity;

    move-result-object v0

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 113
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v2, v3, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 112
    invoke-virtual {v0, v1, v2}, Landroid/app/Activity;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    :cond_0
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 117
    invoke-static {v5}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$4(Z)V

    .line 118
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 119
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$5(Landroid/webkit/WebView;)V

    .line 122
    :cond_1
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    if-nez v0, :cond_3

    .line 123
    new-instance v0, Landroid/webkit/WebView;

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$1()Landroid/app/Activity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    invoke-static {v0}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$5(Landroid/webkit/WebView;)V

    .line 124
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 125
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    new-instance v1, Lcom/digitalsky/sdk/kefu/KeFuPage$1$1;

    invoke-direct {v1, p0}, Lcom/digitalsky/sdk/kefu/KeFuPage$1$1;-><init>(Lcom/digitalsky/sdk/kefu/KeFuPage$1;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 139
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_2

    .line 140
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    const-string v1, "searchBoxJavaBridge_"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 141
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    const-string v1, "accessibility"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 142
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    const-string v1, "accessibilityTraversal"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 144
    :cond_2
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$6()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 145
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 146
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    .line 147
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 148
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 149
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v0

    new-instance v1, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;

    invoke-direct {v1, p0}, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;-><init>(Lcom/digitalsky/sdk/kefu/KeFuPage$1;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 190
    :cond_3
    invoke-static {v4}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$4(Z)V

    .line 191
    return-void
.end method
