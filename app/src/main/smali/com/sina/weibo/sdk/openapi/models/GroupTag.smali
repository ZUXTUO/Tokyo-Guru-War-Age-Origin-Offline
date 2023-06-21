.class public Lcom/sina/weibo/sdk/openapi/models/GroupTag;
.super Ljava/lang/Object;
.source "GroupTag.java"


# instance fields
.field public tag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/GroupTag;
    .locals 1
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    .line 32
    if-nez p0, :cond_0

    .line 33
    const/4 v0, 0x0

    .line 39
    :goto_0
    return-object v0

    .line 36
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/GroupTag;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/GroupTag;-><init>()V

    .line 39
    .local v0, "tag":Lcom/sina/weibo/sdk/openapi/models/GroupTag;
    goto :goto_0
.end method
