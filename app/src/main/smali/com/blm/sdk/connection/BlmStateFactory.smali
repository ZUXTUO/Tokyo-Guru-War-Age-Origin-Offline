.class public final Lcom/blm/sdk/connection/BlmStateFactory;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final states:Ljava/util/List;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 44
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getExistingState(I)Lcom/blm/sdk/connection/BlmLib;
    .locals 2
    .param p0, "index"    # I

    .prologue
    .line 73
    const-class v1, Lcom/blm/sdk/connection/BlmStateFactory;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blm/sdk/connection/BlmLib;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static declared-synchronized getNextStateIndex()I
    .locals 3

    .prologue
    .line 119
    const-class v1, Lcom/blm/sdk/connection/BlmStateFactory;

    monitor-enter v1

    const/4 v0, 0x0

    :goto_0
    :try_start_0
    sget-object v2, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v0, v2, :cond_0

    sget-object v2, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    if-eqz v2, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 121
    :cond_0
    monitor-exit v1

    return v0

    .line 119
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized insertBlmState(Lcom/blm/sdk/connection/BlmLib;)I
    .locals 8
    .param p0, "L"    # Lcom/blm/sdk/connection/BlmLib;

    .prologue
    .line 85
    const-class v2, Lcom/blm/sdk/connection/BlmStateFactory;

    monitor-enter v2

    const/4 v1, 0x0

    :goto_0
    :try_start_0
    sget-object v0, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 87
    sget-object v0, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blm/sdk/connection/BlmLib;

    .line 89
    if-eqz v0, :cond_0

    .line 91
    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v4

    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-wide v6

    cmp-long v0, v4, v6

    if-nez v0, :cond_0

    move v0, v1

    .line 100
    :goto_1
    monitor-exit v2

    return v0

    .line 85
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 96
    :cond_1
    :try_start_1
    invoke-static {}, Lcom/blm/sdk/connection/BlmStateFactory;->getNextStateIndex()I

    move-result v0

    .line 98
    sget-object v1, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v1, v0, p0}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 85
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method

.method public static declared-synchronized newBlmState()Lcom/blm/sdk/connection/BlmLib;
    .locals 4

    .prologue
    .line 58
    const-class v1, Lcom/blm/sdk/connection/BlmStateFactory;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/blm/sdk/connection/BlmStateFactory;->getNextStateIndex()I

    move-result v0

    .line 59
    new-instance v2, Lcom/blm/sdk/connection/BlmLib;

    invoke-direct {v2, v0}, Lcom/blm/sdk/connection/BlmLib;-><init>(I)V

    .line 61
    sget-object v3, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    invoke-interface {v3, v0, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 63
    monitor-exit v1

    return-object v2

    .line 58
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized removeBlmState(I)V
    .locals 3
    .param p0, "idx"    # I

    .prologue
    .line 109
    const-class v1, Lcom/blm/sdk/connection/BlmStateFactory;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/blm/sdk/connection/BlmStateFactory;->states:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v0, p0, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 110
    monitor-exit v1

    return-void

    .line 109
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method
