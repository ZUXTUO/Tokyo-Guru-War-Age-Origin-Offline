.class Lcom/blm/sdk/async/http/AsyncHttpRequest;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final client:Lorg/apache/http/impl/client/AbstractHttpClient;

.field private final context:Lorg/apache/http/protocol/HttpContext;

.field private executionCount:I

.field private final request:Lorg/apache/http/client/methods/HttpUriRequest;

.field private final responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;


# direct methods
.method public constructor <init>(Lorg/apache/http/impl/client/AbstractHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)V
    .locals 0
    .param p1, "client"    # Lorg/apache/http/impl/client/AbstractHttpClient;
    .param p2, "context"    # Lorg/apache/http/protocol/HttpContext;
    .param p3, "request"    # Lorg/apache/http/client/methods/HttpUriRequest;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    .line 40
    iput-object p2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->context:Lorg/apache/http/protocol/HttpContext;

    .line 41
    iput-object p3, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->request:Lorg/apache/http/client/methods/HttpUriRequest;

    .line 42
    iput-object p4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .line 43
    return-void
.end method

.method private makeRequest()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 65
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v0

    if-nez v0, :cond_1

    .line 67
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->request:Lorg/apache/http/client/methods/HttpUriRequest;

    invoke-interface {v0}, Lorg/apache/http/client/methods/HttpUriRequest;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 69
    new-instance v0, Ljava/net/MalformedURLException;

    const-string v1, "No valid URI scheme was provided"

    invoke-direct {v0, v1}, Ljava/net/MalformedURLException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 72
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->request:Lorg/apache/http/client/methods/HttpUriRequest;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-virtual {v0, v1, v2}, Lorg/apache/http/impl/client/AbstractHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;Lorg/apache/http/protocol/HttpContext;)Lorg/apache/http/HttpResponse;

    move-result-object v0

    .line 74
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v1

    if-nez v1, :cond_1

    .line 75
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    if-eqz v1, :cond_1

    .line 76
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    invoke-interface {v1, v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendResponseMessage(Lorg/apache/http/HttpResponse;)V

    .line 80
    :cond_1
    return-void
.end method

.method private makeRequestWithRetries()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 83
    .line 84
    const/4 v0, 0x0

    .line 85
    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    invoke-virtual {v2}, Lorg/apache/http/impl/client/AbstractHttpClient;->getHttpRequestRetryHandler()Lorg/apache/http/client/HttpRequestRetryHandler;

    move-result-object v3

    move v2, v1

    .line 87
    :cond_0
    :goto_0
    if-eqz v2, :cond_2

    .line 89
    :try_start_0
    invoke-direct {p0}, Lcom/blm/sdk/async/http/AsyncHttpRequest;->makeRequest()V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 90
    return-void

    .line 91
    :catch_0
    move-exception v0

    .line 95
    :try_start_1
    new-instance v2, Ljava/io/IOException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "UnknownHostException exception: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 96
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    if-lez v0, :cond_3

    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    iget-object v4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v3, v2, v0, v4}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v1

    :goto_1
    move-object v6, v2

    move v2, v0

    move-object v0, v6

    .line 107
    :goto_2
    if-eqz v2, :cond_0

    iget-object v4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    if-eqz v4, :cond_0

    .line 108
    iget-object v4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    invoke-interface {v4}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendRetryMessage()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 111
    :catch_1
    move-exception v0

    move-object v1, v0

    .line 113
    sget-boolean v0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    if-eqz v0, :cond_1

    .line 116
    :cond_1
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unhandled exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 120
    :cond_2
    throw v0

    .line 96
    :cond_3
    const/4 v0, 0x0

    goto :goto_1

    .line 97
    :catch_2
    move-exception v2

    .line 101
    :try_start_2
    new-instance v0, Ljava/io/IOException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "NPE in HttpClient: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 102
    iget v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    iget-object v4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v3, v0, v2, v4}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v2

    goto :goto_2

    .line 103
    :catch_3
    move-exception v0

    .line 105
    iget v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->executionCount:I

    iget-object v4, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v3, v0, v2, v4}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    move-result v2

    goto :goto_2
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 47
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    if-eqz v0, :cond_0

    .line 48
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    invoke-interface {v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendStartMessage()V

    .line 52
    :cond_0
    :try_start_0
    invoke-direct {p0}, Lcom/blm/sdk/async/http/AsyncHttpRequest;->makeRequestWithRetries()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 59
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    if-eqz v0, :cond_2

    .line 60
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    invoke-interface {v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendFinishMessage()V

    .line 62
    :cond_2
    return-void

    .line 53
    :catch_0
    move-exception v0

    .line 54
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    if-eqz v1, :cond_1

    .line 55
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpRequest;->responseHandler:Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    const/4 v2, 0x0

    invoke-interface {v1, v2, v3, v3, v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendFailureMessage(I[Lorg/apache/http/Header;[BLjava/lang/Throwable;)V

    goto :goto_0
.end method
