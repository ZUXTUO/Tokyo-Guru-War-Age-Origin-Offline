.class public Lcom/blm/sdk/down/b;
.super Ljava/lang/Thread;
.source "SourceFile"


# instance fields
.field private a:Ljava/io/File;

.field private b:Ljava/net/URL;

.field private c:I

.field private d:I

.field private e:I

.field private f:Z

.field private g:Lcom/blm/sdk/down/c;


# direct methods
.method public constructor <init>(Lcom/blm/sdk/down/c;Ljava/net/URL;Ljava/io/File;III)V
    .locals 1

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 17
    const/4 v0, -0x1

    iput v0, p0, Lcom/blm/sdk/down/b;->d:I

    .line 19
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/blm/sdk/down/b;->f:Z

    .line 23
    iput-object p2, p0, Lcom/blm/sdk/down/b;->b:Ljava/net/URL;

    .line 24
    iput-object p3, p0, Lcom/blm/sdk/down/b;->a:Ljava/io/File;

    .line 25
    iput p4, p0, Lcom/blm/sdk/down/b;->c:I

    .line 26
    iput-object p1, p0, Lcom/blm/sdk/down/b;->g:Lcom/blm/sdk/down/c;

    .line 27
    iput p6, p0, Lcom/blm/sdk/down/b;->d:I

    .line 28
    iput p5, p0, Lcom/blm/sdk/down/b;->e:I

    .line 29
    return-void
.end method

.method private static a(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 71
    const-string v0, "DownloadThread"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    return-void
.end method


# virtual methods
.method public a()Z
    .locals 1

    .prologue
    .line 78
    iget-boolean v0, p0, Lcom/blm/sdk/down/b;->f:Z

    return v0
.end method

.method public b()J
    .locals 2

    .prologue
    .line 85
    iget v0, p0, Lcom/blm/sdk/down/b;->e:I

    int-to-long v0, v0

    return-wide v0
.end method

.method public run()V
    .locals 8

    .prologue
    const/4 v7, -0x1

    .line 33
    iget v0, p0, Lcom/blm/sdk/down/b;->e:I

    iget v1, p0, Lcom/blm/sdk/down/b;->c:I

    if-ge v0, v1, :cond_0

    .line 35
    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/down/b;->b:Ljava/net/URL;

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 36
    const/16 v1, 0x1388

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 37
    const-string v1, "GET"

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 38
    const-string v1, "Accept"

    const-string v2, "image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    const-string v1, "Accept-Language"

    const-string v2, "zh-CN"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 40
    const-string v1, "Referer"

    iget-object v2, p0, Lcom/blm/sdk/down/b;->b:Ljava/net/URL;

    invoke-virtual {v2}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const-string v1, "Charset"

    const-string v2, "UTF-8"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    iget v1, p0, Lcom/blm/sdk/down/b;->c:I

    iget v2, p0, Lcom/blm/sdk/down/b;->d:I

    add-int/lit8 v2, v2, -0x1

    mul-int/2addr v1, v2

    iget v2, p0, Lcom/blm/sdk/down/b;->e:I

    add-int/2addr v1, v2

    .line 43
    iget v2, p0, Lcom/blm/sdk/down/b;->c:I

    iget v3, p0, Lcom/blm/sdk/down/b;->d:I

    mul-int/2addr v2, v3

    add-int/lit8 v2, v2, -0x1

    .line 44
    const-string v3, "Range"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "bytes="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    const-string v2, "User-Agent"

    const-string v3, "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"

    invoke-virtual {v0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    const-string v2, "Connection"

    const-string v3, "Keep-Alive"

    invoke-virtual {v0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 49
    const v2, 0x7d000

    new-array v2, v2, [B

    .line 51
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Thread "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/blm/sdk/down/b;->d:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " start download from position "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/blm/sdk/down/b;->a(Ljava/lang/String;)V

    .line 52
    new-instance v3, Ljava/io/RandomAccessFile;

    iget-object v4, p0, Lcom/blm/sdk/down/b;->a:Ljava/io/File;

    const-string v5, "rwd"

    invoke-direct {v3, v4, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 53
    int-to-long v4, v1

    invoke-virtual {v3, v4, v5}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 54
    :goto_0
    const/4 v1, 0x0

    const/16 v4, 0x400

    invoke-virtual {v0, v2, v1, v4}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    if-eq v1, v7, :cond_1

    .line 55
    const/4 v4, 0x0

    invoke-virtual {v3, v2, v4, v1}, Ljava/io/RandomAccessFile;->write([BII)V

    .line 56
    iget v4, p0, Lcom/blm/sdk/down/b;->e:I

    add-int/2addr v4, v1

    iput v4, p0, Lcom/blm/sdk/down/b;->e:I

    .line 57
    iget-object v4, p0, Lcom/blm/sdk/down/b;->g:Lcom/blm/sdk/down/c;

    iget v5, p0, Lcom/blm/sdk/down/b;->d:I

    iget v6, p0, Lcom/blm/sdk/down/b;->e:I

    invoke-virtual {v4, v5, v6}, Lcom/blm/sdk/down/c;->a(II)V

    .line 58
    iget-object v4, p0, Lcom/blm/sdk/down/b;->g:Lcom/blm/sdk/down/c;

    invoke-virtual {v4, v1}, Lcom/blm/sdk/down/c;->a(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 64
    :catch_0
    move-exception v0

    .line 65
    iput v7, p0, Lcom/blm/sdk/down/b;->e:I

    .line 66
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Thread "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/blm/sdk/down/b;->d:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/down/b;->a(Ljava/lang/String;)V

    .line 69
    :cond_0
    :goto_1
    return-void

    .line 60
    :cond_1
    :try_start_1
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V

    .line 61
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 62
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Thread "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/blm/sdk/down/b;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " download finish"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/down/b;->a(Ljava/lang/String;)V

    .line 63
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/blm/sdk/down/b;->f:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method
