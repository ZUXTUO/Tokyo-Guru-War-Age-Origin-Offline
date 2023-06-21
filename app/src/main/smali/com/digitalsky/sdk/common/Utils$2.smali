.class Lcom/digitalsky/sdk/common/Utils$2;
.super Ljava/lang/Object;
.source "Utils.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

.field private final synthetic val$data:[B

.field private final synthetic val$reqUrl:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$reqUrl:Ljava/lang/String;

    iput-object p2, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$data:[B

    iput-object p3, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    .line 65
    const/4 v1, 0x0

    .line 67
    .local v1, "conn":Ljava/net/HttpURLConnection;
    :try_start_0
    new-instance v5, Ljava/net/URL;

    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$reqUrl:Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 68
    .local v5, "url":Ljava/net/URL;
    invoke-virtual {v5}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v6

    move-object v0, v6

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v1, v0

    .line 69
    const/4 v6, 0x1

    invoke-virtual {v1, v6}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 71
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    .line 72
    .local v3, "out":Ljava/io/OutputStream;
    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$data:[B

    invoke-virtual {v3, v6}, Ljava/io/OutputStream;->write([B)V

    .line 74
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    invoke-static {v6}, Lcom/digitalsky/sdk/common/Utils;->readStream(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v4

    .line 75
    .local v4, "ret":Ljava/lang/String;
    invoke-static {}, Lcom/digitalsky/sdk/common/Utils;->access$0()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "return "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

    if-eqz v6, :cond_0

    .line 77
    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

    invoke-interface {v6, v4}, Lcom/digitalsky/sdk/common/Utils$Callback;->onCallback(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 85
    :cond_0
    if-eqz v1, :cond_1

    .line 86
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 88
    .end local v3    # "out":Ljava/io/OutputStream;
    .end local v4    # "ret":Ljava/lang/String;
    .end local v5    # "url":Ljava/net/URL;
    :cond_1
    :goto_0
    return-void

    .line 79
    :catch_0
    move-exception v2

    .line 80
    .local v2, "e":Ljava/io/IOException;
    :try_start_1
    invoke-static {}, Lcom/digitalsky/sdk/common/Utils;->access$0()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "return "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 81
    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

    if-eqz v6, :cond_2

    .line 82
    iget-object v6, p0, Lcom/digitalsky/sdk/common/Utils$2;->val$callback:Lcom/digitalsky/sdk/common/Utils$Callback;

    const-string v7, ""

    invoke-interface {v6, v7}, Lcom/digitalsky/sdk/common/Utils$Callback;->onCallback(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 85
    :cond_2
    if-eqz v1, :cond_1

    .line 86
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    goto :goto_0

    .line 84
    .end local v2    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v6

    .line 85
    if-eqz v1, :cond_3

    .line 86
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 87
    :cond_3
    throw v6
.end method
