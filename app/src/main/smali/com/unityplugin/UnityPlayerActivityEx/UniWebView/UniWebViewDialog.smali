.class public Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
.super Landroid/app/Dialog;
.source "UniWebViewDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;
    }
.end annotation


# instance fields
.field private _alertDialog:Landroid/app/AlertDialog;

.field private _backButtonEnable:Z

.field private _bottom:I

.field private _content:Landroid/widget/FrameLayout;

.field private _currentUrl:Ljava/lang/String;

.field private _currentUserAgent:Ljava/lang/String;

.field private _isLoading:Z

.field private _left:I

.field private _listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

.field private _loadingInterrupted:Z

.field private _manualHide:Z

.field private _right:I

.field private _showSpinnerWhenLoading:Z

.field private _spinner:Landroid/app/ProgressDialog;

.field private _spinnerText:Ljava/lang/String;

.field private _top:I

.field private _transparent:Z

.field private _uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

.field public schemes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "listener"    # Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    const/16 v4, 0x10

    const/4 v2, 0x1

    const/4 v3, -0x1

    .line 86
    const v1, 0x103006c

    invoke-direct {p0, p1, v1}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 56
    iput-boolean v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_showSpinnerWhenLoading:Z

    .line 57
    const-string v1, "Loading..."

    iput-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinnerText:Ljava/lang/String;

    .line 62
    const-string v1, ""

    iput-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_currentUrl:Ljava/lang/String;

    .line 64
    iput-boolean v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_backButtonEnable:Z

    .line 87
    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    .line 89
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    .line 90
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    const-string v2, "uniwebview"

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 92
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 93
    .local v0, "window":Landroid/view/Window;
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 94
    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 95
    invoke-virtual {v0, v4}, Landroid/view/Window;->setSoftInputMode(I)V

    .line 97
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v1, v4, :cond_0

    .line 98
    const/16 v1, 0x400

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 103
    :goto_0
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->createContent()V

    .line 104
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->createWebView()V

    .line 105
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->createSpinner()V

    .line 107
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_content:Landroid/widget/FrameLayout;

    .line 108
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v2, v3, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 107
    invoke-virtual {p0, v1, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 109
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_content:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 110
    const-string v1, "UniWebView"

    const-string v2, "Create a new UniWebView Dialog"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    return-void

    .line 100
    :cond_0
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->HideSystemUI()V

    goto :goto_0
.end method

.method static synthetic access$0(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Z
    .locals 1

    .prologue
    .line 56
    iget-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_showSpinnerWhenLoading:Z

    return v0
.end method

.method static synthetic access$1(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V
    .locals 0

    .prologue
    .line 311
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->showSpinner()V

    return-void
.end method

.method static synthetic access$10(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 61
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$2(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Z)V
    .locals 0

    .prologue
    .line 58
    iput-boolean p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_isLoading:Z

    return-void
.end method

.method static synthetic access$3(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;
    .locals 1

    .prologue
    .line 55
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    return-object v0
.end method

.method static synthetic access$4(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Landroid/app/ProgressDialog;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    return-object v0
.end method

.method static synthetic access$5(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 62
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_currentUrl:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$6(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    return-object v0
.end method

.method static synthetic access$7(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 66
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_currentUserAgent:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$8(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)Z
    .locals 1

    .prologue
    .line 63
    iget-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_transparent:Z

    return v0
.end method

.method static synthetic access$9(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/app/AlertDialog;)V
    .locals 0

    .prologue
    .line 61
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    return-void
.end method

.method private createContent()V
    .locals 2

    .prologue
    .line 326
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_content:Landroid/widget/FrameLayout;

    .line 327
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_content:Landroid/widget/FrameLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 328
    return-void
.end method

.method private createSpinner()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 331
    new-instance v0, Landroid/app/ProgressDialog;

    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    .line 332
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    .line 333
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->requestWindowFeature(I)Z

    .line 334
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinnerText:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 335
    return-void
.end method

.method private createWebView()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 338
    new-instance v2, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    .line 340
    new-instance v1, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$2;

    invoke-direct {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$2;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    .line 387
    .local v1, "webClient":Landroid/webkit/WebViewClient;
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v2, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 389
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_content:Landroid/widget/FrameLayout;

    invoke-direct {v0, p0, v2}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$3;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/widget/FrameLayout;)V

    .line 519
    .local v0, "chromeClient":Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebChromeClient;
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v2, v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 521
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    new-instance v3, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$4;

    invoke-direct {v3, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$4;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    invoke-virtual {v2, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setDownloadListener(Landroid/webkit/DownloadListener;)V

    .line 531
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v2, v4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setVisibility(I)V

    .line 533
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const-string v3, "android"

    invoke-virtual {v2, p0, v3}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 535
    invoke-virtual {p0, v4}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->setBounces(Z)V

    .line 536
    return-void
.end method

.method private showDialog()V
    .locals 3

    .prologue
    const/16 v2, 0x8

    .line 231
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    .line 232
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2, v2}, Landroid/view/Window;->setFlags(II)V

    .line 233
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->show()V

    .line 234
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 235
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    .line 234
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 236
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->clearFlags(I)V

    .line 240
    :goto_0
    return-void

    .line 238
    :cond_0
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->show()V

    goto :goto_0
.end method

.method private showSpinner()V
    .locals 3

    .prologue
    const/16 v2, 0x8

    .line 312
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    .line 313
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2, v2}, Landroid/view/Window;->setFlags(II)V

    .line 315
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    .line 317
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 318
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    .line 317
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 319
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->clearFlags(I)V

    .line 323
    :goto_0
    return-void

    .line 321
    :cond_0
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    goto :goto_0
.end method


# virtual methods
.method public HideSystemUI()V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    const/16 v6, 0x13

    .line 115
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x10

    if-lt v4, v5, :cond_0

    .line 116
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 118
    .local v0, "decorView":Landroid/view/View;
    const/4 v2, 0x0

    .line 120
    .local v2, "uiOptions":I
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v4, v6, :cond_1

    .line 121
    const/16 v2, 0xf06

    .line 130
    :goto_0
    invoke-virtual {v0, v2}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 132
    const/4 v3, 0x0

    .line 134
    .local v3, "updatedUIOptions":I
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v4, v6, :cond_2

    .line 135
    const/16 v3, 0x1706

    .line 145
    :goto_1
    move v1, v3

    .line 146
    .local v1, "finalUiOptions":I
    new-instance v4, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;

    invoke-direct {v4, p0, v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;-><init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/view/View;I)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setOnSystemUiVisibilityChangeListener(Landroid/view/View$OnSystemUiVisibilityChangeListener;)V

    .line 153
    .end local v0    # "decorView":Landroid/view/View;
    .end local v1    # "finalUiOptions":I
    .end local v2    # "uiOptions":I
    .end local v3    # "updatedUIOptions":I
    :cond_0
    return-void

    .line 128
    .restart local v0    # "decorView":Landroid/view/View;
    .restart local v2    # "uiOptions":I
    :cond_1
    const/4 v2, 0x4

    goto :goto_0

    .line 142
    .restart local v3    # "updatedUIOptions":I
    :cond_2
    const/4 v3, 0x4

    goto :goto_1
.end method

.method public addJs(Ljava/lang/String;)V
    .locals 4
    .param p1, "js"    # Ljava/lang/String;

    .prologue
    .line 169
    if-nez p1, :cond_0

    .line 170
    const-string v1, "UniWebView"

    const-string v2, "Trying to add a null js. Abort."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    :goto_0
    return-void

    .line 174
    :cond_0
    const-string v1, "javascript:%s"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 175
    .local v0, "requestString":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->load(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public addUrlScheme(Ljava/lang/String;)V
    .locals 1
    .param p1, "scheme"    # Ljava/lang/String;

    .prologue
    .line 602
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 603
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 605
    :cond_0
    return-void
.end method

.method public changeSize(IIII)V
    .locals 0
    .param p1, "top"    # I
    .param p2, "left"    # I
    .param p3, "bottom"    # I
    .param p4, "right"    # I

    .prologue
    .line 156
    iput p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_top:I

    .line 157
    iput p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_left:I

    .line 158
    iput p3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_bottom:I

    .line 159
    iput p4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_right:I

    .line 160
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->updateContentSize()V

    .line 161
    return-void
.end method

.method public cleanCache()V
    .locals 2

    .prologue
    .line 199
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->clearCache(Z)V

    .line 200
    return-void
.end method

.method public destroy()V
    .locals 2

    .prologue
    .line 221
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const-string v1, "about:blank"

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->loadUrl(Ljava/lang/String;)V

    .line 222
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->removeShowingWebViewDialog(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    .line 223
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->dismiss()V

    .line 224
    return-void
.end method

.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 574
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_currentUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getUserAgent()Ljava/lang/String;
    .locals 1

    .prologue
    .line 622
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_currentUserAgent:Ljava/lang/String;

    return-object v0
.end method

.method public goBack()Z
    .locals 1

    .prologue
    .line 203
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->canGoBack()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 204
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->goBack()V

    .line 205
    const/4 v0, 0x1

    .line 207
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public goBackGround()V
    .locals 1

    .prologue
    .line 545
    iget-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_isLoading:Z

    if-eqz v0, :cond_0

    .line 546
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_loadingInterrupted:Z

    .line 547
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->stopLoading()V

    .line 549
    :cond_0
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_1

    .line 550
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->hide()V

    .line 552
    :cond_1
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->hide()V

    .line 553
    return-void
.end method

.method public goForeGround()V
    .locals 1

    .prologue
    .line 556
    iget-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_manualHide:Z

    if-nez v0, :cond_1

    .line 557
    iget-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_loadingInterrupted:Z

    if-eqz v0, :cond_0

    .line 558
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->reload()V

    .line 559
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_loadingInterrupted:Z

    .line 561
    :cond_0
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->show()V

    .line 562
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_1

    .line 563
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_alertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 566
    :cond_1
    return-void
.end method

.method public goForward()Z
    .locals 1

    .prologue
    .line 212
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->canGoForward()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 213
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->goForward()V

    .line 214
    const/4 v0, 0x1

    .line 216
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public load(Ljava/lang/String;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 164
    const-string v0, "UniWebView"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 165
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->loadUrl(Ljava/lang/String;)V

    .line 166
    return-void
.end method

.method public loadHTMLString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "html"    # Ljava/lang/String;
    .param p2, "baseURL"    # Ljava/lang/String;

    .prologue
    .line 195
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const-string v3, "text/html"

    const-string v4, "UTF-8"

    const/4 v5, 0x0

    move-object v1, p2

    move-object v2, p1

    invoke-virtual/range {v0 .. v5}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 196
    return-void
.end method

.method public loadJS(Ljava/lang/String;)V
    .locals 5
    .param p1, "js"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 179
    if-nez p1, :cond_0

    .line 180
    const-string v2, "UniWebView"

    const-string v3, "Trying to eval a null js. Abort."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 192
    :goto_0
    return-void

    .line 184
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 186
    .local v0, "jsReformat":Ljava/lang/String;
    :goto_1
    const-string v2, ";"

    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 190
    :cond_1
    const-string v2, "javascript:android.onData(%s)"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    aput-object v0, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 191
    .local v1, "requestString":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->load(Ljava/lang/String;)V

    goto :goto_0

    .line 187
    .end local v1    # "requestString":Ljava/lang/String;
    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public onData(Ljava/lang/String;)V
    .locals 3
    .param p1, "value"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    .line 540
    const-string v0, "UniWebView"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "receive a call back from js: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 541
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    invoke-interface {v0, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;->onJavaScriptFinished(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Ljava/lang/String;)V

    .line 542
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 4
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v0, 0x1

    .line 70
    const-string v1, "UniWebView"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "onKeyDown "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    invoke-interface {v1, p0, p1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;->onDialogKeyDown(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;I)V

    .line 72
    const/4 v1, 0x4

    if-ne p1, v1, :cond_2

    .line 73
    iget-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_backButtonEnable:Z

    if-nez v1, :cond_1

    .line 80
    :cond_0
    :goto_0
    return v0

    .line 75
    :cond_1
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->goBack()Z

    move-result v1

    if-nez v1, :cond_0

    .line 76
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    invoke-interface {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;->onDialogShouldCloseByBackButton(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    goto :goto_0

    .line 80
    :cond_2
    invoke-super {p0, p1, p2}, Landroid/app/Dialog;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method protected onStop()V
    .locals 1

    .prologue
    .line 227
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_listener:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;

    invoke-interface {v0, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$DialogListener;->onDialogClose(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    .line 228
    return-void
.end method

.method public reload()V
    .locals 1

    .prologue
    .line 598
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->reload()V

    .line 599
    return-void
.end method

.method public removeUrlScheme(Ljava/lang/String;)V
    .locals 1
    .param p1, "scheme"    # Ljava/lang/String;

    .prologue
    .line 608
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 609
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->schemes:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 611
    :cond_0
    return-void
.end method

.method public setBackButtonEnable(Z)V
    .locals 0
    .param p1, "enable"    # Z

    .prologue
    .line 578
    iput-boolean p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_backButtonEnable:Z

    .line 579
    return-void
.end method

.method public setBounces(Z)V
    .locals 2
    .param p1, "enable"    # Z

    .prologue
    .line 582
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x8

    if-gt v0, v1, :cond_0

    .line 583
    const-string v0, "UniWebView"

    const-string v1, "WebView over scroll effect supports after API 9"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 591
    :goto_0
    return-void

    .line 585
    :cond_0
    if-eqz p1, :cond_1

    .line 586
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setOverScrollMode(I)V

    goto :goto_0

    .line 588
    :cond_1
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->setOverScrollMode(I)V

    goto :goto_0
.end method

.method public setShow(Z)V
    .locals 4
    .param p1, "show"    # Z

    .prologue
    const/4 v3, 0x0

    .line 243
    if-eqz p1, :cond_1

    .line 244
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->showDialog()V

    .line 245
    iget-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_showSpinnerWhenLoading:Z

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_isLoading:Z

    if-eqz v1, :cond_0

    .line 246
    invoke-direct {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->showSpinner()V

    .line 248
    :cond_0
    invoke-static {}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->addShowingWebViewDialog(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V

    .line 249
    iput-boolean v3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_manualHide:Z

    .line 257
    :goto_0
    return-void

    .line 251
    :cond_1
    sget-object v1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 252
    .local v0, "imm":Landroid/view/inputmethod/InputMethodManager;
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    invoke-virtual {v0, v1, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 253
    iget-object v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v1}, Landroid/app/ProgressDialog;->hide()V

    .line 254
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->hide()V

    .line 255
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_manualHide:Z

    goto :goto_0
.end method

.method public setSpinnerShowWhenLoading(Z)V
    .locals 0
    .param p1, "showSpinnerWhenLoading"    # Z

    .prologue
    .line 299
    iput-boolean p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_showSpinnerWhenLoading:Z

    .line 300
    return-void
.end method

.method public setSpinnerText(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 303
    if-eqz p1, :cond_0

    .line 304
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinnerText:Ljava/lang/String;

    .line 308
    :goto_0
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinner:Landroid/app/ProgressDialog;

    invoke-virtual {v0, p1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 309
    return-void

    .line 306
    :cond_0
    const-string v0, ""

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_spinnerText:Ljava/lang/String;

    goto :goto_0
.end method

.method public setTransparent(Z)V
    .locals 2
    .param p1, "transparent"    # Z

    .prologue
    .line 569
    iput-boolean p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_transparent:Z

    .line 570
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    iget-boolean v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_transparent:Z

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->updateTransparent(Z)V

    .line 571
    return-void
.end method

.method public setZoomEnable(Z)V
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    .line 594
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 595
    return-void
.end method

.method public stop()V
    .locals 1

    .prologue
    .line 614
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->stopLoading()V

    .line 615
    return-void
.end method

.method public updateContentSize()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 260
    invoke-virtual {p0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->getWindow()Landroid/view/Window;

    move-result-object v5

    .line 261
    .local v5, "window":Landroid/view/Window;
    invoke-virtual {v5}, Landroid/view/Window;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v6

    invoke-interface {v6}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 265
    .local v0, "display":Landroid/view/Display;
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0x13

    if-lt v6, v7, :cond_1

    .line 266
    new-instance v3, Landroid/graphics/Point;

    invoke-direct {v3}, Landroid/graphics/Point;-><init>()V

    .line 267
    .local v3, "size":Landroid/graphics/Point;
    invoke-virtual {v0, v3}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 268
    iget v4, v3, Landroid/graphics/Point;->x:I

    .line 269
    .local v4, "width":I
    iget v1, v3, Landroid/graphics/Point;->y:I

    .line 280
    .end local v3    # "size":Landroid/graphics/Point;
    .local v1, "height":I
    :goto_0
    iget v6, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_left:I

    sub-int v6, v4, v6

    iget v7, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_right:I

    sub-int/2addr v6, v7

    invoke-static {v8, v6}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 281
    iget v6, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_top:I

    sub-int v6, v1, v6

    iget v7, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_bottom:I

    sub-int/2addr v6, v7

    invoke-static {v8, v6}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 283
    if-eqz v4, :cond_0

    if-nez v1, :cond_3

    .line 284
    :cond_0
    const-string v6, "UniWebView"

    const-string v7, "The inset is lager then screen size. Webview will not show. Please check your insets setting."

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    :goto_1
    return-void

    .line 270
    .end local v1    # "height":I
    .end local v4    # "width":I
    :cond_1
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0xd

    if-lt v6, v7, :cond_2

    .line 271
    new-instance v3, Landroid/graphics/Point;

    invoke-direct {v3}, Landroid/graphics/Point;-><init>()V

    .line 272
    .restart local v3    # "size":Landroid/graphics/Point;
    invoke-virtual {v0, v3}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    .line 273
    iget v4, v3, Landroid/graphics/Point;->x:I

    .line 274
    .restart local v4    # "width":I
    iget v1, v3, Landroid/graphics/Point;->y:I

    .line 275
    .restart local v1    # "height":I
    goto :goto_0

    .line 276
    .end local v1    # "height":I
    .end local v3    # "size":Landroid/graphics/Point;
    .end local v4    # "width":I
    :cond_2
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v4

    .line 277
    .restart local v4    # "width":I
    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v1

    .restart local v1    # "height":I
    goto :goto_0

    .line 288
    :cond_3
    invoke-virtual {v5, v4, v1}, Landroid/view/Window;->setLayout(II)V

    .line 290
    invoke-virtual {v5}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    .line 291
    .local v2, "layoutParam":Landroid/view/WindowManager$LayoutParams;
    const/16 v6, 0x33

    iput v6, v2, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 292
    iget v6, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_left:I

    iput v6, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 293
    iget v6, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_top:I

    iput v6, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 295
    invoke-virtual {v5, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    goto :goto_1
.end method

.method public useWideViewPort(Z)V
    .locals 1
    .param p1, "use"    # Z

    .prologue
    .line 618
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->_uniWebView:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;

    invoke-virtual {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    .line 619
    return-void
.end method
