.class final Lcom/payeco/android/plugin/e;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/hardware/Camera$PictureCallback;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/b;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/b;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/e;->a:Lcom/payeco/android/plugin/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onPictureTaken([BLandroid/hardware/Camera;)V
    .locals 4

    const/4 v2, 0x0

    :try_start_0
    new-instance v1, Ljava/io/FileOutputStream;

    sget-object v0, Lcom/payeco/android/plugin/b/a;->b:Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1, p1}, Ljava/io/FileOutputStream;->write([B)V

    iget-object v0, p0, Lcom/payeco/android/plugin/e;->a:Lcom/payeco/android/plugin/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b;->a(Lcom/payeco/android/plugin/b;)Lcom/payeco/android/plugin/a;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/a;->a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;

    move-result-object v0

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/payeco/android/plugin/PayecoCameraActivity;->setResult(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3

    :goto_0
    iget-object v0, p0, Lcom/payeco/android/plugin/e;->a:Lcom/payeco/android/plugin/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b;->a(Lcom/payeco/android/plugin/b;)Lcom/payeco/android/plugin/a;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/a;->a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->finish()V

    :cond_0
    :goto_1
    return-void

    :catch_0
    move-exception v0

    move-object v1, v2

    :goto_2
    :try_start_3
    const-string v2, "payeco"

    const-string v3, "\u62cd\u7167\u8f93\u51fa\u9519\u8bef!"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-eqz v1, :cond_0

    :try_start_4
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    :goto_3
    iget-object v0, p0, Lcom/payeco/android/plugin/e;->a:Lcom/payeco/android/plugin/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b;->a(Lcom/payeco/android/plugin/b;)Lcom/payeco/android/plugin/a;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/a;->a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->finish()V

    goto :goto_1

    :catchall_0
    move-exception v0

    move-object v1, v2

    :goto_4
    if-eqz v1, :cond_1

    :try_start_5
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    :goto_5
    iget-object v1, p0, Lcom/payeco/android/plugin/e;->a:Lcom/payeco/android/plugin/b;

    invoke-static {v1}, Lcom/payeco/android/plugin/b;->a(Lcom/payeco/android/plugin/b;)Lcom/payeco/android/plugin/a;

    move-result-object v1

    invoke-static {v1}, Lcom/payeco/android/plugin/a;->a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;

    move-result-object v1

    invoke-virtual {v1}, Lcom/payeco/android/plugin/PayecoCameraActivity;->finish()V

    :cond_1
    throw v0

    :catch_1
    move-exception v0

    goto :goto_3

    :catch_2
    move-exception v1

    goto :goto_5

    :catch_3
    move-exception v0

    goto :goto_0

    :catchall_1
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v0

    goto :goto_2
.end method
