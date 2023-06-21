.class public Lcom/tendcloud/appcpa/Order;
.super Lorg/json/JSONObject;


# static fields
.field public static final a:Ljava/lang/String; = "keyOrderId"

.field public static final b:Ljava/lang/String; = "keyTotalPrice"

.field public static final c:Ljava/lang/String; = "keyCurrencyType"

.field public static final d:Ljava/lang/String; = "keyOrderDetail"

.field static final e:Ljava/lang/String; = "id"

.field static final f:Ljava/lang/String; = "category"

.field static final g:Ljava/lang/String; = "name"

.field static final h:Ljava/lang/String; = "unitPrice"

.field static final i:Ljava/lang/String; = "count"


# instance fields
.field j:Lorg/json/JSONArray;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lorg/json/JSONObject;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lorg/json/JSONObject;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    :try_start_0
    const-string v0, "keyOrderId"

    invoke-virtual {p0, v0, p1}, Lcom/tendcloud/appcpa/Order;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v0, "keyTotalPrice"

    invoke-virtual {p0, v0, p2}, Lcom/tendcloud/appcpa/Order;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v0, "keyCurrencyType"

    invoke-virtual {p0, v0, p3}, Lcom/tendcloud/appcpa/Order;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    invoke-static {v0}, Lcom/talkingdata/sdk/ap;->b(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static createOrder(Ljava/lang/String;ILjava/lang/String;)Lcom/tendcloud/appcpa/Order;
    .locals 1

    new-instance v0, Lcom/tendcloud/appcpa/Order;

    invoke-direct {v0, p0, p1, p2}, Lcom/tendcloud/appcpa/Order;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public declared-synchronized addItem(Ljava/lang/String;Ljava/lang/String;II)Lcom/tendcloud/appcpa/Order;
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iput-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    const-string v0, "keyOrderDetail"

    iget-object v1, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    invoke-virtual {p0, v0, v1}, Lcom/tendcloud/appcpa/Order;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "name"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "unitPrice"

    invoke-virtual {v0, v1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "count"

    invoke-virtual {v0, v1, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "category"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-object p0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized addItem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)Lcom/tendcloud/appcpa/Order;
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iput-object v0, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    const-string v0, "keyOrderDetail"

    iget-object v1, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    invoke-virtual {p0, v0, v1}, Lcom/tendcloud/appcpa/Order;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "id"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "name"

    invoke-virtual {v0, v1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "unitPrice"

    invoke-virtual {v0, v1, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "count"

    invoke-virtual {v0, v1, p5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "category"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/tendcloud/appcpa/Order;->j:Lorg/json/JSONArray;

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-object p0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
