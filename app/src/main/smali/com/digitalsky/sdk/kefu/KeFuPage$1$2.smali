.class Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;
.super Landroid/webkit/WebViewClient;
.source "KeFuPage.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/kefu/KeFuPage$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field dialog:Landroid/app/ProgressDialog;

.field final synthetic this$1:Lcom/digitalsky/sdk/kefu/KeFuPage$1;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/kefu/KeFuPage$1;)V
    .locals 2

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->this$1:Lcom/digitalsky/sdk/kefu/KeFuPage$1;

    .line 149
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    .line 151
    new-instance v0, Landroid/app/ProgressDialog;

    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$1()Landroid/app/Activity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 162
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$7()Ljava/lang/String;

    move-result-object v0

    const-string v1, "web onPageFinished"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 163
    iget-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    .line 164
    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 3
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "favicon"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v2, 0x0

    .line 180
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$7()Ljava/lang/String;

    move-result-object v0

    const-string v1, "web onPageStarted"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    iget-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    .line 182
    iget-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    .line 183
    iget-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    const-string v1, "Loading ......"

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 184
    iget-object v0, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$2;->dialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    .line 185
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 174
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$7()Ljava/lang/String;

    move-result-object v0

    const-string v1, "web onReceivedError"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 175
    return-void
.end method

.method public onScaleChanged(Landroid/webkit/WebView;FF)V
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "oldScale"    # F
    .param p3, "newScale"    # F

    .prologue
    .line 168
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$7()Ljava/lang/String;

    move-result-object v0

    const-string v1, "web onScaleChanged"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 169
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 155
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$7()Ljava/lang/String;

    move-result-object v0

    const-string v1, "web shouldOverrideUrlLoading"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 157
    const/4 v0, 0x1

    return v0
.end method
