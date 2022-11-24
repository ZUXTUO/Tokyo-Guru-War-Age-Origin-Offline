.class public Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;
.super Landroid/app/Activity;
.source "ToolBarMainPage.java"


# static fields
.field private static mAccessToken:Ljava/lang/String;

.field private static mAccount:Ljava/lang/String;

.field private static mActivity:Landroid/app/Activity;

.field private static mAppId:Ljava/lang/String;

.field private static mCloseButton:Landroid/widget/ImageButton;

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

.field private static mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

.field private static mWebView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 26
    sput-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    .line 27
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAppId:Ljava/lang/String;

    .line 28
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mOpenid:Ljava/lang/String;

    .line 29
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccessToken:Ljava/lang/String;

    .line 30
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccount:Ljava/lang/String;

    .line 31
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mParams:Ljava/util/Map;

    .line 32
    sput-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    .line 33
    sput-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    .line 34
    sput-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mCloseButton:Landroid/widget/ImageButton;

    .line 35
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mIsShow:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "openid"    # Ljava/lang/String;
    .param p1, "accessToken"    # Ljava/lang/String;
    .param p2, "account"    # Ljava/lang/String;

    .prologue
    .line 49
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 50
    sput-object p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mOpenid:Ljava/lang/String;

    .line 51
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 52
    sput-object p1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccessToken:Ljava/lang/String;

    .line 53
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 54
    sput-object p2, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccount:Ljava/lang/String;

    .line 55
    :cond_2
    return-void
.end method

.method public static addUrlParam(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 58
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 59
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mParams:Ljava/util/Map;

    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
    :cond_0
    return-void
.end method

.method public static cleanUrlParam()V
    .locals 1

    .prologue
    .line 64
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mParams:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 65
    return-void
.end method

.method public static close()V
    .locals 1

    .prologue
    .line 177
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 178
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    .line 179
    :cond_0
    return-void
.end method

.method public static getUrl(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)Ljava/lang/String;
    .locals 7
    .param p0, "item"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    .line 68
    invoke-static {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->itemTypeToUrl(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)Ljava/lang/String;

    move-result-object v2

    .line 69
    .local v2, "url":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "?appid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAppId:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 70
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&openid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mOpenid:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 71
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&token="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccessToken:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 73
    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "&account="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAccount:Ljava/lang/String;

    const-string v5, "UTF-8"

    invoke-static {v4, v5}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 78
    :goto_0
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mParams:Ljava/util/Map;

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    .line 87
    return-object v2

    .line 74
    :catch_0
    move-exception v0

    .line 75
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "ToolBarMainPage getUrl error."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 76
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 78
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 80
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

    .line 81
    :catch_1
    move-exception v0

    .line 82
    .restart local v0    # "e":Ljava/io/UnsupportedEncodingException;
    sget-object v5, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v3, "ToolBarMainPage getUrl error key:"

    invoke-direct {v6, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1
.end method

.method public static isShow()Z
    .locals 1

    .prologue
    .line 182
    sget-boolean v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mIsShow:Z

    return v0
.end method

.method private static itemTypeToUrl(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)Ljava/lang/String;
    .locals 1
    .param p0, "type"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    .line 91
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p0, v0, :cond_0

    .line 92
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarKefuUrl:Ljava/lang/String;

    .line 100
    :goto_0
    return-object v0

    .line 93
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p0, v0, :cond_1

    .line 94
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarMallUrl:Ljava/lang/String;

    goto :goto_0

    .line 95
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p0, v0, :cond_2

    .line 96
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarRaidersUrl:Ljava/lang/String;

    goto :goto_0

    .line 97
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p0, v0, :cond_3

    .line 98
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarInfoUrl:Ljava/lang/String;

    goto :goto_0

    .line 100
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V
    .locals 3
    .param p0, "parentActivity"    # Landroid/app/Activity;
    .param p1, "item"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    .line 170
    const/4 v1, 0x1

    sput-boolean v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mIsShow:Z

    .line 171
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 172
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "item"

    invoke-virtual {p1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->ordinal()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 173
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 174
    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 219
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 220
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    if-eqz v0, :cond_0

    .line 221
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    invoke-virtual {v0, p1, p2, p3}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;->onActivityResult(IILandroid/content/Intent;)V

    .line 223
    :cond_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 5
    .param p1, "b"    # Landroid/os/Bundle;

    .prologue
    .line 39
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 41
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->close()V

    .line 42
    sput-object p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    .line 43
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    sput-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mAppId:Ljava/lang/String;

    .line 44
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v1

    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "item"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    aget-object v0, v1, v2

    .line 45
    .local v0, "itemType":Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->showPage(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    .line 46
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 211
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "UserCenter_ToolBarMainPage onDestroy"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 212
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mIsShow:Z

    .line 213
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 214
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 199
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "UserCenter_ToolBarMainPage onPause"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 201
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 193
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "UserCenter_ToolBarMainPage onResume"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 194
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 195
    return-void
.end method

.method protected onStart()V
    .locals 2

    .prologue
    .line 187
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "UserCenter_ToolBarMainPage onStart"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 188
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 189
    return-void
.end method

.method protected onStop()V
    .locals 2

    .prologue
    .line 205
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "UserCenter_ToolBarMainPage onStop"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 206
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 207
    return-void
.end method

.method public showPage(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V
    .locals 7
    .param p1, "item"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    const/4 v6, 0x1

    .line 104
    const-string v3, "layout"

    const-string v4, "tool_bar_main_page"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 105
    .local v0, "resId":I
    const/4 v3, -0x1

    if-ne v0, v3, :cond_0

    .line 106
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "invalid res id"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 107
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->finish()V

    .line 167
    :goto_0
    return-void

    .line 110
    :cond_0
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v3, v0}, Landroid/app/Activity;->setContentView(I)V

    .line 111
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    .line 112
    .local v1, "tool_bar_main_page_view":Landroid/view/View;
    const-string v3, "id"

    const-string v4, "webView1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/webkit/WebView;

    sput-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    .line 113
    const-string v3, "id"

    const-string v4, "imageButton1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageButton;

    sput-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mCloseButton:Landroid/widget/ImageButton;

    .line 114
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mCloseButton:Landroid/widget/ImageButton;

    new-instance v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$1;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$1;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 123
    invoke-static {p1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->getUrl(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)Ljava/lang/String;

    move-result-object v2

    .line 124
    .local v2, "url":Ljava/lang/String;
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "web "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0xb

    if-lt v3, v4, :cond_1

    .line 126
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    const-string v4, "searchBoxJavaBridge_"

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 127
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    const-string v4, "accessibility"

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 128
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    const-string v4, "accessibilityTraversal"

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 130
    :cond_1
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 131
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    .line 132
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    invoke-virtual {v3, v6}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 133
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    invoke-virtual {v3, v6}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 134
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    new-instance v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$2;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$2;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;)V

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 164
    new-instance v3, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mActivity:Landroid/app/Activity;

    invoke-direct {v3, v4}, Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;-><init>(Landroid/app/Activity;)V

    sput-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    .line 165
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    sget-object v4, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebChromeClientEx:Lcom/digital/cloud/usercenter/toolbar/WebChromeClientEx;

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 166
    sget-object v3, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v3, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto/16 :goto_0
.end method
