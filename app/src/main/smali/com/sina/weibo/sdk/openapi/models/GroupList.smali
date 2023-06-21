.class public Lcom/sina/weibo/sdk/openapi/models/GroupList;
.super Ljava/lang/Object;
.source "GroupList.java"


# instance fields
.field public groupList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/sina/weibo/sdk/openapi/models/Group;",
            ">;"
        }
    .end annotation
.end field

.field public total_number:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/GroupList;
    .locals 8
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 40
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 41
    const/4 v1, 0x0

    .line 61
    :cond_0
    :goto_0
    return-object v1

    .line 44
    :cond_1
    new-instance v1, Lcom/sina/weibo/sdk/openapi/models/GroupList;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/openapi/models/GroupList;-><init>()V

    .line 46
    .local v1, "groupList":Lcom/sina/weibo/sdk/openapi/models/GroupList;
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 47
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v6, "total_number"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v6

    iput v6, v1, Lcom/sina/weibo/sdk/openapi/models/GroupList;->total_number:I

    .line 49
    const-string v6, "lists"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    .line 50
    .local v3, "jsonArray":Lorg/json/JSONArray;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_0

    .line 51
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    .line 52
    .local v5, "length":I
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v5}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v6, v1, Lcom/sina/weibo/sdk/openapi/models/GroupList;->groupList:Ljava/util/ArrayList;

    .line 53
    const/4 v2, 0x0

    .local v2, "ix":I
    :goto_1
    if-ge v2, v5, :cond_0

    .line 54
    iget-object v6, v1, Lcom/sina/weibo/sdk/openapi/models/GroupList;->groupList:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    invoke-static {v7}, Lcom/sina/weibo/sdk/openapi/models/Group;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Group;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 53
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 57
    .end local v2    # "ix":I
    .end local v3    # "jsonArray":Lorg/json/JSONArray;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "length":I
    :catch_0
    move-exception v0

    .line 58
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
