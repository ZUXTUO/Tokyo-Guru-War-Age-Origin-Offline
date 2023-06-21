.class public abstract Lcom/sina/weibo/sdk/net/CustomRedirectHandler;
.super Ljava/lang/Object;
.source "CustomRedirectHandler.java"

# interfaces
.implements Lorg/apache/http/client/RedirectHandler;


# static fields
.field private static final MAX_REDIRECT_COUNT:I = 0xf

.field private static final TAG:Ljava/lang/String;


# instance fields
.field redirectCount:I

.field redirectUrl:Ljava/lang/String;

.field private tempRedirectUrl:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 23
    const-class v0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->TAG:Ljava/lang/String;

    .line 25
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getLocationURI(Lorg/apache/http/HttpResponse;Lorg/apache/http/protocol/HttpContext;)Ljava/net/URI;
    .locals 3
    .param p1, "response"    # Lorg/apache/http/HttpResponse;
    .param p2, "context"    # Lorg/apache/http/protocol/HttpContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/http/ProtocolException;
        }
    .end annotation

    .prologue
    .line 35
    sget-object v0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "CustomRedirectHandler getLocationURI getRedirectUrl : "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    iget-object v0, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 37
    iget-object v0, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    invoke-static {v0}, Ljava/net/URI;->create(Ljava/lang/String;)Ljava/net/URI;

    move-result-object v0

    .line 39
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getRedirectCount()I
    .locals 1

    .prologue
    .line 78
    iget v0, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectCount:I

    return v0
.end method

.method public getRedirectUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 74
    iget-object v0, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectUrl:Ljava/lang/String;

    return-object v0
.end method

.method public isRedirectRequested(Lorg/apache/http/HttpResponse;Lorg/apache/http/protocol/HttpContext;)Z
    .locals 3
    .param p1, "response"    # Lorg/apache/http/HttpResponse;
    .param p2, "context"    # Lorg/apache/http/protocol/HttpContext;

    .prologue
    .line 45
    invoke-interface {p1}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v1

    invoke-interface {v1}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v0

    .line 46
    .local v0, "statusCode":I
    const/16 v1, 0x12d

    if-eq v0, v1, :cond_0

    .line 47
    const/16 v1, 0x12e

    if-ne v0, v1, :cond_1

    .line 48
    :cond_0
    const-string v1, "Location"

    invoke-interface {p1, v1}, Lorg/apache/http/HttpResponse;->getFirstHeader(Ljava/lang/String;)Lorg/apache/http/Header;

    move-result-object v1

    invoke-interface {v1}, Lorg/apache/http/Header;->getValue()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    .line 49
    iget-object v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    iget v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectCount:I

    const/16 v2, 0xf

    if-ge v1, v2, :cond_2

    .line 50
    iget-object v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    invoke-virtual {p0, v1}, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->shouldRedirectUrl(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 51
    iget v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectCount:I

    .line 52
    const/4 v1, 0x1

    .line 59
    :goto_0
    return v1

    .line 54
    :cond_1
    const/16 v1, 0xc8

    if-ne v0, v1, :cond_3

    .line 55
    iget-object v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->tempRedirectUrl:Ljava/lang/String;

    iput-object v1, p0, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->redirectUrl:Ljava/lang/String;

    .line 59
    :cond_2
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    .line 57
    :cond_3
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/net/CustomRedirectHandler;->onReceivedException()V

    goto :goto_1
.end method

.method public abstract onReceivedException()V
.end method

.method public abstract shouldRedirectUrl(Ljava/lang/String;)Z
.end method
