.class public Lcom/talkingdata/sdk/bt;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/talkingdata/sdk/bt$b;,
        Lcom/talkingdata/sdk/bt$a;
    }
.end annotation


# static fields
.field private static a:I

.field private static b:I

.field private static c:I

.field private static d:I

.field private static e:I


# instance fields
.field private f:Lcom/talkingdata/sdk/br;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v1, 0x6

    const/4 v0, 0x2

    sput v0, Lcom/talkingdata/sdk/bt;->a:I

    sput v1, Lcom/talkingdata/sdk/bt;->b:I

    sput v1, Lcom/talkingdata/sdk/bt;->c:I

    const/16 v0, -0x28

    sput v0, Lcom/talkingdata/sdk/bt;->d:I

    const/4 v0, 0x4

    sput v0, Lcom/talkingdata/sdk/bt;->e:I

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    new-instance v0, Lcom/talkingdata/sdk/br;

    invoke-direct {v0}, Lcom/talkingdata/sdk/br;-><init>()V

    invoke-direct {p0, v0}, Lcom/talkingdata/sdk/bt;-><init>(Lcom/talkingdata/sdk/br;)V

    return-void
.end method

.method public constructor <init>(Lcom/talkingdata/sdk/br;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/talkingdata/sdk/bt;->f:Lcom/talkingdata/sdk/br;

    return-void
.end method


# virtual methods
.method public a(II)D
    .locals 8

    const-wide/16 v0, 0x0

    if-gez p1, :cond_0

    if-ltz p2, :cond_1

    :cond_0
    :goto_0
    return-wide v0

    :cond_1
    add-int v2, p1, p2

    div-int/lit8 v2, v2, 0x2

    int-to-double v2, v2

    int-to-double v4, p1

    sub-double/2addr v4, v2

    invoke-static {v4, v5}, Ljava/lang/Math;->abs(D)D

    move-result-wide v4

    sget v6, Lcom/talkingdata/sdk/bt;->a:I

    int-to-double v6, v6

    cmpl-double v6, v4, v6

    if-lez v6, :cond_2

    sget v0, Lcom/talkingdata/sdk/bt;->a:I

    int-to-double v0, v0

    sub-double v0, v4, v0

    :cond_2
    add-double/2addr v0, v2

    div-double/2addr v0, v2

    sget v2, Lcom/talkingdata/sdk/bt;->b:I

    int-to-double v2, v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    goto :goto_0
.end method

.method public a(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)D
    .locals 18

    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/bs;->a(Z)Ljava/util/Map;

    move-result-object v10

    const/4 v2, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/bs;->a(Z)Ljava/util/Map;

    move-result-object v11

    new-instance v12, Ljava/util/HashSet;

    invoke-direct {v12}, Ljava/util/HashSet;-><init>()V

    const/4 v3, 0x0

    const-wide/16 v6, 0x0

    const-wide/16 v4, 0x0

    const/4 v2, 0x0

    const/4 v13, 0x0

    invoke-interface {v10}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v14

    move-wide v8, v6

    move-wide v6, v4

    move v4, v2

    move v5, v3

    :goto_0
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/talkingdata/sdk/bq;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v11, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v15

    add-int/2addr v4, v15

    if-nez v2, :cond_0

    invoke-interface {v12, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-wide v2, v6

    move-wide v6, v8

    :goto_1
    move-wide v8, v6

    move-wide v6, v2

    goto :goto_0

    :cond_0
    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v15

    invoke-virtual {v2}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v16

    move-object/from16 v0, p0

    move/from16 v1, v16

    invoke-virtual {v0, v15, v1}, Lcom/talkingdata/sdk/bt;->b(II)D

    move-result-wide v16

    add-double v6, v6, v16

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v3

    invoke-virtual {v2}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v2

    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v2}, Lcom/talkingdata/sdk/bt;->a(II)D

    move-result-wide v2

    mul-double v2, v2, v16

    add-double/2addr v8, v2

    move-wide v2, v6

    move-wide v6, v8

    goto :goto_1

    :cond_1
    if-nez v5, :cond_2

    const-wide/16 v2, 0x0

    :goto_2
    return-wide v2

    :cond_2
    invoke-interface {v11}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :cond_3
    :goto_3
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v3

    add-int/2addr v4, v3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v12, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_4
    invoke-virtual/range {p1 .. p1}, Lcom/talkingdata/sdk/bs;->c()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual/range {p2 .. p2}, Lcom/talkingdata/sdk/bs;->c()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    add-int/2addr v2, v3

    sub-int/2addr v2, v13

    div-int/2addr v4, v2

    const-wide/16 v2, 0x0

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/talkingdata/sdk/bt;->f:Lcom/talkingdata/sdk/br;

    invoke-virtual {v10}, Lcom/talkingdata/sdk/br;->d()I

    move-result v10

    int-to-double v14, v4

    const-wide v16, 0x3ff3333333333333L    # 1.2

    add-double v14, v14, v16

    double-to-int v4, v14

    invoke-static {v10, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-interface {v12}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v12

    move-wide v10, v2

    :goto_4
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v2

    if-le v2, v4, :cond_6

    const-wide/high16 v2, 0x3ff0000000000000L    # 1.0

    add-double/2addr v2, v10

    :goto_5
    move-wide v10, v2

    goto :goto_4

    :cond_5
    mul-int/lit8 v2, v5, 0x2

    int-to-double v2, v2

    add-double/2addr v2, v10

    div-double v2, v10, v2

    div-double v4, v8, v6

    const-wide/high16 v6, 0x3ff0000000000000L    # 1.0

    sget v8, Lcom/talkingdata/sdk/bt;->e:I

    int-to-double v8, v8

    invoke-static {v2, v3, v8, v9}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    sub-double v2, v6, v2

    mul-double/2addr v2, v4

    goto/16 :goto_2

    :cond_6
    move-wide v2, v10

    goto :goto_5
.end method

.method public a(Lcom/talkingdata/sdk/bs;Ljava/util/List;)D
    .locals 5

    const-wide/16 v0, 0x0

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move-wide v2, v0

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bs;

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/bt;->a(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)D

    move-result-wide v0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v0

    move-wide v2, v0

    goto :goto_0

    :cond_0
    return-wide v2
.end method

.method public a(Ljava/util/List;Ljava/util/List;)D
    .locals 8

    const-wide/16 v2, 0x0

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-wide v2

    :cond_1
    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {p0, p1, p2, v1}, Lcom/talkingdata/sdk/bt;->b(Ljava/util/List;Ljava/util/List;Ljava/util/List;)V

    const/4 v0, 0x0

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v1, v0

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bt$a;

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    if-eqz v5, :cond_3

    iget-wide v6, v0, Lcom/talkingdata/sdk/bt$a;->c:D

    add-double/2addr v2, v6

    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_2
    move v1, v0

    goto :goto_1

    :cond_2
    int-to-double v0, v1

    div-double/2addr v2, v0

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_2
.end method

.method public a(Ljava/util/List;Ljava/util/List;Ljava/util/List;)D
    .locals 8

    const-wide/16 v2, 0x0

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-interface {p3, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    invoke-interface {p3, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :goto_0
    return-wide v2

    :cond_1
    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {p0, p1, p2, v1}, Lcom/talkingdata/sdk/bt;->b(Ljava/util/List;Ljava/util/List;Ljava/util/List;)V

    const/4 v0, 0x0

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v1, v0

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bt$a;

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    if-eqz v5, :cond_2

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    if-eqz v5, :cond_2

    iget-wide v6, v0, Lcom/talkingdata/sdk/bt$a;->c:D

    add-double/2addr v2, v6

    add-int/lit8 v1, v1, 0x1

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    iget-object v0, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    invoke-virtual {p0, v5, v0}, Lcom/talkingdata/sdk/bt;->b(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)Lcom/talkingdata/sdk/bs;

    move-result-object v0

    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move v0, v1

    :goto_2
    move v1, v0

    goto :goto_1

    :cond_2
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v5

    iget-object v6, p0, Lcom/talkingdata/sdk/bt;->f:Lcom/talkingdata/sdk/br;

    invoke-virtual {v6}, Lcom/talkingdata/sdk/br;->b()I

    move-result v6

    if-ge v5, v6, :cond_3

    iget-object v5, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    if-nez v5, :cond_4

    iget-object v0, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bs;->d()Lcom/talkingdata/sdk/bs;

    move-result-object v0

    :goto_3
    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    move v0, v1

    goto :goto_2

    :cond_4
    iget-object v0, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bs;->d()Lcom/talkingdata/sdk/bs;

    move-result-object v0

    goto :goto_3

    :cond_5
    int-to-double v0, v1

    div-double/2addr v2, v0

    goto :goto_0
.end method

.method public b(II)D
    .locals 4

    if-gez p1, :cond_0

    if-ltz p2, :cond_1

    :cond_0
    const-wide/16 v0, 0x0

    :goto_0
    return-wide v0

    :cond_1
    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result v0

    int-to-double v0, v0

    sget v2, Lcom/talkingdata/sdk/bt;->d:I

    int-to-double v2, v2

    cmpl-double v2, v0, v2

    if-ltz v2, :cond_2

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    goto :goto_0

    :cond_2
    const-wide/high16 v2, 0x4060000000000000L    # 128.0

    add-double/2addr v0, v2

    sget v2, Lcom/talkingdata/sdk/bt;->d:I

    add-int/lit16 v2, v2, 0x80

    int-to-double v2, v2

    div-double/2addr v0, v2

    sget v2, Lcom/talkingdata/sdk/bt;->c:I

    int-to-double v2, v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    goto :goto_0
.end method

.method public b(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)Lcom/talkingdata/sdk/bs;
    .locals 16

    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/bs;->a(Z)Ljava/util/Map;

    move-result-object v8

    const/4 v2, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/bs;->a(Z)Ljava/util/Map;

    move-result-object v9

    new-instance v10, Ljava/util/TreeMap;

    invoke-direct {v10}, Ljava/util/TreeMap;-><init>()V

    new-instance v11, Lcom/talkingdata/sdk/bs;

    invoke-direct {v11}, Lcom/talkingdata/sdk/bs;-><init>()V

    invoke-virtual/range {p2 .. p2}, Lcom/talkingdata/sdk/bs;->b()J

    move-result-wide v2

    invoke-virtual {v11, v2, v3}, Lcom/talkingdata/sdk/bs;->a(J)V

    invoke-virtual/range {p2 .. p2}, Lcom/talkingdata/sdk/bs;->a()I

    move-result v2

    invoke-virtual {v11, v2}, Lcom/talkingdata/sdk/bs;->a(I)V

    new-instance v12, Ljava/util/LinkedList;

    invoke-direct {v12}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {v11, v12}, Lcom/talkingdata/sdk/bs;->a(Ljava/util/List;)V

    invoke-interface {v8}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_0
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    move-object v5, v3

    check-cast v5, Lcom/talkingdata/sdk/bq;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v9, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    move-object v7, v2

    check-cast v7, Lcom/talkingdata/sdk/bq;

    if-nez v7, :cond_1

    invoke-virtual {v5}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v2

    neg-int v2, v2

    int-to-double v2, v2

    :goto_1
    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-interface {v10, v4}, Ljava/util/SortedMap;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-wide v6, 0x3f1a36e2eb1c432dL    # 1.0E-4

    add-double/2addr v2, v6

    goto :goto_1

    :cond_0
    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    invoke-interface {v10, v2, v5}, Ljava/util/SortedMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    new-instance v2, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v7}, Lcom/talkingdata/sdk/bq;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7}, Lcom/talkingdata/sdk/bq;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v7}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v6

    invoke-virtual {v5}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v5

    add-int/2addr v5, v6

    div-int/lit8 v5, v5, 0x2

    int-to-byte v5, v5

    invoke-virtual {v7}, Lcom/talkingdata/sdk/bq;->d()B

    move-result v6

    invoke-virtual {v7}, Lcom/talkingdata/sdk/bq;->e()B

    move-result v7

    invoke-direct/range {v2 .. v7}, Lcom/talkingdata/sdk/bq;-><init>(Ljava/lang/String;Ljava/lang/String;BBB)V

    invoke-interface {v12, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    invoke-interface {v9}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_3
    :goto_2
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v8, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/talkingdata/sdk/bq;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/bq;->c()B

    move-result v3

    neg-int v3, v3

    int-to-double v4, v3

    :goto_3
    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/SortedMap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-wide v14, 0x3f1a36e2eb1c432dL    # 1.0E-4

    add-double/2addr v4, v14

    goto :goto_3

    :cond_4
    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v10, v3, v2}, Ljava/util/SortedMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_5
    invoke-interface {v10}, Ljava/util/SortedMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Double;

    invoke-virtual {v3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v6

    neg-double v6, v6

    double-to-int v3, v6

    int-to-byte v3, v3

    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v5

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/talkingdata/sdk/bt;->f:Lcom/talkingdata/sdk/br;

    invoke-virtual {v6}, Lcom/talkingdata/sdk/br;->c()I

    move-result v6

    if-ge v5, v6, :cond_6

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/talkingdata/sdk/bt;->f:Lcom/talkingdata/sdk/br;

    invoke-virtual {v5}, Lcom/talkingdata/sdk/br;->d()I

    move-result v5

    if-ge v3, v5, :cond_7

    :cond_6
    return-object v11

    :cond_7
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v12, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4
.end method

.method public b(Ljava/util/List;Ljava/util/List;Ljava/util/List;)V
    .locals 11

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    new-instance v7, Ljava/util/HashSet;

    invoke-direct {v7}, Ljava/util/HashSet;-><init>()V

    new-instance v8, Ljava/util/HashSet;

    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/talkingdata/sdk/bs;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_1
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/talkingdata/sdk/bs;

    invoke-interface {v8, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v2, v3}, Lcom/talkingdata/sdk/bt;->a(Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;)D

    move-result-wide v4

    new-instance v0, Lcom/talkingdata/sdk/bt$a;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/bt$a;-><init>(Lcom/talkingdata/sdk/bt;Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;D)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    invoke-interface {v7, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/talkingdata/sdk/bu;

    invoke-direct {v0, p0}, Lcom/talkingdata/sdk/bu;-><init>(Lcom/talkingdata/sdk/bt;)V

    invoke-static {v6, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-interface {p3}, Ljava/util/List;->clear()V

    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bt$a;

    iget-object v2, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    invoke-interface {v7, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    invoke-interface {v8, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    invoke-interface {v7, v2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    iget-object v2, v0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    invoke-interface {v8, v2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_3
    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_3
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/talkingdata/sdk/bs;

    new-instance v0, Lcom/talkingdata/sdk/bt$a;

    const/4 v3, 0x0

    const-wide/16 v4, 0x0

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/bt$a;-><init>(Lcom/talkingdata/sdk/bt;Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;D)V

    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_4
    invoke-interface {v8}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/talkingdata/sdk/bs;

    new-instance v0, Lcom/talkingdata/sdk/bt$a;

    const/4 v2, 0x0

    const-wide/16 v4, 0x0

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/bt$a;-><init>(Lcom/talkingdata/sdk/bt;Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;D)V

    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4

    :cond_5
    return-void
.end method
