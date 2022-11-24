.class public Lcom/sina/weibo/sdk/openapi/models/Visible;
.super Ljava/lang/Object;
.source "Visible.java"


# static fields
.field public static final VISIBLE_FRIEND:I = 0x3

.field public static final VISIBLE_GROUPED:I = 0x2

.field public static final VISIBLE_NORMAL:I = 0x0

.field public static final VISIBLE_PRIVACY:I = 0x1


# instance fields
.field public list_id:I

.field public type:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Visible;
    .locals 3
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .prologue
    const/4 v2, 0x0

    .line 40
    if-nez p0, :cond_0

    .line 41
    const/4 v0, 0x0

    .line 48
    :goto_0
    return-object v0

    .line 44
    :cond_0
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/Visible;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/Visible;-><init>()V

    .line 45
    .local v0, "visible":Lcom/sina/weibo/sdk/openapi/models/Visible;
    const-string v1, "type"

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/Visible;->type:I

    .line 46
    const-string v1, "list_id"

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/sina/weibo/sdk/openapi/models/Visible;->list_id:I

    goto :goto_0
.end method
