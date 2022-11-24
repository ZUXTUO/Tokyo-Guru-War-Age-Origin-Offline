.class public Lcom/talkingdata/sdk/h;
.super Ljava/lang/Object;


# static fields
.field private static final j:J = 0x300000L

.field private static final k:Ljava/lang/String; = "td-cache"


# instance fields
.field a:Landroid/content/Context;

.field b:Ljava/io/File;

.field c:Ljava/io/RandomAccessFile;

.field d:Ljava/lang/String;

.field e:Ljava/util/zip/CRC32;

.field f:Ljava/util/concurrent/locks/Lock;

.field g:J

.field h:J

.field i:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    const-wide/16 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/zip/CRC32;

    invoke-direct {v0}, Ljava/util/zip/CRC32;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/talkingdata/sdk/h;->i:J

    :try_start_0
    iput-object p1, p0, Lcom/talkingdata/sdk/h;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/talkingdata/sdk/h;->d:Ljava/lang/String;

    const-string v0, "td-cache"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/h;->b:Ljava/io/File;

    invoke-direct {p0}, Lcom/talkingdata/sdk/h;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-direct {p0}, Lcom/talkingdata/sdk/h;->f()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :goto_0
    :try_start_2
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v0

    const-wide/32 v2, 0x300000

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    invoke-direct {p0}, Lcom/talkingdata/sdk/h;->d()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_0
    :goto_1
    return-void

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method private a(J)Z
    .locals 11

    const/16 v9, 0x2e

    const/16 v8, 0x1f

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->lock()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1, p1, p2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v1

    if-ne v1, v8, :cond_1

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v2

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readShort()S

    move-result v3

    if-ltz v3, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v4

    int-to-long v6, v3

    add-long/2addr v4, v6

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    cmp-long v1, v4, v6

    if-gtz v1, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v1}, Ljava/util/zip/CRC32;->reset()V

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    iget-object v4, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    iget-object v5, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v5}, Ljava/io/RandomAccessFile;->read()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/util/zip/CRC32;->update(I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v1

    if-ne v1, v8, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v1}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v4

    long-to-int v1, v4

    if-ne v2, v1, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    :goto_1
    return v0

    :cond_1
    if-ne v1, v9, :cond_2

    :try_start_2
    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v1

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v2

    if-ltz v1, :cond_2

    int-to-long v4, v1

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    cmp-long v3, v4, v6

    if-gez v3, :cond_2

    if-ne v2, v9, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    int-to-long v2, v1

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto :goto_1

    :catch_0
    move-exception v1

    :cond_2
    const-wide/16 v2, 0x1

    add-long/2addr v2, p1

    :try_start_3
    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto :goto_1

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method private a(JZ)[B
    .locals 11

    const/4 v1, 0x0

    const/16 v9, 0x2e

    const/16 v8, 0x1f

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0, p1, p2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v0

    if-ne v0, v8, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v2

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->readShort()S

    move-result v0

    if-ltz v0, :cond_2

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v4

    int-to-long v6, v0

    add-long/2addr v4, v6

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    cmp-long v3, v4, v6

    if-gtz v3, :cond_2

    new-array v0, v0, [B

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3, v0}, Ljava/io/RandomAccessFile;->readFully([B)V

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v3

    if-ne v3, v8, :cond_2

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v3}, Ljava/util/zip/CRC32;->reset()V

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v3, v0}, Ljava/util/zip/CRC32;->update([B)V

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v3}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v4

    long-to-int v3, v4

    if-ne v2, v3, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    :goto_0
    return-object v0

    :cond_0
    if-ne v0, v9, :cond_2

    :try_start_2
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v0

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->readByte()B

    move-result v2

    if-ltz v0, :cond_2

    int-to-long v4, v0

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    cmp-long v3, v4, v6

    if-gez v3, :cond_2

    if-ne v2, v9, :cond_2

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    if-eqz p3, :cond_1

    int-to-long v2, v0

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_1
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object v0, v1

    goto :goto_0

    :catch_0
    move-exception v0

    :cond_2
    const-wide/16 v2, 0x1

    add-long/2addr v2, p1

    :try_start_3
    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object v0, v1

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method private b(J)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    const/16 v1, 0x2e

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeByte(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    long-to-int v1, p1

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeInt(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    const/16 v1, 0x2e

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeByte(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method private b([B)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    const/16 v1, 0x1f

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeByte(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v0}, Ljava/util/zip/CRC32;->reset()V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v0, p1}, Ljava/util/zip/CRC32;->update([B)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->e:Ljava/util/zip/CRC32;

    invoke-virtual {v1}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v2

    long-to-int v1, v2

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeInt(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeShort(I)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0, p1}, Ljava/io/RandomAccessFile;->write([B)V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    const/16 v1, 0x1f

    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->writeByte(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->f:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method private d()V
    .locals 8

    const-wide/16 v6, 0x0

    iget-wide v0, p0, Lcom/talkingdata/sdk/h;->g:J

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->i:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    iget-wide v0, p0, Lcom/talkingdata/sdk/h;->i:J

    :goto_0
    iput-wide v0, p0, Lcom/talkingdata/sdk/h;->h:J

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->b:Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->d:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    :cond_0
    :goto_1
    :try_start_0
    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iget-object v4, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v4}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v4

    cmp-long v2, v2, v4

    if-gez v2, :cond_2

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    const/4 v4, 0x0

    invoke-direct {p0, v2, v3, v4}, Lcom/talkingdata/sdk/h;->a(JZ)[B

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v1, v2}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    throw v0

    :cond_1
    iget-wide v0, p0, Lcom/talkingdata/sdk/h;->g:J

    goto :goto_0

    :cond_2
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->b:Ljava/io/File;

    iget-object v3, p0, Lcom/talkingdata/sdk/h;->d:Ljava/lang/String;

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    invoke-direct {p0}, Lcom/talkingdata/sdk/h;->e()V

    iput-wide v6, p0, Lcom/talkingdata/sdk/h;->g:J

    iput-wide v6, p0, Lcom/talkingdata/sdk/h;->h:J

    return-void
.end method

.method private e()V
    .locals 3

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->b:Ljava/io/File;

    iget-object v2, p0, Lcom/talkingdata/sdk/h;->d:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v1, Ljava/io/RandomAccessFile;

    const-string v2, "rw"

    invoke-direct {v1, v0, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    return-void
.end method

.method private f()V
    .locals 8

    const/4 v0, 0x0

    :cond_0
    :goto_0
    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-gez v1, :cond_2

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->i:J

    const-wide/16 v4, -0x1

    cmp-long v1, v2, v4

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/talkingdata/sdk/h;->h:J

    sub-long/2addr v2, v4

    const-wide/32 v4, 0x300000

    cmp-long v1, v2, v4

    if-gez v1, :cond_1

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->i:J

    :cond_1
    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    invoke-direct {p0, v2, v3}, Lcom/talkingdata/sdk/h;->a(J)Z

    move-result v1

    if-eqz v1, :cond_0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iget-wide v4, p0, Lcom/talkingdata/sdk/h;->g:J

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-nez v1, :cond_0

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J

    goto :goto_0

    :cond_2
    return-void
.end method


# virtual methods
.method public a(I)Ljava/util/List;
    .locals 6

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    :try_start_0
    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    :cond_0
    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iget-object v1, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-gez v1, :cond_2

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    const/4 v1, 0x0

    invoke-direct {p0, v2, v3, v1}, Lcom/talkingdata/sdk/h;->a(JZ)[B

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->size()I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-lt v1, p1, :cond_0

    :cond_2
    :goto_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_3

    iget-wide v2, p0, Lcom/talkingdata/sdk/h;->h:J

    iput-wide v2, p0, Lcom/talkingdata/sdk/h;->g:J

    :cond_3
    return-object v0

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public a()V
    .locals 2

    iget-wide v0, p0, Lcom/talkingdata/sdk/h;->h:J

    invoke-direct {p0, v0, v1}, Lcom/talkingdata/sdk/h;->b(J)V

    iget-wide v0, p0, Lcom/talkingdata/sdk/h;->h:J

    iput-wide v0, p0, Lcom/talkingdata/sdk/h;->g:J

    return-void
.end method

.method public a([B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/talkingdata/sdk/h;->b([B)V

    return-void
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFD()Ljava/io/FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/FileDescriptor;->sync()V

    return-void
.end method

.method public c()V
    .locals 1

    invoke-virtual {p0}, Lcom/talkingdata/sdk/h;->b()V

    iget-object v0, p0, Lcom/talkingdata/sdk/h;->c:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V

    return-void
.end method
