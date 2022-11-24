.class public final Lcom/payeco/android/plugin/b/g;
.super Ljava/lang/Object;


# static fields
.field private static a:Ljava/lang/String;

.field private static b:Lorg/json/JSONObject;

.field private static c:Lorg/json/JSONObject;

.field private static d:Ljava/lang/String;

.field private static e:Ljava/lang/String;

.field private static f:Ljava/lang/String;

.field private static g:[B


# direct methods
.method public static a()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/payeco/android/plugin/b/g;->a:Ljava/lang/String;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->b:Lorg/json/JSONObject;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->c:Lorg/json/JSONObject;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->d:Ljava/lang/String;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->e:Ljava/lang/String;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->f:Ljava/lang/String;

    sput-object v0, Lcom/payeco/android/plugin/b/g;->g:[B

    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->a:Ljava/lang/String;

    return-void
.end method

.method public static a(Lorg/json/JSONObject;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->b:Lorg/json/JSONObject;

    return-void
.end method

.method public static a([B)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->g:[B

    return-void
.end method

.method public static b()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->a:Ljava/lang/String;

    return-object v0
.end method

.method public static b(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->d:Ljava/lang/String;

    return-void
.end method

.method public static b(Lorg/json/JSONObject;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->c:Lorg/json/JSONObject;

    return-void
.end method

.method public static c()Lorg/json/JSONObject;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->b:Lorg/json/JSONObject;

    return-object v0
.end method

.method public static c(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->f:Ljava/lang/String;

    return-void
.end method

.method public static d()Lorg/json/JSONObject;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->c:Lorg/json/JSONObject;

    return-object v0
.end method

.method public static d(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/g;->e:Ljava/lang/String;

    return-void
.end method

.method public static e()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->d:Ljava/lang/String;

    return-object v0
.end method

.method public static e(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lcom/payeco/android/plugin/c/c;->a(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/payeco/android/plugin/b/g;->g:[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->f:Ljava/lang/String;

    return-object v0
.end method

.method public static g()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->e:Ljava/lang/String;

    return-object v0
.end method

.method public static h()[B
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/g;->g:[B

    return-object v0
.end method

.method public static i()Ljava/lang/String;
    .locals 1

    :try_start_0
    sget-object v0, Lcom/payeco/android/plugin/b/g;->g:[B

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
