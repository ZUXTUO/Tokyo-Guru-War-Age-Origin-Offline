.class public Lcom/talkingdata/sdk/ax;
.super Lcom/talkingdata/sdk/az;


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    const-string v0, "name"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->h(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "globalId"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "versionName"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "versionCode"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->b(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "installTime"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->d(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "updateTime"

    invoke-static {}, Lcom/talkingdata/sdk/a;->a()Lcom/talkingdata/sdk/a;

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/a;->e(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    const-string v0, "appKey"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    const-string v0, "channel"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    const-string v0, "uniqueId"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/ax;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
