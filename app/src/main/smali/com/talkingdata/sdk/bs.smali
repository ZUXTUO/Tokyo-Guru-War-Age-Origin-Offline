.class public Lcom/talkingdata/sdk/bs;
.super Ljava/lang/Object;


# instance fields
.field private a:I

.field private b:J

.field private c:Ljava/util/List;

.field private d:Ljava/util/Map;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lcom/talkingdata/sdk/bs;->a:I

    return v0
.end method

.method public a(Z)Ljava/util/Map;
    .locals 4

    iget-object v0, p0, Lcom/talkingdata/sdk/bs;->d:Ljava/util/Map;

    if-eqz v0, :cond_0

    if-eqz p1, :cond_1

    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/bs;->d:Ljava/util/Map;

    iget-object v0, p0, Lcom/talkingdata/sdk/bs;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bq;

    iget-object v2, p0, Lcom/talkingdata/sdk/bs;->d:Ljava/util/Map;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bq;->b()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/talkingdata/sdk/bs;->d:Ljava/util/Map;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lcom/talkingdata/sdk/bs;->a:I

    return-void
.end method

.method public a(J)V
    .locals 1

    iput-wide p1, p0, Lcom/talkingdata/sdk/bs;->b:J

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/bs;->c:Ljava/util/List;

    return-void
.end method

.method public b()J
    .locals 2

    iget-wide v0, p0, Lcom/talkingdata/sdk/bs;->b:J

    return-wide v0
.end method

.method public c()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/bs;->c:Ljava/util/List;

    return-object v0
.end method

.method public d()Lcom/talkingdata/sdk/bs;
    .locals 4

    new-instance v1, Lcom/talkingdata/sdk/bs;

    invoke-direct {v1}, Lcom/talkingdata/sdk/bs;-><init>()V

    iget v0, p0, Lcom/talkingdata/sdk/bs;->a:I

    invoke-virtual {v1, v0}, Lcom/talkingdata/sdk/bs;->a(I)V

    iget-wide v2, p0, Lcom/talkingdata/sdk/bs;->b:J

    invoke-virtual {v1, v2, v3}, Lcom/talkingdata/sdk/bs;->a(J)V

    new-instance v2, Ljava/util/LinkedList;

    invoke-direct {v2}, Ljava/util/LinkedList;-><init>()V

    iget-object v0, p0, Lcom/talkingdata/sdk/bs;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bq;->f()Lcom/talkingdata/sdk/bq;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/bs;->a(Ljava/util/List;)V

    return-object v1
.end method
