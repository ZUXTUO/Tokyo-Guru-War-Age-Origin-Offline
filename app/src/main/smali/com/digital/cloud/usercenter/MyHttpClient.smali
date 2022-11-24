.class public Lcom/digital/cloud/usercenter/MyHttpClient;
.super Ljava/lang/Object;
.source "MyHttpClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static asyncHttpRequest(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 1
    .param p0, "httpUrl"    # Ljava/lang/String;
    .param p1, "body"    # [B
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 22
    const-string v0, "https"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 23
    invoke-static {p0, p1, p2}, Lcom/digital/cloud/usercenter/MyHttpClient;->httpsReq(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 27
    :goto_0
    return-void

    .line 25
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/digital/cloud/usercenter/MyHttpClient;->httpReq(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    goto :goto_0
.end method

.method public static httpReq(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 4
    .param p0, "httpUrl"    # Ljava/lang/String;
    .param p1, "body"    # [B
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 31
    :try_start_0
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "asyncHttpRequest: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 32
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/digital/cloud/usercenter/MyHttpClient$1;

    invoke-direct {v2, p0, p1, p2}, Lcom/digital/cloud/usercenter/MyHttpClient$1;-><init>(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 57
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 63
    :cond_0
    :goto_0
    return-void

    .line 58
    :catch_0
    move-exception v0

    .line 59
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 60
    if-eqz p2, :cond_0

    .line 61
    const/4 v1, 0x0

    invoke-interface {p2, v1}, Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static httpsReq(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V
    .locals 4
    .param p0, "httpUrl"    # Ljava/lang/String;
    .param p1, "body"    # [B
    .param p2, "listener"    # Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;

    .prologue
    .line 67
    :try_start_0
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "asyncHttpRequest: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 68
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/digital/cloud/usercenter/MyHttpClient$2;

    invoke-direct {v2, p0, p1, p2}, Lcom/digital/cloud/usercenter/MyHttpClient$2;-><init>(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 92
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 98
    :cond_0
    :goto_0
    return-void

    .line 93
    :catch_0
    move-exception v0

    .line 94
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 95
    if-eqz p2, :cond_0

    .line 96
    const/4 v1, 0x0

    invoke-interface {p2, v1}, Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;->asyncHttpRequestFinished(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static readStream(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 6
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 101
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 102
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    const/16 v3, 0x400

    new-array v1, v3, [B

    .line 103
    .local v1, "buffer":[B
    const/4 v2, 0x0

    .line 104
    .local v2, "read":I
    :goto_0
    array-length v3, v1

    invoke-virtual {p0, v1, v4, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    .line 107
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 108
    new-instance v3, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-direct {v3, v4, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v3

    .line 105
    :cond_0
    invoke-virtual {v0, v1, v4, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0
.end method
