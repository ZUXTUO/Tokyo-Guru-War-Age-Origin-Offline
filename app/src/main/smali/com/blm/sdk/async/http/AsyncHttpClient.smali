.class public Lcom/blm/sdk/async/http/AsyncHttpClient;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blm/sdk/async/http/AsyncHttpClient$InflatingEntity;
    }
.end annotation


# static fields
.field private static final DEFAULT_MAX_CONNECTIONS:I = 0xa

.field private static final DEFAULT_MAX_RETRIES:I = 0x5

.field private static final DEFAULT_RETRY_SLEEP_TIME_MILLIS:I = 0x5dc

.field private static final DEFAULT_SOCKET_BUFFER_SIZE:I = 0x2000

.field private static final DEFAULT_SOCKET_TIMEOUT:I = 0x2710

.field private static final ENCODING_GZIP:Ljava/lang/String; = "gzip"

.field private static final HEADER_ACCEPT_ENCODING:Ljava/lang/String; = "Accept-Encoding"

.field private static final LOG_TAG:Ljava/lang/String; = "AsyncHttpClient"

.field private static final VERSION:Ljava/lang/String; = "1.4.4"

.field public static isDebug:Z


# instance fields
.field private final clientHeaderMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

.field private final httpContext:Lorg/apache/http/protocol/HttpContext;

.field private isUrlEncodingEnabled:Z

.field private maxConnections:I

.field private final requestMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Ljava/util/concurrent/Future",
            "<*>;>;>;>;"
        }
    .end annotation
.end field

.field private threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

.field private timeout:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 95
    const/4 v0, 0x0

    sput-boolean v0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 120
    const/4 v0, 0x0

    const/16 v1, 0x50

    const/16 v2, 0x1bb

    invoke-direct {p0, v0, v1, v2}, Lcom/blm/sdk/async/http/AsyncHttpClient;-><init>(ZII)V

    .line 121
    return-void
.end method

.method public constructor <init>(I)V
    .locals 2
    .param p1, "httpPort"    # I

    .prologue
    .line 129
    const/4 v0, 0x0

    const/16 v1, 0x1bb

    invoke-direct {p0, v0, p1, v1}, Lcom/blm/sdk/async/http/AsyncHttpClient;-><init>(ZII)V

    .line 130
    return-void
.end method

.method public constructor <init>(II)V
    .locals 1
    .param p1, "httpPort"    # I
    .param p2, "httpsPort"    # I

    .prologue
    .line 139
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;-><init>(ZII)V

    .line 140
    return-void
.end method

.method public constructor <init>(Lorg/apache/http/conn/scheme/SchemeRegistry;)V
    .locals 6
    .param p1, "schemeRegistry"    # Lorg/apache/http/conn/scheme/SchemeRegistry;

    .prologue
    const/16 v5, 0xa

    const/4 v4, 0x1

    .line 195
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 106
    iput v5, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->maxConnections:I

    .line 107
    const/16 v0, 0x2710

    iput v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    .line 114
    iput-boolean v4, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    .line 197
    new-instance v1, Lorg/apache/http/params/BasicHttpParams;

    invoke-direct {v1}, Lorg/apache/http/params/BasicHttpParams;-><init>()V

    .line 199
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    int-to-long v2, v0

    invoke-static {v1, v2, v3}, Lorg/apache/http/conn/params/ConnManagerParams;->setTimeout(Lorg/apache/http/params/HttpParams;J)V

    .line 200
    new-instance v0, Lorg/apache/http/conn/params/ConnPerRouteBean;

    iget v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->maxConnections:I

    invoke-direct {v0, v2}, Lorg/apache/http/conn/params/ConnPerRouteBean;-><init>(I)V

    invoke-static {v1, v0}, Lorg/apache/http/conn/params/ConnManagerParams;->setMaxConnectionsPerRoute(Lorg/apache/http/params/HttpParams;Lorg/apache/http/conn/params/ConnPerRoute;)V

    .line 201
    invoke-static {v1, v5}, Lorg/apache/http/conn/params/ConnManagerParams;->setMaxTotalConnections(Lorg/apache/http/params/HttpParams;I)V

    .line 203
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setSoTimeout(Lorg/apache/http/params/HttpParams;I)V

    .line 204
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setConnectionTimeout(Lorg/apache/http/params/HttpParams;I)V

    .line 205
    invoke-static {v1, v4}, Lorg/apache/http/params/HttpConnectionParams;->setTcpNoDelay(Lorg/apache/http/params/HttpParams;Z)V

    .line 206
    const/16 v0, 0x2000

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpConnectionParams;->setSocketBufferSize(Lorg/apache/http/params/HttpParams;I)V

    .line 208
    sget-object v0, Lorg/apache/http/HttpVersion;->HTTP_1_1:Lorg/apache/http/HttpVersion;

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpProtocolParams;->setVersion(Lorg/apache/http/params/HttpParams;Lorg/apache/http/ProtocolVersion;)V

    .line 209
    const-string v0, "android-async-http/%s (http://loopj.com/android-async-http)"

    new-array v2, v4, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "1.4.4"

    aput-object v4, v2, v3

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/apache/http/params/HttpProtocolParams;->setUserAgent(Lorg/apache/http/params/HttpParams;Ljava/lang/String;)V

    .line 211
    new-instance v2, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;

    invoke-direct {v2, v1, p1}, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;-><init>(Lorg/apache/http/params/HttpParams;Lorg/apache/http/conn/scheme/SchemeRegistry;)V

    .line 213
    invoke-static {v5}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ThreadPoolExecutor;

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 214
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->requestMap:Ljava/util/Map;

    .line 215
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->clientHeaderMap:Ljava/util/Map;

    .line 217
    new-instance v0, Lorg/apache/http/protocol/SyncBasicHttpContext;

    new-instance v3, Lorg/apache/http/protocol/BasicHttpContext;

    invoke-direct {v3}, Lorg/apache/http/protocol/BasicHttpContext;-><init>()V

    invoke-direct {v0, v3}, Lorg/apache/http/protocol/SyncBasicHttpContext;-><init>(Lorg/apache/http/protocol/HttpContext;)V

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    .line 218
    new-instance v0, Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-direct {v0, v2, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>(Lorg/apache/http/conn/ClientConnectionManager;Lorg/apache/http/params/HttpParams;)V

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    .line 219
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    new-instance v1, Lcom/blm/sdk/async/http/AsyncHttpClient$1;

    invoke-direct {v1, p0}, Lcom/blm/sdk/async/http/AsyncHttpClient$1;-><init>(Lcom/blm/sdk/async/http/AsyncHttpClient;)V

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->addRequestInterceptor(Lorg/apache/http/HttpRequestInterceptor;)V

    .line 231
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    new-instance v1, Lcom/blm/sdk/async/http/AsyncHttpClient$2;

    invoke-direct {v1, p0}, Lcom/blm/sdk/async/http/AsyncHttpClient$2;-><init>(Lcom/blm/sdk/async/http/AsyncHttpClient;)V

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->addResponseInterceptor(Lorg/apache/http/HttpResponseInterceptor;)V

    .line 250
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    new-instance v1, Lcom/blm/sdk/async/http/RetryHandler;

    const/4 v2, 0x5

    const/16 v3, 0x5dc

    invoke-direct {v1, v2, v3}, Lcom/blm/sdk/async/http/RetryHandler;-><init>(II)V

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->setHttpRequestRetryHandler(Lorg/apache/http/client/HttpRequestRetryHandler;)V

    .line 251
    return-void
.end method

.method public constructor <init>(ZII)V
    .locals 1
    .param p1, "fixNoHttpResponseException"    # Z
    .param p2, "httpPort"    # I
    .param p3, "httpsPort"    # I

    .prologue
    .line 150
    invoke-static {p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getDefaultSchemeRegistry(ZII)Lorg/apache/http/conn/scheme/SchemeRegistry;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/blm/sdk/async/http/AsyncHttpClient;-><init>(Lorg/apache/http/conn/scheme/SchemeRegistry;)V

    .line 151
    return-void
.end method

.method static synthetic access$000(Lcom/blm/sdk/async/http/AsyncHttpClient;)Ljava/util/Map;
    .locals 1
    .param p0, "x0"    # Lcom/blm/sdk/async/http/AsyncHttpClient;

    .prologue
    .line 92
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->clientHeaderMap:Ljava/util/Map;

    return-object v0
.end method

.method private addEntityToRequestBase(Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;Lorg/apache/http/HttpEntity;)Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;
    .locals 0
    .param p1, "requestBase"    # Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;
    .param p2, "entity"    # Lorg/apache/http/HttpEntity;

    .prologue
    .line 985
    if-eqz p2, :cond_0

    .line 986
    invoke-virtual {p1, p2}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setEntity(Lorg/apache/http/HttpEntity;)V

    .line 989
    :cond_0
    return-object p1
.end method

.method private static getDefaultSchemeRegistry(ZII)Lorg/apache/http/conn/scheme/SchemeRegistry;
    .locals 5
    .param p0, "fixNoHttpResponseException"    # Z
    .param p1, "httpPort"    # I
    .param p2, "httpsPort"    # I

    .prologue
    const/4 v0, 0x1

    .line 161
    if-eqz p0, :cond_0

    .line 165
    :cond_0
    if-ge p1, v0, :cond_1

    .line 166
    const/16 p1, 0x50

    .line 170
    :cond_1
    if-ge p2, v0, :cond_2

    .line 171
    const/16 p2, 0x1bb

    .line 178
    :cond_2
    if-eqz p0, :cond_3

    .line 179
    invoke-static {}, Lcom/blm/sdk/async/http/MySSLSocketFactory;->getFixedSocketFactory()Lorg/apache/http/conn/ssl/SSLSocketFactory;

    move-result-object v0

    .line 183
    :goto_0
    new-instance v1, Lorg/apache/http/conn/scheme/SchemeRegistry;

    invoke-direct {v1}, Lorg/apache/http/conn/scheme/SchemeRegistry;-><init>()V

    .line 184
    new-instance v2, Lorg/apache/http/conn/scheme/Scheme;

    const-string v3, "http"

    invoke-static {}, Lorg/apache/http/conn/scheme/PlainSocketFactory;->getSocketFactory()Lorg/apache/http/conn/scheme/PlainSocketFactory;

    move-result-object v4

    invoke-direct {v2, v3, v4, p1}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v1, v2}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    .line 185
    new-instance v2, Lorg/apache/http/conn/scheme/Scheme;

    const-string v3, "https"

    invoke-direct {v2, v3, v0, p2}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v1, v2}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    .line 187
    return-object v1

    .line 181
    :cond_3
    invoke-static {}, Lorg/apache/http/conn/ssl/SSLSocketFactory;->getSocketFactory()Lorg/apache/http/conn/ssl/SSLSocketFactory;

    move-result-object v0

    goto :goto_0
.end method

.method public static getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;
    .locals 3
    .param p0, "shouldEncodeUrl"    # Z
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/blm/sdk/async/http/RequestParams;

    .prologue
    .line 931
    if-eqz p0, :cond_0

    .line 932
    const-string v0, " "

    const-string v1, "%20"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 934
    :cond_0
    if-eqz p2, :cond_1

    .line 935
    invoke-virtual {p2}, Lcom/blm/sdk/async/http/RequestParams;->getParamString()Ljava/lang/String;

    move-result-object v0

    .line 936
    const-string v1, "?"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 937
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "?"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 943
    :cond_1
    :goto_0
    return-object p1

    .line 939
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "&"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method private paramsToEntity(Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lorg/apache/http/HttpEntity;
    .locals 3
    .param p1, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    const/4 v0, 0x0

    .line 954
    .line 957
    if-eqz p1, :cond_0

    .line 958
    :try_start_0
    invoke-virtual {p1, p2}, Lcom/blm/sdk/async/http/RequestParams;->getEntity(Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lorg/apache/http/HttpEntity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 970
    :cond_0
    :goto_0
    return-object v0

    .line 960
    :catch_0
    move-exception v1

    .line 961
    if-eqz p2, :cond_1

    .line 962
    const/4 v2, 0x0

    invoke-interface {p2, v2, v0, v0, v1}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->sendFailureMessage(I[Lorg/apache/http/Header;[BLjava/lang/Throwable;)V

    goto :goto_0

    .line 964
    :cond_1
    sget-boolean v2, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    if-eqz v2, :cond_0

    .line 965
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "header"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 424
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->clientHeaderMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 425
    return-void
.end method

.method public cancelRequests(Landroid/content/Context;Z)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "mayInterruptIfRunning"    # Z

    .prologue
    .line 479
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->requestMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 480
    if-eqz v0, :cond_1

    .line 481
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    .line 482
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/Future;

    .line 483
    if-eqz v0, :cond_0

    .line 484
    invoke-interface {v0, p2}, Ljava/util/concurrent/Future;->cancel(Z)Z

    goto :goto_0

    .line 488
    :cond_1
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->requestMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 489
    return-void
.end method

.method public clearBasicAuth()V
    .locals 1

    .prologue
    .line 465
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getCredentialsProvider()Lorg/apache/http/client/CredentialsProvider;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/client/CredentialsProvider;->clear()V

    .line 466
    return-void
.end method

.method public delete(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 839
    new-instance v3, Lorg/apache/http/client/methods/HttpDelete;

    invoke-direct {v3, p2}, Lorg/apache/http/client/methods/HttpDelete;-><init>(Ljava/lang/String;)V

    .line 840
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p3

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public delete(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 869
    new-instance v3, Lorg/apache/http/client/methods/HttpDelete;

    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    invoke-static {v0, p2, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Lorg/apache/http/client/methods/HttpDelete;-><init>(Ljava/lang/String;)V

    .line 870
    if-eqz p3, :cond_0

    invoke-virtual {v3, p3}, Lorg/apache/http/client/methods/HttpDelete;->setHeaders([Lorg/apache/http/Header;)V

    .line 871
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p5

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public delete(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 853
    new-instance v3, Lorg/apache/http/client/methods/HttpDelete;

    invoke-direct {v3, p2}, Lorg/apache/http/client/methods/HttpDelete;-><init>(Ljava/lang/String;)V

    .line 854
    if-eqz p3, :cond_0

    invoke-virtual {v3, p3}, Lorg/apache/http/client/methods/HttpDelete;->setHeaders([Lorg/apache/http/Header;)V

    .line 855
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p4

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public delete(Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 827
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;->delete(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public get(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 613
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    new-instance v3, Lorg/apache/http/client/methods/HttpGet;

    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    invoke-static {v0, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p4

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public get(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 600
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->get(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public get(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 628
    new-instance v3, Lorg/apache/http/client/methods/HttpGet;

    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    invoke-static {v0, p2, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    .line 629
    if-eqz p3, :cond_0

    invoke-interface {v3, p3}, Lorg/apache/http/client/methods/HttpUriRequest;->setHeaders([Lorg/apache/http/Header;)V

    .line 630
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p5

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public get(Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 587
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->get(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public get(Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    const/4 v0, 0x0

    .line 575
    invoke-virtual {p0, v0, p1, v0, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;->get(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public getHttpClient()Lorg/apache/http/client/HttpClient;
    .locals 1

    .prologue
    .line 261
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    return-object v0
.end method

.method public getHttpContext()Lorg/apache/http/protocol/HttpContext;
    .locals 1

    .prologue
    .line 271
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    return-object v0
.end method

.method public getMaxConnections()I
    .locals 1

    .prologue
    .line 327
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->maxConnections:I

    return v0
.end method

.method public getTimeout()I
    .locals 1

    .prologue
    .line 349
    iget v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    return v0
.end method

.method public head(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 541
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    new-instance v3, Lorg/apache/http/client/methods/HttpHead;

    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    invoke-static {v0, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Lorg/apache/http/client/methods/HttpHead;-><init>(Ljava/lang/String;)V

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p4

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public head(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 528
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->head(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public head(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 556
    new-instance v3, Lorg/apache/http/client/methods/HttpHead;

    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    invoke-static {v0, p2, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getUrlWithQueryString(ZLjava/lang/String;Lcom/blm/sdk/async/http/RequestParams;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Lorg/apache/http/client/methods/HttpHead;-><init>(Ljava/lang/String;)V

    .line 557
    if-eqz p3, :cond_0

    invoke-interface {v3, p3}, Lorg/apache/http/client/methods/HttpUriRequest;->setHeaders([Lorg/apache/http/Header;)V

    .line 558
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p5

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public head(Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 515
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->head(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public head(Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    const/4 v0, 0x0

    .line 503
    invoke-virtual {p0, v0, p1, v0, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;->head(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public isUrlEncodingEnabled()Z
    .locals 1

    .prologue
    .line 974
    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    return v0
.end method

.method public post(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 672
    invoke-direct {p0, p3, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->paramsToEntity(Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lorg/apache/http/HttpEntity;

    move-result-object v3

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/blm/sdk/async/http/AsyncHttpClient;->post(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public post(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "entity"    # Lorg/apache/http/HttpEntity;
    .param p4, "contentType"    # Ljava/lang/String;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 689
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    new-instance v0, Lorg/apache/http/client/methods/HttpPost;

    invoke-direct {v0, p2}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->addEntityToRequestBase(Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;Lorg/apache/http/HttpEntity;)Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;

    move-result-object v3

    move-object v0, p0

    move-object v4, p4

    move-object v5, p5

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public post(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lcom/blm/sdk/async/http/RequestParams;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p5, "contentType"    # Ljava/lang/String;
    .param p6, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 707
    new-instance v3, Lorg/apache/http/client/methods/HttpPost;

    invoke-direct {v3, p2}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    .line 708
    if-eqz p4, :cond_0

    invoke-direct {p0, p4, p6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->paramsToEntity(Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lorg/apache/http/HttpEntity;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setEntity(Lorg/apache/http/HttpEntity;)V

    .line 709
    :cond_0
    if-eqz p3, :cond_1

    invoke-virtual {v3, p3}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setHeaders([Lorg/apache/http/Header;)V

    .line 710
    :cond_1
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    move-object v0, p0

    move-object v4, p5

    move-object v5, p6

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public post(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "entity"    # Lorg/apache/http/HttpEntity;
    .param p5, "contentType"    # Ljava/lang/String;
    .param p6, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 731
    new-instance v0, Lorg/apache/http/client/methods/HttpPost;

    invoke-direct {v0, p2}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->addEntityToRequestBase(Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;Lorg/apache/http/HttpEntity;)Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;

    move-result-object v3

    .line 732
    if-eqz p3, :cond_0

    invoke-virtual {v3, p3}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setHeaders([Lorg/apache/http/Header;)V

    .line 733
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    move-object v0, p0

    move-object v4, p5

    move-object v5, p6

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public post(Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 659
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->post(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public post(Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    const/4 v0, 0x0

    .line 647
    invoke-virtual {p0, v0, p1, v0, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;->post(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public put(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p4, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 773
    invoke-direct {p0, p3, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->paramsToEntity(Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lorg/apache/http/HttpEntity;

    move-result-object v3

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/blm/sdk/async/http/AsyncHttpClient;->put(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public put(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "entity"    # Lorg/apache/http/HttpEntity;
    .param p4, "contentType"    # Ljava/lang/String;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 791
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    new-instance v0, Lorg/apache/http/client/methods/HttpPut;

    invoke-direct {v0, p2}, Lorg/apache/http/client/methods/HttpPut;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->addEntityToRequestBase(Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;Lorg/apache/http/HttpEntity;)Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;

    move-result-object v3

    move-object v0, p0

    move-object v4, p4

    move-object v5, p5

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public put(Landroid/content/Context;Ljava/lang/String;[Lorg/apache/http/Header;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "headers"    # [Lorg/apache/http/Header;
    .param p4, "entity"    # Lorg/apache/http/HttpEntity;
    .param p5, "contentType"    # Ljava/lang/String;
    .param p6, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 810
    new-instance v0, Lorg/apache/http/client/methods/HttpPut;

    invoke-direct {v0, p2}, Lorg/apache/http/client/methods/HttpPut;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0, p4}, Lcom/blm/sdk/async/http/AsyncHttpClient;->addEntityToRequestBase(Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;Lorg/apache/http/HttpEntity;)Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;

    move-result-object v3

    .line 811
    if-eqz p3, :cond_0

    invoke-virtual {v3, p3}, Lorg/apache/http/client/methods/HttpEntityEnclosingRequestBase;->setHeaders([Lorg/apache/http/Header;)V

    .line 812
    :cond_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    move-object v0, p0

    move-object v4, p5

    move-object v5, p6

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/blm/sdk/async/http/AsyncHttpClient;->sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public put(Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/blm/sdk/async/http/RequestParams;
    .param p3, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    .line 760
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpClient;->put(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public put(Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;

    .prologue
    const/4 v0, 0x0

    .line 748
    invoke-virtual {p0, v0, p1, v0, p2}, Lcom/blm/sdk/async/http/AsyncHttpClient;->put(Landroid/content/Context;Ljava/lang/String;Lcom/blm/sdk/async/http/RequestParams;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;

    move-result-object v0

    return-object v0
.end method

.method public removeHeader(Ljava/lang/String;)V
    .locals 1
    .param p1, "header"    # Ljava/lang/String;

    .prologue
    .line 433
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->clientHeaderMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 434
    return-void
.end method

.method protected sendRequest(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;Landroid/content/Context;)Lcom/blm/sdk/async/http/RequestHandle;
    .locals 3
    .param p1, "client"    # Lorg/apache/http/impl/client/DefaultHttpClient;
    .param p2, "httpContext"    # Lorg/apache/http/protocol/HttpContext;
    .param p3, "uriRequest"    # Lorg/apache/http/client/methods/HttpUriRequest;
    .param p4, "contentType"    # Ljava/lang/String;
    .param p5, "responseHandler"    # Lcom/blm/sdk/async/http/ResponseHandlerInterface;
    .param p6, "context"    # Landroid/content/Context;

    .prologue
    .line 887
    if-eqz p4, :cond_0

    .line 888
    const-string v0, "Content-Type"

    invoke-interface {p3, v0, p4}, Lorg/apache/http/client/methods/HttpUriRequest;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 891
    :cond_0
    invoke-interface {p3}, Lorg/apache/http/client/methods/HttpUriRequest;->getAllHeaders()[Lorg/apache/http/Header;

    move-result-object v0

    invoke-interface {p5, v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->setRequestHeaders([Lorg/apache/http/Header;)V

    .line 892
    invoke-interface {p3}, Lorg/apache/http/client/methods/HttpUriRequest;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-interface {p5, v0}, Lcom/blm/sdk/async/http/ResponseHandlerInterface;->setRequestURI(Ljava/net/URI;)V

    .line 894
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v1, Lcom/blm/sdk/async/http/AsyncHttpRequest;

    invoke-direct {v1, p1, p2, p3, p5}, Lcom/blm/sdk/async/http/AsyncHttpRequest;-><init>(Lorg/apache/http/impl/client/AbstractHttpClient;Lorg/apache/http/protocol/HttpContext;Lorg/apache/http/client/methods/HttpUriRequest;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v1

    .line 896
    if-eqz p6, :cond_2

    .line 898
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->requestMap:Ljava/util/Map;

    invoke-interface {v0, p6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 899
    if-nez v0, :cond_1

    .line 900
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    .line 901
    iget-object v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->requestMap:Ljava/util/Map;

    invoke-interface {v2, p6, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 904
    :cond_1
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 909
    :cond_2
    new-instance v0, Lcom/blm/sdk/async/http/RequestHandle;

    invoke-direct {v0, v1}, Lcom/blm/sdk/async/http/RequestHandle;-><init>(Ljava/util/concurrent/Future;)V

    return-object v0
.end method

.method public setBasicAuth(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;

    .prologue
    .line 444
    sget-object v0, Lorg/apache/http/auth/AuthScope;->ANY:Lorg/apache/http/auth/AuthScope;

    .line 445
    invoke-virtual {p0, p1, p2, v0}, Lcom/blm/sdk/async/http/AsyncHttpClient;->setBasicAuth(Ljava/lang/String;Ljava/lang/String;Lorg/apache/http/auth/AuthScope;)V

    .line 446
    return-void
.end method

.method public setBasicAuth(Ljava/lang/String;Ljava/lang/String;Lorg/apache/http/auth/AuthScope;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .param p3, "scope"    # Lorg/apache/http/auth/AuthScope;

    .prologue
    .line 457
    new-instance v0, Lorg/apache/http/auth/UsernamePasswordCredentials;

    invoke-direct {v0, p1, p2}, Lorg/apache/http/auth/UsernamePasswordCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 458
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->getCredentialsProvider()Lorg/apache/http/client/CredentialsProvider;

    move-result-object v1

    invoke-interface {v1, p3, v0}, Lorg/apache/http/client/CredentialsProvider;->setCredentials(Lorg/apache/http/auth/AuthScope;Lorg/apache/http/auth/Credentials;)V

    .line 459
    return-void
.end method

.method public setCookieStore(Lorg/apache/http/client/CookieStore;)V
    .locals 2
    .param p1, "cookieStore"    # Lorg/apache/http/client/CookieStore;

    .prologue
    .line 281
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpContext:Lorg/apache/http/protocol/HttpContext;

    const-string v1, "http.cookie-store"

    invoke-interface {v0, v1, p1}, Lorg/apache/http/protocol/HttpContext;->setAttribute(Ljava/lang/String;Ljava/lang/Object;)V

    .line 282
    return-void
.end method

.method public setEnableRedirects(Z)V
    .locals 2
    .param p1, "enableRedirects"    # Z

    .prologue
    .line 302
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    new-instance v1, Lcom/blm/sdk/async/http/AsyncHttpClient$3;

    invoke-direct {v1, p0, p1}, Lcom/blm/sdk/async/http/AsyncHttpClient$3;-><init>(Lcom/blm/sdk/async/http/AsyncHttpClient;Z)V

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->setRedirectHandler(Lorg/apache/http/client/RedirectHandler;)V

    .line 308
    return-void
.end method

.method public setMaxConnections(I)V
    .locals 3
    .param p1, "maxConnections"    # I

    .prologue
    .line 336
    const/4 v0, 0x1

    if-ge p1, v0, :cond_0

    .line 337
    const/16 p1, 0xa

    .line 338
    :cond_0
    iput p1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->maxConnections:I

    .line 339
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v0

    .line 340
    new-instance v1, Lorg/apache/http/conn/params/ConnPerRouteBean;

    iget v2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->maxConnections:I

    invoke-direct {v1, v2}, Lorg/apache/http/conn/params/ConnPerRouteBean;-><init>(I)V

    invoke-static {v0, v1}, Lorg/apache/http/conn/params/ConnManagerParams;->setMaxConnectionsPerRoute(Lorg/apache/http/params/HttpParams;Lorg/apache/http/conn/params/ConnPerRoute;)V

    .line 341
    return-void
.end method

.method public setMaxRetriesAndTimeout(II)V
    .locals 2
    .param p1, "retries"    # I
    .param p2, "timeout"    # I

    .prologue
    .line 414
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    new-instance v1, Lcom/blm/sdk/async/http/RetryHandler;

    invoke-direct {v1, p1, p2}, Lcom/blm/sdk/async/http/RetryHandler;-><init>(II)V

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->setHttpRequestRetryHandler(Lorg/apache/http/client/HttpRequestRetryHandler;)V

    .line 415
    return-void
.end method

.method public setProxy(Ljava/lang/String;I)V
    .locals 3
    .param p1, "hostname"    # Ljava/lang/String;
    .param p2, "port"    # I

    .prologue
    .line 374
    new-instance v0, Lorg/apache/http/HttpHost;

    invoke-direct {v0, p1, p2}, Lorg/apache/http/HttpHost;-><init>(Ljava/lang/String;I)V

    .line 375
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v1

    .line 376
    const-string v2, "http.route.default-proxy"

    invoke-interface {v1, v2, v0}, Lorg/apache/http/params/HttpParams;->setParameter(Ljava/lang/String;Ljava/lang/Object;)Lorg/apache/http/params/HttpParams;

    .line 377
    return-void
.end method

.method public setProxy(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "hostname"    # Ljava/lang/String;
    .param p2, "port"    # I
    .param p3, "username"    # Ljava/lang/String;
    .param p4, "password"    # Ljava/lang/String;

    .prologue
    .line 388
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getCredentialsProvider()Lorg/apache/http/client/CredentialsProvider;

    move-result-object v0

    new-instance v1, Lorg/apache/http/auth/AuthScope;

    invoke-direct {v1, p1, p2}, Lorg/apache/http/auth/AuthScope;-><init>(Ljava/lang/String;I)V

    new-instance v2, Lorg/apache/http/auth/UsernamePasswordCredentials;

    invoke-direct {v2, p3, p4}, Lorg/apache/http/auth/UsernamePasswordCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, v1, v2}, Lorg/apache/http/client/CredentialsProvider;->setCredentials(Lorg/apache/http/auth/AuthScope;Lorg/apache/http/auth/Credentials;)V

    .line 391
    new-instance v0, Lorg/apache/http/HttpHost;

    invoke-direct {v0, p1, p2}, Lorg/apache/http/HttpHost;-><init>(Ljava/lang/String;I)V

    .line 392
    iget-object v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v1

    .line 393
    const-string v2, "http.route.default-proxy"

    invoke-interface {v1, v2, v0}, Lorg/apache/http/params/HttpParams;->setParameter(Ljava/lang/String;Ljava/lang/Object;)Lorg/apache/http/params/HttpParams;

    .line 394
    return-void
.end method

.method public setSSLSocketFactory(Lorg/apache/http/conn/ssl/SSLSocketFactory;)V
    .locals 4
    .param p1, "sslSocketFactory"    # Lorg/apache/http/conn/ssl/SSLSocketFactory;

    .prologue
    .line 404
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getConnectionManager()Lorg/apache/http/conn/ClientConnectionManager;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/conn/ClientConnectionManager;->getSchemeRegistry()Lorg/apache/http/conn/scheme/SchemeRegistry;

    move-result-object v0

    new-instance v1, Lorg/apache/http/conn/scheme/Scheme;

    const-string v2, "https"

    const/16 v3, 0x1bb

    invoke-direct {v1, v2, p1, v3}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v0, v1}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    .line 405
    return-void
.end method

.method public setThreadPool(Ljava/util/concurrent/ThreadPoolExecutor;)V
    .locals 0
    .param p1, "threadPool"    # Ljava/util/concurrent/ThreadPoolExecutor;

    .prologue
    .line 292
    iput-object p1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->threadPool:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 293
    return-void
.end method

.method public setTimeout(I)V
    .locals 4
    .param p1, "timeout"    # I

    .prologue
    .line 358
    const/16 v0, 0x3e8

    if-ge p1, v0, :cond_0

    .line 359
    const/16 p1, 0x2710

    .line 360
    :cond_0
    iput p1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    .line 361
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v0

    .line 362
    iget v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    int-to-long v2, v1

    invoke-static {v0, v2, v3}, Lorg/apache/http/conn/params/ConnManagerParams;->setTimeout(Lorg/apache/http/params/HttpParams;J)V

    .line 363
    iget v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    invoke-static {v0, v1}, Lorg/apache/http/params/HttpConnectionParams;->setSoTimeout(Lorg/apache/http/params/HttpParams;I)V

    .line 364
    iget v1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->timeout:I

    invoke-static {v0, v1}, Lorg/apache/http/params/HttpConnectionParams;->setConnectionTimeout(Lorg/apache/http/params/HttpParams;I)V

    .line 365
    return-void
.end method

.method public setURLEncodingEnabled(Z)V
    .locals 0
    .param p1, "enabled"    # Z

    .prologue
    .line 919
    iput-boolean p1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isUrlEncodingEnabled:Z

    .line 920
    return-void
.end method

.method public setUserAgent(Ljava/lang/String;)V
    .locals 1
    .param p1, "userAgent"    # Ljava/lang/String;

    .prologue
    .line 317
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient;->httpClient:Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v0

    invoke-static {v0, p1}, Lorg/apache/http/params/HttpProtocolParams;->setUserAgent(Lorg/apache/http/params/HttpParams;Ljava/lang/String;)V

    .line 318
    return-void
.end method
