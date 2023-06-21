.class public abstract Lcom/payeco/android/plugin/js/JsFunction;
.super Ljava/lang/Object;


# instance fields
.field protected context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public closeProgress()Ljava/lang/String;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Lcom/payeco/android/plugin/d/aa;->a()V

    const-string v1, "errCode"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public data3DesEnc(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    const/4 v6, 0x1

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "pw"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "encFlag"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->i()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/payeco/android/plugin/c/c;->a(Ljava/lang/String;)[B

    move-result-object v3

    if-ne v1, v6, :cond_0

    const-string v4, "utf-8"

    invoke-virtual {v2, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v4

    invoke-static {v3, v4}, Lcom/payeco/android/plugin/a/g;->a([B[B)[B

    move-result-object v4

    invoke-static {v4}, Lcom/payeco/android/plugin/c/c;->a([B)Ljava/lang/String;

    move-result-object v4

    const-string v5, "data"

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    const/4 v4, 0x2

    if-ne v1, v4, :cond_2

    invoke-static {v2}, Lcom/payeco/android/plugin/c/c;->a(Ljava/lang/String;)[B

    move-result-object v1

    invoke-static {v3, v1}, Lcom/payeco/android/plugin/a/g;->b([B[B)[B

    move-result-object v1

    if-nez v1, :cond_1

    const-string v1, "errCode"

    invoke-virtual {v0, v1, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, "\u89e3\u5bc6\u5931\u8d25"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_1
    const-string v2, "data"

    new-instance v3, Ljava/lang/String;

    const-string v4, "utf-8"

    invoke-direct {v3, v1, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_2
    const-string v1, "errCode"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public exitPlugin()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    check-cast v0, Landroid/app/Activity;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Landroid/app/Activity;)V

    const/4 v0, 0x0

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getConfig()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDevInfo()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    const-string v1, "\u83b7\u53d6\u6210\u529f\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "Mac"

    iget-object v2, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/payeco/android/plugin/c/g;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "MobileOS"

    const-string v2, "android"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "OsVer"

    sget-object v2, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "Factory"

    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "Model"

    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "Imsi"

    iget-object v2, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/payeco/android/plugin/c/g;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "Imei"

    iget-object v2, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/payeco/android/plugin/c/g;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "IsRoot"

    invoke-static {}, Lcom/payeco/android/plugin/c/g;->a()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getKey()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->d()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLbsInfo()Ljava/lang/String;
    .locals 8

    const/4 v2, 0x0

    const/4 v1, 0x1

    const-string v0, "\u83b7\u53d6\u6210\u529f\uff01"

    invoke-virtual {p0, v2, v0}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    iget-object v0, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    const-string v0, "android.permission.ACCESS_COARSE_LOCATION"

    iget-object v5, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v0, v5}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_3

    move v0, v1

    :goto_0
    const-string v5, "android.permission.ACCESS_FINE_LOCATION"

    iget-object v6, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_0

    move v2, v1

    :cond_0
    if-eqz v0, :cond_6

    if-eqz v2, :cond_6

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->a()Lcom/payeco/android/plugin/b/f;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v2

    const-string v4, "payecoLat"

    invoke-static {v0, v2, v4}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v4

    const-string v5, "payecoLon"

    invoke-static {v0, v4, v5}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v2, :cond_1

    if-nez v4, :cond_4

    :cond_1
    const/4 v0, 0x0

    :cond_2
    :goto_1
    if-nez v0, :cond_5

    const-string v0, "errCode"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v0, "errMsg"

    const-string v1, "\u6ca1\u6709\u83b7\u53d6\u5230LBS\u4fe1\u606f"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :goto_2
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_3
    return-object v0

    :cond_3
    move v0, v2

    goto :goto_0

    :cond_4
    new-instance v0, Lcom/payeco/android/plugin/b/f;

    invoke-direct {v0}, Lcom/payeco/android/plugin/b/f;-><init>()V

    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v6

    iput-wide v6, v0, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-static {v4}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    iput-wide v4, v0, Lcom/payeco/android/plugin/b/f;->b:D

    new-instance v2, Ljava/lang/StringBuilder;

    iget-wide v4, v0, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, ","

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, v0, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/payeco/android/plugin/b/h;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/payeco/android/plugin/b/b;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_5
    :try_start_0
    const-string v2, "LbsLat"

    iget-wide v4, v0, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-virtual {v3, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    const-string v2, "LbsLon"

    iget-wide v4, v0, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-virtual {v3, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    const-string v2, "lbs"

    new-instance v4, Ljava/lang/StringBuilder;

    iget-wide v6, v0, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v6, v0, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    const-string v2, "payeco"

    const-string v4, "\u6ca1\u6709\u83b7\u53d6\u5230LBS\u4fe1\u606f"

    invoke-static {v2, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v0, "errCode"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v0, "errMsg"

    const-string v1, "\u6ca1\u6709\u83b7\u53d6\u5230LBS\u4fe1\u606f"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    new-instance v0, Lcom/payeco/android/plugin/b/b;

    iget-object v1, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/payeco/android/plugin/b/b;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/b/b;->b()V

    goto/16 :goto_2

    :cond_6
    const-string v0, "hx"

    const-string v2, "Js-->\u6728\u6709\u8fd9\u4e2a\u6743\u9650"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "errCode"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v0, "errMsg"

    const-string v1, "\u6ca1\u6709\u83b7\u53d6\u5230LBS\u4fe1\u606f"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_3
.end method

.method public getPluginAppVerInfo()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    const-string v1, "\u83b7\u53d6\u6210\u529f\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "pluginAppVerCode"

    const/16 v2, 0xa

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "pluginAppVer"

    const-string v2, "2.1.6"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "MobileOS"

    const-string v2, "android"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "errCode"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method

.method public getSessionId()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    const-string v1, "\u83b7\u53d6\u6210\u529f\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "sessionId"

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract goBack()Ljava/lang/String;
.end method

.method public gotoLbsSetting()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    const-string v1, "\u83b7\u53d6\u6210\u529f\uff01"

    invoke-virtual {p0, v0, v1}, Lcom/payeco/android/plugin/js/JsFunction;->getResultJson(ILjava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.settings.LOCATION_SOURCE_SETTINGS"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-virtual {v2, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract notifyPayResult(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract repay()Ljava/lang/String;
.end method

.method public setConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "key"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "value"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {v3}, Lcom/payeco/android/plugin/b/h;->a(Lorg/json/JSONObject;)V

    const-string v1, "errCode"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setKey(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "key"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "value"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->d()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {v3, v1}, Lcom/payeco/android/plugin/b/h;->a(Lorg/json/JSONObject;Landroid/content/Context;)V

    const-string v1, "errCode"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public showProgress(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "text"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "isCancel"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iget-object v3, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    invoke-static {v3, v2, v1}, Lcom/payeco/android/plugin/d/aa;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    const-string v1, "errCode"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "errMsg"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract startCamera(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method public abstract startCreditKeyboard(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method public abstract startNumberKeyboard(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method public abstract startPasswordKeyBoard(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method public abstract startRecord(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method public abstract startVedio(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method

.method protected toast(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/js/JsFunction;->context:Landroid/content/Context;

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method public abstract upFile(Lorg/json/JSONObject;Ljava/lang/String;)V
.end method
