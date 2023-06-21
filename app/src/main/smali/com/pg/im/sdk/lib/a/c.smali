.class public Lcom/pg/im/sdk/lib/a/c;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Lcom/pg/im/sdk/lib/a/b;

.field private static b:Lcom/pg/im/sdk/lib/a/c;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    return-void
.end method

.method public static declared-synchronized b()Lcom/pg/im/sdk/lib/a/c;
    .locals 2

    .prologue
    .line 19
    const-class v1, Lcom/pg/im/sdk/lib/a/c;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/pg/im/sdk/lib/a/c;->b:Lcom/pg/im/sdk/lib/a/c;

    if-nez v0, :cond_0

    .line 20
    new-instance v0, Lcom/pg/im/sdk/lib/a/c;

    invoke-direct {v0}, Lcom/pg/im/sdk/lib/a/c;-><init>()V

    sput-object v0, Lcom/pg/im/sdk/lib/a/c;->b:Lcom/pg/im/sdk/lib/a/c;

    .line 22
    :cond_0
    sget-object v0, Lcom/pg/im/sdk/lib/a/c;->b:Lcom/pg/im/sdk/lib/a/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 19
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public a()Lcom/pg/im/sdk/lib/a/b;
    .locals 1

    .prologue
    .line 11
    sget-object v0, Lcom/pg/im/sdk/lib/a/c;->a:Lcom/pg/im/sdk/lib/a/b;

    return-object v0
.end method

.method public a(Z)V
    .locals 1

    .prologue
    .line 31
    if-eqz p1, :cond_0

    .line 32
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    new-instance v0, Lcom/pg/im/sdk/lib/a/d;

    invoke-direct {v0}, Lcom/pg/im/sdk/lib/a/d;-><init>()V

    sput-object v0, Lcom/pg/im/sdk/lib/a/c;->a:Lcom/pg/im/sdk/lib/a/b;

    .line 36
    :goto_0
    return-void

    .line 34
    :cond_0
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    new-instance v0, Lcom/pg/im/sdk/lib/a/a;

    invoke-direct {v0}, Lcom/pg/im/sdk/lib/a/a;-><init>()V

    sput-object v0, Lcom/pg/im/sdk/lib/a/c;->a:Lcom/pg/im/sdk/lib/a/b;

    goto :goto_0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 42
    sget-object v0, Lcom/pg/im/sdk/lib/a/c;->a:Lcom/pg/im/sdk/lib/a/b;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/a/b;->b()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
