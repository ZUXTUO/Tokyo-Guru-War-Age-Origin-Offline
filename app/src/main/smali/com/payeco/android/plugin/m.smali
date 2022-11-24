.class final Lcom/payeco/android/plugin/m;
.super Lcom/payeco/android/plugin/js/JsFunction;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

.field private b:Landroid/widget/PopupWindow;


# direct methods
.method public constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0, p2}, Lcom/payeco/android/plugin/js/JsFunction;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/m;)V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    return-void
.end method

.method static synthetic b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    return-object v0
.end method


# virtual methods
.method public final goBack()Ljava/lang/String;
    .locals 4

    const/4 v3, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->dismiss()V

    iput-object v3, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    const/4 v0, 0x1

    const-string v1, "\u9000\u51faPopupWindow!"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/m;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    const-string v1, "pageBack"

    const-string v2, ""

    invoke-virtual {v0, v1, v2, v3}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethod(Ljava/lang/String;Ljava/lang/Object;Lcom/payeco/android/plugin/js/JsCallBack;)V

    const/4 v0, 0x0

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/m;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final notifyPayResult(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->i(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "upPay.Rsp"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->j(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->context:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    const/4 v0, 0x0

    const-string v1, "\u901a\u77e5\u5b8c\u6bd5\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/m;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "\u9000\u51fa\u670d\u52a1\u5668\u4f1a\u8bdd\u9519\u8bef\uff01"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public final repay()Ljava/lang/String;
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->h(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    const/4 v0, 0x0

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/m;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "repay\u9519\u8bef\uff01"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v0, 0x1

    const-string v1, "\u91cd\u65b0\u652f\u4ed8\u9519\u8bef\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/m;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final startCamera(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v4, 0x1

    invoke-static {}, Lcom/payeco/android/plugin/c/g;->b()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const-string v2, "\u624b\u673a\u672a\u4f7f\u7528SD\u5361\uff0c\u8bf7\u63d2\u5165\u540e\u518d\u8bd5\uff01"

    aput-object v2, v1, v4

    const/4 v2, 0x2

    const-string v3, ""

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, ""

    aput-object v3, v1, v2

    invoke-virtual {v0, p2, v1}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0, p2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v3, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "android.permission.CAMERA"

    invoke-static {v2, v1, v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "\u76f8\u673a"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_2

    iget-object v2, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/16 v1, 0x66

    invoke-virtual {v2, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->requestPermissions([Ljava/lang/String;I)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->l(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    goto :goto_0
.end method

.method public final startCreditKeyboard(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 7

    const-string v0, "minlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    const-string v0, "maxlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v4, v0, Landroid/content/res/Configuration;->orientation:I

    const-string v0, "orderId"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v5, Lcom/payeco/android/plugin/o;

    invoke-direct {v5, p0, v6, p2}, Lcom/payeco/android/plugin/o;-><init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static/range {v0 .. v5}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/view/View;IIILcom/payeco/android/plugin/d/l;)Lcom/payeco/android/plugin/d/a;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    return-void
.end method

.method public final startNumberKeyboard(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 10

    const-string v0, "minlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    const-string v0, "maxlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    const-string v0, "title"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v0, "xEnabled"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v6

    const-string v0, "formatFlag"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v7

    const-string v0, "defaultVal"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v8, v0, Landroid/content/res/Configuration;->orientation:I

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->context:Landroid/content/Context;

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/widget/LinearLayout;

    move-result-object v1

    if-eqz v6, :cond_0

    const/4 v6, 0x0

    :goto_0
    new-instance v9, Lcom/payeco/android/plugin/q;

    invoke-direct {v9, p0, p2}, Lcom/payeco/android/plugin/q;-><init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;)V

    invoke-static/range {v0 .. v9}, Lcom/payeco/android/plugin/d/n;->a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;IILjava/lang/String;ZZILcom/payeco/android/plugin/d/s;)Lcom/payeco/android/plugin/d/n;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    return-void

    :cond_0
    const/4 v6, 0x1

    goto :goto_0
.end method

.method public final startPasswordKeyBoard(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 7

    const-string v0, "minlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    const-string v0, "minlen"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v4, v0, Landroid/content/res/Configuration;->orientation:I

    const-string v0, "orderId"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->context:Landroid/content/Context;

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v5, Lcom/payeco/android/plugin/p;

    invoke-direct {v5, p0, v6, p2}, Lcom/payeco/android/plugin/p;-><init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static/range {v0 .. v5}, Lcom/payeco/android/plugin/d/t;->a(Landroid/content/Context;Landroid/view/View;IIILcom/payeco/android/plugin/d/z;)Lcom/payeco/android/plugin/d/t;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    return-void
.end method

.method public final startRecord(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 4

    const-string v0, "recordTime"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/m;->context:Landroid/content/Context;

    iget-object v2, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->k(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/widget/LinearLayout;

    move-result-object v2

    new-instance v3, Lcom/payeco/android/plugin/r;

    invoke-direct {v3, p0, p2}, Lcom/payeco/android/plugin/r;-><init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;)V

    invoke-static {v1, v2, v0, v3}, Lcom/payeco/android/plugin/d/ab;->a(Landroid/content/Context;Landroid/view/View;ILcom/payeco/android/plugin/d/aj;)Lcom/payeco/android/plugin/d/ab;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/m;->b:Landroid/widget/PopupWindow;

    return-void
.end method

.method public final startVedio(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 9

    const/4 v8, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x0

    const/4 v4, 0x1

    invoke-static {}, Lcom/payeco/android/plugin/c/g;->b()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "\u624b\u673a\u672a\u4f7f\u7528SD\u5361\uff0c\u8bf7\u63d2\u5165\u540e\u518d\u8bd5\uff01"

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/m;->toast(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    new-array v1, v8, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v5

    const-string v2, "\u624b\u673a\u672a\u4f7f\u7528SD\u5361\uff0c\u8bf7\u63d2\u5165\u540e\u518d\u8bd5\uff01"

    aput-object v2, v1, v4

    const-string v2, ""

    aput-object v2, v1, v6

    const-string v2, ""

    aput-object v2, v1, v7

    invoke-virtual {v0, p2, v1}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "vedioTime"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    :try_start_0
    iget-object v1, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1, p2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-class v3, Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "vedioTime"

    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoPluginLoadingActivity PayecoJsFunction startVedio error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object v0, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    new-array v1, v8, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v5

    const-string v2, "\u65e0\u6cd5\u5f00\u542f\u76f8\u673a\uff01"

    aput-object v2, v1, v4

    const-string v2, ""

    aput-object v2, v1, v6

    const-string v2, ""

    aput-object v2, v1, v7

    invoke-virtual {v0, p2, v1}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public final upFile(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 4

    const-string v0, "fileName"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "url"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "url"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    const-string v2, "fileName"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    new-instance v2, Lcom/payeco/android/plugin/http/biz/UploadFile;

    invoke-direct {v2, v1}, Lcom/payeco/android/plugin/http/biz/UploadFile;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lcom/payeco/android/plugin/http/biz/UploadFile;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v1

    iget-object v3, p0, Lcom/payeco/android/plugin/m;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v3

    invoke-virtual {v3}, Lcom/payeco/android/plugin/http/comm/Http;->getCookieStore()Lorg/apache/http/client/CookieStore;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/payeco/android/plugin/http/comm/Http;->setCookieStore(Lorg/apache/http/client/CookieStore;)V

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0, v1}, Lcom/payeco/android/plugin/http/biz/UploadFile;->addFile(Ljava/lang/String;Ljava/io/File;)V

    invoke-virtual {p1}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/payeco/android/plugin/http/comm/HttpComm;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;-><init>()V

    invoke-virtual {v0, v2}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpEntity(Lcom/payeco/android/plugin/http/itf/IHttpEntity;)V

    new-instance v1, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;

    invoke-direct {v1}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;-><init>()V

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpExecute(Lcom/payeco/android/plugin/http/itf/IHttpExecute;)V

    new-instance v1, Lcom/payeco/android/plugin/n;

    invoke-direct {v1, p0, p2}, Lcom/payeco/android/plugin/n;-><init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/HttpComm;->setHttpCallBack(Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/comm/HttpComm;->request()V

    return-void

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lcom/payeco/android/plugin/http/biz/UploadFile;->addParams(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
