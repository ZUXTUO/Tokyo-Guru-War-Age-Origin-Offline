.class public Lcom/talkingdata/sdk/bq;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:B

.field private d:B

.field private e:B


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/talkingdata/sdk/bq;->a:Ljava/lang/String;

    const-string v0, "00:00:00:00:00:00"

    iput-object v0, p0, Lcom/talkingdata/sdk/bq;->b:Ljava/lang/String;

    const/16 v0, -0x7f

    iput-byte v0, p0, Lcom/talkingdata/sdk/bq;->c:B

    iput-byte v1, p0, Lcom/talkingdata/sdk/bq;->d:B

    iput-byte v1, p0, Lcom/talkingdata/sdk/bq;->e:B

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;BBB)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/talkingdata/sdk/bq;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/talkingdata/sdk/bq;->b:Ljava/lang/String;

    iput-byte p3, p0, Lcom/talkingdata/sdk/bq;->c:B

    iput-byte p4, p0, Lcom/talkingdata/sdk/bq;->d:B

    iput-byte p5, p0, Lcom/talkingdata/sdk/bq;->e:B

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/bq;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(B)V
    .locals 0

    iput-byte p1, p0, Lcom/talkingdata/sdk/bq;->c:B

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/bq;->a:Ljava/lang/String;

    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/bq;->b:Ljava/lang/String;

    return-object v0
.end method

.method public b(B)V
    .locals 0

    iput-byte p1, p0, Lcom/talkingdata/sdk/bq;->d:B

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/bq;->b:Ljava/lang/String;

    return-void
.end method

.method public c()B
    .locals 1

    iget-byte v0, p0, Lcom/talkingdata/sdk/bq;->c:B

    return v0
.end method

.method public c(B)V
    .locals 0

    iput-byte p1, p0, Lcom/talkingdata/sdk/bq;->e:B

    return-void
.end method

.method public d()B
    .locals 1

    iget-byte v0, p0, Lcom/talkingdata/sdk/bq;->d:B

    return v0
.end method

.method public e()B
    .locals 1

    iget-byte v0, p0, Lcom/talkingdata/sdk/bq;->e:B

    return v0
.end method

.method public f()Lcom/talkingdata/sdk/bq;
    .locals 6

    new-instance v0, Lcom/talkingdata/sdk/bq;

    iget-object v1, p0, Lcom/talkingdata/sdk/bq;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/talkingdata/sdk/bq;->b:Ljava/lang/String;

    iget-byte v3, p0, Lcom/talkingdata/sdk/bq;->c:B

    iget-byte v4, p0, Lcom/talkingdata/sdk/bq;->d:B

    iget-byte v5, p0, Lcom/talkingdata/sdk/bq;->e:B

    invoke-direct/range {v0 .. v5}, Lcom/talkingdata/sdk/bq;-><init>(Ljava/lang/String;Ljava/lang/String;BBB)V

    return-object v0
.end method
