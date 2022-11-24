.class Lcom/talkingdata/sdk/b$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/talkingdata/sdk/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "a"
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Ljava/lang/String;

.field e:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/b$a;->a:Ljava/lang/String;

    iput-object v0, p0, Lcom/talkingdata/sdk/b$a;->b:Ljava/lang/String;

    iput-object v0, p0, Lcom/talkingdata/sdk/b$a;->c:Ljava/lang/String;

    iput-object v0, p0, Lcom/talkingdata/sdk/b$a;->d:Ljava/lang/String;

    iput-object v0, p0, Lcom/talkingdata/sdk/b$a;->e:Ljava/lang/String;

    return-void
.end method
