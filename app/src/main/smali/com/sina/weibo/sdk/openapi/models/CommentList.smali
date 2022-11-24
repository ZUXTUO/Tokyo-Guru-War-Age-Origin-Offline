.class public Lcom/sina/weibo/sdk/openapi/models/CommentList;
.super Ljava/lang/Object;
.source "CommentList.java"


# instance fields
.field public commentList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/sina/weibo/sdk/openapi/models/Comment;",
            ">;"
        }
    .end annotation
.end field

.field public next_cursor:Ljava/lang/String;

.field public previous_cursor:Ljava/lang/String;

.field public total_number:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/sina/weibo/sdk/openapi/models/CommentList;
    .locals 8
    .param p0, "jsonString"    # Ljava/lang/String;

    .prologue
    .line 42
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 43
    const/4 v0, 0x0

    .line 65
    :cond_0
    :goto_0
    return-object v0

    .line 46
    :cond_1
    new-instance v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/openapi/models/CommentList;-><init>()V

    .line 48
    .local v0, "comments":Lcom/sina/weibo/sdk/openapi/models/CommentList;
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 49
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v6, "previous_cursor"

    const-string v7, "0"

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;->previous_cursor:Ljava/lang/String;

    .line 50
    const-string v6, "next_cursor"

    const-string v7, "0"

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;->next_cursor:Ljava/lang/String;

    .line 51
    const-string v6, "total_number"

    const/4 v7, 0x0

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    iput v6, v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;->total_number:I

    .line 53
    const-string v6, "comments"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    .line 54
    .local v3, "jsonArray":Lorg/json/JSONArray;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_0

    .line 55
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    .line 56
    .local v5, "length":I
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v5}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v6, v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;->commentList:Ljava/util/ArrayList;

    .line 57
    const/4 v2, 0x0

    .local v2, "ix":I
    :goto_1
    if-ge v2, v5, :cond_0

    .line 58
    iget-object v6, v0, Lcom/sina/weibo/sdk/openapi/models/CommentList;->commentList:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    invoke-static {v7}, Lcom/sina/weibo/sdk/openapi/models/Comment;->parse(Lorg/json/JSONObject;)Lcom/sina/weibo/sdk/openapi/models/Comment;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 57
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 61
    .end local v2    # "ix":I
    .end local v3    # "jsonArray":Lorg/json/JSONArray;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "length":I
    :catch_0
    move-exception v1

    .line 62
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
