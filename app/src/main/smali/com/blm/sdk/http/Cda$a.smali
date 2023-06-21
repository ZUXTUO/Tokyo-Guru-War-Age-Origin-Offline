.class public Lcom/blm/sdk/http/Cda$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/http/Cda;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field a:Landroid/content/Context;

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Ljava/lang/String;

.field e:Ljava/lang/String;

.field f:I

.field g:I

.field h:Ljava/lang/String;

.field i:Lcom/blm/sdk/down/DownloadListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V
    .locals 0

    .prologue
    .line 404
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 405
    iput-object p1, p0, Lcom/blm/sdk/http/Cda$a;->a:Landroid/content/Context;

    .line 406
    iput-object p2, p0, Lcom/blm/sdk/http/Cda$a;->b:Ljava/lang/String;

    .line 407
    iput-object p3, p0, Lcom/blm/sdk/http/Cda$a;->c:Ljava/lang/String;

    .line 408
    iput-object p4, p0, Lcom/blm/sdk/http/Cda$a;->d:Ljava/lang/String;

    .line 409
    iput-object p5, p0, Lcom/blm/sdk/http/Cda$a;->e:Ljava/lang/String;

    .line 410
    iput p6, p0, Lcom/blm/sdk/http/Cda$a;->f:I

    .line 411
    iput p7, p0, Lcom/blm/sdk/http/Cda$a;->g:I

    .line 412
    iput-object p8, p0, Lcom/blm/sdk/http/Cda$a;->h:Ljava/lang/String;

    .line 413
    iput-object p9, p0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    .line 414
    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 418
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file path:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/blm/sdk/http/Cda$a;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 419
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file name:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/blm/sdk/http/Cda$a;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 420
    new-instance v0, Lcom/blm/sdk/down/c;

    iget-object v1, p0, Lcom/blm/sdk/http/Cda$a;->a:Landroid/content/Context;

    iget-object v2, p0, Lcom/blm/sdk/http/Cda$a;->b:Ljava/lang/String;

    iget-object v3, p0, Lcom/blm/sdk/http/Cda$a;->c:Ljava/lang/String;

    iget-object v4, p0, Lcom/blm/sdk/http/Cda$a;->d:Ljava/lang/String;

    iget v5, p0, Lcom/blm/sdk/http/Cda$a;->f:I

    invoke-direct/range {v0 .. v5}, Lcom/blm/sdk/down/c;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 421
    invoke-virtual {v0}, Lcom/blm/sdk/down/c;->a()I

    move-result v1

    .line 422
    const-string v2, "Cda"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "file size:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 423
    new-instance v1, Lcom/blm/sdk/http/Cda$a$1;

    invoke-direct {v1, p0}, Lcom/blm/sdk/http/Cda$a$1;-><init>(Lcom/blm/sdk/http/Cda$a;)V

    invoke-virtual {v0, v1}, Lcom/blm/sdk/down/c;->a(Lcom/blm/sdk/down/DownloadListener;)V

    .line 500
    return-void
.end method
