.class Lcom/digital/cloud/usercenter/MyHttpClient$1;
.super Ljava/lang/Object;
.source "MyHttpClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/MyHttpClient;->httpReq(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$body:[B

.field private final synthetic val$httpUrl:Ljava/lang/String;

.field private final synthetic val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;


# direct methods
.method constructor <init>(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$httpUrl:Ljava/lang/String;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$body:[B

    iput-object p3, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 36
    :try_start_0
    new-instance v2, Ljava/net/URL;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$httpUrl:Ljava/lang/String;

    invoke-direct {v2, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 38
    .local v2, "url":Ljava/net/URL;
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v3

    check-cast v3, Ljava/net/HttpURLConnection;

    .line 40
    .local v3, "urlconn":Ljava/net/HttpURLConnection;
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 41
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$body:[B

    if-eqz v4, :cond_0

    .line 42
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    .line 43
    .local v1, "out":Ljava/io/OutputStream;
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$body:[B

    invoke-virtual {v1, v4}, Ljava/io/OutputStream;->write([B)V

    .line 44
    invoke-virtual {v1}, Ljava/io/OutputStream;->flush()V

    .line 45
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 47
    .end local v1    # "out":Ljava/io/OutputStream;
    :cond_0
    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    .line 48
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "code: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " msg: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 47
    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 49
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    if-eqz v4, :cond_1

    .line 50
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/MyHttpClient;->readStream(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    .end local v2    # "url":Ljava/net/URL;
    .end local v3    # "urlconn":Ljava/net/HttpURLConnection;
    :cond_1
    :goto_0
    return-void

    .line 51
    :catch_0
    move-exception v0

    .line 52
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 53
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    if-eqz v4, :cond_1

    .line 54
    iget-object v4, p0, Lcom/digital/cloud/usercenter/MyHttpClient$1;->val$listener:Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    const/4 v5, 0x0

    invoke-interface {v4, v5}, Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V

    goto :goto_0
.end method
