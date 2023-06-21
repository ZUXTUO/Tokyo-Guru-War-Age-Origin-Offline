.class Lorg/deviceinfo/DeviceInfo$area;
.super Ljava/lang/Object;
.source "DeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/deviceinfo/DeviceInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "area"
.end annotation


# instance fields
.field public mLatitude:D

.field public mLongitude:D


# direct methods
.method public constructor <init>(DD)V
    .locals 3
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D

    .prologue
    const-wide/16 v0, 0x0

    .line 629
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 634
    iput-wide v0, p0, Lorg/deviceinfo/DeviceInfo$area;->mLatitude:D

    .line 635
    iput-wide v0, p0, Lorg/deviceinfo/DeviceInfo$area;->mLongitude:D

    .line 630
    iput-wide p1, p0, Lorg/deviceinfo/DeviceInfo$area;->mLatitude:D

    .line 631
    iput-wide p3, p0, Lorg/deviceinfo/DeviceInfo$area;->mLongitude:D

    .line 632
    return-void
.end method
