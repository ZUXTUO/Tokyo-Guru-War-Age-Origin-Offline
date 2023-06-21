.class final Lcom/payeco/android/plugin/y;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpCallBack;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/y;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    return-void
.end method


# virtual methods
.method public final fail(Ljava/lang/Exception;)V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2102"

    const-string v2, "\u67e5\u8be2\u8ba2\u5355\u901a\u8baf\u5f02\u5e38\uff01"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u67e5\u8be2\u8ba2\u5355\u5931\u8d25[2102]!"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    return-void
.end method

.method public final success(Ljava/lang/String;)V
    .locals 6

    if-nez p1, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2101"

    const-string v2, "\u67e5\u8be2\u8ba2\u5355\u5931\u8d25\u8fd4\u56de\u5185\u5bb9\u7a7a\uff01"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u67e5\u8be2\u8ba2\u5355\u5931\u8d25[2101]!"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->e(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/y;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Landroid/webkit/WebView;

    move-result-object v0

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->b()Ljava/lang/String;

    move-result-object v1

    const-string v3, "text/html"

    const-string v4, "utf-8"

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->b()Ljava/lang/String;

    move-result-object v5

    move-object v2, p1

    invoke-virtual/range {v0 .. v5}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    goto :goto_0
.end method
