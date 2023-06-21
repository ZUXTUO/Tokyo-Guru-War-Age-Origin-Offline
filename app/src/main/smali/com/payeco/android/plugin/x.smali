.class final Lcom/payeco/android/plugin/x;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpCallBack;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

.field private b:I


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 1

    iput-object p1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/payeco/android/plugin/x;->b:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/x;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    return-void
.end method


# virtual methods
.method public final fail(Ljava/lang/Exception;)V
    .locals 4

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -\u6536\u5230\u521d\u59cb\u5316\u56de\u8c03 - success."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_0

    const-string v0, "payeco"

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5f02\u5e38!"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v0

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/comm/Http;->getStatusCode()I

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->c()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2010"

    const-string v2, "\u8fde\u63a5\u5207\u6362\u591a\u6b21\u5207\u6362\u57df\u540d\u540e\u4ecd\u65e0\u6cd5\u901a\u8baf\u6210\u529f\uff01"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    :goto_1
    return-void

    :cond_0
    const-string v0, "payeco"

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5f02\u5e38!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-boolean v1, v1, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Z)V

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2011"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\u8bf7\u6c42\u670d\u52a1\u5931\u8d25\uff0c\u7f51\u7edc\u72b6\u6001\u7801\uff1a"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v3

    invoke-virtual {v3}, Lcom/payeco/android/plugin/http/comm/Http;->getStatusCode()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\uff01"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2011]\uff01\u7f51\u7edc\u72b6\u6001\u7801\uff1a"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v2

    invoke-virtual {v2}, Lcom/payeco/android/plugin/http/comm/Http;->getStatusCode()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\uff01"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public final success(Ljava/lang/String;)V
    .locals 8
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v7, 0x1

    const/4 v6, 0x0

    const-string v0, "payeco"

    const-string v1, "PayecoPluginLoadingActivity -\u6536\u5230\u521d\u59cb\u5316\u56de\u8c03 - success."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->c(Landroid/content/Context;)V

    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2001"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u54cd\u5e94\u4e3a\u7a7a\uff01"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2001]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "{"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget v0, p0, Lcom/payeco/android/plugin/x;->b:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/payeco/android/plugin/x;->b:I

    const/4 v1, 0x3

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2009"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u8fde\u63a5\u66f4\u65b0\u4e09\u6b21\u65e0\u679c[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2009]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const-string v1, "errCode"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "info"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_1
    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v2, "info"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2003"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u8bfb\u53d6\u9519\u8bef\u4fe1\u606f[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2003]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto :goto_0

    :catch_1
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2002"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u89e3\u6790\u54cd\u5e94[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2002]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    :try_start_2
    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v2, "2004"

    const-string v3, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u8bfb\u53d6\u9519\u8bef\u4fe1\u606f[%s]\uff01"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object p1, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v2, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25\uff0c\u9519\u8bef\u7801:%s\uff0c[2004]"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "errCode"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    goto/16 :goto_0

    :catch_2
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2005"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u8bfb\u53d6\u9519\u8bef\u4fe1\u606f[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2005]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_3
    :try_start_3
    const-string v1, "package"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result-object v0

    :try_start_4
    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Lorg/json/JSONObject;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    :try_start_5
    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/b/h;->a(Lorg/json/JSONObject;Landroid/content/Context;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-boolean v1, v1, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a:Z

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Z)V

    goto/16 :goto_0

    :catch_3
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2006"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u83b7\u53d6package[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2006]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto/16 :goto_0

    :catch_4
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2007"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u66f4\u65b0\u914d\u7f6e[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2007]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto/16 :goto_0

    :catch_5
    move-exception v0

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "2008"

    const-string v2, "\u901a\u8baf\u5931\u8d25\u65e0\u6cd5\u66f4\u65b0\u5bc6\u94a5[%s]\uff01"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object p1, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "\u63d2\u4ef6\u521d\u59cb\u5316\u901a\u8baf\u5931\u8d25[2008]\uff01"

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_4
    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/Http;->syncCookie(Landroid/content/Context;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->b(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

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

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_7

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v3, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {v2, v1, v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    const-string v2, "\u5b9a\u4f4d"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    iget-object v2, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v3, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-static {v2, v1, v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/util/List;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_6

    const-string v2, "\u5b9a\u4f4d"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_7

    iget-object v2, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/16 v1, 0x67

    invoke-virtual {v2, v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->requestPermissions([Ljava/lang/String;I)V

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    goto/16 :goto_0

    :cond_7
    iget-object v0, p0, Lcom/payeco/android/plugin/x;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->d(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    goto/16 :goto_0
.end method
