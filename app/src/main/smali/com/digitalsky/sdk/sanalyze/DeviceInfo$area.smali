.class Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;
.super Ljava/lang/Object;
.source "DeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digitalsky/sdk/sanalyze/DeviceInfo;
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

    .line 614
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 619
    iput-wide v0, p0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLatitude:D

    .line 620
    iput-wide v0, p0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLongitude:D

    .line 615
    iput-wide p1, p0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLatitude:D

    .line 616
    iput-wide p3, p0, Lcom/digitalsky/sdk/sanalyze/DeviceInfo$area;->mLongitude:D

    .line 617
    return-void
.end method
