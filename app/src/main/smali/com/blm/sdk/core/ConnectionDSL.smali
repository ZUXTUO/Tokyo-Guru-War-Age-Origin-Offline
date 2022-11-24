.class public Lcom/blm/sdk/core/ConnectionDSL;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final TAG:Ljava/lang/String;

.field private static instance_:Lcom/blm/sdk/core/ConnectionDSL;


# instance fields
.field private mAppContext:Landroid/content/Context;

.field private mConnectionThread:Landroid/os/HandlerThread;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    const-class v0, Lcom/blm/sdk/core/ConnectionDSL;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/ConnectionDSL;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    return-void
.end method

.method public static getInstance()Lcom/blm/sdk/core/ConnectionDSL;
    .locals 1

    .prologue
    .line 38
    sget-object v0, Lcom/blm/sdk/core/ConnectionDSL;->instance_:Lcom/blm/sdk/core/ConnectionDSL;

    if-nez v0, :cond_0

    .line 39
    new-instance v0, Lcom/blm/sdk/core/ConnectionDSL;

    invoke-direct {v0}, Lcom/blm/sdk/core/ConnectionDSL;-><init>()V

    sput-object v0, Lcom/blm/sdk/core/ConnectionDSL;->instance_:Lcom/blm/sdk/core/ConnectionDSL;

    .line 41
    :cond_0
    sget-object v0, Lcom/blm/sdk/core/ConnectionDSL;->instance_:Lcom/blm/sdk/core/ConnectionDSL;

    return-object v0
.end method


# virtual methods
.method public destroy()V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    .line 62
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_0

    .line 63
    iget-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mConnectionThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quitSafely()Z

    .line 67
    :goto_0
    return-void

    .line 65
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mConnectionThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quit()Z

    goto :goto_0
.end method

.method public getContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mAppContext:Landroid/content/Context;

    return-object v0
.end method

.method public getDbWithPath(Ljava/lang/String;)Landroid/database/sqlite/SQLiteDatabase;
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 174
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 176
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 186
    :goto_0
    return-object v0

    .line 182
    :cond_0
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-static {p1, v1, v2}, Landroid/database/sqlite/SQLiteDatabase;->openDatabase(Ljava/lang/String;Landroid/database/sqlite/SQLiteDatabase$CursorFactory;I)Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 183
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public getNextCode(I)V
    .locals 4
    .param p1, "nextId"    # I

    .prologue
    .line 94
    sget-object v0, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    .line 95
    sget-object v1, Lcom/blm/sdk/constants/Constants;->LAST_REQUEST_ID:Ljava/lang/String;

    .line 96
    sget-object v2, Lcom/blm/sdk/constants/Constants;->LAST_HELLO_ID:Ljava/lang/Integer;

    .line 97
    if-eqz v0, :cond_0

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-nez v3, :cond_1

    .line 103
    :cond_0
    :goto_0
    return-void

    .line 102
    :cond_1
    invoke-static {p1, v0, v1, v2}, Lcom/blm/sdk/core/b;->a(ILandroid/content/Context;Ljava/lang/String;Ljava/lang/Integer;)V

    goto :goto_0
.end method

.method public httpPost(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "body"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 192
    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    .line 200
    if-nez p2, :cond_0

    .line 202
    const-string p2, ""

    .line 205
    :cond_0
    :try_start_1
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 206
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 207
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 208
    const/16 v2, 0x1770

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 209
    const-string v2, "POST"

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 210
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    .line 211
    const-string v3, "utf-8"

    invoke-virtual {p2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 212
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 213
    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v2

    .line 214
    if-nez v2, :cond_1

    move-object v0, v1

    .line 224
    :goto_0
    return-object v0

    .line 193
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 195
    goto :goto_0

    .line 217
    :cond_1
    new-array v2, v2, [B

    .line 218
    invoke-virtual {v0, v2}, Ljava/io/InputStream;->read([B)I

    .line 219
    new-instance v0, Ljava/lang/String;

    const-string v3, "utf-8"

    invoke-direct {v0, v2, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 222
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 224
    goto :goto_0
.end method

.method public init(Landroid/content/Context;)V
    .locals 2
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 52
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mAppContext:Landroid/content/Context;

    .line 53
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "Connection"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mConnectionThread:Landroid/os/HandlerThread;

    .line 54
    iget-object v0, p0, Lcom/blm/sdk/core/ConnectionDSL;->mConnectionThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 55
    return-void
.end method

.method public scheduleTask(Ljava/lang/Runnable;I)V
    .locals 2
    .param p1, "task"    # Ljava/lang/Runnable;
    .param p2, "flag"    # I

    .prologue
    .line 117
    if-nez p1, :cond_1

    .line 127
    :cond_0
    :goto_0
    return-void

    .line 120
    :cond_1
    if-nez p2, :cond_2

    .line 121
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 122
    :cond_2
    const/4 v0, 0x1

    if-ne p2, v0, :cond_3

    .line 123
    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lcom/blm/sdk/core/ConnectionDSL;->mConnectionThread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 124
    :cond_3
    const/4 v0, 0x2

    if-ne p2, v0, :cond_0

    .line 125
    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method public startDown(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "path"    # Ljava/lang/String;

    .prologue
    .line 81
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 87
    :cond_0
    :goto_0
    return-void

    .line 86
    :cond_1
    invoke-static {p1, p2, p3}, Lcom/blm/sdk/core/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public tryCatch(Ljava/lang/Runnable;Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "r0"    # Ljava/lang/Runnable;
    .param p2, "r1"    # Ljava/lang/Runnable;

    .prologue
    .line 137
    :try_start_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    :cond_0
    :goto_0
    return-void

    .line 138
    :catch_0
    move-exception v0

    .line 140
    if-eqz p2, :cond_0

    .line 141
    invoke-interface {p2}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method

.method public tryCatchFinally(Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "r0"    # Ljava/lang/Runnable;
    .param p2, "r1"    # Ljava/lang/Runnable;
    .param p3, "r2"    # Ljava/lang/Runnable;

    .prologue
    .line 155
    :try_start_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 162
    if-eqz p3, :cond_0

    .line 163
    invoke-interface {p3}, Ljava/lang/Runnable;->run()V

    .line 166
    :cond_0
    :goto_0
    return-void

    .line 156
    :catch_0
    move-exception v0

    .line 158
    if-eqz p2, :cond_1

    .line 159
    :try_start_1
    invoke-interface {p2}, Ljava/lang/Runnable;->run()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 162
    :cond_1
    if-eqz p3, :cond_0

    .line 163
    invoke-interface {p3}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 162
    :catchall_0
    move-exception v0

    if-eqz p3, :cond_2

    .line 163
    invoke-interface {p3}, Ljava/lang/Runnable;->run()V

    :cond_2
    throw v0
.end method
