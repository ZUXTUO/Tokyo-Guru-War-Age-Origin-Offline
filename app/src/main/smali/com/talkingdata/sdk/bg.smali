.class public Lcom/talkingdata/sdk/bg;
.super Lcom/talkingdata/sdk/az;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/talkingdata/sdk/bg$1;
    }
.end annotation


# static fields
.field public static a:Lcom/talkingdata/sdk/bs;

.field public static c:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/bg;->c:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/talkingdata/sdk/bh;)V
    .locals 6

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    sget-object v0, Lcom/talkingdata/sdk/bg$1;->a:[I

    invoke-virtual {p1}, Lcom/talkingdata/sdk/bh;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    const-string v0, "type"

    sget-object v1, Lcom/talkingdata/sdk/bh;->a:Lcom/talkingdata/sdk/bh;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/bh;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "available"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->d(Landroid/content/Context;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/i;->g(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, "connected"

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "current"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->w(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/i;->x(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/bg;->a(Lorg/json/JSONArray;)Lcom/talkingdata/sdk/bs;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/bg;->a:Lcom/talkingdata/sdk/bs;

    if-nez v2, :cond_2

    const-string v2, "env"

    invoke-virtual {p0, v2, v0}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sput-object v1, Lcom/talkingdata/sdk/bg;->a:Lcom/talkingdata/sdk/bs;

    :goto_1
    const-string v0, "configured"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->u(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "ip"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    :goto_2
    invoke-static {}, Lcom/talkingdata/sdk/i;->a()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "proxy"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/net/Proxy;->getDefaultHost()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/net/Proxy;->getDefaultPort()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    :cond_1
    const-string v0, "scanableFingerId"

    sget-object v1, Lcom/talkingdata/sdk/bg;->c:Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto/16 :goto_0

    :cond_2
    new-instance v2, Lcom/talkingdata/sdk/bt;

    invoke-direct {v2}, Lcom/talkingdata/sdk/bt;-><init>()V

    sget-object v3, Lcom/talkingdata/sdk/bg;->a:Lcom/talkingdata/sdk/bs;

    invoke-virtual {v2, v3, v1}, Lcom/talkingdata/sdk/bt;->a(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)D

    move-result-wide v2

    const-wide v4, 0x3fe999999999999aL    # 0.8

    cmpl-double v2, v2, v4

    if-lez v2, :cond_3

    const-string v0, "env"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_1

    :cond_3
    const-string v2, "env"

    invoke-virtual {p0, v2, v0}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sput-object v1, Lcom/talkingdata/sdk/bg;->a:Lcom/talkingdata/sdk/bs;

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/bg;->c:Ljava/lang/String;

    goto :goto_1

    :cond_4
    const-string v0, "connected"

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_2

    :pswitch_1
    const-string v0, "type"

    sget-object v1, Lcom/talkingdata/sdk/bh;->b:Lcom/talkingdata/sdk/bh;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/bh;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "available"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->d(Landroid/content/Context;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "connected"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->c(Landroid/content/Context;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/i;->c(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "current"

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/talkingdata/sdk/i;->s(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    :cond_5
    invoke-static {}, Lcom/talkingdata/sdk/i;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "proxy"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/net/Proxy;->getDefaultHost()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/net/Proxy;->getDefaultPort()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/bg;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private static a(Lorg/json/JSONArray;)Lcom/talkingdata/sdk/bs;
    .locals 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    if-eqz p0, :cond_1

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    move v6, v0

    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-ge v6, v0, :cond_0

    :try_start_0
    invoke-virtual {p0, v6}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    new-instance v0, Lcom/talkingdata/sdk/bq;

    const-string v1, "name"

    invoke-virtual {v3, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "id"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v4, "level"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    int-to-byte v3, v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/bq;-><init>(Ljava/lang/String;Ljava/lang/String;BBB)V

    invoke-interface {v7, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/talkingdata/sdk/bs;

    invoke-direct {v0}, Lcom/talkingdata/sdk/bs;-><init>()V

    invoke-virtual {v0, v7}, Lcom/talkingdata/sdk/bs;->a(Ljava/util/List;)V

    :goto_2
    return-object v0

    :catch_0
    move-exception v0

    goto :goto_1

    :cond_1
    move-object v0, v1

    goto :goto_2
.end method
