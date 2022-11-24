.class public final Lcom/payeco/android/plugin/b/h;
.super Ljava/lang/Object;


# static fields
.field private static a:Ljava/lang/String;

.field private static b:Ljava/lang/String;

.field private static c:Ljava/lang/String;

.field private static d:I

.field private static e:I


# direct methods
.method public static a()I
    .locals 1

    sget v0, Lcom/payeco/android/plugin/b/h;->d:I

    return v0
.end method

.method public static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static a(Landroid/app/Activity;)V
    .locals 3

    :try_start_0
    sget-object v0, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->c(Ljava/lang/String;)Z

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u6210\u529f\u5220\u9664:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    :cond_0
    :goto_0
    :try_start_1
    sget-object v0, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->c(Ljava/lang/String;)Z

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u6210\u529f\u5220\u9664:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    :cond_1
    :goto_1
    :try_start_2
    sget-object v0, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->c(Ljava/lang/String;)Z

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u6210\u529f\u5220\u9664:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    :cond_2
    :goto_2
    :try_start_3
    sget-object v0, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    sget-object v0, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/b;->c(Ljava/lang/String;)Z

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u6210\u529f\u5220\u9664:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    :cond_3
    :goto_3
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :catch_0
    move-exception v0

    goto :goto_3

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 7

    const/4 v6, 0x0

    const-string v0, "02"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "00"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    sput v6, Lcom/payeco/android/plugin/b/h;->d:I

    :goto_0
    return-void

    :cond_1
    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "domainIndex"

    invoke-static {p0, v0, v1}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v0

    const-string v2, "lastSaveDomainTime"

    invoke-static {p0, v0, v2}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v1, :cond_3

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const/16 v0, 0x5a0

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v4

    if-eqz v4, :cond_2

    const-string v5, "DnsSwitchTime"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    :try_start_0
    const-string v5, "DnsSwitchTime"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :cond_2
    :goto_1
    new-instance v4, Ljava/util/Date;

    invoke-direct {v4}, Ljava/util/Date;-><init>()V

    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    sub-long v2, v4, v2

    mul-int/lit8 v0, v0, 0x3c

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v4, v0

    cmp-long v0, v2, v4

    if-gtz v0, :cond_3

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/payeco/android/plugin/b/h;->d:I

    :goto_2
    sput v6, Lcom/payeco/android/plugin/b/h;->e:I

    goto :goto_0

    :cond_3
    sput v6, Lcom/payeco/android/plugin/b/h;->d:I

    goto :goto_2

    :catch_0
    move-exception v4

    goto :goto_1
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    sput-object p0, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    sput-object p1, Lcom/payeco/android/plugin/b/h;->b:Ljava/lang/String;

    sput-object p2, Lcom/payeco/android/plugin/b/h;->c:Ljava/lang/String;

    sput v0, Lcom/payeco/android/plugin/b/h;->d:I

    sput v0, Lcom/payeco/android/plugin/b/h;->e:I

    return-void
.end method

.method public static a(Lorg/json/JSONObject;)V
    .locals 4

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->f()Ljava/lang/String;

    move-result-object v1

    const-string v2, "GetLBS"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "GetLBS"

    const-string v3, "GetLBS"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    const-string v2, "LbsTime"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "LbsTime"

    const-string v3, "LbsTime"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    const-string v2, "PhotoSize"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "PhotoSize"

    const-string v3, "PhotoSize"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_2
    const-string v2, "SoundTime"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "SoundTime"

    const-string v3, "SoundTime"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_3
    const-string v2, "SmsNumber"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v2, "SmsNumber"

    const-string v3, "SmsNumber"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_4
    const-string v2, "SmsPattern"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    const-string v2, "SmsPattern"

    const-string v3, "SmsPattern"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_5
    const-string v2, "IsFetchSms"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    const-string v2, "IsFetchSms"

    const-string v3, "IsFetchSms"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_6
    const-string v2, "ClientTradeOutTime"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    const-string v2, "ClientTradeOutTime"

    const-string v3, "ClientTradeOutTime"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_7
    const-string v2, "ClientPayOutTime"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    const-string v2, "ClientPayOutTime"

    const-string v3, "ClientPayOutTime"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_8
    const-string v2, "DnsSwitchTime"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_9

    const-string v2, "DnsSwitchTime"

    const-string v3, "DnsSwitchTime"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_9
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "utf-8"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    return-void
.end method

.method public static a(Lorg/json/JSONObject;Landroid/content/Context;)V
    .locals 5

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->d()Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->e()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->g()Ljava/lang/String;

    move-result-object v2

    const-string v3, "CommPKeyIndex"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "CommPKeyIndex"

    const-string v4, "CommPKeyIndex"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    const-string v3, "CommPKey"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "CommPKey"

    const-string v4, "CommPKey"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    const-string v3, "PinPKeyIndex"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "PinPKeyIndex"

    const-string v4, "PinPKeyIndex"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_2
    const-string v3, "PinPKey"

    invoke-virtual {p0, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    const-string v3, "PinPKey"

    const-string v4, "PinPKey"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_3
    invoke-static {p1}, Lcom/payeco/android/plugin/b/h;->d(Landroid/content/Context;)[B

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v4, "utf-8"

    invoke-virtual {v0, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v3, v0}, Lcom/payeco/android/plugin/a/g;->a([B[B)[B

    move-result-object v3

    invoke-static {v0}, Lcom/payeco/android/plugin/a/e;->a([B)[B

    move-result-object v0

    invoke-static {v2, v0}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    invoke-static {v1, v3}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    return-void
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;[B)[B
    .locals 3

    const-string v0, "{\"PinPKey\":\"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJ1fKGMV\\/yOUnY1ysFCk0yPP4bfOolC\\/nTAyHmoser+1yzeLtyYsfitYonFIsXBKoAYwSAhNE+ZSdXZs4A5zt4EKoU+T3IoByCoKgvpCuOx8rgIAqC3O\\/95pGb9n6rKHR2sz5EPT0aBUUDAB2FJYjA9Sy+kURxa52EOtRKolSmEwIDAQAB\",\"PinPKeyIndex\":\"1\",\"CommPKey\":\"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDS4TageE+BMTBTsq\\/fayJZBY6p9jMe3TLBhGJag2dP+vVOJxWwT2guucBMvM+z29d1CIc3LKVbxcO9wF3UBgLbw5F4LpNUeG+KmHyeH\\/qwVWIu13dCsrvqOzUvsJlA9zVA9YVvvCaCfTIHfd\\/bU5KDQeIJpnwYvm5LNCZOFEITFwIDAQAB\",\"CommPKeyIndex\":\"1\"}"

    const-string v1, "utf-8"

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {p2, v0}, Lcom/payeco/android/plugin/a/g;->a([B[B)[B

    move-result-object v1

    invoke-static {v0}, Lcom/payeco/android/plugin/a/e;->a([B)[B

    move-result-object v2

    invoke-static {p1, v2}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    invoke-static {p0, v1}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;[B)V

    return-object v0
.end method

.method public static b()Ljava/lang/String;
    .locals 3

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v0, "01"

    sget-object v2, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "https://"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->e()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "/ppi/plugin/itf.do"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "02"

    sget-object v2, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "http://"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->e()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "https://"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->e()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static b(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {}, Lcom/payeco/android/plugin/b/g;->d()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 9

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->e()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->g()Ljava/lang/String;

    move-result-object v3

    invoke-static {p0}, Lcom/payeco/android/plugin/b/h;->d(Landroid/content/Context;)[B

    move-result-object v4

    invoke-static {v2}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {v3}, Lcom/payeco/android/plugin/c/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    invoke-static {v2, v3, v4}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;Ljava/lang/String;[B)[B

    move-result-object v0

    :goto_0
    new-instance v1, Lorg/json/JSONObject;

    new-instance v2, Ljava/lang/String;

    const-string v3, "utf-8"

    invoke-direct {v2, v0, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->f()[B

    move-result-object v0

    invoke-static {v1}, Lcom/payeco/android/plugin/b/g;->b(Lorg/json/JSONObject;)V

    invoke-static {v0}, Lcom/payeco/android/plugin/b/g;->a([B)V

    return-void

    :cond_1
    invoke-static {v2}, Lcom/payeco/android/plugin/c/b;->b(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v4, v0}, Lcom/payeco/android/plugin/a/g;->b([B[B)[B

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-static {v3}, Lcom/payeco/android/plugin/c/b;->b(Ljava/lang/String;)[B

    move-result-object v5

    invoke-static {v1}, Lcom/payeco/android/plugin/a/e;->a([B)[B

    move-result-object v6

    if-eqz v5, :cond_3

    if-eqz v6, :cond_3

    array-length v0, v5

    array-length v7, v6

    if-ne v0, v7, :cond_3

    const/4 v0, 0x0

    :goto_1
    array-length v7, v6

    if-lt v0, v7, :cond_2

    move-object v0, v1

    goto :goto_0

    :cond_2
    aget-byte v7, v5, v0

    aget-byte v8, v6, v0

    if-ne v7, v8, :cond_3

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    invoke-static {v2, v3, v4}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;Ljava/lang/String;[B)[B

    move-result-object v0

    goto :goto_0
.end method

.method public static c(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-static {}, Lcom/payeco/android/plugin/b/g;->h()[B

    move-result-object v0

    const-string v1, "utf-8"

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/a/g;->a([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/c/c;->a([B)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static c(Landroid/content/Context;)V
    .locals 6

    const-string v0, "01"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "domainIndex"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget v3, Lcom/payeco/android/plugin/b/h;->d:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "lastSaveDomainTime"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v3}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static c()Z
    .locals 3

    const/4 v0, 0x0

    const-string v1, "01"

    sget-object v2, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget v1, Lcom/payeco/android/plugin/b/h;->e:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/payeco/android/plugin/b/h;->e:I

    sget-object v2, Lcom/payeco/android/plugin/b/a;->e:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    sget v1, Lcom/payeco/android/plugin/b/h;->d:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/payeco/android/plugin/b/h;->d:I

    sget-object v2, Lcom/payeco/android/plugin/b/a;->e:[Ljava/lang/String;

    array-length v2, v2

    if-lt v1, v2, :cond_2

    sput v0, Lcom/payeco/android/plugin/b/h;->d:I

    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static d()Ljava/lang/String;
    .locals 2

    const-string v0, "01"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "payecoPreferencesPro"

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "02"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "payecoPreferencesDev"

    goto :goto_0

    :cond_1
    const-string v0, "payecoPreferencesTest"

    goto :goto_0
.end method

.method public static final d(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    sget-object v0, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    const-string v1, "01"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "payecoPluginPro"

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    :cond_0
    return-object v0

    :cond_1
    sget-object v0, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    const-string v1, "02"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "payecoPluginDev"

    goto :goto_0

    :cond_2
    const-string v0, "payecoPluginTest"

    goto :goto_0
.end method

.method private static d(Landroid/content/Context;)[B
    .locals 4

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "DataKey"

    invoke-static {p0, v0, v1}, Lcom/payeco/android/plugin/c/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->f()[B

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/c/c;->a([B)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v2

    const-string v3, "DataKey"

    invoke-static {p0, v2, v3, v1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-object v0

    :cond_0
    invoke-static {v0}, Lcom/payeco/android/plugin/c/c;->a(Ljava/lang/String;)[B

    move-result-object v0

    goto :goto_0
.end method

.method private static e()Ljava/lang/String;
    .locals 3

    const-string v0, "01"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/payeco/android/plugin/b/a;->e:[Ljava/lang/String;

    sget v1, Lcom/payeco/android/plugin/b/h;->d:I

    aget-object v0, v0, v1

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "02"

    sget-object v1, Lcom/payeco/android/plugin/b/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v1, Ljava/lang/StringBuilder;

    sget-object v0, Lcom/payeco/android/plugin/b/h;->b:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "80"

    sget-object v2, Lcom/payeco/android/plugin/b/h;->c:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, ""

    :goto_1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, ":"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/payeco/android/plugin/b/h;->c:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_2
    const-string v0, "testmobile.payeco.com"

    goto :goto_0
.end method

.method private static f()[B
    .locals 5

    const/16 v4, 0x18

    new-array v1, v4, [B

    new-instance v2, Ljava/util/Random;

    invoke-direct {v2}, Ljava/util/Random;-><init>()V

    const/4 v0, 0x0

    :goto_0
    if-lt v0, v4, :cond_0

    return-object v1

    :cond_0
    const/16 v3, 0x100

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
