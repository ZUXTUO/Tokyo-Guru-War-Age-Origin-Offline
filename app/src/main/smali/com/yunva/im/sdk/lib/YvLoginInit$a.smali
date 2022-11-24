.class Lcom/yunva/im/sdk/lib/YvLoginInit$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/pg/im/sdk/lib/c/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yunva/im/sdk/lib/YvLoginInit;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/yunva/im/sdk/lib/YvLoginInit;


# direct methods
.method constructor <init>(Lcom/yunva/im/sdk/lib/YvLoginInit;)V
    .locals 0

    .prologue
    .line 392
    iput-object p1, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$a;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 2

    .prologue
    .line 402
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$a;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    const-string v1, ""

    invoke-virtual {v0, p1, p2, v1}, Lcom/yunva/im/sdk/lib/YvLoginInit;->YvImUpdateGps(IILjava/lang/String;)V

    .line 404
    return-void
.end method

.method public a(ILjava/lang/String;)V
    .locals 2

    .prologue
    .line 396
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$a;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1, p2}, Lcom/yunva/im/sdk/lib/YvLoginInit;->YvImUpdateGps(IILjava/lang/String;)V

    .line 398
    return-void
.end method
