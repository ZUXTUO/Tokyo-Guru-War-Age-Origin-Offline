.class public Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;
.super Landroid/app/Activity;


# instance fields
.field public a:Z

.field public b:Z

.field c:Lcom/baidu/location/LocationClient;

.field private final d:I

.field private final e:I

.field private final f:I

.field private g:Landroid/widget/LinearLayout;

.field private h:Landroid/webkit/WebView;

.field private i:Lcom/payeco/android/plugin/js/JsBridge;

.field private j:Lcom/payeco/android/plugin/js/JsFunction;

.field private k:Z

.field private l:Ljava/lang/String;

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/String;

.field private o:Ljava/lang/String;

.field private p:Ljava/lang/String;

.field private q:Ljava/lang/String;

.field private r:Ljava/lang/String;

.field private s:Lcom/payeco/android/plugin/http/comm/Http;

.field private t:Landroid/content/BroadcastReceiver;

.field private u:Landroid/content/ContentResolver;

.field private v:Landroid/database/ContentObserver;

.field private w:Ljava/lang/String;

.field private x:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const/16 v0, 0x65

    iput v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->d:I

    const/16 v0, 0x66

    iput v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->e:I

    const/16 v0, 0x67

    iput v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->f:I

    iput-boolean v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    iput-boolean v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b:Z

    const-string v0, "por"

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->q:Ljava/lang/String;

    new-instance v0, Lcom/payeco/android/plugin/s;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/payeco/android/plugin/s;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->v:Landroid/database/ContentObserver;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->s:Lcom/payeco/android/plugin/http/comm/Http;

    return-object v0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Z)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 3

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "\u63d0\u793a"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "\u786e\u5b9a"

    new-instance v2, Lcom/payeco/android/plugin/j;

    invoke-direct {v2, p0}, Lcom/payeco/android/plugin/j;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SimpleDateFormat"
        }
    .end annotation

    const/4 v2, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    if-eqz p3, :cond_2

    const-string v0, "payeco"

    const-string v1, "\u9519\u8bef\u7801:%s,\u9519\u8bef\u6d88\u606f:%s"

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p1, v2, v3

    aput-object p2, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v0, "errCode"

    invoke-virtual {v1, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v0, "errMsg"

    invoke-virtual {v1, v0, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v0, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "errTime"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    if-eqz p3, :cond_0

    const-string v0, "errDetail"

    invoke-virtual {p3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v2

    const-string v3, "ErrorInfo"

    invoke-static {v0, v2, v3}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    if-eqz v2, :cond_1

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    :cond_1
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v2

    const-string v3, "ErrorInfo"

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v2, v3, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    return-void

    :cond_2
    const-string v0, "payeco"

    const-string v1, "\u9519\u8bef\u7801:%s,\u9519\u8bef\u6d88\u606f:%s"

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p1, v2, v3

    aput-object p2, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v0, "payeco"

    const-string v1, "\u8bb0\u5f55\u9519\u8bef\u4fe1\u606f\u51fa\u9519\uff01"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "\u8bb0\u5f55\u9519\u8bef\u4fe1\u606f\u51fa\u9519\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private a(Z)V
    .locals 4

    new-instance v0, Lcom/payeco/android/plugin/http/biz/PluginInit;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/biz/PluginInit;-><init>()V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/biz/PluginInit;->setUpPayReq(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/biz/PluginInit;->setMerchOrderId(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Lcom/payeco/android/plugin/http/biz/PluginInit;->setContext(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/PluginInit;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    invoke-virtual {v2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v2

    invoke-virtual {v2}, Landroid/webkit/WebSettings;->getUserAgentString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/payeco/android/plugin/http/comm/Http;->setUserAgent(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/PluginInit;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    invoke-virtual {v0, p1}, Lcom/payeco/android/plugin/http/biz/PluginInit;->getHttpParams(Z)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/payeco/android/plugin/http/comm/Http;->setHttpParams(Ljava/util/List;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/PluginInit;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    iput-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->s:Lcom/payeco/android/plugin/http/comm/Http;

    new-instance v1, Lcom/payeco/android/plugin/http/comm/HttpComm;

    invoke-direct {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;-><init>()V

    new-instance v2, Lcom/payeco/android/plugin/x;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/payeco/android/plugin/x;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V

    invoke-virtual {v1, v2}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpCallBack(Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpEntity(Lcom/payeco/android/plugin/http/itf/IHttpEntity;)V

    new-instance v0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;-><init>()V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpExecute(Lcom/payeco/android/plugin/http/itf/IHttpExecute;)V

    invoke-virtual {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;->request()V

    return-void
.end method

.method private a()Z
    .locals 6

    const/4 v0, 0x1

    const/4 v1, 0x0

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initViews ..."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initWebView ..."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    const/4 v5, -0x1

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x106000b

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    new-instance v2, Landroid/webkit/WebView;

    invoke-direct {v2, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xe

    if-lt v2, v3, :cond_0

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setFitsSystemWindows(Z)V

    :cond_0
    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    const/4 v5, -0x1

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setHorizontalScrollBarEnabled(Z)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setScrollBarStyle(I)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    const/16 v3, 0x82

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->requestFocus(I)Z

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    new-instance v3, Lcom/payeco/android/plugin/h;

    invoke-direct {v3, p0}, Lcom/payeco/android/plugin/h;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->setContentView(Landroid/view/View;)V

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initWebView ok."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initJsBridge ..."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Lcom/payeco/android/plugin/m;

    invoke-direct {v2, p0, p0}, Lcom/payeco/android/plugin/m;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/content/Context;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->j:Lcom/payeco/android/plugin/js/JsFunction;

    new-instance v2, Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    invoke-direct {v2, p0, v3}, Lcom/payeco/android/plugin/js/JsBridge;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->j:Lcom/payeco/android/plugin/js/JsFunction;

    invoke-virtual {v2, v3}, Lcom/payeco/android/plugin/js/JsBridge;->setJsFunction(Lcom/payeco/android/plugin/js/JsFunction;)V

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initJsBridge ok."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initViews ok."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -initViews error."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v2, "1001"

    const-string v3, "\u521d\u59cb\u5316\u754c\u9762\u5931\u8d25\uff01"

    invoke-direct {p0, v2, v3, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string v0, "\u63d2\u4ef6\u521d\u59cb\u5316\u5931\u8d25[1001]\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0
.end method

.method private a(Landroid/os/Bundle;)Z
    .locals 8

    const/4 v1, 0x1

    const/4 v2, 0x0

    const-string v0, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -checkError ..."

    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p1, :cond_0

    const-string v0, "payeco"

    const-string v2, "PayecoPluginLoadingActivity -checkError ok."

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    :goto_0
    return v0

    :cond_0
    const-string v0, "ClientErrOutTime"

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const/16 v0, 0x1e

    :try_start_0
    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_1
    mul-int/lit8 v3, v0, 0x3c

    mul-int/lit16 v3, v3, 0x3e8

    new-instance v4, Ljava/util/Date;

    invoke-direct {v4}, Ljava/util/Date;-><init>()V

    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    const-string v6, "saveStateTime"

    invoke-virtual {p1, v6}, Landroid/os/Bundle;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    sub-long/2addr v4, v6

    int-to-long v6, v3

    cmp-long v3, v4, v6

    if-lez v3, :cond_1

    const-string v3, "1201"

    const-string v4, "\u63d2\u4ef6\u5185\u5b58\u88ab\u9500\u6bc1\u8d85\u8fc7%d\u5206\u949f\uff01"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v1, v2

    invoke-static {v4, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v3, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->finish()V

    move v0, v2

    goto :goto_0

    :cond_1
    const-string v0, "upPayReq"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l:Ljava/lang/String;

    const-string v0, "merchOrderId"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;

    const-string v0, "broadcast"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->m:Ljava/lang/String;

    const-string v0, "env"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n:Ljava/lang/String;

    const-string v0, "dev_ip"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->o:Ljava/lang/String;

    const-string v0, "dev_port"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->p:Ljava/lang/String;

    const-string v0, "commDesKey"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/g;->e(Ljava/lang/String;)V

    const-string v0, "\u6b63\u5728\u67e5\u5355..."

    invoke-static {p0, v0, v1}, Lcom/payeco/android/plugin/d/aa;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n:Ljava/lang/String;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->o:Ljava/lang/String;

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->p:Ljava/lang/String;

    invoke-static {v0, v1, v3}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b()Z

    move-result v0

    if-nez v0, :cond_2

    move v0, v2

    goto/16 :goto_0

    :cond_2
    new-instance v0, Lcom/payeco/android/plugin/http/biz/OrderQuery;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/biz/OrderQuery;-><init>()V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/biz/OrderQuery;->setUpPayReq(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/biz/OrderQuery;->setMerchOrderId(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/OrderQuery;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/OrderQuery;->getHttpParams()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/payeco/android/plugin/http/comm/Http;->setHttpParams(Ljava/util/List;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/OrderQuery;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->s:Lcom/payeco/android/plugin/http/comm/Http;

    invoke-virtual {v3}, Lcom/payeco/android/plugin/http/comm/Http;->getCookieStore()Lorg/apache/http/client/CookieStore;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/payeco/android/plugin/http/comm/Http;->setCookieStore(Lorg/apache/http/client/CookieStore;)V

    new-instance v1, Lcom/payeco/android/plugin/http/comm/HttpComm;

    invoke-direct {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;-><init>()V

    new-instance v3, Lcom/payeco/android/plugin/y;

    invoke-direct {v3, p0, v2}, Lcom/payeco/android/plugin/y;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V

    invoke-virtual {v1, v3}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpCallBack(Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpEntity(Lcom/payeco/android/plugin/http/itf/IHttpEntity;)V

    new-instance v0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;-><init>()V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpExecute(Lcom/payeco/android/plugin/http/itf/IHttpExecute;)V

    invoke-virtual {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;->request()V

    move v0, v2

    goto/16 :goto_0

    :catch_0
    move-exception v3

    goto/16 :goto_1
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/util/List;Ljava/lang/String;)Z
    .locals 1

    invoke-direct {p0, p1, p2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/util/List;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private a(Ljava/util/List;Ljava/lang/String;)Z
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    invoke-virtual {p0, p2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, p2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->shouldShowRequestPermissionRationale(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    new-instance v1, Lcom/payeco/android/plugin/i;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/i;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    new-instance v1, Lcom/payeco/android/plugin/u;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/payeco/android/plugin/u;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    const-string v2, "mybridge"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    const-string v1, "searchBoxJavaBredge_"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->w:Ljava/lang/String;

    return-void
.end method

.method private b()Z
    .locals 4

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -initApp ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "payeco_plugin_keys.js"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "payeco_plugin_key_md5"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "payeco_plugin_config.js"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1}, Lcom/payeco/android/plugin/b/g;->b(Ljava/lang/String;)V

    invoke-static {v2}, Lcom/payeco/android/plugin/b/g;->d(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/payeco/android/plugin/b/g;->c(Ljava/lang/String;)V

    invoke-static {p0}, Lcom/payeco/android/plugin/b/h;->b(Landroid/content/Context;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "{\"ClientErrOutTime\":\"30\",\"SmsNumber\":\"1252015014126587,\",\"IsFetchSms\":\"1\",\"SoundTime\":\"10\",\"LbsTime\":\"3000\",\"SmsPattern\":\"\u9a8c\u8bc1\u7801:(\\\\d+)\",\"PhotoSize\":\"500\"}"

    const-string v2, "utf-8"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    :goto_0
    new-instance v1, Lorg/json/JSONObject;

    new-instance v2, Ljava/lang/String;

    const-string v3, "utf-8"

    invoke-direct {v2, v0, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Lcom/payeco/android/plugin/b/g;->a(Lorg/json/JSONObject;)V

    invoke-static {p0}, Lcom/payeco/android/plugin/b/h;->a(Landroid/content/Context;)V

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -initApp ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    :goto_1
    return v0

    :cond_1
    invoke-static {v1}, Lcom/payeco/android/plugin/c/b;->b(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoPluginLoadingActivity -initApp error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v1, "1002"

    const-string v2, "\u521d\u59cb\u5316\u53c2\u6570\u5931\u8d25\uff01"

    invoke-direct {p0, v1, v2, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string v0, "\u63d2\u4ef6\u521d\u59cb\u5316\u5931\u8d25[1002]\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    const/4 v0, 0x0

    goto :goto_1
.end method

.method static synthetic c(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/webkit/WebView;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h:Landroid/webkit/WebView;

    return-object v0
.end method

.method static synthetic c(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->x:Ljava/lang/String;

    return-void
.end method

.method private c()Z
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x0

    const-string v2, "payeco"

    const-string v3, "PayecoPluginLoadingActivity -checkReqString ..."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v3

    if-nez v3, :cond_0

    const-string v2, "1202"

    const-string v3, "Intent.getExtras()\u4e3a\u7a7a\uff01"

    invoke-direct {p0, v2, v3, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string v0, "\u63d2\u4ef6\u521d\u59cb\u5316\u5931\u8d25[1202]\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    :goto_0
    return v0

    :cond_0
    const-string v2, "upPay.Req"

    invoke-virtual {v3, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v2, "Broadcast"

    invoke-virtual {v3, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v2, "Environment"

    invoke-virtual {v3, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v4, :cond_1

    const-string v0, "payeco"

    const-string v2, "checkReqString upPay.Req == null."

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "\u672a\u63d0\u4ea4\u53c2\u6570upPay.Req\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_1
    if-nez v2, :cond_2

    const-string v0, "payeco"

    const-string v2, "checkReqString Environment == null."

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "\u672a\u63d0\u4ea4\u53c2\u6570Environment\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_2
    const-string v6, "0[012]"

    invoke-virtual {v2, v6}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    const-string v0, "payeco"

    const-string v2, "checkReqString Environment \u4e0d\u662f 00,01,02"

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "\u63d0\u4ea4\u53c2\u6570Environment\u503c\u4e0d\u6b63\u786e\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_3
    if-nez v5, :cond_4

    const-string v0, "payeco"

    const-string v2, "checkReqString Broadcast == null."

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "\u672a\u63d0\u4ea4\u53c2\u6570Broadcast\uff01"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_4
    const-string v1, "02"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    const-string v1, "dev_ip"

    invoke-virtual {v3, v1}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "dev_port"

    invoke-virtual {v3, v1}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_7

    :cond_5
    const-string v1, "00"

    move-object v2, v1

    move-object v1, v0

    :goto_1
    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    invoke-static {v2, v1, v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    const-string v6, "{"

    invoke-virtual {v3, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v6, "MerchOrderId"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    :cond_6
    :goto_2
    iput-object v4, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l:Ljava/lang/String;

    iput-object v5, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->m:Ljava/lang/String;

    iput-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n:Ljava/lang/String;

    iput-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->o:Ljava/lang/String;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->p:Ljava/lang/String;

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -checkReqString ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    goto/16 :goto_0

    :cond_7
    const-string v0, "dev_ip"

    invoke-virtual {v3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v0, "dev_port"

    invoke-virtual {v3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_8
    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    const-string v6, "<"

    invoke-virtual {v3, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    :try_start_1
    invoke-static {v4}, Lcom/payeco/android/plugin/c/a/c;->a(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/b;

    move-result-object v3

    const-string v6, "merchantOrderId"

    invoke-static {v3, v6}, Lcom/payeco/android/plugin/c/a/c;->a(Lcom/payeco/android/plugin/c/a/b;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v3

    goto :goto_2

    :catch_1
    move-exception v3

    goto :goto_2

    :cond_9
    move-object v1, v0

    goto :goto_1
.end method

.method private d()V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/payeco/android/plugin/l;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/l;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    new-instance v0, Lcom/baidu/location/LocationClient;

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/baidu/location/LocationClient;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    new-instance v1, Lcom/payeco/android/plugin/k;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/k;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-virtual {v0, v1}, Lcom/baidu/location/LocationClient;->registerLocationListener(Lcom/baidu/location/BDLocationListener;)V

    new-instance v0, Lcom/baidu/location/LocationClientOption;

    invoke-direct {v0}, Lcom/baidu/location/LocationClientOption;-><init>()V

    sget-object v1, Lcom/baidu/location/LocationClientOption$LocationMode;->Hight_Accuracy:Lcom/baidu/location/LocationClientOption$LocationMode;

    invoke-virtual {v0, v1}, Lcom/baidu/location/LocationClientOption;->setLocationMode(Lcom/baidu/location/LocationClientOption$LocationMode;)V

    const-string v1, "gcj02"

    invoke-virtual {v0, v1}, Lcom/baidu/location/LocationClientOption;->setCoorType(Ljava/lang/String;)V

    const v1, 0x493e0

    invoke-virtual {v0, v1}, Lcom/baidu/location/LocationClientOption;->setScanSpan(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/baidu/location/LocationClientOption;->setIsNeedAddress(Z)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    invoke-virtual {v1, v0}, Lcom/baidu/location/LocationClient;->setLocOption(Lcom/baidu/location/LocationClientOption;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    invoke-virtual {v0}, Lcom/baidu/location/LocationClient;->start()V

    return-void
.end method

.method static synthetic d(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->d()V

    return-void
.end method

.method static synthetic d(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    .locals 4

    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k:Z

    if-eqz v0, :cond_0

    const-string v0, "SmsPattern"

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    :try_start_0
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    const-string v2, "receiveSMS"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v0, v3}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethod(Ljava/lang/String;Ljava/lang/Object;Lcom/payeco/android/plugin/js/JsCallBack;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    const-string v0, "payeco"

    const-string v1, "\u586b\u5145\u77ed\u4fe1\u5931\u8d25!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private e()V
    .locals 6

    const/4 v5, 0x1

    const/4 v4, 0x0

    :try_start_0
    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0xb

    if-le v0, v1, :cond_1

    const/16 v1, 0xf

    if-ne v0, v1, :cond_0

    const-string v0, "HTC S710d"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const-string v1, "output"

    new-instance v2, Ljava/io/File;

    sget-object v3, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :goto_0
    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/payeco/android/plugin/PayecoCameraActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "\u65e0\u6cd5\u5f00\u542f\u76f8\u673a\uff01"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->w:Ljava/lang/String;

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    const-string v3, "\u65e0\u6cd5\u5f00\u542f\u76f8\u673a\uff01"

    aput-object v3, v2, v5

    const/4 v3, 0x2

    const-string v4, ""

    aput-object v4, v2, v3

    const/4 v3, 0x3

    const-string v4, ""

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_1
    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const-string v1, "output"

    new-instance v2, Ljava/io/File;

    sget-object v3, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Z
    .locals 1

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a()Z

    move-result v0

    return v0
.end method

.method static synthetic f(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k:Z

    return-void
.end method

.method static synthetic g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    return-object v0
.end method

.method static synthetic h(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 2

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -reload ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Z)V

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -reload ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method static synthetic i(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 3

    new-instance v0, Lcom/payeco/android/plugin/http/biz/ExitSession;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/biz/ExitSession;-><init>()V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/biz/ExitSession;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->s:Lcom/payeco/android/plugin/http/comm/Http;

    invoke-virtual {v2}, Lcom/payeco/android/plugin/http/comm/Http;->getCookieStore()Lorg/apache/http/client/CookieStore;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/payeco/android/plugin/http/comm/Http;->setCookieStore(Lorg/apache/http/client/CookieStore;)V

    new-instance v1, Lcom/payeco/android/plugin/http/comm/HttpComm;

    invoke-direct {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;-><init>()V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpCallBack(Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpEntity(Lcom/payeco/android/plugin/http/itf/IHttpEntity;)V

    new-instance v0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;-><init>()V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpExecute(Lcom/payeco/android/plugin/http/itf/IHttpExecute;)V

    invoke-virtual {v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;->request()V

    return-void
.end method

.method static synthetic j(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->m:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic k(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/widget/LinearLayout;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic l(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->e()V

    return-void
.end method

.method static synthetic m(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/content/ContentResolver;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->u:Landroid/content/ContentResolver;

    return-object v0
.end method

.method static synthetic n(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->w:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 9

    const/4 v8, -0x1

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x0

    const/4 v4, 0x1

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onActivityResult ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p1, :cond_0

    if-ne p2, v8, :cond_2

    new-instance v0, Lcom/payeco/android/plugin/g;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/g;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    new-array v1, v5, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/g;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    :cond_0
    :goto_0
    if-ne p1, v4, :cond_1

    if-ne p2, v8, :cond_3

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->x:Ljava/lang/String;

    new-array v2, v7, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v5

    const-string v3, "\u5f55\u50cf\u6210\u529f"

    aput-object v3, v2, v4

    sget-object v3, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    aput-object v3, v2, v6

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    :goto_1
    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onActivityResult ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_2
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->w:Ljava/lang/String;

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v5

    const-string v3, "\u62cd\u7167\u5931\u8d25"

    aput-object v3, v2, v4

    const-string v3, ""

    aput-object v3, v2, v6

    const-string v3, ""

    aput-object v3, v2, v7

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_3
    if-eqz p2, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->x:Ljava/lang/String;

    new-array v2, v7, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v5

    const-string v3, "\u5f55\u50cf\u5931\u8d25"

    aput-object v3, v2, v4

    const-string v3, ""

    aput-object v3, v2, v6

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    const/4 v2, 0x1

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onCreate ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "orientation_mode"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->q:Ljava/lang/String;

    const-string v0, "land"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->q:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->setRequestedOrientation(I)V

    :goto_0
    invoke-virtual {p0, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->requestWindowFeature(I)Z

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Landroid/os/Bundle;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    :goto_1
    return-void

    :cond_1
    invoke-virtual {p0, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->setRequestedOrientation(I)V

    goto :goto_0

    :cond_2
    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "\u6b63\u5728\u521d\u59cb\u5316..."

    invoke-static {p0, v0, v2}, Lcom/payeco/android/plugin/d/aa;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_7

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-direct {p0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "\u83b7\u53d6\u624b\u673a\u4fe1\u606f"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    const-string v2, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-direct {p0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    const-string v2, "\u8bfb\u53d6\u6570\u636e\u5361"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    const-string v2, "android.permission.RECEIVE_SMS"

    invoke-direct {p0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    const-string v2, "\u63a5\u6536\u77ed\u4fe1"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    const-string v2, "android.permission.READ_SMS"

    invoke-direct {p0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_6

    const-string v2, "\u8bfb\u53d6\u77ed\u4fe1"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_7

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/16 v1, 0x65

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->requestPermissions([Ljava/lang/String;I)V

    :goto_2
    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onCreate ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_7
    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Z)V

    goto :goto_2
.end method

.method protected onDestroy()V
    .locals 2

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onDestroy ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->u:Landroid/content/ContentResolver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->u:Landroid/content/ContentResolver;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->v:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    invoke-virtual {v0}, Lcom/baidu/location/LocationClient;->stop()V

    :cond_1
    invoke-static {}, Lcom/payeco/android/plugin/b/g;->a()V

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onDestroy ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 3

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i:Lcom/payeco/android/plugin/js/JsBridge;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k:Z

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->j:Lcom/payeco/android/plugin/js/JsFunction;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/js/JsFunction;->goBack()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const-string v1, "1101"

    const-string v2, "back\u952e\u56de\u8c03js\u9519\u8bef\uff01"

    invoke-direct {p0, v1, v2, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method protected onPause()V
    .locals 2

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onPause ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->t:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->t:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 6
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    const/4 v5, 0x0

    const/4 v2, 0x1

    const/4 v0, 0x0

    packed-switch p1, :pswitch_data_0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    move v1, v0

    :goto_1
    array-length v3, p2

    if-lt v0, v3, :cond_1

    if-eqz v1, :cond_5

    const-string v0, "2100"

    const-string v1, "\u9700\u8981\u6570\u636e\u5361\u8bfb\u53d6\u6743\u9650\uff01"

    invoke-direct {p0, v0, v1, v5}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string v0, "\u7f3a\u5c11\u76f8\u5173\u6743\u9650\uff0c\u8bf7\u5728\'\u8bbe\u7f6e\' ->\'\u5e94\u7528\'\u4e2d\u5f00\u542f\u6570\u636e\u5361\u8bfb\u53d6\u6743\u9650"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    aget v3, p3, v0

    if-eqz v3, :cond_4

    const-string v3, "android.permission.WRITE_EXTERNAL_STORAGE"

    aget-object v4, p2, v0

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    move v1, v2

    :cond_2
    const-string v3, "android.permission.READ_PHONE_STATE"

    aget-object v4, p2, v0

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iput-boolean v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    :cond_3
    const-string v3, "android.permission.RECEIVE_SMS"

    aget-object v4, p2, v0

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "payeco"

    const-string v4, "\u7f3a\u5c11\u77ed\u4fe1\u6743\u9650\uff01"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v2, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b:Z

    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_5
    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Z)V

    goto :goto_0

    :pswitch_1
    move v1, v0

    :goto_2
    array-length v3, p2

    if-lt v1, v3, :cond_6

    if-eqz v0, :cond_8

    const-string v0, "2100"

    const-string v1, "\u9700\u8981\u62cd\u7167\u6743\u9650\uff01"

    invoke-direct {p0, v0, v1, v5}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string v0, "\u7f3a\u5c11\u76f8\u5173\u6743\u9650\uff0c\u8bf7\u5728\'\u8bbe\u7f6e\' ->\'\u5e94\u7528\'\u4e2d\u5f00\u542f\u62cd\u7167\u6743\u9650"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_6
    aget v3, p3, v1

    if-eqz v3, :cond_7

    move v0, v2

    :cond_7
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_8
    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->e()V

    goto :goto_0

    :pswitch_2
    move v1, v0

    :goto_3
    array-length v3, p2

    if-lt v0, v3, :cond_9

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->d()V

    goto :goto_0

    :cond_9
    aget v3, p3, v0

    if-eqz v3, :cond_a

    move v1, v2

    :cond_a
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    nop

    :pswitch_data_0
    .packed-switch 0x65
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method protected onResume()V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onResume ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    const-string v0, "IsFetchSms"

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-boolean v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b:Z

    if-eqz v1, :cond_0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-lt v1, v2, :cond_0

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity - No SMS Permission."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onResume ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    const-string v1, "1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p0}, Lcom/payeco/android/plugin/c/g;->b(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    new-instance v1, Lcom/payeco/android/plugin/t;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/payeco/android/plugin/t;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V

    iput-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->t:Landroid/content/BroadcastReceiver;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.provider.Telephony.SMS_DELIVER"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const/16 v1, 0x3e8

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->setPriority(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->t:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    :cond_1
    invoke-static {p0}, Lcom/payeco/android/plugin/c/g;->c(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->u:Landroid/content/ContentResolver;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->u:Landroid/content/ContentResolver;

    const-string v1, "content://mms-sms/"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->v:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    :cond_2
    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onResume ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onSaveInstanceState ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "saveStateTime"

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-virtual {p1, v0, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    const-string v0, "commDesKey"

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->i()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "merchOrderId"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->r:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "upPayReq"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "broadcast"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->m:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "env"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "dev_ip"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->o:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "dev_port"

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->p:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -onSaveInstanceState ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
