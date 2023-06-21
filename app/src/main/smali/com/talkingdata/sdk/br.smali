.class public Lcom/talkingdata/sdk/br;
.super Ljava/lang/Object;


# static fields
.field public static final a:I = 0xa

.field public static final b:I = 0x3

.field public static final c:I = 0x32

.field public static final d:I = -0x55


# instance fields
.field private e:I

.field private f:I

.field private g:I

.field private h:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0xa

    iput v0, p0, Lcom/talkingdata/sdk/br;->e:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/talkingdata/sdk/br;->f:I

    const/16 v0, 0x32

    iput v0, p0, Lcom/talkingdata/sdk/br;->g:I

    const/16 v0, -0x55

    iput v0, p0, Lcom/talkingdata/sdk/br;->h:I

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lcom/talkingdata/sdk/br;->e:I

    return v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lcom/talkingdata/sdk/br;->e:I

    return-void
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lcom/talkingdata/sdk/br;->f:I

    return v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lcom/talkingdata/sdk/br;->f:I

    return-void
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lcom/talkingdata/sdk/br;->g:I

    return v0
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lcom/talkingdata/sdk/br;->g:I

    return-void
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lcom/talkingdata/sdk/br;->h:I

    return v0
.end method

.method public d(I)V
    .locals 0

    iput p1, p0, Lcom/talkingdata/sdk/br;->h:I

    return-void
.end method
