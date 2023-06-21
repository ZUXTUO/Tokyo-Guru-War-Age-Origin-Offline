.class public Lcom/talkingdata/sdk/bc;
.super Lcom/talkingdata/sdk/az;


# direct methods
.method public constructor <init>()V
    .locals 5

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    const-string v0, "manufacture"

    invoke-static {}, Lcom/talkingdata/sdk/e;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/talkingdata/sdk/bc;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "brand"

    invoke-static {}, Lcom/talkingdata/sdk/e;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/talkingdata/sdk/bc;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "model"

    invoke-static {}, Lcom/talkingdata/sdk/e;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/talkingdata/sdk/bc;->a(Ljava/lang/String;Ljava/lang/Object;)V

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    invoke-static {}, Lcom/talkingdata/sdk/e;->k()[Ljava/lang/String;

    move-result-object v3

    move v0, v1

    :goto_0
    array-length v4, v3

    if-ge v0, v4, :cond_0

    aget-object v4, v3, v0

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    const-string v0, "cpuInfo"

    invoke-virtual {p0, v0, v2}, Lcom/talkingdata/sdk/bc;->a(Ljava/lang/String;Ljava/lang/Object;)V

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    invoke-static {}, Lcom/talkingdata/sdk/e;->m()[I

    move-result-object v3

    :goto_1
    array-length v4, v3

    if-ge v1, v4, :cond_1

    aget v4, v3, v1

    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->put(I)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    const-string v0, "memoryInfo"

    invoke-virtual {p0, v0, v2}, Lcom/talkingdata/sdk/bc;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
