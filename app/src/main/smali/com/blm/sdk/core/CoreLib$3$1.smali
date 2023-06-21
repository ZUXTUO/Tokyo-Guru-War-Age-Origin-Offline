.class Lcom/blm/sdk/core/CoreLib$3$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/blm/sdk/down/DownloadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/CoreLib$3;->a(Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/blm/sdk/a/a/a;

.field final synthetic b:Lcom/blm/sdk/core/CoreLib$3;


# direct methods
.method constructor <init>(Lcom/blm/sdk/core/CoreLib$3;Lcom/blm/sdk/a/a/a;)V
    .locals 0

    .prologue
    .line 99
    iput-object p1, p0, Lcom/blm/sdk/core/CoreLib$3$1;->b:Lcom/blm/sdk/core/CoreLib$3;

    iput-object p2, p0, Lcom/blm/sdk/core/CoreLib$3$1;->a:Lcom/blm/sdk/a/a/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDownloadFail(ILjava/lang/String;)V
    .locals 0
    .param p1, "code"    # I
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 118
    return-void
.end method

.method public onDownloadFinish(Ljava/lang/String;I)V
    .locals 4
    .param p1, "saveFilePath"    # Ljava/lang/String;
    .param p2, "totalSize"    # I

    .prologue
    .line 109
    iget-object v0, p0, Lcom/blm/sdk/core/CoreLib$3$1;->b:Lcom/blm/sdk/core/CoreLib$3;

    iget-object v0, v0, Lcom/blm/sdk/core/CoreLib$3;->a:Landroid/content/Context;

    iget-object v1, p0, Lcom/blm/sdk/core/CoreLib$3$1;->b:Lcom/blm/sdk/core/CoreLib$3;

    iget-object v1, v1, Lcom/blm/sdk/core/CoreLib$3;->a:Landroid/content/Context;

    const-string v2, "blm"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/blm/sdk/core/CoreLib$3$1;->a:Lcom/blm/sdk/a/a/a;

    invoke-virtual {v2}, Lcom/blm/sdk/a/a/a;->a()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/blm/sdk/core/CoreLib$3$1;->a:Lcom/blm/sdk/a/a/a;

    invoke-virtual {v3}, Lcom/blm/sdk/a/a/a;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, p1, v1, v2, v3}, Lcom/blm/sdk/http/Cda;->lj(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 112
    iget-object v1, p0, Lcom/blm/sdk/core/CoreLib$3$1;->b:Lcom/blm/sdk/core/CoreLib$3;

    iget-object v1, v1, Lcom/blm/sdk/core/CoreLib$3;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/blm/sdk/core/CoreLib;->access$000(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/blm/sdk/core/CoreLib$3$1;->a:Lcom/blm/sdk/a/a/a;

    invoke-virtual {v3}, Lcom/blm/sdk/a/a/a;->c()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-static {v1, v2, v3, v0}, Lcom/blm/sdk/core/CoreLib;->completeJarReport(Landroid/content/Context;Ljava/lang/String;II)Ljava/lang/String;

    .line 114
    return-void
.end method

.method public onDownloadProgress(I)V
    .locals 0
    .param p1, "downloadSize"    # I

    .prologue
    .line 105
    return-void
.end method

.method public onDownloadStart()V
    .locals 0

    .prologue
    .line 102
    return-void
.end method
