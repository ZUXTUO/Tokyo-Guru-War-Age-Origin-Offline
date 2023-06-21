.class final Lcom/talkingdata/sdk/ab;
.super Lcom/talkingdata/sdk/z;


# static fields
.field static final synthetic G:Z

.field private static final H:I = 0x1000

.field private static I:I

.field private static J:I


# instance fields
.field private final K:[Lcom/talkingdata/sdk/ad;

.field private L:I

.field private M:I

.field private N:Lcom/talkingdata/sdk/ac;

.field private final O:[I

.field private final P:Lcom/talkingdata/sdk/af;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/16 v1, 0x1000

    const-class v0, Lcom/talkingdata/sdk/ab;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/talkingdata/sdk/ab;->G:Z

    sput v1, Lcom/talkingdata/sdk/ab;->I:I

    sput v1, Lcom/talkingdata/sdk/ab;->J:I

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/talkingdata/sdk/ae;IIIIIII)V
    .locals 9

    new-instance v0, Lcom/talkingdata/sdk/w;

    sget v1, Lcom/talkingdata/sdk/ab;->I:I

    invoke-static {p6, v1}, Ljava/lang/Math;->max(II)I

    move-result v2

    sget v3, Lcom/talkingdata/sdk/ab;->J:I

    const/16 v5, 0x111

    move v1, p5

    move/from16 v4, p7

    move/from16 v6, p8

    invoke-direct/range {v0 .. v6}, Lcom/talkingdata/sdk/w;-><init>(IIIIII)V

    move-object v1, p0

    move-object v2, p1

    move-object v3, v0

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    move/from16 v8, p7

    invoke-direct/range {v1 .. v8}, Lcom/talkingdata/sdk/z;-><init>(Lcom/talkingdata/sdk/ae;Lcom/talkingdata/sdk/w;IIIII)V

    const/16 v0, 0x1000

    new-array v0, v0, [Lcom/talkingdata/sdk/ad;

    iput-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    const/4 v0, 0x0

    iput v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    const/4 v0, 0x4

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    new-instance v0, Lcom/talkingdata/sdk/af;

    invoke-direct {v0}, Lcom/talkingdata/sdk/af;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0x1000

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    new-instance v2, Lcom/talkingdata/sdk/ad;

    invoke-direct {v2}, Lcom/talkingdata/sdk/ad;-><init>()V

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method private a(IIIII)V
    .locals 12

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v2, v2, -0x1

    aget v1, v1, v2

    if-le v1, p3, :cond_1

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    const/4 v2, 0x0

    iput v2, v1, Lcom/talkingdata/sdk/ac;->c:I

    :goto_0
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    aget v1, v1, v2

    if-ge v1, p3, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v1, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v2, v2, 0x1

    iput v2, v1, Lcom/talkingdata/sdk/ac;->c:I

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v3, v2, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v4, v3, 0x1

    iput v4, v2, Lcom/talkingdata/sdk/ac;->c:I

    aput p3, v1, v3

    :cond_1
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v2, v2, -0x1

    aget v1, v1, v2

    move/from16 v0, p5

    if-ge v1, v0, :cond_2

    :goto_1
    return-void

    :cond_2
    :goto_2
    iget v1, p0, Lcom/talkingdata/sdk/ab;->M:I

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v3, v3, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v4, v4, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v4, v4, -0x1

    aget v3, v3, v4

    add-int/2addr v2, v3

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->M:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/talkingdata/sdk/ab;->M:I

    aget-object v1, v1, v2

    invoke-virtual {v1}, Lcom/talkingdata/sdk/ad;->a()V

    goto :goto_2

    :cond_3
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    move/from16 v0, p4

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/ab;->a(ILcom/talkingdata/sdk/af;)I

    move-result v8

    const/4 v1, 0x0

    :goto_3
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v2, v2, Lcom/talkingdata/sdk/ac;->a:[I

    aget v2, v2, v1

    move/from16 v0, p5

    if-le v0, v2, :cond_4

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_4
    move v7, v1

    :goto_4
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->b:[I

    aget v9, v1, v7

    move/from16 v0, p5

    invoke-virtual {p0, v8, v9, v0, p2}, Lcom/talkingdata/sdk/ab;->a(IIII)I

    move-result v10

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int v2, v2, p5

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v10, v1, :cond_5

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int v2, v2, p5

    aget-object v1, v1, v2

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v3, v9, 0x4

    invoke-virtual {v1, v10, v2, v3}, Lcom/talkingdata/sdk/ad;->a(III)V

    :cond_5
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->a:[I

    aget v1, v1, v7

    move/from16 v0, p5

    if-eq v0, v1, :cond_7

    move v1, v7

    :cond_6
    add-int/lit8 p5, p5, 0x1

    move v7, v1

    goto :goto_4

    :cond_7
    iget v1, p0, Lcom/talkingdata/sdk/ab;->C:I

    sub-int v2, p3, p5

    add-int/lit8 v2, v2, -0x1

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    add-int/lit8 v3, p5, 0x1

    invoke-virtual {v2, v3, v9, v1}, Lcom/talkingdata/sdk/w;->a(III)I

    move-result v11

    const/4 v1, 0x2

    if-lt v11, v1, :cond_9

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->d()V

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v2, 0x0

    move/from16 v0, p5

    invoke-virtual {v1, v0, v2}, Lcom/talkingdata/sdk/w;->a(II)I

    move-result v2

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v3

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v4, 0x1

    move/from16 v0, p5

    invoke-virtual {v1, v0, v4}, Lcom/talkingdata/sdk/w;->a(II)I

    move-result v4

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->z:Lcom/talkingdata/sdk/z$b;

    add-int v5, p1, p5

    iget-object v6, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual/range {v1 .. v6}, Lcom/talkingdata/sdk/z$b;->a(IIIILcom/talkingdata/sdk/af;)I

    move-result v1

    add-int/2addr v1, v10

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/af;->c()V

    add-int v2, p1, p5

    add-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/talkingdata/sdk/ab;->m:I

    and-int/2addr v2, v3

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v3, v11, v4, v2}, Lcom/talkingdata/sdk/ab;->b(IILcom/talkingdata/sdk/af;I)I

    move-result v2

    add-int/2addr v2, v1

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int v1, v1, p5

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v1, v11

    :goto_5
    iget v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v3, v1, :cond_8

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->M:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/talkingdata/sdk/ab;->M:I

    aget-object v3, v3, v4

    invoke-virtual {v3}, Lcom/talkingdata/sdk/ad;->a()V

    goto :goto_5

    :cond_8
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v3, v3, v1

    iget v3, v3, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v2, v3, :cond_9

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v3, v1

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v4, v9, 0x4

    const/4 v6, 0x0

    move/from16 v5, p5

    invoke-virtual/range {v1 .. v6}, Lcom/talkingdata/sdk/ad;->a(IIIII)V

    :cond_9
    add-int/lit8 v1, v7, 0x1

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    if-ne v1, v2, :cond_6

    goto/16 :goto_1
.end method

.method private b(IIII)V
    .locals 10

    const/4 v9, 0x2

    const/4 v6, 0x1

    const/4 v7, 0x0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0, v7}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v1

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->b:[I

    aget v2, v2, v7

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v2

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v3

    iget v8, v0, Lcom/talkingdata/sdk/ad;->c:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->z:Lcom/talkingdata/sdk/z$b;

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v3, v6}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v3

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v4, v4, v5

    iget-object v5, v4, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    move v4, p1

    invoke-virtual/range {v0 .. v5}, Lcom/talkingdata/sdk/z$b;->a(IIIILcom/talkingdata/sdk/af;)I

    move-result v0

    add-int v3, v8, v0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v4, v4, 0x1

    aget-object v0, v0, v4

    iget v0, v0, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v3, v0, :cond_4

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v4, v4, 0x1

    aget-object v0, v0, v4

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    const/4 v5, -0x1

    invoke-virtual {v0, v3, v4, v5}, Lcom/talkingdata/sdk/ad;->a(III)V

    move v0, v6

    :goto_0
    if-ne v2, v1, :cond_1

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v5, v5, 0x1

    aget-object v4, v4, v5

    iget v4, v4, Lcom/talkingdata/sdk/ad;->d:I

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    if-eq v4, v5, :cond_0

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v5, v5, 0x1

    aget-object v4, v4, v5

    iget v4, v4, Lcom/talkingdata/sdk/ad;->e:I

    if-eqz v4, :cond_1

    :cond_0
    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v4, v4, v5

    iget-object v4, v4, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, p4, v4, p2}, Lcom/talkingdata/sdk/ab;->a(ILcom/talkingdata/sdk/af;I)I

    move-result v4

    iget-object v5, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v8, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v8, v8, 0x1

    aget-object v5, v5, v8

    iget v5, v5, Lcom/talkingdata/sdk/ad;->c:I

    if-gt v4, v5, :cond_1

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v5, v5, 0x1

    aget-object v0, v0, v5

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    invoke-virtual {v0, v4, v5, v7}, Lcom/talkingdata/sdk/ad;->a(III)V

    move v0, v6

    :cond_1
    if-nez v0, :cond_3

    if-eq v2, v1, :cond_3

    if-le p3, v9, :cond_3

    iget v0, p0, Lcom/talkingdata/sdk/ab;->C:I

    add-int/lit8 v1, p3, -0x1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v4

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->b:[I

    aget v2, v2, v7

    invoke-virtual {v1, v6, v2, v0}, Lcom/talkingdata/sdk/w;->a(III)I

    move-result v0

    if-lt v0, v9, :cond_3

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v4

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->c()V

    add-int/lit8 v1, p1, 0x1

    iget v2, p0, Lcom/talkingdata/sdk/ab;->m:I

    and-int/2addr v1, v2

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v7, v0, v2, v1}, Lcom/talkingdata/sdk/ab;->b(IILcom/talkingdata/sdk/af;I)I

    move-result v1

    add-int/2addr v1, v3

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v2, v2, 0x1

    add-int/2addr v0, v2

    :goto_1
    iget v2, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v2, v0, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    aget-object v2, v2, v3

    invoke-virtual {v2}, Lcom/talkingdata/sdk/ad;->a()V

    goto :goto_1

    :cond_2
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v2, v2, v0

    iget v2, v2, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v1, v2, :cond_3

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v2, v0

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    invoke-virtual {v0, v1, v2, v7}, Lcom/talkingdata/sdk/ad;->b(III)V

    :cond_3
    return-void

    :cond_4
    move v0, v7

    goto/16 :goto_0
.end method

.method private c(IIII)I
    .locals 13

    const/4 v7, 0x2

    iget v1, p0, Lcom/talkingdata/sdk/ab;->C:I

    move/from16 v0, p3

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v10

    const/4 v1, 0x0

    move v9, v1

    move v1, v7

    :goto_0
    const/4 v2, 0x4

    if-ge v9, v2, :cond_6

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v3, v3, v4

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->b:[I

    aget v3, v3, v9

    invoke-virtual {v2, v3, v10}, Lcom/talkingdata/sdk/w;->b(II)I

    move-result v8

    const/4 v2, 0x2

    if-ge v8, v2, :cond_1

    move v7, v1

    :cond_0
    :goto_1
    add-int/lit8 v1, v9, 0x1

    move v9, v1

    move v1, v7

    goto :goto_0

    :cond_1
    :goto_2
    iget v2, p0, Lcom/talkingdata/sdk/ab;->M:I

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/2addr v3, v8

    if-ge v2, v3, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    aget-object v2, v2, v3

    invoke-virtual {v2}, Lcom/talkingdata/sdk/ad;->a()V

    goto :goto_2

    :cond_2
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    move/from16 v0, p4

    invoke-virtual {p0, v0, v9, v2, p2}, Lcom/talkingdata/sdk/ab;->a(IILcom/talkingdata/sdk/af;I)I

    move-result v3

    move v2, v8

    :goto_3
    const/4 v4, 0x2

    if-lt v2, v4, :cond_4

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->B:Lcom/talkingdata/sdk/z$a;

    invoke-virtual {v4, v2, p2}, Lcom/talkingdata/sdk/z$a;->b(II)I

    move-result v4

    add-int/2addr v4, v3

    iget-object v5, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v6, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/2addr v6, v2

    aget-object v5, v5, v6

    iget v5, v5, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v4, v5, :cond_3

    iget-object v5, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v6, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/2addr v6, v2

    aget-object v5, v5, v6

    iget v6, p0, Lcom/talkingdata/sdk/ab;->L:I

    invoke-virtual {v5, v4, v6, v9}, Lcom/talkingdata/sdk/ad;->a(III)V

    :cond_3
    add-int/lit8 v2, v2, -0x1

    goto :goto_3

    :cond_4
    if-nez v9, :cond_7

    add-int/lit8 v1, v8, 0x1

    move v7, v1

    :goto_4
    iget v1, p0, Lcom/talkingdata/sdk/ab;->C:I

    sub-int v2, p3, v8

    add-int/lit8 v2, v2, -0x1

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    add-int/lit8 v4, v8, 0x1

    iget-object v5, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v6, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v5, v5, v6

    iget-object v5, v5, Lcom/talkingdata/sdk/ad;->b:[I

    aget v5, v5, v9

    invoke-virtual {v2, v4, v5, v1}, Lcom/talkingdata/sdk/w;->a(III)I

    move-result v11

    const/4 v1, 0x2

    if-lt v11, v1, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->B:Lcom/talkingdata/sdk/z$a;

    invoke-virtual {v1, v8, p2}, Lcom/talkingdata/sdk/z$a;->b(II)I

    move-result v1

    add-int v12, v3, v1

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->e()V

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v2, 0x0

    invoke-virtual {v1, v8, v2}, Lcom/talkingdata/sdk/w;->a(II)I

    move-result v2

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v3

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    const/4 v4, 0x1

    invoke-virtual {v1, v8, v4}, Lcom/talkingdata/sdk/w;->a(II)I

    move-result v4

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->z:Lcom/talkingdata/sdk/z$b;

    add-int v5, p1, v8

    iget-object v6, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual/range {v1 .. v6}, Lcom/talkingdata/sdk/z$b;->a(IIIILcom/talkingdata/sdk/af;)I

    move-result v1

    add-int/2addr v1, v12

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/af;->c()V

    add-int v2, p1, v8

    add-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/talkingdata/sdk/ab;->m:I

    and-int/2addr v2, v3

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->P:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v3, v11, v4, v2}, Lcom/talkingdata/sdk/ab;->b(IILcom/talkingdata/sdk/af;I)I

    move-result v2

    add-int/2addr v2, v1

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/2addr v1, v8

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v1, v11

    :goto_5
    iget v3, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v3, v1, :cond_5

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->M:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/talkingdata/sdk/ab;->M:I

    aget-object v3, v3, v4

    invoke-virtual {v3}, Lcom/talkingdata/sdk/ad;->a()V

    goto :goto_5

    :cond_5
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v3, v3, v1

    iget v3, v3, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v2, v3, :cond_0

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v3, v1

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    const/4 v6, 0x0

    move v4, v9

    move v5, v8

    invoke-virtual/range {v1 .. v6}, Lcom/talkingdata/sdk/ad;->a(IIIII)V

    goto/16 :goto_1

    :cond_6
    return v1

    :cond_7
    move v7, v1

    goto/16 :goto_4
.end method

.method private i()I
    .locals 4

    iget v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iput v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v1

    iget v0, v0, Lcom/talkingdata/sdk/ad;->d:I

    :cond_0
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v1, v2

    iget-boolean v1, v2, Lcom/talkingdata/sdk/ad;->f:Z

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v0

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    iput v3, v1, Lcom/talkingdata/sdk/ad;->d:I

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v0

    const/4 v3, -0x1

    iput v3, v1, Lcom/talkingdata/sdk/ad;->e:I

    add-int/lit8 v1, v0, -0x1

    iput v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget-boolean v0, v2, Lcom/talkingdata/sdk/ad;->g:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v1

    add-int/lit8 v3, v1, 0x1

    iput v3, v0, Lcom/talkingdata/sdk/ad;->d:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v1

    iget v3, v2, Lcom/talkingdata/sdk/ad;->i:I

    iput v3, v0, Lcom/talkingdata/sdk/ad;->e:I

    iput v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget v0, v2, Lcom/talkingdata/sdk/ad;->h:I

    move v1, v0

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v1

    iget v0, v0, Lcom/talkingdata/sdk/ad;->d:I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v2, v2, v1

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    iput v3, v2, Lcom/talkingdata/sdk/ad;->d:I

    iput v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    if-gtz v1, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iget v0, v0, Lcom/talkingdata/sdk/ad;->d:I

    iput v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v1

    iget v0, v0, Lcom/talkingdata/sdk/ad;->e:I

    iput v0, p0, Lcom/talkingdata/sdk/ab;->D:I

    iget v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    return v0

    :cond_2
    move v1, v0

    goto :goto_0
.end method

.method private j()V
    .locals 8

    const/4 v1, 0x1

    const/4 v7, 0x4

    const/4 v6, 0x0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v2

    iget v0, v0, Lcom/talkingdata/sdk/ad;->d:I

    sget-boolean v2, Lcom/talkingdata/sdk/ab;->G:Z

    if-nez v2, :cond_0

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    if-lt v0, v2, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-boolean v2, v2, Lcom/talkingdata/sdk/ad;->f:Z

    if-eqz v2, :cond_3

    add-int/lit8 v0, v0, -0x1

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-boolean v2, v2, Lcom/talkingdata/sdk/ad;->g:Z

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v4, v4, v5

    iget v4, v4, Lcom/talkingdata/sdk/ad;->h:I

    aget-object v3, v3, v4

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2, v3}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget v2, v2, Lcom/talkingdata/sdk/ad;->i:I

    if-ge v2, v7, :cond_1

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/af;->e()V

    :goto_0
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/af;->c()V

    :goto_1
    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v2, v2, -0x1

    if-ne v0, v2, :cond_7

    sget-boolean v1, Lcom/talkingdata/sdk/ab;->G:Z

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->e:I

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->e:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_4

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_1
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/af;->d()V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2, v3}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    goto :goto_0

    :cond_3
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v2, v3}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    goto :goto_1

    :cond_4
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->e:I

    if-nez v1, :cond_6

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->f()V

    :goto_2
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v1, v0

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->b:[I

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->b:[I

    invoke-static {v0, v6, v1, v6, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_5
    :goto_3
    return-void

    :cond_6
    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->c()V

    goto :goto_2

    :cond_7
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-boolean v2, v2, Lcom/talkingdata/sdk/ad;->f:Z

    if-eqz v2, :cond_8

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-boolean v2, v2, Lcom/talkingdata/sdk/ad;->g:Z

    if-eqz v2, :cond_8

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v2

    iget v2, v0, Lcom/talkingdata/sdk/ad;->h:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v3

    iget v0, v0, Lcom/talkingdata/sdk/ad;->i:I

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v3, v3, v4

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/af;->e()V

    move v3, v2

    move v2, v0

    :goto_4
    if-ge v2, v7, :cond_b

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v4

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->b:[I

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v4, v4, v3

    iget-object v4, v4, Lcom/talkingdata/sdk/ad;->b:[I

    aget v4, v4, v2

    aput v4, v0, v6

    move v0, v1

    :goto_5
    if-gt v0, v2, :cond_a

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v4

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->b:[I

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v4, v4, v3

    iget-object v4, v4, Lcom/talkingdata/sdk/ad;->b:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    :cond_8
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget v2, v2, Lcom/talkingdata/sdk/ad;->e:I

    if-ge v2, v7, :cond_9

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v3, v3, v4

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/af;->e()V

    move v3, v0

    goto :goto_4

    :cond_9
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v3, v3, v4

    iget-object v3, v3, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {v3}, Lcom/talkingdata/sdk/af;->d()V

    move v3, v0

    goto :goto_4

    :cond_a
    :goto_6
    if-ge v0, v7, :cond_5

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->b:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->b:[I

    aget v2, v2, v0

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    :cond_b
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v4

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->b:[I

    add-int/lit8 v2, v2, -0x4

    aput v2, v0, v6

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v3

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->b:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v3, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/talkingdata/sdk/ad;->b:[I

    const/4 v3, 0x3

    invoke-static {v0, v6, v2, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto/16 :goto_3
.end method


# virtual methods
.method a()I
    .locals 14

    const/4 v13, 0x4

    const/4 v12, -0x1

    const/4 v9, 0x1

    const/4 v11, 0x2

    const/4 v8, 0x0

    iget v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget v1, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v1

    iget v0, v0, Lcom/talkingdata/sdk/ad;->d:I

    iget v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->d:I

    iput v1, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v2, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v1, v1, v2

    iget v1, v1, Lcom/talkingdata/sdk/ad;->e:I

    iput v1, p0, Lcom/talkingdata/sdk/ab;->D:I

    :goto_0
    return v0

    :cond_0
    sget-boolean v0, Lcom/talkingdata/sdk/ab;->G:Z

    if-nez v0, :cond_1

    iget v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget v1, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-eq v0, v1, :cond_1

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_1
    iput v8, p0, Lcom/talkingdata/sdk/ab;->L:I

    iput v8, p0, Lcom/talkingdata/sdk/ab;->M:I

    iput v12, p0, Lcom/talkingdata/sdk/ab;->D:I

    iget v0, p0, Lcom/talkingdata/sdk/ab;->E:I

    if-ne v0, v12, :cond_2

    invoke-virtual {p0}, Lcom/talkingdata/sdk/ab;->g()Lcom/talkingdata/sdk/ac;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    :cond_2
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/w;->e()I

    move-result v0

    const/16 v1, 0x111

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v2

    if-ge v2, v11, :cond_3

    move v0, v9

    goto :goto_0

    :cond_3
    move v1, v8

    move v6, v8

    :goto_1
    if-ge v1, v13, :cond_5

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->n:[I

    aget v4, v4, v1

    invoke-virtual {v3, v4, v2}, Lcom/talkingdata/sdk/w;->b(II)I

    move-result v3

    aput v3, v0, v1

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v1

    if-ge v0, v11, :cond_4

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aput v8, v0, v1

    move v0, v6

    :goto_2
    add-int/lit8 v1, v1, 0x1

    move v6, v0

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v1

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v3, v3, v6

    if-le v0, v3, :cond_19

    move v0, v1

    goto :goto_2

    :cond_5
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v6

    iget v1, p0, Lcom/talkingdata/sdk/ab;->C:I

    if-lt v0, v1, :cond_6

    iput v6, p0, Lcom/talkingdata/sdk/ab;->D:I

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v6

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Lcom/talkingdata/sdk/ab;->c(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v6

    goto :goto_0

    :cond_6
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v0, v0, Lcom/talkingdata/sdk/ac;->c:I

    if-lez v0, :cond_18

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v0, v0, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v1, v1, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v1, v1, Lcom/talkingdata/sdk/ac;->b:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v2, v2, -0x1

    aget v1, v1, v2

    iget v2, p0, Lcom/talkingdata/sdk/ab;->C:I

    if-lt v0, v2, :cond_7

    add-int/lit8 v1, v1, 0x4

    iput v1, p0, Lcom/talkingdata/sdk/ab;->D:I

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Lcom/talkingdata/sdk/ab;->c(I)V

    goto/16 :goto_0

    :cond_7
    move v7, v0

    :goto_3
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0, v8}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v1

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->n:[I

    aget v2, v2, v8

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v2}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v2

    if-ge v7, v11, :cond_8

    if-eq v1, v2, :cond_8

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v6

    if-ge v0, v11, :cond_8

    move v0, v9

    goto/16 :goto_0

    :cond_8
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/w;->f()I

    move-result v4

    iget v0, p0, Lcom/talkingdata/sdk/ab;->m:I

    and-int v10, v4, v0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0, v9}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v3

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->z:Lcom/talkingdata/sdk/z$b;

    iget-object v5, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual/range {v0 .. v5}, Lcom/talkingdata/sdk/z$b;->a(IIIILcom/talkingdata/sdk/af;)I

    move-result v0

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v3, v3, v9

    invoke-virtual {v3, v0, v8, v12}, Lcom/talkingdata/sdk/ad;->a(III)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v0, v10}, Lcom/talkingdata/sdk/ab;->a(Lcom/talkingdata/sdk/af;I)I

    move-result v3

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v3, v0}, Lcom/talkingdata/sdk/ab;->b(ILcom/talkingdata/sdk/af;)I

    move-result v5

    if-ne v2, v1, :cond_9

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v5, v0, v10}, Lcom/talkingdata/sdk/ab;->a(ILcom/talkingdata/sdk/af;I)I

    move-result v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v9

    iget v1, v1, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v0, v1, :cond_9

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v9

    invoke-virtual {v1, v0, v8, v8}, Lcom/talkingdata/sdk/ad;->a(III)V

    :cond_9
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v6

    invoke-static {v7, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    iget v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v0, v11, :cond_b

    sget-boolean v0, Lcom/talkingdata/sdk/ab;->G:Z

    if-nez v0, :cond_a

    iget v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-eqz v0, :cond_a

    new-instance v0, Ljava/lang/AssertionError;

    iget v1, p0, Lcom/talkingdata/sdk/ab;->M:I

    invoke-direct {v0, v1}, Ljava/lang/AssertionError;-><init>(I)V

    throw v0

    :cond_a
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v9

    iget v0, v0, Lcom/talkingdata/sdk/ad;->e:I

    iput v0, p0, Lcom/talkingdata/sdk/ab;->D:I

    move v0, v9

    goto/16 :goto_0

    :cond_b
    invoke-virtual {p0}, Lcom/talkingdata/sdk/ab;->h()V

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v0, v0, v8

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/af;->a(Lcom/talkingdata/sdk/af;)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->n:[I

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v8

    iget-object v1, v1, Lcom/talkingdata/sdk/ad;->b:[I

    invoke-static {v0, v8, v1, v8, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    :goto_4
    if-lt v0, v11, :cond_c

    iget-object v1, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Lcom/talkingdata/sdk/ad;->a()V

    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    :cond_c
    move v1, v8

    :goto_5
    if-ge v1, v13, :cond_10

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v1

    if-ge v0, v11, :cond_d

    :goto_6
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_5

    :cond_d
    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v5, v1, v2, v10}, Lcom/talkingdata/sdk/ab;->a(IILcom/talkingdata/sdk/af;I)I

    move-result v2

    :cond_e
    iget-object v6, p0, Lcom/talkingdata/sdk/ab;->B:Lcom/talkingdata/sdk/z$a;

    invoke-virtual {v6, v0, v10}, Lcom/talkingdata/sdk/z$a;->b(II)I

    move-result v6

    add-int/2addr v6, v2

    iget-object v9, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v9, v9, v0

    iget v9, v9, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v6, v9, :cond_f

    iget-object v9, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v9, v9, v0

    invoke-virtual {v9, v6, v8, v1}, Lcom/talkingdata/sdk/ad;->a(III)V

    :cond_f
    add-int/lit8 v0, v0, -0x1

    if-ge v0, v11, :cond_e

    goto :goto_6

    :cond_10
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->O:[I

    aget v0, v0, v8

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0, v11}, Ljava/lang/Math;->max(II)I

    move-result v1

    if-gt v1, v7, :cond_14

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v3, v0}, Lcom/talkingdata/sdk/ab;->a(ILcom/talkingdata/sdk/af;)I

    move-result v2

    move v0, v8

    :goto_7
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v3, v3, Lcom/talkingdata/sdk/ac;->a:[I

    aget v3, v3, v0

    if-le v1, v3, :cond_12

    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    :cond_11
    add-int/lit8 v1, v1, 0x1

    :cond_12
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v3, v3, Lcom/talkingdata/sdk/ac;->b:[I

    aget v3, v3, v0

    invoke-virtual {p0, v2, v3, v1, v10}, Lcom/talkingdata/sdk/ab;->a(IIII)I

    move-result v5

    iget-object v6, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v6, v6, v1

    iget v6, v6, Lcom/talkingdata/sdk/ad;->c:I

    if-ge v5, v6, :cond_13

    iget-object v6, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    aget-object v6, v6, v1

    add-int/lit8 v3, v3, 0x4

    invoke-virtual {v6, v5, v8, v3}, Lcom/talkingdata/sdk/ad;->a(III)V

    :cond_13
    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v3, v3, Lcom/talkingdata/sdk/ac;->a:[I

    aget v3, v3, v0

    if-ne v1, v3, :cond_11

    add-int/lit8 v0, v0, 0x1

    iget-object v3, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v3, v3, Lcom/talkingdata/sdk/ac;->c:I

    if-ne v0, v3, :cond_11

    :cond_14
    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/w;->e()I

    move-result v0

    const/16 v1, 0xfff

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v3

    move v1, v4

    :cond_15
    :goto_8
    iget v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iget v2, p0, Lcom/talkingdata/sdk/ab;->M:I

    if-ge v0, v2, :cond_16

    invoke-virtual {p0}, Lcom/talkingdata/sdk/ab;->g()Lcom/talkingdata/sdk/ac;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v0, v0, Lcom/talkingdata/sdk/ac;->c:I

    if-lez v0, :cond_17

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget-object v0, v0, Lcom/talkingdata/sdk/ac;->a:[I

    iget-object v2, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v2, v2, Lcom/talkingdata/sdk/ac;->c:I

    add-int/lit8 v2, v2, -0x1

    aget v0, v0, v2

    iget v2, p0, Lcom/talkingdata/sdk/ab;->C:I

    if-lt v0, v2, :cond_17

    :cond_16
    invoke-direct {p0}, Lcom/talkingdata/sdk/ab;->i()I

    move-result v0

    goto/16 :goto_0

    :cond_17
    add-int/lit8 v3, v3, -0x1

    add-int/lit8 v1, v1, 0x1

    iget v0, p0, Lcom/talkingdata/sdk/ab;->m:I

    and-int v2, v1, v0

    invoke-direct {p0}, Lcom/talkingdata/sdk/ab;->j()V

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v4, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v4

    iget v0, v0, Lcom/talkingdata/sdk/ad;->c:I

    iget-object v4, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v4, v4, v5

    iget-object v4, v4, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v4, v2}, Lcom/talkingdata/sdk/ab;->a(Lcom/talkingdata/sdk/af;I)I

    move-result v4

    add-int/2addr v4, v0

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->K:[Lcom/talkingdata/sdk/ad;

    iget v5, p0, Lcom/talkingdata/sdk/ab;->L:I

    aget-object v0, v0, v5

    iget-object v0, v0, Lcom/talkingdata/sdk/ad;->a:Lcom/talkingdata/sdk/af;

    invoke-virtual {p0, v4, v0}, Lcom/talkingdata/sdk/ab;->b(ILcom/talkingdata/sdk/af;)I

    move-result v0

    invoke-direct {p0, v1, v2, v3, v0}, Lcom/talkingdata/sdk/ab;->b(IIII)V

    if-lt v3, v11, :cond_15

    invoke-direct {p0, v1, v2, v3, v0}, Lcom/talkingdata/sdk/ab;->c(IIII)I

    move-result v5

    iget-object v0, p0, Lcom/talkingdata/sdk/ab;->N:Lcom/talkingdata/sdk/ac;

    iget v0, v0, Lcom/talkingdata/sdk/ac;->c:I

    if-lez v0, :cond_15

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/ab;->a(IIIII)V

    goto :goto_8

    :cond_18
    move v7, v8

    goto/16 :goto_3

    :cond_19
    move v0, v6

    goto/16 :goto_2
.end method

.method public c()V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lcom/talkingdata/sdk/ab;->L:I

    iput v0, p0, Lcom/talkingdata/sdk/ab;->M:I

    invoke-super {p0}, Lcom/talkingdata/sdk/z;->c()V

    return-void
.end method
