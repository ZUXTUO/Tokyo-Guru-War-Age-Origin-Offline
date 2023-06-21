.class public Lcom/blm/sdk/down/c;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private a:Landroid/content/Context;

.field private b:I

.field private c:I

.field private d:[Lcom/blm/sdk/down/b;

.field private e:Ljava/io/File;

.field private f:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private g:I

.field private h:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    iput v1, p0, Lcom/blm/sdk/down/c;->b:I

    .line 29
    iput v1, p0, Lcom/blm/sdk/down/c;->c:I

    .line 35
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    .line 81
    :try_start_0
    const-string v0, ""

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "FileDownloader-1-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 82
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 83
    iput-object p1, p0, Lcom/blm/sdk/down/c;->a:Landroid/content/Context;

    .line 84
    iput-object p2, p0, Lcom/blm/sdk/down/c;->h:Ljava/lang/String;

    .line 86
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 87
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    .line 88
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 91
    :cond_0
    new-array v3, p5, [Lcom/blm/sdk/down/b;

    iput-object v3, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    .line 92
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 94
    const-string v3, "GET"

    invoke-virtual {v0, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 95
    const-string v3, "Accept"

    const-string v4, "image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"

    invoke-virtual {v0, v3, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 96
    const-string v3, "Accept-Language"

    const-string v4, "zh-CN"

    invoke-virtual {v0, v3, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 97
    const-string v3, "Referer"

    invoke-virtual {v0, v3, p2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 98
    const-string v3, "Charset"

    const-string v4, "UTF-8"

    invoke-virtual {v0, v3, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    const-string v3, "User-Agent"

    const-string v4, "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"

    invoke-virtual {v0, v3, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    const-string v3, "Connection"

    const-string v4, "Keep-Alive"

    invoke-virtual {v0, v3, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 101
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->connect()V

    .line 103
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_5

    .line 104
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v0

    iput v0, p0, Lcom/blm/sdk/down/c;->c:I

    .line 105
    iget v0, p0, Lcom/blm/sdk/down/c;->c:I

    if-gtz v0, :cond_1

    .line 107
    const-string v0, "Unkown file size "

    invoke-static {v0}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    .line 132
    :goto_0
    return-void

    .line 111
    :cond_1
    new-instance v0, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2, p3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    .line 112
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mSaveFile:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    .line 113
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    iget-object v2, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v2, v2

    if-ne v0, v2, :cond_3

    .line 114
    :goto_1
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v0, v0

    if-ge v1, v0, :cond_2

    .line 115
    iget v2, p0, Lcom/blm/sdk/down/c;->b:I

    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v3, v1, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    add-int/2addr v0, v2

    iput v0, p0, Lcom/blm/sdk/down/c;->b:I

    .line 114
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 117
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u5df2\u7ecf\u4e0b\u8f7d\u7684\u957f\u5ea6"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/blm/sdk/down/c;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    .line 120
    :cond_3
    iget v0, p0, Lcom/blm/sdk/down/c;->c:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    rem-int/2addr v0, v1

    if-nez v0, :cond_4

    iget v0, p0, Lcom/blm/sdk/down/c;->c:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    div-int/2addr v0, v1

    :goto_2
    iput v0, p0, Lcom/blm/sdk/down/c;->g:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 126
    :catch_0
    move-exception v0

    .line 127
    const-string v1, "don\'t connection this url"

    invoke-static {v1}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    .line 128
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 129
    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 120
    :cond_4
    :try_start_1
    iget v0, p0, Lcom/blm/sdk/down/c;->c:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    div-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 123
    :cond_5
    const-string v0, "server no response "

    invoke-static {v0}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method

.method private static a(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 360
    const-string v0, "FileDownloader"

    invoke-static {v0, p0}, Lcom/blm/sdk/d/j;->b(Ljava/lang/String;Ljava/lang/Object;)V

    .line 361
    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    .prologue
    .line 52
    iget v0, p0, Lcom/blm/sdk/down/c;->c:I

    return v0
.end method

.method public a(Lcom/blm/sdk/down/a;)I
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v7, 0x1

    const/4 v9, 0x0

    .line 162
    :try_start_0
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    const-string v2, "rw"

    invoke-direct {v0, v1, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 163
    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    if-lez v1, :cond_0

    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    int-to-long v2, v1

    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->setLength(J)V

    .line 164
    :cond_0
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V

    .line 165
    new-instance v2, Ljava/net/URL;

    iget-object v0, p0, Lcom/blm/sdk/down/c;->h:Ljava/lang/String;

    invoke-direct {v2, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 166
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-eq v0, v1, :cond_1

    .line 167
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    move v0, v9

    .line 168
    :goto_0
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 169
    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v3, v0, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 168
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v8, v9

    .line 172
    :goto_1
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v0, v0

    if-ge v8, v0, :cond_4

    .line 173
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v1, v8, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 174
    iget v1, p0, Lcom/blm/sdk/down/c;->g:I

    if-ge v0, v1, :cond_2

    iget v0, p0, Lcom/blm/sdk/down/c;->b:I

    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    if-ge v0, v1, :cond_2

    .line 175
    iget-object v10, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    new-instance v0, Lcom/blm/sdk/down/b;

    iget-object v3, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    iget v4, p0, Lcom/blm/sdk/down/c;->g:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v5, v8, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v5

    add-int/lit8 v6, v8, 0x1

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/blm/sdk/down/b;-><init>(Lcom/blm/sdk/down/c;Ljava/net/URL;Ljava/io/File;III)V

    aput-object v0, v10, v8

    .line 176
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    const/4 v1, 0x7

    invoke-virtual {v0, v1}, Lcom/blm/sdk/down/b;->setPriority(I)V

    .line 177
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->start()V

    .line 172
    :goto_2
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_1

    .line 179
    :cond_2
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    const/4 v1, 0x0

    aput-object v1, v0, v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 200
    :catch_0
    move-exception v0

    .line 201
    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/blm/sdk/down/c;->a(Ljava/lang/String;)V

    .line 202
    const-string v1, "FileDownloader"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    .line 205
    :cond_3
    iget v0, p0, Lcom/blm/sdk/down/c;->b:I

    return v0

    :cond_4
    move v0, v7

    .line 183
    :cond_5
    :goto_3
    if-eqz v0, :cond_3

    .line 184
    const-wide/16 v0, 0x384

    :try_start_1
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    move v8, v9

    move v0, v9

    .line 186
    :goto_4
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-ge v8, v1, :cond_8

    .line 187
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v1, v1, v8

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v1, v1, v8

    invoke-virtual {v1}, Lcom/blm/sdk/down/b;->a()Z

    move-result v1

    if-nez v1, :cond_7

    .line 189
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->b()J

    move-result-wide v0

    const-wide/16 v4, -0x1

    cmp-long v0, v0, v4

    if-nez v0, :cond_6

    .line 190
    iget-object v10, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    new-instance v0, Lcom/blm/sdk/down/b;

    iget-object v3, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    iget v4, p0, Lcom/blm/sdk/down/c;->g:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v5, v8, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v5

    add-int/lit8 v6, v8, 0x1

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/blm/sdk/down/b;-><init>(Lcom/blm/sdk/down/c;Ljava/net/URL;Ljava/io/File;III)V

    aput-object v0, v10, v8

    .line 191
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    const/4 v1, 0x7

    invoke-virtual {v0, v1}, Lcom/blm/sdk/down/b;->setPriority(I)V

    .line 192
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->start()V

    :cond_6
    move v0, v7

    .line 186
    :cond_7
    add-int/lit8 v1, v8, 0x1

    move v8, v1

    goto :goto_4

    .line 196
    :cond_8
    if-eqz p1, :cond_5

    .line 197
    iget v1, p0, Lcom/blm/sdk/down/c;->b:I

    invoke-interface {p1, v1}, Lcom/blm/sdk/down/a;->a(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3
.end method

.method protected declared-synchronized a(I)V
    .locals 1

    .prologue
    .line 60
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/blm/sdk/down/c;->b:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/blm/sdk/down/c;->b:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 61
    monitor-exit p0

    return-void

    .line 60
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized a(II)V
    .locals 3

    .prologue
    .line 70
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 71
    monitor-exit p0

    return-void

    .line 70
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public a(Lcom/blm/sdk/down/DownloadListener;)V
    .locals 12

    .prologue
    const/16 v4, 0x68

    const/16 v3, 0x65

    const/4 v11, 0x7

    const/4 v9, 0x1

    const/4 v7, 0x0

    .line 214
    .line 215
    iget-object v0, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    if-nez v0, :cond_1

    .line 217
    const-string v0, ""

    const-string v1, "download savefile==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 328
    :cond_0
    :goto_0
    return-void

    .line 221
    :cond_1
    :try_start_0
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    const-string v2, "rw"

    invoke-direct {v0, v1, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 230
    if-nez v0, :cond_2

    .line 231
    if-eqz p1, :cond_0

    .line 232
    const-string v0, "file not found-2"

    invoke-interface {p1, v3, v0}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 222
    :catch_0
    move-exception v0

    .line 224
    if-eqz p1, :cond_0

    .line 225
    const-string v0, "file not found-1"

    invoke-interface {p1, v3, v0}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 237
    :cond_2
    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    if-gtz v1, :cond_3

    .line 238
    if-eqz p1, :cond_0

    .line 239
    const/16 v0, 0x67

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mFileSize = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/blm/sdk/down/c;->c:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 245
    :cond_3
    :try_start_1
    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    int-to-long v2, v1

    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->setLength(J)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 255
    :try_start_2
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 262
    :goto_1
    :try_start_3
    new-instance v2, Ljava/net/URL;

    iget-object v0, p0, Lcom/blm/sdk/down/c;->h:Ljava/lang/String;

    invoke-direct {v2, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/net/MalformedURLException; {:try_start_3 .. :try_end_3} :catch_3

    .line 271
    if-nez v2, :cond_4

    .line 272
    if-eqz p1, :cond_0

    .line 273
    const-string v0, "url parsed exception-2"

    invoke-interface {p1, v4, v0}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 246
    :catch_1
    move-exception v0

    .line 247
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 248
    if-eqz p1, :cond_0

    .line 249
    const/16 v0, 0x66

    const-string v1, "setLength exception"

    invoke-interface {p1, v0, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 256
    :catch_2
    move-exception v0

    .line 257
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 263
    :catch_3
    move-exception v0

    .line 264
    invoke-virtual {v0}, Ljava/net/MalformedURLException;->printStackTrace()V

    .line 265
    if-eqz p1, :cond_0

    .line 266
    const-string v0, "url parsed exception-1"

    invoke-interface {p1, v4, v0}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 278
    :cond_4
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-eq v0, v1, :cond_5

    .line 279
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    move v0, v7

    .line 280
    :goto_2
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-ge v0, v1, :cond_5

    .line 281
    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v3, v0, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 280
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 285
    :cond_5
    if-eqz p1, :cond_6

    .line 286
    invoke-interface {p1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadStart()V

    :cond_6
    move v8, v7

    .line 289
    :goto_3
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v0, v0

    if-ge v8, v0, :cond_8

    .line 290
    iget-object v0, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v1, v8, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 291
    iget v1, p0, Lcom/blm/sdk/down/c;->g:I

    if-ge v0, v1, :cond_7

    iget v0, p0, Lcom/blm/sdk/down/c;->b:I

    iget v1, p0, Lcom/blm/sdk/down/c;->c:I

    if-ge v0, v1, :cond_7

    .line 292
    iget-object v10, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    new-instance v0, Lcom/blm/sdk/down/b;

    iget-object v3, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    iget v4, p0, Lcom/blm/sdk/down/c;->g:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v5, v8, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v5

    add-int/lit8 v6, v8, 0x1

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/blm/sdk/down/b;-><init>(Lcom/blm/sdk/down/c;Ljava/net/URL;Ljava/io/File;III)V

    aput-object v0, v10, v8

    .line 293
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0, v11}, Lcom/blm/sdk/down/b;->setPriority(I)V

    .line 294
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->start()V

    .line 289
    :goto_4
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_3

    .line 296
    :cond_7
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    const/4 v1, 0x0

    aput-object v1, v0, v8

    goto :goto_4

    :cond_8
    move v0, v9

    .line 301
    :cond_9
    :goto_5
    if-eqz v0, :cond_c

    .line 303
    const-wide/16 v0, 0x384

    :try_start_4
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_4

    :goto_6
    move v8, v7

    move v0, v7

    .line 309
    :goto_7
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    array-length v1, v1

    if-ge v8, v1, :cond_b

    .line 310
    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v1, v1, v8

    if-eqz v1, :cond_d

    iget-object v1, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v1, v1, v8

    invoke-virtual {v1}, Lcom/blm/sdk/down/b;->a()Z

    move-result v1

    if-nez v1, :cond_d

    .line 312
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->b()J

    move-result-wide v0

    const-wide/16 v4, -0x1

    cmp-long v0, v0, v4

    if-nez v0, :cond_a

    .line 313
    iget-object v10, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    new-instance v0, Lcom/blm/sdk/down/b;

    iget-object v3, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    iget v4, p0, Lcom/blm/sdk/down/c;->g:I

    iget-object v1, p0, Lcom/blm/sdk/down/c;->f:Ljava/util/Map;

    add-int/lit8 v5, v8, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v5

    add-int/lit8 v6, v8, 0x1

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/blm/sdk/down/b;-><init>(Lcom/blm/sdk/down/c;Ljava/net/URL;Ljava/io/File;III)V

    aput-object v0, v10, v8

    .line 314
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0, v11}, Lcom/blm/sdk/down/b;->setPriority(I)V

    .line 315
    iget-object v0, p0, Lcom/blm/sdk/down/c;->d:[Lcom/blm/sdk/down/b;

    aget-object v0, v0, v8

    invoke-virtual {v0}, Lcom/blm/sdk/down/b;->start()V

    :cond_a
    move v1, v9

    .line 309
    :goto_8
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    move v0, v1

    goto :goto_7

    .line 304
    :catch_4
    move-exception v0

    .line 305
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_6

    .line 320
    :cond_b
    if-eqz p1, :cond_9

    .line 321
    iget v1, p0, Lcom/blm/sdk/down/c;->b:I

    invoke-interface {p1, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadProgress(I)V

    goto :goto_5

    .line 325
    :cond_c
    if-eqz p1, :cond_0

    .line 326
    iget-object v0, p0, Lcom/blm/sdk/down/c;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    iget v1, p0, Lcom/blm/sdk/down/c;->b:I

    invoke-interface {p1, v0, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFinish(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_d
    move v1, v0

    goto :goto_8
.end method
