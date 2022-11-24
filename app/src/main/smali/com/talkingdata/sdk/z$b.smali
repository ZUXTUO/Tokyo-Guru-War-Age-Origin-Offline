.class Lcom/talkingdata/sdk/z$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/talkingdata/sdk/z;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/talkingdata/sdk/z$b$a;
    }
.end annotation


# static fields
.field static final synthetic b:Z


# instance fields
.field a:[Lcom/talkingdata/sdk/z$b$a;

.field final synthetic c:Lcom/talkingdata/sdk/z;

.field private final d:I

.field private final e:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/talkingdata/sdk/z;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/talkingdata/sdk/z$b;->b:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/talkingdata/sdk/z;II)V
    .locals 4

    const/4 v1, 0x1

    iput-object p1, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/talkingdata/sdk/z$b;->d:I

    shl-int v0, v1, p3

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/talkingdata/sdk/z$b;->e:I

    add-int v0, p2, p3

    shl-int v0, v1, v0

    new-array v0, v0, [Lcom/talkingdata/sdk/z$b$a;

    iput-object v0, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    new-instance v2, Lcom/talkingdata/sdk/z$b$a;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/talkingdata/sdk/z$b$a;-><init>(Lcom/talkingdata/sdk/z$b;Lcom/talkingdata/sdk/z$1;)V

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method final a(II)I
    .locals 3

    iget v0, p0, Lcom/talkingdata/sdk/z$b;->d:I

    rsub-int/lit8 v0, v0, 0x8

    shr-int v0, p1, v0

    iget v1, p0, Lcom/talkingdata/sdk/z$b;->e:I

    and-int/2addr v1, p2

    iget v2, p0, Lcom/talkingdata/sdk/z$b;->d:I

    shl-int/2addr v1, v2

    add-int/2addr v0, v1

    return v0
.end method

.method a(IIIILcom/talkingdata/sdk/af;)I
    .locals 3

    iget-object v0, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v0, v0, Lcom/talkingdata/sdk/z;->p:[[S

    invoke-virtual {p5}, Lcom/talkingdata/sdk/af;->b()I

    move-result v1

    aget-object v0, v0, v1

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v1, v1, Lcom/talkingdata/sdk/z;->m:I

    and-int/2addr v1, p4

    aget-short v0, v0, v1

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/ae;->a(II)I

    move-result v1

    invoke-virtual {p0, p3, p4}, Lcom/talkingdata/sdk/z$b;->a(II)I

    move-result v0

    invoke-virtual {p5}, Lcom/talkingdata/sdk/af;->g()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    aget-object v0, v2, v0

    invoke-virtual {v0, p1}, Lcom/talkingdata/sdk/z$b$a;->a(I)I

    move-result v0

    :goto_0
    add-int/2addr v0, v1

    return v0

    :cond_0
    iget-object v2, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    aget-object v0, v2, v0

    invoke-virtual {v0, p1, p2}, Lcom/talkingdata/sdk/z$b$a;->a(II)I

    move-result v0

    goto :goto_0
.end method

.method a()V
    .locals 2

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    aget-object v1, v1, v0

    invoke-virtual {v1}, Lcom/talkingdata/sdk/z$b$a;->a()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method b()V
    .locals 2

    sget-boolean v0, Lcom/talkingdata/sdk/z$b;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v0, v0, Lcom/talkingdata/sdk/z;->E:I

    if-gez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/talkingdata/sdk/z$b$a;->b()V

    return-void
.end method

.method c()V
    .locals 3

    sget-boolean v0, Lcom/talkingdata/sdk/z$b;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v0, v0, Lcom/talkingdata/sdk/z;->E:I

    if-gez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v0, v0, Lcom/talkingdata/sdk/z;->y:Lcom/talkingdata/sdk/w;

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v1, v1, Lcom/talkingdata/sdk/z;->E:I

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/w;->c(I)I

    move-result v0

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget-object v1, v1, Lcom/talkingdata/sdk/z;->y:Lcom/talkingdata/sdk/w;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/w;->f()I

    move-result v1

    iget-object v2, p0, Lcom/talkingdata/sdk/z$b;->c:Lcom/talkingdata/sdk/z;

    iget v2, v2, Lcom/talkingdata/sdk/z;->E:I

    sub-int/2addr v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/z$b;->a(II)I

    move-result v0

    iget-object v1, p0, Lcom/talkingdata/sdk/z$b;->a:[Lcom/talkingdata/sdk/z$b$a;

    aget-object v0, v1, v0

    invoke-virtual {v0}, Lcom/talkingdata/sdk/z$b$a;->b()V

    return-void
.end method
