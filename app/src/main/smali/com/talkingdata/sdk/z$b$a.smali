.class Lcom/talkingdata/sdk/z$b$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/talkingdata/sdk/z$b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field final a:[S

.field final synthetic b:Lcom/talkingdata/sdk/z$b;


# direct methods
.method private constructor <init>(Lcom/talkingdata/sdk/z$b;)V
    .locals 1

    iput-object p1, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x300

    new-array v0, v0, [S

    iput-object v0, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    return-void
.end method

.method synthetic constructor <init>(Lcom/talkingdata/sdk/z$b;Lcom/talkingdata/sdk/z$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/talkingdata/sdk/z$b$a;-><init>(Lcom/talkingdata/sdk/z$b;)V

    return-void
.end method


# virtual methods
.method a(I)I
    .locals 5

    const/4 v0, 0x0

    or-int/lit16 v1, p1, 0x100

    :cond_0
    ushr-int/lit8 v2, v1, 0x8

    ushr-int/lit8 v3, v1, 0x7

    and-int/lit8 v3, v3, 0x1

    iget-object v4, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    aget-short v2, v4, v2

    invoke-static {v2, v3}, Lcom/talkingdata/sdk/ae;->a(II)I

    move-result v2

    add-int/2addr v0, v2

    shl-int/lit8 v1, v1, 0x1

    const/high16 v2, 0x10000

    if-lt v1, v2, :cond_0

    return v0
.end method

.method a(II)I
    .locals 6

    const/4 v1, 0x0

    const/16 v0, 0x100

    or-int/lit16 v2, p1, 0x100

    :cond_0
    shl-int/lit8 p2, p2, 0x1

    and-int v3, p2, v0

    add-int/2addr v3, v0

    ushr-int/lit8 v4, v2, 0x8

    add-int/2addr v3, v4

    ushr-int/lit8 v4, v2, 0x7

    and-int/lit8 v4, v4, 0x1

    iget-object v5, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    aget-short v3, v5, v3

    invoke-static {v3, v4}, Lcom/talkingdata/sdk/ae;->a(II)I

    move-result v3

    add-int/2addr v1, v3

    shl-int/lit8 v2, v2, 0x1

    xor-int v3, p2, v2

    xor-int/lit8 v3, v3, -0x1

    and-int/2addr v0, v3

    const/high16 v3, 0x10000

    if-lt v2, v3, :cond_0

    return v1
.end method

.method a()V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    invoke-static {v0}, Lcom/talkingdata/sdk/ae;->a([S)V

    return-void
.end method

.method b()V
    .locals 9

    const/high16 v7, 0x10000

    iget-object v0, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v0, v0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v0, v0, Lcom/talkingdata/sdk/z;->y:Lcom/talkingdata/sdk/w;

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v1, v1, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v1, v1, Lcom/talkingdata/sdk/z;->E:I

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v0

    or-int/lit16 v0, v0, 0x100

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v1, v1, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v1, v1, Lcom/talkingdata/sdk/z;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/af;->g()Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    ushr-int/lit8 v1, v0, 0x8

    ushr-int/lit8 v2, v0, 0x7

    and-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v3, v3, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    invoke-static {v3}, Lcom/talkingdata/sdk/z;->a(Lcom/talkingdata/sdk/z;)Lcom/talkingdata/sdk/ae;

    move-result-object v3

    iget-object v4, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    invoke-virtual {v3, v4, v1, v2}, Lcom/talkingdata/sdk/ae;->a([SII)V

    shl-int/lit8 v0, v0, 0x1

    if-lt v0, v7, :cond_0

    :goto_0
    iget-object v0, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v0, v0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v0, v0, Lcom/talkingdata/sdk/z;->o:Lcom/talkingdata/sdk/af;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/af;->c()V

    return-void

    :cond_1
    iget-object v1, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v1, v1, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v1, v1, Lcom/talkingdata/sdk/z;->y:Lcom/talkingdata/sdk/w;

    iget-object v2, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v2, v2, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v2, v2, Lcom/talkingdata/sdk/z;->n:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v3, v3, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v3, v3, Lcom/talkingdata/sdk/z;->E:I

    add-int/2addr v2, v3

    invoke-virtual {v1, v2}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v2

    const/16 v1, 0x100

    move v8, v1

    move v1, v2

    move v2, v0

    move v0, v8

    :cond_2
    shl-int/lit8 v1, v1, 0x1

    and-int v3, v1, v0

    add-int/2addr v3, v0

    ushr-int/lit8 v4, v2, 0x8

    add-int/2addr v3, v4

    ushr-int/lit8 v4, v2, 0x7

    and-int/lit8 v4, v4, 0x1

    iget-object v5, p0, Lcom/talkingdata/sdk/z$b$a;->b:Lcom/talkingdata/sdk/z$b;

    iget-object v5, v5, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    invoke-static {v5}, Lcom/talkingdata/sdk/z;->a(Lcom/talkingdata/sdk/z;)Lcom/talkingdata/sdk/ae;

    move-result-object v5

    iget-object v6, p0, Lcom/talkingdata/sdk/z$b$a;->a:[S

    invoke-virtual {v5, v6, v3, v4}, Lcom/talkingdata/sdk/ae;->a([SII)V

    shl-int/lit8 v2, v2, 0x1

    xor-int v3, v1, v2

    xor-int/lit8 v3, v3, -0x1

    and-int/2addr v0, v3

    if-lt v2, v7, :cond_2

    goto :goto_0
.end method
