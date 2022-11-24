.class public Lcom/talkingdata/sdk/at;
.super Ljava/lang/Object;


# static fields
.field public static a:Ljava/lang/String;

.field static b:I

.field static c:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, ""

    sput-object v0, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    const/16 v0, 0x1e

    sput v0, Lcom/talkingdata/sdk/at;->b:I

    const-string v0, "session"

    sput-object v0, Lcom/talkingdata/sdk/at;->c:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()V
    .locals 4

    :try_start_0
    invoke-static {}, Lcom/talkingdata/sdk/bp;->i()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;)V

    invoke-static {}, Lcom/talkingdata/sdk/bp;->h()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-lez v2, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long v0, v2, v0

    sget v2, Lcom/talkingdata/sdk/at;->b:I

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    invoke-static {}, Lcom/talkingdata/sdk/at;->c()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {}, Lcom/talkingdata/sdk/at;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static b()V
    .locals 2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/bp;->c(J)V

    return-void
.end method

.method static c()V
    .locals 9

    const-wide/16 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/talkingdata/sdk/bp;->h()J

    move-result-wide v4

    sget-object v2, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    if-eqz v2, :cond_1

    invoke-static {}, Lcom/talkingdata/sdk/bp;->f()J

    move-result-wide v2

    sub-long v2, v4, v2

    const-wide/16 v6, 0x1f4

    cmp-long v6, v2, v6

    if-gez v6, :cond_0

    const-wide/16 v2, -0x3e8

    :cond_0
    new-instance v6, Ljava/util/TreeMap;

    invoke-direct {v6}, Ljava/util/TreeMap;-><init>()V

    const-string v7, "sessionId"

    sget-object v8, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-interface {v6, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v7, "duration"

    long-to-int v2, v2

    div-int/lit16 v2, v2, 0x3e8

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v6, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v2, Lcom/talkingdata/sdk/at;->c:Ljava/lang/String;

    const-string v3, "end"

    invoke-static {v2, v3, v6}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    :cond_1
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v2

    sget-object v3, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/talkingdata/sdk/au;->a(Ljava/lang/String;)V

    sget-object v2, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-static {v2}, Lcom/talkingdata/sdk/bp;->a(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Lcom/talkingdata/sdk/bp;->b(J)V

    sub-long/2addr v2, v4

    cmp-long v4, v0, v4

    if-ltz v4, :cond_2

    :goto_0
    new-instance v2, Ljava/util/TreeMap;

    invoke-direct {v2}, Ljava/util/TreeMap;-><init>()V

    const-string v3, "sessionId"

    sget-object v4, Lcom/talkingdata/sdk/at;->a:Ljava/lang/String;

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "interval"

    long-to-int v0, v0

    div-int/lit16 v0, v0, 0x3e8

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {v2, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/talkingdata/sdk/at;->c:Ljava/lang/String;

    const-string v1, "begin"

    invoke-static {v0, v1, v2}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {}, Lcom/talkingdata/sdk/an;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    return-void

    :cond_2
    move-wide v0, v2

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_1
.end method
