.class final Lcom/payeco/android/plugin/g;
.super Landroid/os/AsyncTask;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

.field private b:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/g;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method private varargs a()Ljava/lang/Void;
    .locals 10

    const/16 v7, 0x64

    const/16 v0, 0x1f4

    :try_start_0
    const-string v1, "PhotoSize"

    invoke-static {v1}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    move v8, v0

    :goto_0
    :try_start_1
    sget-object v0, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/c/a;->a(Ljava/lang/String;)I

    move-result v1

    sget-object v0, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    sget-object v9, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    sget-object v2, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/16 v3, 0xb

    if-le v2, v3, :cond_3

    const/16 v2, 0x280

    const/16 v3, 0x3c0

    invoke-static {v0, v2, v3}, Lcom/payeco/android/plugin/c/a;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object v0

    :goto_1
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    int-to-float v2, v1

    invoke-virtual {v5, v2}, Landroid/graphics/Matrix;->postRotate(F)Z

    if-eqz v1, :cond_5

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v0

    move-object v2, v0

    :goto_2
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x64

    invoke-virtual {v2, v1, v4, v3}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    array-length v0, v0

    move v1, v7

    :goto_3
    div-int/lit16 v0, v0, 0x400

    if-le v0, v8, :cond_1

    const/16 v0, 0xa

    if-ne v1, v0, :cond_4

    :cond_1
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->close()V

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    invoke-static {}, Ljava/lang/System;->gc()V

    :cond_2
    sget-object v0, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    const/16 v1, 0x64

    const/16 v2, 0x64

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/a;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/c/a;->a(Landroid/graphics/Bitmap;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/g;->b:Ljava/lang/String;

    :goto_4
    const/4 v0, 0x0

    return-object v0

    :catch_0
    move-exception v1

    move v8, v0

    goto/16 :goto_0

    :cond_3
    const/16 v2, 0xf0

    const/16 v3, 0x140

    invoke-static {v0, v2, v3}, Lcom/payeco/android/plugin/c/a;->a(Ljava/lang/String;II)Landroid/graphics/Bitmap;

    move-result-object v0

    goto/16 :goto_1

    :cond_4
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->reset()V

    sget-object v0, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {v2, v0, v1, v3}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    array-length v0, v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v1, v1, -0x3

    goto :goto_3

    :catch_1
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "\u538b\u7f29\u5931\u8d25"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_4

    :cond_5
    move-object v2, v0

    goto/16 :goto_2
.end method


# virtual methods
.method protected final varargs synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    invoke-direct {p0}, Lcom/payeco/android/plugin/g;->a()Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method

.method protected final synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 9

    const/4 v3, 0x4

    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/g;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "data:image/jpg;base64,"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/g;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/g;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/g;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v2}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Ljava/lang/String;

    move-result-object v2

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    const-string v4, ""

    aput-object v4, v3, v6

    sget-object v4, Lcom/payeco/android/plugin/b/a;->c:Ljava/lang/String;

    aput-object v4, v3, v7

    aput-object v0, v3, v8

    invoke-virtual {v1, v2, v3}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/g;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/g;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->n(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v5

    const-string v3, "\u62cd\u7167\u51fa\u9519\uff01"

    aput-object v3, v2, v6

    const-string v3, ""

    aput-object v3, v2, v7

    const-string v3, ""

    aput-object v3, v2, v8

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method
