.class final Lcom/payeco/android/plugin/u;
.super Landroid/webkit/WebViewClient;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "NewApi"
    }
.end annotation


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/u;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/u;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    return-void
.end method


# virtual methods
.method public final onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 3

    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "var funcs=[]; \r\nvar index=0;\r\nvar WebViewJavascriptBridge={};\r\nWebViewJavascriptBridge.callHandler=function(handleName,data,callback){\r\n\tindex++; \r\n\tfuncs[index] = callback;\r\n\tmybridge.callHandler(handleName,JSON.stringify(data),index+\'\');\r\n}\r\nWebViewJavascriptBridge.syn=function(handleName,data){\r\n\tif(data==undefined){\r\n\t\treturn JSON.parse(mybridge.syn(handleName));\r\n\t}else if(typeof(data)==\'object\'){\r\n\t\treturn JSON.parse(mybridge.syn(handleName,JSON.stringify(data)));\r\n\t}else{\r\n\t\treturn JSON.parse(mybridge.syn(handleName,data));\r\n\t}\r\n}\r\nfuncs[1000000+\"\"] = function(errCode, errMsg,fileName,data){\r\n\t$(\"#previewPic\").attr(\"src\",data);\r\n}\r\nif(onPluginStart && typeof(onPluginStart)==\'function\'){\r\n\tonPluginStart();\r\n}\r\n"

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x13

    if-lt v1, v2, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "javascript:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/payeco/android/plugin/v;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/v;-><init>(Lcom/payeco/android/plugin/u;)V

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :goto_0
    iget-object v0, p0, Lcom/payeco/android/plugin/u;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->f(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/u;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    :cond_0
    return-void

    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "javascript:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 3

    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/u;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/u;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u6b63\u5728\u52a0\u8f7d\u9875\u9762..."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/d/aa;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    :cond_0
    return-void
.end method

.method public final onReceivedSslError(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V
    .locals 0

    invoke-virtual {p2}, Landroid/webkit/SslErrorHandler;->proceed()V

    return-void
.end method

.method public final shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 2

    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0x12

    if-le v0, v1, :cond_0

    const-string v0, "javascript:"

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/payeco/android/plugin/w;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/w;-><init>(Lcom/payeco/android/plugin/u;)V

    invoke-virtual {p1, p2, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :goto_0
    const/4 v0, 0x0

    return v0

    :cond_0
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_0
.end method
