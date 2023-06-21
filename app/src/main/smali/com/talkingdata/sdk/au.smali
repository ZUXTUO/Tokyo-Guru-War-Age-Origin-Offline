.class public Lcom/talkingdata/sdk/au;
.super Lcom/talkingdata/sdk/az;


# static fields
.field static a:Lcom/talkingdata/sdk/au;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    return-void
.end method

.method public static declared-synchronized a()Lcom/talkingdata/sdk/au;
    .locals 2

    const-class v1, Lcom/talkingdata/sdk/au;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/au;->a:Lcom/talkingdata/sdk/au;

    if-nez v0, :cond_0

    new-instance v0, Lcom/talkingdata/sdk/au;

    invoke-direct {v0}, Lcom/talkingdata/sdk/au;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/au;->a:Lcom/talkingdata/sdk/au;

    :cond_0
    sget-object v0, Lcom/talkingdata/sdk/au;->a:Lcom/talkingdata/sdk/au;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    const-string v0, "sessionId"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public a(Lorg/json/JSONObject;)V
    .locals 1

    const-string v0, "account"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    const-string v0, "page"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public b(Lorg/json/JSONObject;)V
    .locals 1

    const-string v0, "subaccount"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    const-string v0, "utf-8"

    invoke-static {p1, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "deeplink"

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {v0}, Lcom/talkingdata/sdk/bp;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
