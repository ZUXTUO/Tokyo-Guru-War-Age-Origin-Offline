.class public Lcom/blm/sdk/a/c/d;
.super Lcom/blm/sdk/a/c/a;
.source "SourceFile"


# instance fields
.field private a:Ljava/lang/String;

.field private b:Lcom/blm/sdk/a/b/g;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Lcom/blm/sdk/a/c/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 11
    iget-object v0, p0, Lcom/blm/sdk/a/c/d;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(Lcom/blm/sdk/a/b/g;)V
    .locals 0

    .prologue
    .line 23
    iput-object p1, p0, Lcom/blm/sdk/a/c/d;->b:Lcom/blm/sdk/a/b/g;

    .line 24
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 15
    iput-object p1, p0, Lcom/blm/sdk/a/c/d;->a:Ljava/lang/String;

    .line 16
    return-void
.end method

.method public b()Lcom/blm/sdk/a/b/g;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/blm/sdk/a/c/d;->b:Lcom/blm/sdk/a/b/g;

    return-object v0
.end method
