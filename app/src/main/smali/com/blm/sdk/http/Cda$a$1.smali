.class Lcom/blm/sdk/http/Cda$a$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/blm/sdk/down/DownloadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/http/Cda$a;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/blm/sdk/http/Cda$a;


# direct methods
.method constructor <init>(Lcom/blm/sdk/http/Cda$a;)V
    .locals 0

    .prologue
    .line 423
    iput-object p1, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDownloadFail(ILjava/lang/String;)V
    .locals 2
    .param p1, "code"    # I
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 490
    const-string v0, "Cda"

    const-string v1, "download fail"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 491
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    if-eqz v0, :cond_0

    .line 492
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    invoke-interface {v0, p1, p2}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    .line 495
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget v0, v0, Lcom/blm/sdk/http/Cda$a;->g:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 496
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->e:Ljava/lang/String;

    const-string v1, "1"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    .line 498
    :cond_1
    return-void
.end method

.method public onDownloadFinish(Ljava/lang/String;I)V
    .locals 6
    .param p1, "saveFilePath"    # Ljava/lang/String;
    .param p2, "totalSize"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 440
    const-string v0, "Cda"

    const-string v3, "download finish"

    invoke-static {v0, v3}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 442
    const-string v0, "Cda"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "md5:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v4, v4, Lcom/blm/sdk/http/Cda$a;->h:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 444
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->h:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 447
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/blm/sdk/d/e;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 448
    const-string v3, "Cda"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "md5ByFile:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 449
    iget-object v3, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v3, v3, Lcom/blm/sdk/http/Cda$a;->h:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 450
    const-string v0, "Cda"

    const-string v3, "\u6821\u9a8c\u6210\u529f"

    invoke-static {v0, v3}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    .line 460
    :goto_0
    if-eqz v0, :cond_0

    move v2, v1

    .line 469
    :cond_0
    :goto_1
    if-eqz v2, :cond_5

    .line 470
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    if-eqz v0, :cond_1

    .line 471
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    invoke-interface {v0, p1, p2}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFinish(Ljava/lang/String;I)V

    .line 474
    :cond_1
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget v0, v0, Lcom/blm/sdk/http/Cda$a;->g:I

    if-ne v0, v1, :cond_2

    .line 475
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->e:Ljava/lang/String;

    const-string v1, "0"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    .line 486
    :cond_2
    :goto_2
    return-void

    :cond_3
    move v0, v2

    .line 453
    goto :goto_0

    .line 455
    :catch_0
    move-exception v0

    .line 456
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    move v0, v2

    .line 457
    goto :goto_0

    :cond_4
    move v2, v1

    .line 466
    goto :goto_1

    .line 478
    :cond_5
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    if-eqz v0, :cond_6

    .line 479
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    const/16 v2, 0x6b

    const-string v3, "MD5 check fail"

    invoke-interface {v0, v2, v3}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    .line 482
    :cond_6
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget v0, v0, Lcom/blm/sdk/http/Cda$a;->g:I

    if-ne v0, v1, :cond_2

    .line 483
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->e:Ljava/lang/String;

    const-string v1, "1"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2
.end method

.method public onDownloadProgress(I)V
    .locals 1
    .param p1, "downloadSize"    # I

    .prologue
    .line 433
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    if-eqz v0, :cond_0

    .line 434
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    invoke-interface {v0, p1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadProgress(I)V

    .line 436
    :cond_0
    return-void
.end method

.method public onDownloadStart()V
    .locals 1

    .prologue
    .line 426
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    if-eqz v0, :cond_0

    .line 427
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$a$1;->a:Lcom/blm/sdk/http/Cda$a;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$a;->i:Lcom/blm/sdk/down/DownloadListener;

    invoke-interface {v0}, Lcom/blm/sdk/down/DownloadListener;->onDownloadStart()V

    .line 429
    :cond_0
    return-void
.end method
