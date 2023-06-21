.class final Lcom/payeco/android/plugin/n;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpCallBack;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/m;

.field private final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    iput-object p2, p0, Lcom/payeco/android/plugin/n;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final fail(Ljava/lang/Exception;)V
    .locals 6

    const/4 v5, 0x1

    iget-object v0, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "3012"

    const-string v2, "\u4e0a\u4f20\u6587\u4ef6\u901a\u8baf\u5931\u8d25\uff01"

    invoke-static {v0, v1, v2, p1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/n;->b:Ljava/lang/String;

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const-string v3, "\u4e0a\u4f20\u6587\u4ef6\u5931\u8d25\uff01"

    aput-object v3, v2, v5

    const/4 v3, 0x2

    const-string v4, ""

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public final success(Ljava/lang/String;)V
    .locals 11

    const/4 v10, 0x3

    const/4 v9, 0x2

    const/4 v8, 0x0

    const/4 v7, 0x1

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "errCode"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "errMsg"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "fileName"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v3}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v3

    invoke-static {v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v3

    iget-object v4, p0, Lcom/payeco/android/plugin/n;->b:Ljava/lang/String;

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v1, v5, v6

    const/4 v1, 0x1

    aput-object v2, v5, v1

    const/4 v1, 0x2

    aput-object v0, v5, v1

    invoke-virtual {v3, v4, v5}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v1}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v1

    const-string v2, "3011"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "\u4e0a\u4f20\u6587\u4ef6\u89e3\u6790\u901a\u8baf\u54cd\u5e94\u5931\u8d25["

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]\uff01"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/n;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/n;->b:Ljava/lang/String;

    new-array v2, v10, [Ljava/lang/Object;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v8

    const-string v3, "\u4e0a\u4f20\u6587\u4ef6\u5931\u8d25\uff01"

    aput-object v3, v2, v7

    const-string v3, ""

    aput-object v3, v2, v9

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method
