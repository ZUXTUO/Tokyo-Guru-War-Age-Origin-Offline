.class public Lcom/sina/weibo/sdk/openapi/models/Coordinate;
.super Ljava/lang/Object;
.source "Coordinate.java"


# instance fields
.field public Latitude:Ljava/lang/Double;

.field public Longtitude:Ljava/lang/Double;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Coordinate;
    .locals 4
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 32
    if-nez p0, :cond_0

    .line 33
    const/4 v0, 0x0

    .line 40
    :goto_0
    return-object v0

    .line 36
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Coordinate;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Coordinate;-><init>()V

    .line 37
    .local v0, "coordinate":Lcom/sina/weibo/sdk/openapi/models/Coordinate;
    const-string v1, "longitude"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Coordinate;->Longtitude:Ljava/lang/Double;

    .line 38
    const-string v1, "latitude"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    iput-object v1, v0, Lcom/sina/weibo/sdk/openapi/models/Coordinate;->Latitude:Ljava/lang/Double;

    goto :goto_0
.end method
