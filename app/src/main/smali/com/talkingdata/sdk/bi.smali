.class public Lcom/talkingdata/sdk/bi;
.super Ljava/lang/Object;


# static fields
.field static a:Lcom/talkingdata/sdk/h;

.field static b:Ljava/lang/String;

.field static c:Ljava/lang/String;

.field static d:[B


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const-string v0, "td_databaseTalkingData"

    sput-object v0, Lcom/talkingdata/sdk/bi;->b:Ljava/lang/String;

    const-string v0, "utf-8"

    sput-object v0, Lcom/talkingdata/sdk/bi;->c:Ljava/lang/String;

    new-instance v0, Lcom/talkingdata/sdk/h;

    sget-object v1, Lcom/talkingdata/sdk/bm;->a:Landroid/content/Context;

    sget-object v2, Lcom/talkingdata/sdk/bi;->b:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/talkingdata/sdk/h;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    sput-object v0, Lcom/talkingdata/sdk/bi;->a:Lcom/talkingdata/sdk/h;

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/t;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    if-eqz v1, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/bi;->d:[B

    :goto_0
    return-void

    :cond_0
    const-class v0, Lcom/talkingdata/sdk/as;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/bi;->d:[B

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized a()Ljava/util/List;
    .locals 5

    const-class v2, Lcom/talkingdata/sdk/bi;

    monitor-enter v2

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/talkingdata/sdk/bi;->a:Lcom/talkingdata/sdk/h;

    const/16 v3, 0x64

    invoke-virtual {v1, v3}, Lcom/talkingdata/sdk/h;->a(I)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    sget-object v4, Lcom/talkingdata/sdk/bi;->d:[B

    invoke-static {v0, v4}, Lcom/talkingdata/sdk/t;->c([B[B)[B

    move-result-object v0

    new-instance v4, Ljava/lang/String;

    invoke-direct {v4, v0}, Ljava/lang/String;-><init>([B)V

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :cond_1
    monitor-exit v2

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method

.method public static declared-synchronized a(Ljava/lang/String;)V
    .locals 3

    const-class v1, Lcom/talkingdata/sdk/bi;

    monitor-enter v1

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    :cond_0
    const-string v0, "TDFileStoreManager storeMessage()# message is null or empty"

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->e(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit v1

    return-void

    :cond_1
    :try_start_1
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sget-object v2, Lcom/talkingdata/sdk/bi;->d:[B

    invoke-static {v0, v2}, Lcom/talkingdata/sdk/t;->b([B[B)[B

    move-result-object v0

    sget-object v2, Lcom/talkingdata/sdk/bi;->a:Lcom/talkingdata/sdk/h;

    invoke-virtual {v2, v0}, Lcom/talkingdata/sdk/h;->a([B)V

    sget-object v0, Lcom/talkingdata/sdk/bi;->a:Lcom/talkingdata/sdk/h;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/h;->b()V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public static b()V
    .locals 1

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/bi;->a:Lcom/talkingdata/sdk/h;

    invoke-virtual {v0}, Lcom/talkingdata/sdk/h;->a()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static c()V
    .locals 0

    return-void
.end method
