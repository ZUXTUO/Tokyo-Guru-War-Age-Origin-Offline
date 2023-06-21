.class public Lcom/talkingdata/sdk/bd;
.super Lcom/talkingdata/sdk/az;


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    const-string v0, "tid"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/d;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/i;->y(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    if-eqz v0, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "imei"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_0

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "imei"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    :cond_0
    const-string v0, "imeis"

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/d;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const-string v1, "wifiMacs"

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/d;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "androidId"

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "adId"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/d;->h(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v1, "serialNo"

    invoke-static {}, Lcom/talkingdata/sdk/d;->a()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v0, ""

    :goto_1
    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/bd;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void

    :cond_1
    invoke-static {}, Lcom/talkingdata/sdk/d;->a()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_0
.end method
