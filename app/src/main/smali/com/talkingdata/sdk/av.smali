.class public Lcom/talkingdata/sdk/av;
.super Lcom/talkingdata/sdk/az;


# instance fields
.field private a:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    const-string v0, "type"

    iput-object v0, p0, Lcom/talkingdata/sdk/av;->a:Ljava/lang/String;

    const-string v0, "name"

    iput-object v0, p0, Lcom/talkingdata/sdk/av;->c:Ljava/lang/String;

    const-string v0, "extra1"

    iput-object v0, p0, Lcom/talkingdata/sdk/av;->d:Ljava/lang/String;

    const-string v0, "extra2"

    iput-object v0, p0, Lcom/talkingdata/sdk/av;->e:Ljava/lang/String;

    const-string v0, "targetApp"

    iput-object v0, p0, Lcom/talkingdata/sdk/av;->f:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/av;->c:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/talkingdata/sdk/av;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/av;->a:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/talkingdata/sdk/av;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/av;->e:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/talkingdata/sdk/av;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/av;->d:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/talkingdata/sdk/av;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/av;->f:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/talkingdata/sdk/av;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
