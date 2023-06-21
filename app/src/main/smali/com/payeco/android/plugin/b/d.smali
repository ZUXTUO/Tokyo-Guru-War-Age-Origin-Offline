.class final Lcom/payeco/android/plugin/b/d;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/location/LocationListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/b/b;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/b/b;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/b/d;->a:Lcom/payeco/android/plugin/b/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/b/b;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/b/d;-><init>(Lcom/payeco/android/plugin/b/b;)V

    return-void
.end method


# virtual methods
.method public final onLocationChanged(Landroid/location/Location;)V
    .locals 5

    iget-object v0, p0, Lcom/payeco/android/plugin/b/d;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->a(Lcom/payeco/android/plugin/b/b;)V

    :try_start_0
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    invoke-virtual {p1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v0

    invoke-virtual {p1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    new-instance v4, Lcom/payeco/android/plugin/b/f;

    invoke-direct {v4}, Lcom/payeco/android/plugin/b/f;-><init>()V

    invoke-static {v4}, Lcom/payeco/android/plugin/b/b;->a(Lcom/payeco/android/plugin/b/f;)V

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->c()Lcom/payeco/android/plugin/b/f;

    move-result-object v4

    iput-wide v0, v4, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->c()Lcom/payeco/android/plugin/b/f;

    move-result-object v0

    iput-wide v2, v0, Lcom/payeco/android/plugin/b/f;->b:D

    iget-object v0, p0, Lcom/payeco/android/plugin/b/d;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->c()Lcom/payeco/android/plugin/b/f;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/b/b;->a(Lcom/payeco/android/plugin/b/b;Lcom/payeco/android/plugin/b/f;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->c()Lcom/payeco/android/plugin/b/f;

    move-result-object v1

    iget-wide v2, v1, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/payeco/android/plugin/b/b;->c()Lcom/payeco/android/plugin/b/f;

    move-result-object v1

    iget-wide v2, v1, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/b/d;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->b(Lcom/payeco/android/plugin/b/b;)Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    iget-object v0, p0, Lcom/payeco/android/plugin/b/d;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->c(Lcom/payeco/android/plugin/b/b;)V

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    return-void

    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit p0

    throw v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public final onProviderDisabled(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final onProviderEnabled(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .locals 0

    return-void
.end method
