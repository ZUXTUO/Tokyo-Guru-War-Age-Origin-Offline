.class public Lcom/pg/im/sdk/lib/c/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static a:Lcom/pg/im/sdk/lib/c/a;


# instance fields
.field private b:Landroid/content/Context;

.field private c:Landroid/location/LocationManager;

.field private d:Lcom/pg/im/sdk/lib/c/b;

.field private e:D

.field private f:D

.field private g:D

.field private h:D


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/pg/im/sdk/lib/c/b;)V
    .locals 2

    .prologue
    const-wide/16 v0, 0x0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 25
    iput-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 44
    iput-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    .line 45
    iput-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    .line 37
    iput-object p1, p0, Lcom/pg/im/sdk/lib/c/a;->b:Landroid/content/Context;

    .line 39
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->b:Landroid/content/Context;

    const-string v1, "location"

    .line 40
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/LocationManager;

    iput-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    .line 41
    iput-object p2, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    .line 42
    return-void
.end method

.method public static a(Landroid/content/Context;Lcom/pg/im/sdk/lib/c/b;)Lcom/pg/im/sdk/lib/c/a;
    .locals 1

    .prologue
    .line 28
    sget-object v0, Lcom/pg/im/sdk/lib/c/a;->a:Lcom/pg/im/sdk/lib/c/a;

    if-eqz v0, :cond_0

    .line 29
    sget-object v0, Lcom/pg/im/sdk/lib/c/a;->a:Lcom/pg/im/sdk/lib/c/a;

    .line 33
    :goto_0
    return-object v0

    .line 31
    :cond_0
    new-instance v0, Lcom/pg/im/sdk/lib/c/a;

    invoke-direct {v0, p0, p1}, Lcom/pg/im/sdk/lib/c/a;-><init>(Landroid/content/Context;Lcom/pg/im/sdk/lib/c/b;)V

    sput-object v0, Lcom/pg/im/sdk/lib/c/a;->a:Lcom/pg/im/sdk/lib/c/a;

    .line 33
    sget-object v0, Lcom/pg/im/sdk/lib/c/a;->a:Lcom/pg/im/sdk/lib/c/a;

    goto :goto_0
.end method

.method private h()Landroid/location/LocationListener;
    .locals 6

    .prologue
    .line 168
    new-instance v5, Lcom/pg/im/sdk/lib/c/a$1;

    invoke-direct {v5, p0}, Lcom/pg/im/sdk/lib/c/a$1;-><init>(Lcom/pg/im/sdk/lib/c/a;)V

    .line 198
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "gps"

    const-wide/16 v2, 0x3e8

    const/high16 v4, 0x41200000    # 10.0f

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 199
    return-object v5
.end method

.method private i()Landroid/location/LocationListener;
    .locals 6

    .prologue
    .line 203
    new-instance v5, Lcom/pg/im/sdk/lib/c/a$2;

    invoke-direct {v5, p0}, Lcom/pg/im/sdk/lib/c/a$2;-><init>(Lcom/pg/im/sdk/lib/c/a;)V

    .line 235
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "network"

    const-wide/16 v2, 0x3e8

    const/high16 v4, 0x41200000    # 10.0f

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 236
    return-object v5
.end method


# virtual methods
.method public a()Z
    .locals 8

    .prologue
    const/4 v1, 0x0

    const-wide/16 v6, 0x0

    const/4 v0, 0x1

    .line 59
    iput-wide v6, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    .line 60
    iput-wide v6, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    .line 61
    iget-object v2, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v3, "gps"

    invoke-virtual {v2, v3}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 63
    iget-object v2, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v3, "gps"

    .line 64
    invoke-virtual {v2, v3}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v2

    .line 65
    if-eqz v2, :cond_0

    .line 66
    invoke-virtual {v2}, Landroid/location/Location;->getLatitude()D

    move-result-wide v4

    iput-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    .line 67
    invoke-virtual {v2}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    .line 69
    :cond_0
    invoke-direct {p0}, Lcom/pg/im/sdk/lib/c/a;->h()Landroid/location/LocationListener;

    move-result-object v2

    .line 71
    iget-object v3, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v4, "gps"

    .line 72
    invoke-virtual {v3, v4}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v3

    .line 73
    if-eqz v3, :cond_1

    .line 74
    invoke-virtual {v3}, Landroid/location/Location;->getLatitude()D

    move-result-wide v4

    iput-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    .line 75
    invoke-virtual {v3}, Landroid/location/Location;->getLongitude()D

    move-result-wide v4

    iput-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    .line 78
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v0, v3}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    .line 79
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v2}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 93
    :goto_0
    return v0

    .line 82
    :cond_1
    iget-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    cmpl-double v2, v2, v6

    if-eqz v2, :cond_2

    iget-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    cmpl-double v2, v2, v6

    if-eqz v2, :cond_2

    .line 83
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->h:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->g:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    goto :goto_0

    .line 86
    :cond_2
    iget-object v2, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v3, 0x79d

    invoke-interface {v2, v3, v0}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    move v0, v1

    .line 93
    goto :goto_0

    .line 90
    :cond_3
    iget-object v2, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v3, 0x797

    invoke-interface {v2, v3, v0}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    move v0, v1

    .line 91
    goto :goto_0
.end method

.method public b()V
    .locals 3

    .prologue
    .line 97
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x79a

    const/16 v2, 0x8

    invoke-interface {v0, v1, v2}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    .line 98
    return-void
.end method

.method public c()V
    .locals 7

    .prologue
    const/16 v6, 0x20

    .line 101
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 102
    invoke-direct {p0}, Lcom/pg/im/sdk/lib/c/a;->i()Landroid/location/LocationListener;

    move-result-object v0

    .line 103
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v2, "network"

    invoke-virtual {v1, v2}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    .line 104
    if-eqz v1, :cond_0

    .line 105
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 106
    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 107
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v6, v2}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    .line 109
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v0}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 116
    :cond_0
    :goto_0
    return-void

    .line 114
    :cond_1
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x79a

    invoke-interface {v0, v1, v6}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    goto :goto_0
.end method

.method public d()V
    .locals 7

    .prologue
    const/16 v6, 0x40

    const-wide/16 v4, 0x0

    .line 119
    iput-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 120
    iput-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 121
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 122
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "gps"

    .line 123
    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v0

    .line 124
    if-eqz v0, :cond_0

    .line 125
    invoke-virtual {v0}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 126
    invoke-virtual {v0}, Landroid/location/Location;->getLongitude()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 128
    :cond_0
    invoke-direct {p0}, Lcom/pg/im/sdk/lib/c/a;->h()Landroid/location/LocationListener;

    move-result-object v0

    .line 130
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v2, "gps"

    .line 131
    invoke-virtual {v1, v2}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    .line 132
    if-eqz v1, :cond_1

    .line 133
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 134
    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 135
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v6, v2}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    .line 137
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v0}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 165
    :goto_0
    return-void

    .line 141
    :cond_1
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 142
    invoke-direct {p0}, Lcom/pg/im/sdk/lib/c/a;->i()Landroid/location/LocationListener;

    move-result-object v0

    .line 143
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    const-string v2, "network"

    .line 144
    invoke-virtual {v1, v2}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v1

    .line 145
    if-eqz v1, :cond_2

    .line 146
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    .line 147
    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iput-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    .line 148
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v6, v2}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    .line 152
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->c:Landroid/location/LocationManager;

    invoke-virtual {v1, v0}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    goto :goto_0

    .line 157
    :cond_2
    iget-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    cmpl-double v0, v0, v4

    if-eqz v0, :cond_3

    iget-wide v0, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    cmpl-double v0, v0, v4

    if-eqz v0, :cond_3

    .line 158
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->f:D

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/pg/im/sdk/lib/c/a;->e:D

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v6, v1}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    goto :goto_0

    .line 162
    :cond_3
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x79a

    invoke-interface {v0, v1, v6}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    goto :goto_0
.end method

.method public e()V
    .locals 8

    .prologue
    const/4 v7, 0x2

    .line 240
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->b:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 241
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v2

    .line 242
    const-string v0, "wifi"

    .line 243
    iget-object v1, p0, Lcom/pg/im/sdk/lib/c/a;->b:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 244
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getScanResults()Ljava/util/List;

    move-result-object v3

    .line 245
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    .line 246
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 247
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/ScanResult;

    .line 248
    const-string v5, ""

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 249
    const-string v5, "{"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 250
    iget-object v5, v0, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 251
    const-string v5, "|"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 252
    iget v0, v0, Landroid/net/wifi/ScanResult;->level:I

    const/4 v5, 0x5

    invoke-static {v0, v5}, Landroid/net/wifi/WifiManager;->calculateSignalLevel(II)I

    move-result v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 253
    const-string v0, "|"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 254
    const-string v0, "}"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 256
    :cond_0
    const/16 v0, 0x1e

    if-lt v1, v0, :cond_2

    .line 260
    :cond_1
    const-string v0, "|"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 261
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 262
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x794

    invoke-interface {v0, v1, v7}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    .line 266
    :goto_1
    return-void

    .line 246
    :cond_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 264
    :cond_3
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v7, v1}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    goto :goto_1
.end method

.method public f()V
    .locals 9

    .prologue
    const/16 v8, 0x79a

    const/4 v7, 0x4

    const/4 v4, 0x3

    .line 270
    :try_start_0
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->b:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 271
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkOperator()Ljava/lang/String;

    move-result-object v1

    .line 272
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v2

    .line 273
    const-string v3, ""

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    if-le v3, v4, :cond_1

    .line 274
    const/4 v3, 0x0

    const/4 v4, 0x3

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    .line 275
    const/4 v4, 0x3

    invoke-virtual {v1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 277
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNeighboringCellInfo()Ljava/util/List;

    move-result-object v0

    .line 278
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    .line 279
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/NeighboringCellInfo;

    .line 280
    const-string v6, "{"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 281
    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 282
    const-string v6, "|"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 283
    invoke-virtual {v4, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 284
    const-string v6, "|"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 285
    invoke-virtual {v0}, Landroid/telephony/NeighboringCellInfo;->getCid()I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 286
    const-string v6, "|"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 287
    invoke-virtual {v0}, Landroid/telephony/NeighboringCellInfo;->getLac()I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 288
    const-string v6, "|"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 289
    invoke-virtual {v0}, Landroid/telephony/NeighboringCellInfo;->getRssi()I

    move-result v0

    mul-int/lit8 v0, v0, 0x2

    add-int/lit8 v0, v0, -0x71

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 290
    const-string v0, "|"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 291
    const-string v0, "|"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 292
    const-string v0, "}"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 300
    :catch_0
    move-exception v0

    .line 301
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 302
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    invoke-interface {v0, v8, v7}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    .line 304
    :goto_1
    return-void

    .line 295
    :cond_0
    :try_start_1
    const-string v0, "|"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 296
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/4 v1, 0x4

    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/pg/im/sdk/lib/c/b;->a(ILjava/lang/String;)V

    goto :goto_1

    .line 298
    :cond_1
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x79a

    const/4 v2, 0x4

    invoke-interface {v0, v1, v2}, Lcom/pg/im/sdk/lib/c/b;->a(II)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public g()V
    .locals 3

    .prologue
    .line 307
    iget-object v0, p0, Lcom/pg/im/sdk/lib/c/a;->d:Lcom/pg/im/sdk/lib/c/b;

    const/16 v1, 0x79a

    const/16 v2, 0x10

    invoke-interface {v0, v1, v2}, Lcom/pg/im/sdk/lib/c/b;->a(II)V

    .line 308
    return-void
.end method
