.class public Lcom/talkingdata/sdk/bo;
.super Ljava/lang/Object;


# static fields
.field static a:Lcom/talkingdata/sdk/ax;

.field static b:Lcom/talkingdata/sdk/ba;

.field static c:Lcom/talkingdata/sdk/be;

.field static d:Lcom/talkingdata/sdk/bb;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    sput-object v0, Lcom/talkingdata/sdk/bo;->b:Lcom/talkingdata/sdk/ba;

    sput-object v0, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    sput-object v0, Lcom/talkingdata/sdk/bo;->d:Lcom/talkingdata/sdk/bb;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized a(Lcom/talkingdata/sdk/aw;Ljava/lang/String;Ljava/lang/String;Z)Lorg/json/JSONObject;
    .locals 10

    const-class v2, Lcom/talkingdata/sdk/bo;

    monitor-enter v2

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lcom/talkingdata/sdk/aw;->a_()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "createTDEventModel()# TDActionModel can not be null"

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->e(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x0

    :goto_0
    monitor-exit v2

    return-object v0

    :cond_1
    :try_start_1
    sget-object v0, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    if-nez v0, :cond_2

    new-instance v0, Lcom/talkingdata/sdk/ax;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ax;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/talkingdata/sdk/bn;->a(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    invoke-virtual {v1, v0}, Lcom/talkingdata/sdk/ax;->c(Ljava/lang/String;)V

    :cond_2
    invoke-static {p1}, Lcom/talkingdata/sdk/t;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    invoke-virtual {v0, p1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;)V

    :cond_3
    invoke-static {p2}, Lcom/talkingdata/sdk/t;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    sget-object v0, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    invoke-virtual {v0, p2}, Lcom/talkingdata/sdk/ax;->b(Ljava/lang/String;)V

    :cond_4
    sget-object v0, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    if-nez v0, :cond_5

    new-instance v0, Lcom/talkingdata/sdk/be;

    invoke-direct {v0}, Lcom/talkingdata/sdk/be;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    :cond_5
    sget-object v0, Lcom/talkingdata/sdk/bo;->b:Lcom/talkingdata/sdk/ba;

    if-nez v0, :cond_6

    new-instance v0, Lcom/talkingdata/sdk/ba;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ba;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/bo;->b:Lcom/talkingdata/sdk/ba;

    :cond_6
    sget-object v0, Lcom/talkingdata/sdk/bo;->d:Lcom/talkingdata/sdk/bb;

    if-nez v0, :cond_7

    new-instance v0, Lcom/talkingdata/sdk/bb;

    invoke-direct {v0}, Lcom/talkingdata/sdk/bb;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/bo;->d:Lcom/talkingdata/sdk/bb;

    sget-object v0, Lcom/talkingdata/sdk/bo;->d:Lcom/talkingdata/sdk/bb;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bb;->b()V

    :cond_7
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v1, "action"

    invoke-virtual {p0}, Lcom/talkingdata/sdk/aw;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "device"

    sget-object v3, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/be;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "app"

    sget-object v3, Lcom/talkingdata/sdk/bo;->a:Lcom/talkingdata/sdk/ax;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/ax;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "sdk"

    sget-object v3, Lcom/talkingdata/sdk/bo;->b:Lcom/talkingdata/sdk/ba;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/ba;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-string v1, "ts"

    invoke-virtual {v0, v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v1

    const-string v3, "appContext"

    invoke-virtual {v1}, Lcom/talkingdata/sdk/au;->a_()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "user"

    sget-object v3, Lcom/talkingdata/sdk/bo;->d:Lcom/talkingdata/sdk/bb;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bb;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "fingerprint"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v4}, Lcom/talkingdata/sdk/bn;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    invoke-virtual {v4}, Lcom/talkingdata/sdk/be;->b()Lcom/talkingdata/sdk/bf;

    move-result-object v4

    invoke-virtual {v4}, Lcom/talkingdata/sdk/bf;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/talkingdata/sdk/bo;->c:Lcom/talkingdata/sdk/be;

    invoke-virtual {v4}, Lcom/talkingdata/sdk/be;->b()Lcom/talkingdata/sdk/bf;

    move-result-object v4

    invoke-virtual {v4}, Lcom/talkingdata/sdk/bf;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/talkingdata/sdk/t;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    invoke-static {}, Lcom/talkingdata/sdk/bp;->b()J

    move-result-wide v6

    sub-long v6, v4, v6

    const-wide/16 v8, 0x2710

    cmp-long v1, v6, v8

    if-ltz v1, :cond_8

    invoke-static {v4, v5}, Lcom/talkingdata/sdk/bp;->a(J)V

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    new-instance v3, Lcom/talkingdata/sdk/bg;

    sget-object v4, Lcom/talkingdata/sdk/bh;->a:Lcom/talkingdata/sdk/bh;

    invoke-direct {v3, v4}, Lcom/talkingdata/sdk/bg;-><init>(Lcom/talkingdata/sdk/bh;)V

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bg;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    new-instance v3, Lcom/talkingdata/sdk/bg;

    sget-object v4, Lcom/talkingdata/sdk/bh;->b:Lcom/talkingdata/sdk/bh;

    invoke-direct {v3, v4}, Lcom/talkingdata/sdk/bg;-><init>(Lcom/talkingdata/sdk/bh;)V

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bg;->a_()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const-string v3, "networks"

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_8
    new-instance v1, Lcom/talkingdata/sdk/ay;

    invoke-direct {v1}, Lcom/talkingdata/sdk/ay;-><init>()V

    const-string v3, "locations"

    invoke-virtual {v1}, Lcom/talkingdata/sdk/ay;->a_()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_0

    :catch_0
    move-exception v1

    :try_start_3
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto/16 :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method
