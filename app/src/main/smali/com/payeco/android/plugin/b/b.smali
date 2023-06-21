.class public final Lcom/payeco/android/plugin/b/b;
.super Ljava/lang/Object;


# static fields
.field private static a:Lcom/payeco/android/plugin/b/f;


# instance fields
.field private b:Landroid/content/Context;

.field private c:Landroid/location/LocationManager;

.field private d:Landroid/os/Looper;

.field private e:Landroid/location/LocationListener;

.field private f:Landroid/location/LocationListener;

.field private g:Ljava/lang/Thread;

.field private h:I

.field private i:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/payeco/android/plugin/b/b;->b:Landroid/content/Context;

    const-string v0, "location"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/LocationManager;

    iput-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    return-void
.end method

.method public static a()Lcom/payeco/android/plugin/b/f;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    return-object v0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/b/b;)V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->e:Landroid/location/LocationListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    iget-object v1, p0, Lcom/payeco/android/plugin/b/b;->e:Landroid/location/LocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/b/b;->e:Landroid/location/LocationListener;

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->f:Landroid/location/LocationListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    iget-object v1, p0, Lcom/payeco/android/plugin/b/b;->f:Landroid/location/LocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/b/b;->f:Landroid/location/LocationListener;

    :cond_1
    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/b/b;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/b/b;->d:Landroid/os/Looper;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/b/b;Lcom/payeco/android/plugin/b/f;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/b/b;->b(Lcom/payeco/android/plugin/b/f;)V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/b/f;)V
    .locals 0

    sput-object p0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 4

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->b()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "PPI_location="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Landroid/webkit/CookieSyncManager;->getInstance()Landroid/webkit/CookieSyncManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/CookieSyncManager;->sync()V

    return-void
.end method

.method static synthetic b(Lcom/payeco/android/plugin/b/b;)Landroid/os/Looper;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->d:Landroid/os/Looper;

    return-object v0
.end method

.method private b(Lcom/payeco/android/plugin/b/f;)V
    .locals 6

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->b:Landroid/content/Context;

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v1

    const-string v2, "payecoLat"

    new-instance v3, Ljava/lang/StringBuilder;

    iget-wide v4, p1, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->b:Landroid/content/Context;

    invoke-static {}, Lcom/payeco/android/plugin/b/h;->d()Ljava/lang/String;

    move-result-object v1

    const-string v2, "payecoLon"

    new-instance v3, Ljava/lang/StringBuilder;

    iget-wide v4, p1, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic c()Lcom/payeco/android/plugin/b/f;
    .locals 1

    sget-object v0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    return-object v0
.end method

.method static synthetic c(Lcom/payeco/android/plugin/b/b;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/payeco/android/plugin/b/b;->i:Z

    return-void
.end method

.method static synthetic d(Lcom/payeco/android/plugin/b/b;)V
    .locals 9

    const/4 v8, 0x0

    const/high16 v4, 0x3f800000    # 1.0f

    const/16 v0, 0x3e8

    :try_start_0
    const-string v1, "LbsTime"

    invoke-static {v1}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    move v7, v0

    :goto_0
    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/payeco/android/plugin/b/d;

    invoke-direct {v0, p0, v8}, Lcom/payeco/android/plugin/b/d;-><init>(Lcom/payeco/android/plugin/b/b;B)V

    iput-object v0, p0, Lcom/payeco/android/plugin/b/b;->f:Landroid/location/LocationListener;

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    const-string v1, "network"

    int-to-long v2, v7

    iget-object v5, p0, Lcom/payeco/android/plugin/b/b;->f:Landroid/location/LocationListener;

    iget-object v6, p0, Lcom/payeco/android/plugin/b/b;->d:Landroid/os/Looper;

    invoke-virtual/range {v0 .. v6}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V

    :cond_0
    invoke-direct {p0}, Lcom/payeco/android/plugin/b/b;->d()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lcom/payeco/android/plugin/b/d;

    invoke-direct {v0, p0, v8}, Lcom/payeco/android/plugin/b/d;-><init>(Lcom/payeco/android/plugin/b/b;B)V

    iput-object v0, p0, Lcom/payeco/android/plugin/b/b;->e:Landroid/location/LocationListener;

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    const-string v1, "gps"

    int-to-long v2, v7

    iget-object v5, p0, Lcom/payeco/android/plugin/b/b;->e:Landroid/location/LocationListener;

    iget-object v6, p0, Lcom/payeco/android/plugin/b/b;->d:Landroid/os/Looper;

    invoke-virtual/range {v0 .. v6}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V

    :cond_1
    return-void

    :catch_0
    move-exception v1

    move v7, v0

    goto :goto_0
.end method

.method private d()Z
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/b/b;)V
    .locals 4

    const/4 v1, 0x0

    const/4 v2, 0x1

    new-instance v0, Landroid/location/Criteria;

    invoke-direct {v0}, Landroid/location/Criteria;-><init>()V

    invoke-virtual {v0, v2}, Landroid/location/Criteria;->setAccuracy(I)V

    invoke-virtual {v0, v1}, Landroid/location/Criteria;->setAltitudeRequired(Z)V

    invoke-virtual {v0, v1}, Landroid/location/Criteria;->setBearingRequired(Z)V

    invoke-virtual {v0, v2}, Landroid/location/Criteria;->setCostAllowed(Z)V

    invoke-virtual {v0, v2}, Landroid/location/Criteria;->setPowerRequirement(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v0, v2}, Landroid/location/LocationManager;->getBestProvider(Landroid/location/Criteria;Z)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/payeco/android/plugin/b/b;->d()Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    const-string v0, "gps"

    :cond_1
    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_2

    iget v2, p0, Lcom/payeco/android/plugin/b/b;->h:I

    const/16 v3, 0x3e8

    if-lt v2, v3, :cond_4

    :cond_2
    if-eqz v1, :cond_3

    iget-boolean v0, p0, Lcom/payeco/android/plugin/b/b;->i:Z

    if-nez v0, :cond_3

    new-instance v0, Lcom/payeco/android/plugin/b/f;

    invoke-direct {v0}, Lcom/payeco/android/plugin/b/f;-><init>()V

    sput-object v0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iput-wide v2, v0, Lcom/payeco/android/plugin/b/f;->b:D

    sget-object v0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    iput-wide v2, v0, Lcom/payeco/android/plugin/b/f;->a:D

    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    iget-wide v2, v1, Lcom/payeco/android/plugin/b/f;->b:D

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    iget-wide v2, v1, Lcom/payeco/android/plugin/b/f;->a:D

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->a(Ljava/lang/String;)V

    sget-object v0, Lcom/payeco/android/plugin/b/b;->a:Lcom/payeco/android/plugin/b/f;

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/b/b;->b(Lcom/payeco/android/plugin/b/f;)V

    :cond_3
    return-void

    :cond_4
    iget-object v1, p0, Lcom/payeco/android/plugin/b/b;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v0}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    iget v2, p0, Lcom/payeco/android/plugin/b/b;->h:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/payeco/android/plugin/b/b;->h:I

    const-wide/16 v2, 0xa

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public final b()V
    .locals 2

    new-instance v0, Lcom/payeco/android/plugin/b/e;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/payeco/android/plugin/b/e;-><init>(Lcom/payeco/android/plugin/b/b;B)V

    iput-object v0, p0, Lcom/payeco/android/plugin/b/b;->g:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/payeco/android/plugin/b/b;->g:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/payeco/android/plugin/b/c;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/b/c;-><init>(Lcom/payeco/android/plugin/b/b;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method
