.class public Lcom/tendcloud/appcpa/ShoppingCart;
.super Lorg/json/JSONArray;


# static fields
.field static final a:Ljava/lang/String; = "id"

.field static final b:Ljava/lang/String; = "category"

.field static final c:Ljava/lang/String; = "name"

.field static final d:Ljava/lang/String; = "unitPrice"

.field static final e:Ljava/lang/String; = "count"


# instance fields
.field f:Lorg/json/JSONArray;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lorg/json/JSONArray;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/tendcloud/appcpa/ShoppingCart;->f:Lorg/json/JSONArray;

    return-void
.end method

.method public static createShoppingCart()Lcom/tendcloud/appcpa/ShoppingCart;
    .locals 1

    new-instance v0, Lcom/tendcloud/appcpa/ShoppingCart;

    invoke-direct {v0}, Lcom/tendcloud/appcpa/ShoppingCart;-><init>()V

    return-object v0
.end method


# virtual methods
.method public declared-synchronized addItem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)Lcom/tendcloud/appcpa/ShoppingCart;
    .locals 2

    monitor-enter p0

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "id"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "name"

    invoke-virtual {v0, v1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "category"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "unitPrice"

    invoke-virtual {v0, v1, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "count"

    invoke-virtual {v0, v1, p5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    invoke-virtual {p0, v0}, Lcom/tendcloud/appcpa/ShoppingCart;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
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
