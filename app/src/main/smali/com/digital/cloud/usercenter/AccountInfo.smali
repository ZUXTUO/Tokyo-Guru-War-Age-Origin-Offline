.class public Lcom/digital/cloud/usercenter/AccountInfo;
.super Ljava/lang/Object;
.source "AccountInfo.java"


# static fields
.field public static MAX:I


# instance fields
.field public mId:Ljava/lang/String;

.field public mPwd:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 14
    const/4 v0, 0x3

    sput v0, Lcom/digital/cloud/usercenter/AccountInfo;->MAX:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "pwd"    # Ljava/lang/String;

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    iput-object p1, p0, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    .line 18
    iput-object p2, p0, Lcom/digital/cloud/usercenter/AccountInfo;->mPwd:Ljava/lang/String;

    .line 19
    return-void
.end method

.method public static Add(Ljava/util/ArrayList;Lcom/digital/cloud/usercenter/AccountInfo;)V
    .locals 3
    .param p1, "info"    # Lcom/digital/cloud/usercenter/AccountInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ")V"
        }
    .end annotation

    .prologue
    .line 32
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 43
    :cond_0
    :goto_0
    return-void

    .line 34
    :cond_1
    invoke-static {p0, p1}, Lcom/digital/cloud/usercenter/AccountInfo;->Contines(Ljava/util/ArrayList;Lcom/digital/cloud/usercenter/AccountInfo;)I

    move-result v0

    .line 35
    .local v0, "index":I
    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    .line 36
    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 38
    :cond_2
    const/4 v1, 0x0

    invoke-virtual {p0, v1, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 40
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v1

    sget v2, Lcom/digital/cloud/usercenter/AccountInfo;->MAX:I

    if-le v1, v2, :cond_0

    .line 41
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_0
.end method

.method public static Contines(Ljava/util/ArrayList;Lcom/digital/cloud/usercenter/AccountInfo;)I
    .locals 3
    .param p1, "info"    # Lcom/digital/cloud/usercenter/AccountInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ")I"
        }
    .end annotation

    .prologue
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    const/4 v2, -0x1

    .line 46
    if-eqz p0, :cond_0

    if-nez p1, :cond_2

    :cond_0
    move v0, v2

    .line 53
    :cond_1
    :goto_0
    return v0

    .line 48
    :cond_2
    const/4 v0, 0x0

    .local v0, "index":I
    :goto_1
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_3

    move v0, v2

    .line 53
    goto :goto_0

    .line 49
    :cond_3
    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/digital/cloud/usercenter/AccountInfo;

    invoke-virtual {v1, p1}, Lcom/digital/cloud/usercenter/AccountInfo;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 48
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public static delete(Ljava/util/ArrayList;I)V
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;I)V"
        }
    .end annotation

    .prologue
    .line 57
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    if-eqz p0, :cond_0

    if-ltz p1, :cond_0

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 60
    :cond_0
    :goto_0
    return-void

    .line 59
    :cond_1
    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_0
.end method

.method public static get(Ljava/util/ArrayList;I)Lcom/digital/cloud/usercenter/AccountInfo;
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;I)",
            "Lcom/digital/cloud/usercenter/AccountInfo;"
        }
    .end annotation

    .prologue
    .line 63
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    if-eqz p0, :cond_0

    if-ltz p1, :cond_0

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 64
    :cond_0
    new-instance v0, Lcom/digital/cloud/usercenter/AccountInfo;

    const-string v1, ""

    const-string v2, ""

    invoke-direct {v0, v1, v2}, Lcom/digital/cloud/usercenter/AccountInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 65
    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/AccountInfo;

    goto :goto_0
.end method

.method public static getAccounts(Ljava/util/ArrayList;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;)",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 69
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 70
    .local v0, "accountList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    if-nez p0, :cond_1

    .line 76
    :cond_0
    return-object v0

    .line 72
    :cond_1
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 73
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/digital/cloud/usercenter/AccountInfo;

    iget-object v2, v2, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 72
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static toJsonArr(Ljava/util/ArrayList;)Lorg/json/JSONArray;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;)",
            "Lorg/json/JSONArray;"
        }
    .end annotation

    .prologue
    .line 80
    .local p0, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 81
    .local v0, "arr":Lorg/json/JSONArray;
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lt v2, v4, :cond_0

    .line 93
    return-object v0

    .line 82
    :cond_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 84
    .local v3, "item":Lorg/json/JSONObject;
    :try_start_0
    const-string v5, "id"

    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/digital/cloud/usercenter/AccountInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v3, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 85
    const-string v5, "pwd"

    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/digital/cloud/usercenter/AccountInfo;

    iget-object v4, v4, Lcom/digital/cloud/usercenter/AccountInfo;->mPwd:Ljava/lang/String;

    invoke-virtual {v3, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 86
    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 87
    :catch_0
    move-exception v1

    .line 89
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public static toList(Lorg/json/JSONArray;)Ljava/util/ArrayList;
    .locals 7
    .param p0, "array"    # Lorg/json/JSONArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/json/JSONArray;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/AccountInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 97
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 98
    .local v4, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/AccountInfo;>;"
    if-nez p0, :cond_1

    .line 113
    :cond_0
    return-object v4

    .line 101
    :cond_1
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v1, v5, :cond_0

    .line 104
    :try_start_0
    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/json/JSONObject;

    .line 105
    .local v3, "item":Lorg/json/JSONObject;
    new-instance v2, Lcom/digital/cloud/usercenter/AccountInfo;

    const-string v5, "id"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "pwd"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v2, v5, v6}, Lcom/digital/cloud/usercenter/AccountInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 106
    .local v2, "info":Lcom/digital/cloud/usercenter/AccountInfo;
    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 101
    .end local v2    # "info":Lcom/digital/cloud/usercenter/AccountInfo;
    .end local v3    # "item":Lorg/json/JSONObject;
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 107
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "obj"    # Ljava/lang/Object;

    .prologue
    const/4 v1, 0x0

    .line 23
    if-nez p1, :cond_1

    .line 28
    :cond_0
    :goto_0
    return v1

    .line 25
    :cond_1
    const-class v2, Lcom/digital/cloud/usercenter/AccountInfo;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v2

    if-eqz v2, :cond_0

    move-object v0, p1

    .line 27
    check-cast v0, Lcom/digital/cloud/usercenter/AccountInfo;

    .line 28
    .local v0, "other":Lcom/digital/cloud/usercenter/AccountInfo;
    iget-object v1, p0, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    iget-object v2, v0, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    goto :goto_0
.end method
