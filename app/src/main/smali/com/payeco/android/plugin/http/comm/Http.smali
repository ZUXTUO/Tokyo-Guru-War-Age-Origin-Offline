.class public Lcom/payeco/android/plugin/http/comm/Http;
.super Ljava/lang/Object;


# static fields
.field public static final TYPE_GET:Ljava/lang/String; = "get"

.field public static final TYPE_POST:Ljava/lang/String; = "post"

.field public static final TYPE_UPLOAD:Ljava/lang/String; = "upload"


# instance fields
.field private connectTimeout:I

.field private cookieStore:Lorg/apache/http/client/CookieStore;

.field private encoding:Ljava/lang/String;

.field private fileParams:Ljava/util/Map;

.field private httpParams:Ljava/util/List;

.field private sessionId:Ljava/lang/String;

.field private soTimeout:I

.field private statusCode:I

.field private type:Ljava/lang/String;

.field private url:Ljava/lang/String;

.field private userAgent:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "UTF-8"

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    const-string v0, "post"

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    const/16 v0, 0xa

    iput v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->connectTimeout:I

    const/16 v0, 0x78

    iput v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->soTimeout:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "UTF-8"

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    const-string v0, "post"

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    const/16 v0, 0xa

    iput v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->connectTimeout:I

    const/16 v0, 0x78

    iput v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->soTimeout:I

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    return-void
.end method

.method private comm(Lorg/apache/http/client/methods/HttpUriRequest;)Ljava/lang/String;
    .locals 5

    invoke-direct {p0}, Lcom/payeco/android/plugin/http/comm/Http;->getDefaultHttpClient()Lorg/apache/http/impl/client/DefaultHttpClient;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->setCookieStore(Lorg/apache/http/client/CookieStore;)V

    :cond_0
    invoke-virtual {v0, p1}, Lorg/apache/http/impl/client/DefaultHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v1

    invoke-virtual {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getCookieStore()Lorg/apache/http/client/CookieStore;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    invoke-interface {v0}, Lorg/apache/http/client/CookieStore;->getCookies()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    :cond_2
    :goto_0
    invoke-interface {v1}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v0

    iput v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->statusCode:I

    iget v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->statusCode:I

    const/16 v2, 0xc8

    if-ne v0, v2, :cond_4

    invoke-interface {v1}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/http/util/EntityUtils;->toString(Lorg/apache/http/HttpEntity;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    return-object v0

    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/http/cookie/Cookie;

    const-string v3, "JSESSIONID"

    invoke-interface {v0}, Lorg/apache/http/cookie/Cookie;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    invoke-interface {v0}, Lorg/apache/http/cookie/Cookie;->getDomain()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Lorg/apache/http/cookie/Cookie;->getValue()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->sessionId:Ljava/lang/String;

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->sessionId:Ljava/lang/String;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/g;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private getDefaultHttpClient()Lorg/apache/http/impl/client/DefaultHttpClient;
    .locals 7

    const/4 v1, 0x0

    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    invoke-virtual {v0, v1, v1}, Ljava/security/KeyStore;->load(Ljava/io/InputStream;[C)V

    new-instance v1, Lcom/payeco/android/plugin/http/comm/SSLSocketFactoryEx;

    invoke-direct {v1, v0}, Lcom/payeco/android/plugin/http/comm/SSLSocketFactoryEx;-><init>(Ljava/security/KeyStore;)V

    sget-object v0, Lorg/apache/http/conn/ssl/SSLSocketFactory;->ALLOW_ALL_HOSTNAME_VERIFIER:Lorg/apache/http/conn/ssl/X509HostnameVerifier;

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/SSLSocketFactoryEx;->setHostnameVerifier(Lorg/apache/http/conn/ssl/X509HostnameVerifier;)V

    new-instance v0, Lorg/apache/http/params/BasicHttpParams;

    invoke-direct {v0}, Lorg/apache/http/params/BasicHttpParams;-><init>()V

    iget v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->connectTimeout:I

    mul-int/lit16 v2, v2, 0x3e8

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpConnectionParams;->setConnectionTimeout(Lorg/apache/http/params/HttpParams;I)V

    iget v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->soTimeout:I

    mul-int/lit16 v2, v2, 0x3e8

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpConnectionParams;->setSoTimeout(Lorg/apache/http/params/HttpParams;I)V

    const/16 v2, 0x2000

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpConnectionParams;->setSocketBufferSize(Lorg/apache/http/params/HttpParams;I)V

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lorg/apache/http/client/params/HttpClientParams;->setRedirecting(Lorg/apache/http/params/HttpParams;Z)V

    iget-object v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->userAgent:Ljava/lang/String;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->userAgent:Ljava/lang/String;

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpProtocolParams;->setUserAgent(Lorg/apache/http/params/HttpParams;Ljava/lang/String;)V

    :cond_0
    sget-object v2, Lorg/apache/http/HttpVersion;->HTTP_1_1:Lorg/apache/http/HttpVersion;

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpProtocolParams;->setVersion(Lorg/apache/http/params/HttpParams;Lorg/apache/http/ProtocolVersion;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    invoke-static {v0, v2}, Lorg/apache/http/params/HttpProtocolParams;->setContentCharset(Lorg/apache/http/params/HttpParams;Ljava/lang/String;)V

    new-instance v2, Lorg/apache/http/conn/scheme/SchemeRegistry;

    invoke-direct {v2}, Lorg/apache/http/conn/scheme/SchemeRegistry;-><init>()V

    new-instance v3, Lorg/apache/http/conn/scheme/Scheme;

    const-string v4, "http"

    invoke-static {}, Lorg/apache/http/conn/scheme/PlainSocketFactory;->getSocketFactory()Lorg/apache/http/conn/scheme/PlainSocketFactory;

    move-result-object v5

    const/16 v6, 0x50

    invoke-direct {v3, v4, v5, v6}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v2, v3}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    new-instance v3, Lorg/apache/http/conn/scheme/Scheme;

    const-string v4, "https"

    const/16 v5, 0x1bb

    invoke-direct {v3, v4, v1, v5}, Lorg/apache/http/conn/scheme/Scheme;-><init>(Ljava/lang/String;Lorg/apache/http/conn/scheme/SocketFactory;I)V

    invoke-virtual {v2, v3}, Lorg/apache/http/conn/scheme/SchemeRegistry;->register(Lorg/apache/http/conn/scheme/Scheme;)Lorg/apache/http/conn/scheme/Scheme;

    new-instance v1, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;

    invoke-direct {v1, v0, v2}, Lorg/apache/http/impl/conn/tsccm/ThreadSafeClientConnManager;-><init>(Lorg/apache/http/params/HttpParams;Lorg/apache/http/conn/scheme/SchemeRegistry;)V

    new-instance v2, Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-direct {v2, v1, v0}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>(Lorg/apache/http/conn/ClientConnectionManager;Lorg/apache/http/params/HttpParams;)V

    return-object v2
.end method


# virtual methods
.method public get()Ljava/lang/String;
    .locals 2

    new-instance v0, Lorg/apache/http/client/methods/HttpGet;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    invoke-direct {v0, v1}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/http/comm/Http;->comm(Lorg/apache/http/client/methods/HttpUriRequest;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getConnectTimeout()I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->connectTimeout:I

    return v0
.end method

.method public getCookieStore()Lorg/apache/http/client/CookieStore;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    return-object v0
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    return-object v0
.end method

.method public getFileParams()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->fileParams:Ljava/util/Map;

    return-object v0
.end method

.method public getHttpParams()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    return-object v0
.end method

.method public getSessionId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public getSoTimeout()I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->soTimeout:I

    return v0
.end method

.method public getStatusCode()I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->statusCode:I

    return v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    return-object v0
.end method

.method public getUserAgent()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->userAgent:Ljava/lang/String;

    return-object v0
.end method

.method public post()Ljava/lang/String;
    .locals 4

    new-instance v0, Lorg/apache/http/client/methods/HttpPost;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    invoke-direct {v0, v1}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    new-instance v1, Lorg/apache/http/client/entity/UrlEncodedFormEntity;

    iget-object v2, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    iget-object v3, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    invoke-direct {v1, v2, v3}, Lorg/apache/http/client/entity/UrlEncodedFormEntity;-><init>(Ljava/util/List;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/http/comm/Http;->comm(Lorg/apache/http/client/methods/HttpUriRequest;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public send()Ljava/lang/String;
    .locals 2

    const-string v0, "post"

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/payeco/android/plugin/http/comm/Http;->post()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "upload"

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/payeco/android/plugin/http/comm/Http;->upload()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/payeco/android/plugin/http/comm/Http;->get()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public setConnectTimeout(I)V
    .locals 0

    iput p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->connectTimeout:I

    return-void
.end method

.method public setCookieStore(Lorg/apache/http/client/CookieStore;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->cookieStore:Lorg/apache/http/client/CookieStore;

    return-void
.end method

.method public setEncoding(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    return-void
.end method

.method public setFileParams(Ljava/util/Map;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->fileParams:Ljava/util/Map;

    return-void
.end method

.method public setHttpParams(Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    return-void
.end method

.method public setSessionId(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->sessionId:Ljava/lang/String;

    return-void
.end method

.method public setSoTimeout(I)V
    .locals 0

    iput p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->soTimeout:I

    return-void
.end method

.method public setType(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->type:Ljava/lang/String;

    return-void
.end method

.method public setUrl(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    return-void
.end method

.method public setUserAgent(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/Http;->userAgent:Ljava/lang/String;

    return-void
.end method

.method public syncCookie(Landroid/content/Context;)V
    .locals 4

    invoke-static {p1}, Landroid/webkit/CookieSyncManager;->createInstance(Landroid/content/Context;)Landroid/webkit/CookieSyncManager;

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "JSESSIONID="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/payeco/android/plugin/http/comm/Http;->sessionId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Landroid/webkit/CookieSyncManager;->getInstance()Landroid/webkit/CookieSyncManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/CookieSyncManager;->sync()V

    return-void
.end method

.method public upload()Ljava/lang/String;
    .locals 7

    new-instance v2, Lorg/apache/http/client/methods/HttpPost;

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->url:Ljava/lang/String;

    invoke-direct {v2, v0}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    new-instance v3, Lorg/apache/http/entity/mime/MultipartEntity;

    invoke-direct {v3}, Lorg/apache/http/entity/mime/MultipartEntity;-><init>()V

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->httpParams:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->fileParams:Ljava/util/Map;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->fileParams:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/Http;->fileParams:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    :cond_1
    invoke-virtual {v2, v3}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    invoke-direct {p0, v2}, Lcom/payeco/android/plugin/http/comm/Http;->comm(Lorg/apache/http/client/methods/HttpUriRequest;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/http/NameValuePair;

    new-instance v4, Lorg/apache/http/entity/mime/content/StringBody;

    invoke-interface {v0}, Lorg/apache/http/NameValuePair;->getValue()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/payeco/android/plugin/http/comm/Http;->encoding:Ljava/lang/String;

    invoke-static {v6}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lorg/apache/http/entity/mime/content/StringBody;-><init>(Ljava/lang/String;Ljava/nio/charset/Charset;)V

    invoke-interface {v0}, Lorg/apache/http/NameValuePair;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0, v4}, Lorg/apache/http/entity/mime/MultipartEntity;->addPart(Ljava/lang/String;Lorg/apache/http/entity/mime/content/ContentBody;)V

    goto :goto_0

    :cond_3
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    new-instance v5, Lorg/apache/http/entity/mime/content/FileBody;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    invoke-direct {v5, v1}, Lorg/apache/http/entity/mime/content/FileBody;-><init>(Ljava/io/File;)V

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0, v5}, Lorg/apache/http/entity/mime/MultipartEntity;->addPart(Ljava/lang/String;Lorg/apache/http/entity/mime/content/ContentBody;)V

    goto :goto_1
.end method
