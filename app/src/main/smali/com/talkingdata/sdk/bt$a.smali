.class Lcom/talkingdata/sdk/bt$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/talkingdata/sdk/bt;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field public a:Lcom/talkingdata/sdk/bs;

.field public b:Lcom/talkingdata/sdk/bs;

.field public c:D

.field final synthetic d:Lcom/talkingdata/sdk/bt;


# direct methods
.method public constructor <init>(Lcom/talkingdata/sdk/bt;Lcom/talkingdata/sdk/bs;Lcom/talkingdata/sdk/bs;D)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/bt$a;->d:Lcom/talkingdata/sdk/bt;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/talkingdata/sdk/bt$a;->a:Lcom/talkingdata/sdk/bs;

    iput-object p3, p0, Lcom/talkingdata/sdk/bt$a;->b:Lcom/talkingdata/sdk/bs;

    iput-wide p4, p0, Lcom/talkingdata/sdk/bt$a;->c:D

    return-void
.end method
