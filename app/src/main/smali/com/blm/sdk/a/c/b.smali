.class public Lcom/blm/sdk/a/c/b;
.super Lcom/blm/sdk/a/c/a;
.source "SourceFile"


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/Integer;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Lcom/blm/sdk/a/c/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 10
    iget-object v0, p0, Lcom/blm/sdk/a/c/b;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(Ljava/lang/Integer;)V
    .locals 0

    .prologue
    .line 22
    iput-object p1, p0, Lcom/blm/sdk/a/c/b;->b:Ljava/lang/Integer;

    .line 23
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 14
    iput-object p1, p0, Lcom/blm/sdk/a/c/b;->a:Ljava/lang/String;

    .line 15
    return-void
.end method

.method public b()Ljava/lang/Integer;
    .locals 1

    .prologue
    .line 18
    iget-object v0, p0, Lcom/blm/sdk/a/c/b;->b:Ljava/lang/Integer;

    return-object v0
.end method
