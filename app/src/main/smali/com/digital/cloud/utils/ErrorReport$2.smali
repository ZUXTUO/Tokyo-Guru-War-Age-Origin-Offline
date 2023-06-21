.class Lcom/digital/cloud/utils/ErrorReport$2;
.super Ljava/lang/Object;
.source "ErrorReport.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/utils/ErrorReport;->asyncHttpRequest(Ljava/lang/String;Lorg/apache/http/entity/StringEntity;Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$httpUrl:Ljava/lang/String;

.field private final synthetic val$httpentity:Lorg/apache/http/entity/StringEntity;

.field private final synthetic val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;


# direct methods
.method constructor <init>(Ljava/lang/String;Lorg/apache/http/entity/StringEntity;Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$httpUrl:Ljava/lang/String;

    iput-object p2, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$httpentity:Lorg/apache/http/entity/StringEntity;

    iput-object p3, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    .line 101
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 105
    :try_start_0
    new-instance v1, Lorg/apache/http/client/methods/HttpPost;

    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$httpUrl:Ljava/lang/String;

    invoke-direct {v1, v4}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    .line 106
    .local v1, "httpRequest":Lorg/apache/http/client/methods/HttpPost;
    new-instance v3, Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-direct {v3}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>()V

    .line 108
    .local v3, "httpclient":Lorg/apache/http/client/HttpClient;
    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$httpentity:Lorg/apache/http/entity/StringEntity;

    invoke-virtual {v1, v4}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    .line 109
    const/4 v2, 0x0

    .line 110
    .local v2, "httpResponse":Lorg/apache/http/HttpResponse;
    invoke-interface {v3, v1}, Lorg/apache/http/client/HttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v2

    .line 111
    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    if-eqz v4, :cond_0

    .line 112
    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v5

    invoke-static {v5}, Lorg/apache/http/util/EntityUtils;->toString(Lorg/apache/http/HttpEntity;)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/apache/http/ParseException; {:try_start_0 .. :try_end_0} :catch_2

    .line 123
    .end local v1    # "httpRequest":Lorg/apache/http/client/methods/HttpPost;
    .end local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .end local v3    # "httpclient":Lorg/apache/http/client/HttpClient;
    :cond_0
    :goto_0
    return-void

    .line 114
    :catch_0
    move-exception v0

    .line 115
    .local v0, "e":Lorg/apache/http/client/ClientProtocolException;
    invoke-virtual {v0}, Lorg/apache/http/client/ClientProtocolException;->printStackTrace()V

    .line 121
    .end local v0    # "e":Lorg/apache/http/client/ClientProtocolException;
    :goto_1
    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    if-eqz v4, :cond_0

    .line 122
    iget-object v4, p0, Lcom/digital/cloud/utils/ErrorReport$2;->val$listener:Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    const/4 v5, 0x0

    invoke-interface {v4, v5}, Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V

    goto :goto_0

    .line 116
    :catch_1
    move-exception v0

    .line 117
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 118
    .end local v0    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v0

    .line 119
    .local v0, "e":Lorg/apache/http/ParseException;
    invoke-virtual {v0}, Lorg/apache/http/ParseException;->printStackTrace()V

    goto :goto_1
.end method
