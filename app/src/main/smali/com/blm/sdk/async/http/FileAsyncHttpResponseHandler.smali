.class public Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;
.super Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;
.source "SourceFile"


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static final LOG_TAG:Ljava/lang/String; = "FileAsyncHttpResponseHandler"


# instance fields
.field private mFile:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    const-class v0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 29
    invoke-direct {p0}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;-><init>()V

    .line 30
    sget-boolean v0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 31
    :cond_0
    invoke-virtual {p0, p1}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->getTemporaryFile(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->mFile:Ljava/io/File;

    .line 32
    return-void
.end method

.method public constructor <init>(Ljava/io/File;)V
    .locals 1
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 23
    invoke-direct {p0}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;-><init>()V

    .line 24
    sget-boolean v0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 25
    :cond_0
    iput-object p1, p0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->mFile:Ljava/io/File;

    .line 26
    return-void
.end method


# virtual methods
.method getResponseData(Lorg/apache/http/HttpEntity;)[B
    .locals 8
    .param p1, "entity"    # Lorg/apache/http/HttpEntity;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 88
    const-string v1, "FileAsyncHttpResponseHandler"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "entry: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 89
    if-eqz p1, :cond_1

    .line 90
    invoke-interface {p1}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;

    move-result-object v1

    .line 91
    invoke-interface {p1}, Lorg/apache/http/HttpEntity;->getContentLength()J

    move-result-wide v2

    .line 92
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-virtual {p0}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->getTargetFile()Ljava/io/File;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 93
    if-eqz v1, :cond_1

    .line 95
    const/16 v5, 0x1000

    :try_start_0
    new-array v5, v5, [B

    .line 98
    :goto_0
    invoke-virtual {v1, v5}, Ljava/io/InputStream;->read([B)I

    move-result v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v7

    if-nez v7, :cond_0

    .line 99
    add-int/2addr v0, v6

    .line 100
    const/4 v7, 0x0

    invoke-virtual {v4, v5, v7, v6}, Ljava/io/FileOutputStream;->write([BII)V

    .line 101
    long-to-int v6, v2

    invoke-virtual {p0, v0, v6}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->sendProgressMessage(II)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 104
    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 105
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->flush()V

    .line 106
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    throw v0

    .line 104
    :cond_0
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 105
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->flush()V

    .line 106
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    .line 110
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method protected getTargetFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 46
    sget-boolean v0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->mFile:Ljava/io/File;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 47
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->mFile:Ljava/io/File;

    return-object v0
.end method

.method protected getTemporaryFile(Landroid/content/Context;)Ljava/io/File;
    .locals 3
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 36
    :try_start_0
    const-string v0, "temp_"

    const-string v1, "_handled"

    invoke-virtual {p1}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v2

    invoke-static {v0, v1, v2}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 42
    :goto_0
    return-object v0

    .line 37
    :catch_0
    move-exception v0

    .line 38
    sget-boolean v1, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    if-eqz v1, :cond_0

    .line 39
    const-string v1, "FileAsyncHttpResponseHandler"

    const-string v2, "Cannot create temporary file"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 42
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onFailure(ILjava/lang/Throwable;Ljava/io/File;)V
    .locals 0
    .param p1, "statusCode"    # I
    .param p2, "e"    # Ljava/lang/Throwable;
    .param p3, "response"    # Ljava/io/File;

    .prologue
    .line 68
    invoke-virtual {p0, p2, p3}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onFailure(Ljava/lang/Throwable;Ljava/io/File;)V

    .line 69
    return-void
.end method

.method public onFailure(I[Lorg/apache/http/Header;Ljava/lang/Throwable;Ljava/io/File;)V
    .locals 0
    .param p1, "statusCode"    # I
    .param p2, "headers"    # [Lorg/apache/http/Header;
    .param p3, "e"    # Ljava/lang/Throwable;
    .param p4, "response"    # Ljava/io/File;

    .prologue
    .line 73
    invoke-virtual {p0, p1, p3, p4}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onFailure(ILjava/lang/Throwable;Ljava/io/File;)V

    .line 74
    return-void
.end method

.method public onFailure(I[Lorg/apache/http/Header;[BLjava/lang/Throwable;)V
    .locals 1
    .param p1, "statusCode"    # I
    .param p2, "headers"    # [Lorg/apache/http/Header;
    .param p3, "responseBody"    # [B
    .param p4, "error"    # Ljava/lang/Throwable;

    .prologue
    .line 78
    invoke-virtual {p0}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->getTargetFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p4, v0}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onFailure(I[Lorg/apache/http/Header;Ljava/lang/Throwable;Ljava/io/File;)V

    .line 79
    return-void
.end method

.method public onFailure(Ljava/lang/Throwable;Ljava/io/File;)V
    .locals 0
    .param p1, "e"    # Ljava/lang/Throwable;
    .param p2, "response"    # Ljava/io/File;

    .prologue
    .line 63
    invoke-virtual {p0, p1}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onFailure(Ljava/lang/Throwable;)V

    .line 64
    return-void
.end method

.method public onSuccess(ILjava/io/File;)V
    .locals 0
    .param p1, "statusCode"    # I
    .param p2, "file"    # Ljava/io/File;

    .prologue
    .line 54
    invoke-virtual {p0, p2}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onSuccess(Ljava/io/File;)V

    .line 55
    return-void
.end method

.method public onSuccess(I[Lorg/apache/http/Header;Ljava/io/File;)V
    .locals 0
    .param p1, "statusCode"    # I
    .param p2, "headers"    # [Lorg/apache/http/Header;
    .param p3, "file"    # Ljava/io/File;

    .prologue
    .line 58
    invoke-virtual {p0, p1, p3}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onSuccess(ILjava/io/File;)V

    .line 59
    return-void
.end method

.method public onSuccess(I[Lorg/apache/http/Header;[B)V
    .locals 1
    .param p1, "statusCode"    # I
    .param p2, "headers"    # [Lorg/apache/http/Header;
    .param p3, "responseBody"    # [B

    .prologue
    .line 83
    invoke-virtual {p0}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->getTargetFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {p0, p1, p2, v0}, Lcom/blm/sdk/async/http/FileAsyncHttpResponseHandler;->onSuccess(I[Lorg/apache/http/Header;Ljava/io/File;)V

    .line 84
    return-void
.end method

.method public onSuccess(Ljava/io/File;)V
    .locals 0
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 51
    return-void
.end method
