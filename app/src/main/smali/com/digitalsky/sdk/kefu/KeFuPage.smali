.class public Lcom/digitalsky/sdk/kefu/KeFuPage;
.super Ljava/lang/Object;
.source "KeFuPage.java"


# static fields
.field private static TAG:Ljava/lang/String;

.field private static mAccessToken:Ljava/lang/String;

.field private static mAccount:Ljava/lang/String;

.field private static mActivity:Landroid/app/Activity;

.field private static mCurrentLayout:Landroid/widget/LinearLayout;

.field private static mIsShow:Z

.field private static mOpenid:Ljava/lang/String;

.field private static mParams:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static mWebView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 29
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/kefu/KeFuPage;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    .line 30
    sput-object v2, Lcom/digitalsky/sdk/kefu/KeFuPage;->mActivity:Landroid/app/Activity;

    .line 31
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mOpenid:Ljava/lang/String;

    .line 32
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccessToken:Ljava/lang/String;

    .line 33
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccount:Ljava/lang/String;

    .line 34
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mParams:Ljava/util/Map;

    .line 35
    sput-object v2, Lcom/digitalsky/sdk/kefu/KeFuPage;->mCurrentLayout:Landroid/widget/LinearLayout;

    .line 36
    sput-object v2, Lcom/digitalsky/sdk/kefu/KeFuPage;->mWebView:Landroid/webkit/WebView;

    .line 37
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mIsShow:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 35
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mCurrentLayout:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$1()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 30
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$2(Landroid/widget/LinearLayout;)V
    .locals 0

    .prologue
    .line 35
    sput-object p0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mCurrentLayout:Landroid/widget/LinearLayout;

    return-void
.end method

.method static synthetic access$3()Landroid/webkit/WebView;
    .locals 1

    .prologue
    .line 36
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mWebView:Landroid/webkit/WebView;

    return-object v0
.end method

.method static synthetic access$4(Z)V
    .locals 0

    .prologue
    .line 37
    sput-boolean p0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mIsShow:Z

    return-void
.end method

.method static synthetic access$5(Landroid/webkit/WebView;)V
    .locals 0

    .prologue
    .line 36
    sput-object p0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mWebView:Landroid/webkit/WebView;

    return-void
.end method

.method static synthetic access$6()Ljava/lang/String;
    .locals 1

    .prologue
    .line 80
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->getUrl()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$7()Ljava/lang/String;
    .locals 1

    .prologue
    .line 29
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "openid"    # Ljava/lang/String;
    .param p1, "accessToken"    # Ljava/lang/String;
    .param p2, "account"    # Ljava/lang/String;

    .prologue
    .line 44
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 45
    sput-object p0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mOpenid:Ljava/lang/String;

    .line 46
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 47
    sput-object p1, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccessToken:Ljava/lang/String;

    .line 48
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 49
    sput-object p2, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccount:Ljava/lang/String;

    .line 50
    :cond_2
    return-void
.end method

.method public static addUrlParam(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 75
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 76
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mParams:Ljava/util/Map;

    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    :cond_0
    return-void
.end method

.method private static closeKeFuWebPage()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 197
    sget-boolean v1, Lcom/digitalsky/sdk/kefu/KeFuPage;->mIsShow:Z

    if-eqz v1, :cond_0

    sget-object v1, Lcom/digitalsky/sdk/kefu/KeFuPage;->mCurrentLayout:Landroid/widget/LinearLayout;

    if-eqz v1, :cond_0

    .line 198
    sput-boolean v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mIsShow:Z

    .line 199
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mCurrentLayout:Landroid/widget/LinearLayout;

    sget-object v1, Lcom/digitalsky/sdk/kefu/KeFuPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 200
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mWebView:Landroid/webkit/WebView;

    .line 201
    const/4 v0, 0x1

    .line 203
    :cond_0
    return v0
.end method

.method private static getUrl()Ljava/lang/String;
    .locals 7

    .prologue
    .line 81
    invoke-static {}, Lcom/digitalsky/sdk/common/Constant;->getKefuUrl()Ljava/lang/String;

    move-result-object v2

    .line 82
    .local v2, "url":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "?appid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 83
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&openid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digitalsky/sdk/kefu/KeFuPage;->mOpenid:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 84
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&token="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 86
    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&account="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digitalsky/sdk/kefu/KeFuPage;->mAccount:Ljava/lang/String;

    const-string v5, "UTF-8"

    invoke-static {v4, v5}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 91
    :goto_0
    sget-object v3, Lcom/digitalsky/sdk/kefu/KeFuPage;->mParams:Ljava/util/Map;

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 100
    return-object v2

    .line 87
    :catch_0
    move-exception v0

    .line 88
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    sget-object v3, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    const-string v4, "KeFuPage getUrl error."

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 89
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 91
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 93
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, "&"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    const-string v6, "UTF-8"

    invoke-static {v3, v6}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v2

    goto :goto_1

    .line 94
    :catch_1
    move-exception v0

    .line 95
    .restart local v0    # "e":Ljava/io/UnsupportedEncodingException;
    sget-object v5, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v3, "KeFuPage getUrl error key:"

    invoke-direct {v6, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v5, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 96
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1
.end method

.method public static init(Landroid/app/Activity;)V
    .locals 0
    .param p0, "ctx"    # Landroid/app/Activity;

    .prologue
    .line 40
    sput-object p0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mActivity:Landroid/app/Activity;

    .line 41
    return-void
.end method

.method public static onKeyDown(I)Z
    .locals 1
    .param p0, "keyCode"    # I

    .prologue
    .line 207
    const/4 v0, 0x4

    if-ne p0, v0, :cond_0

    .line 208
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->closeKeFuWebPage()Z

    move-result v0

    .line 210
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static openKeFuWebPage()V
    .locals 2

    .prologue
    .line 104
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mActivity:Landroid/app/Activity;

    if-nez v0, :cond_0

    .line 193
    :goto_0
    return-void

    .line 106
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/kefu/KeFuPage;->mActivity:Landroid/app/Activity;

    new-instance v1, Lcom/digitalsky/sdk/kefu/KeFuPage$1;

    invoke-direct {v1}, Lcom/digitalsky/sdk/kefu/KeFuPage$1;-><init>()V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public static submitInfo(Lorg/json/JSONObject;)Z
    .locals 7
    .param p0, "data"    # Lorg/json/JSONObject;

    .prologue
    .line 53
    sget-object v4, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "submitInfo: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    if-eqz p0, :cond_0

    .line 56
    :try_start_0
    invoke-virtual {p0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    .line 57
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_1

    .line 71
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :cond_0
    :goto_1
    const/4 v4, 0x1

    return v4

    .line 58
    .restart local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 59
    .local v2, "key":Ljava/lang/String;
    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 60
    .local v3, "value":Ljava/lang/String;
    sget-object v4, Lcom/digitalsky/sdk/kefu/KeFuPage;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, " -- "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    invoke-static {v2, v3}, Lcom/digitalsky/sdk/kefu/KeFuPage;->addUrlParam(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 66
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "value":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 68
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method
