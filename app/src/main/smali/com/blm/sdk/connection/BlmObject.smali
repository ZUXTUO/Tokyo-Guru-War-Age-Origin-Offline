.class public Lcom/blm/sdk/connection/BlmObject;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field protected L:Lcom/blm/sdk/connection/BlmLib;

.field protected ref:Ljava/lang/Integer;


# direct methods
.method protected constructor <init>(Lcom/blm/sdk/connection/BlmLib;I)V
    .locals 1
    .param p1, "L"    # Lcom/blm/sdk/connection/BlmLib;
    .param p2, "index"    # I

    .prologue
    .line 170
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 171
    monitor-enter p1

    .line 173
    :try_start_0
    iput-object p1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 175
    invoke-direct {p0, p2}, Lcom/blm/sdk/connection/BlmObject;->registerValue(I)V

    .line 176
    monitor-exit p1

    .line 177
    return-void

    .line 176
    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method protected constructor <init>(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/String;)V
    .locals 1
    .param p1, "L"    # Lcom/blm/sdk/connection/BlmLib;
    .param p2, "globalName"    # Ljava/lang/String;

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    monitor-enter p1

    .line 70
    :try_start_0
    iput-object p1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 71
    invoke-virtual {p1, p2}, Lcom/blm/sdk/connection/BlmLib;->getGlobal(Ljava/lang/String;)V

    .line 72
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmObject;->registerValue(I)V

    .line 73
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 74
    monitor-exit p1

    .line 75
    return-void

    .line 74
    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method protected constructor <init>(Lcom/blm/sdk/connection/BlmObject;Lcom/blm/sdk/connection/BlmObject;)V
    .locals 3
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Lcom/blm/sdk/connection/BlmObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 143
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 144
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    invoke-virtual {p2}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 145
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "BlmStates must be the same!"

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 146
    :cond_0
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    monitor-enter v1

    .line 148
    :try_start_0
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isUserdata()Z

    move-result v0

    if-nez v0, :cond_1

    .line 149
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Object parent should be a table or userdata ."

    invoke-direct {v0, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 159
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 151
    :cond_1
    :try_start_1
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 153
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 154
    invoke-virtual {p2}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 155
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->getTable(I)V

    .line 156
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->remove(I)V

    .line 157
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmObject;->registerValue(I)V

    .line 158
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 159
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 160
    return-void
.end method

.method protected constructor <init>(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/Number;)V
    .locals 4
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Ljava/lang/Number;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 117
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    monitor-enter v1

    .line 119
    :try_start_0
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 120
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isUserdata()Z

    move-result v0

    if-nez v0, :cond_0

    .line 121
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Object parent should be a table or userdata ."

    invoke-direct {v0, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 129
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 123
    :cond_0
    :try_start_1
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 124
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {p2}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pushNumber(D)V

    .line 125
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->getTable(I)V

    .line 126
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->remove(I)V

    .line 127
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmObject;->registerValue(I)V

    .line 128
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 129
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 130
    return-void
.end method

.method protected constructor <init>(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/String;)V
    .locals 3
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 87
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    monitor-enter v1

    .line 89
    :try_start_0
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 91
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->isUserdata()Z

    move-result v0

    if-nez v0, :cond_0

    .line 93
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Object parent should be a table or userdata ."

    invoke-direct {v0, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 102
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 96
    :cond_0
    :try_start_1
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 97
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p2}, Lcom/blm/sdk/connection/BlmLib;->pushString(Ljava/lang/String;)V

    .line 98
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->getTable(I)V

    .line 99
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->remove(I)V

    .line 100
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmObject;->registerValue(I)V

    .line 101
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 102
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 103
    return-void
.end method

.method private registerValue(I)V
    .locals 3
    .param p1, "index"    # I

    .prologue
    .line 195
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 197
    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p1}, Lcom/blm/sdk/connection/BlmLib;->pushValue(I)V

    .line 199
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/16 v2, -0x2710

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->Lref(I)I

    move-result v0

    .line 200
    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, v0}, Ljava/lang/Integer;-><init>(I)V

    iput-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->ref:Ljava/lang/Integer;

    .line 201
    monitor-exit v1

    .line 202
    return-void

    .line 201
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method


# virtual methods
.method public call([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 490
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/blm/sdk/connection/BlmObject;->call([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public call([Ljava/lang/Object;I)[Ljava/lang/Object;
    .locals 8
    .param p1, "args"    # [Ljava/lang/Object;
    .param p2, "nres"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x1

    const/4 v1, 0x0

    const/4 v6, -0x1

    .line 405
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v2

    .line 407
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isFunction()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isUserdata()Z

    move-result v0

    if-nez v0, :cond_0

    .line 408
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Invalid object. Not a function, table or userdata ."

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 477
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 410
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v3

    .line 411
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 413
    if-eqz p1, :cond_1

    .line 415
    array-length v0, p1

    .line 416
    :goto_0
    if-ge v1, v0, :cond_2

    .line 418
    aget-object v4, p1, v1

    .line 419
    iget-object v5, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v5, v4}, Lcom/blm/sdk/connection/BlmLib;->pushObjectValue(Ljava/lang/Object;)V

    .line 416
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    .line 425
    :cond_2
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v4, 0x0

    invoke-virtual {v1, v0, p2, v4}, Lcom/blm/sdk/connection/BlmLib;->pcall(III)I

    move-result v1

    .line 427
    if-eqz v1, :cond_7

    .line 430
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, -0x1

    invoke-virtual {v0, v3}, Lcom/blm/sdk/connection/BlmLib;->isString(I)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 432
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, -0x1

    invoke-virtual {v0, v3}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 433
    iget-object v3, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 439
    :goto_1
    if-ne v1, v7, :cond_4

    .line 441
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Runtime error. "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 458
    :goto_2
    new-instance v1, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v1, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 436
    :cond_3
    const-string v0, ""

    goto :goto_1

    .line 444
    :cond_4
    const/4 v3, 0x4

    if-ne v1, v3, :cond_5

    .line 446
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Memory allocation error. "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 449
    :cond_5
    const/4 v3, 0x5

    if-ne v1, v3, :cond_6

    .line 451
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error while running the error handler function. "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 455
    :cond_6
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Blm Error code "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ". "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 462
    :cond_7
    if-ne p2, v6, :cond_8

    .line 463
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v0

    sub-int p2, v0, v3

    .line 464
    :cond_8
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v0

    sub-int/2addr v0, v3

    if-ge v0, p2, :cond_9

    .line 466
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Invalid Number of Results ."

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 469
    :cond_9
    new-array v1, p2, [Ljava/lang/Object;

    move v0, p2

    .line 471
    :goto_3
    if-lez v0, :cond_a

    .line 473
    add-int/lit8 v3, v0, -0x1

    iget-object v4, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v5, -0x1

    invoke-virtual {v4, v5}, Lcom/blm/sdk/connection/BlmLib;->toJavaObject(I)Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v1, v3

    .line 474
    iget-object v3, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 471
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 476
    :cond_a
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return-object v1
.end method

.method public createProxy(Ljava/lang/String;)Ljava/lang/Object;
    .locals 5
    .param p1, "implem"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;,
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 535
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 537
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v0

    if-nez v0, :cond_0

    .line 538
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Invalid Object. Must be Table."

    invoke-direct {v0, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 548
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 540
    :cond_0
    :try_start_1
    new-instance v2, Ljava/util/StringTokenizer;

    const-string v0, ","

    invoke-direct {v2, p1, v0}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 541
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->countTokens()I

    move-result v0

    new-array v3, v0, [Ljava/lang/Class;

    .line 542
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 543
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    aput-object v4, v3, v0

    .line 542
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 545
    :cond_1
    new-instance v0, Lcom/blm/sdk/connection/BlmInvocationHandler;

    invoke-direct {v0, p0}, Lcom/blm/sdk/connection/BlmInvocationHandler;-><init>(Lcom/blm/sdk/connection/BlmObject;)V

    .line 547
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    invoke-static {v2, v3, v0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return-object v0
.end method

.method protected finalize()V
    .locals 6

    .prologue
    .line 208
    :try_start_0
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 210
    :try_start_1
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_0

    .line 212
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/16 v2, -0x2710

    iget-object v3, p0, Lcom/blm/sdk/connection/BlmObject;->ref:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-virtual {v0, v2, v3}, Lcom/blm/sdk/connection/BlmLib;->LunRef(II)V

    .line 213
    :cond_0
    monitor-exit v1

    .line 219
    :goto_0
    return-void

    .line 213
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 215
    :catch_0
    move-exception v0

    .line 217
    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to release object "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->ref:Ljava/lang/Integer;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public getBlmState()Lcom/blm/sdk/connection/BlmLib;
    .locals 1

    .prologue
    .line 184
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    return-object v0
.end method

.method public getBoolean()Z
    .locals 4

    .prologue
    .line 342
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 344
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 345
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toBoolean(I)Z

    move-result v0

    .line 346
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 347
    monitor-exit v1

    return v0

    .line 348
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getField(Ljava/lang/String;)Lcom/blm/sdk/connection/BlmObject;
    .locals 1
    .param p1, "field"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 390
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p0, p1}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/String;)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    return-object v0
.end method

.method public getNumber()D
    .locals 5

    .prologue
    .line 353
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 355
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 356
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toNumber(I)D

    move-result-wide v2

    .line 357
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 358
    monitor-exit v1

    return-wide v2

    .line 359
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getObject()Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 375
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 377
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 378
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->getObjectFromUserdata(I)Ljava/lang/Object;

    move-result-object v0

    .line 379
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 380
    monitor-exit v1

    return-object v0

    .line 381
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 364
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 366
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 367
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 368
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 369
    monitor-exit v1

    return-object v0

    .line 370
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isBoolean()Z
    .locals 4

    .prologue
    .line 243
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 245
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 246
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isBoolean(I)Z

    move-result v0

    .line 247
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 248
    monitor-exit v1

    return v0

    .line 249
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isFunction()Z
    .locals 4

    .prologue
    .line 276
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 278
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 279
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isFunction(I)Z

    move-result v0

    .line 280
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 281
    monitor-exit v1

    return v0

    .line 282
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isJavaFunction()Z
    .locals 4

    .prologue
    .line 298
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 300
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 301
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isJavaFunction(I)Z

    move-result v0

    .line 302
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 303
    monitor-exit v1

    return v0

    .line 304
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isJavaObject()Z
    .locals 4

    .prologue
    .line 287
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 289
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 290
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isObject(I)Z

    move-result v0

    .line 291
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 292
    monitor-exit v1

    return v0

    .line 293
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isNil()Z
    .locals 4

    .prologue
    .line 232
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 234
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 235
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isNil(I)Z

    move-result v0

    .line 236
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 237
    monitor-exit v1

    return v0

    .line 238
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isNumber()Z
    .locals 4

    .prologue
    .line 254
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 256
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 257
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isNumber(I)Z

    move-result v0

    .line 258
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 259
    monitor-exit v1

    return v0

    .line 260
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isString()Z
    .locals 4

    .prologue
    .line 265
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 267
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 268
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isString(I)Z

    move-result v0

    .line 269
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 270
    monitor-exit v1

    return v0

    .line 271
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isTable()Z
    .locals 4

    .prologue
    .line 309
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 311
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 312
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isTable(I)Z

    move-result v0

    .line 313
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 314
    monitor-exit v1

    return v0

    .line 315
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isUserdata()Z
    .locals 4

    .prologue
    .line 320
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 322
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 323
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->isUserdata(I)Z

    move-result v0

    .line 324
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 325
    monitor-exit v1

    return v0

    .line 326
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public push()V
    .locals 3

    .prologue
    .line 227
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/16 v1, -0x2710

    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->ref:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/blm/sdk/connection/BlmLib;->rawGetI(II)V

    .line 228
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 495
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 499
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isNil()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 500
    const-string v0, "nil"
    :try_end_0
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 522
    :goto_0
    return-object v0

    .line 501
    :cond_0
    :try_start_2
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isBoolean()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 502
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->getBoolean()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;
    :try_end_2
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    :try_start_3
    monitor-exit v1

    goto :goto_0

    .line 524
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 503
    :cond_1
    :try_start_4
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isNumber()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 504
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->getNumber()D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;
    :try_end_4
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result-object v0

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_0

    .line 505
    :cond_2
    :try_start_6
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isString()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 506
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->getString()Ljava/lang/String;
    :try_end_6
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move-result-object v0

    :try_start_7
    monitor-exit v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_0

    .line 507
    :cond_3
    :try_start_8
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isFunction()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 508
    const-string v0, "Blm Function"
    :try_end_8
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_8 .. :try_end_8} :catch_0
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :try_start_9
    monitor-exit v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto :goto_0

    .line 509
    :cond_4
    :try_start_a
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isJavaObject()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 510
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->getObject()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;
    :try_end_a
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_a .. :try_end_a} :catch_0
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    move-result-object v0

    :try_start_b
    monitor-exit v1
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    goto :goto_0

    .line 511
    :cond_5
    :try_start_c
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isUserdata()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 512
    const-string v0, "Userdata"
    :try_end_c
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_c .. :try_end_c} :catch_0
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    :try_start_d
    monitor-exit v1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    goto :goto_0

    .line 513
    :cond_6
    :try_start_e
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isTable()Z

    move-result v2

    if-eqz v2, :cond_7

    .line 514
    const-string v0, "Blm Table"
    :try_end_e
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_e .. :try_end_e} :catch_0
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    :try_start_f
    monitor-exit v1
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    goto :goto_0

    .line 515
    :cond_7
    :try_start_10
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->isJavaFunction()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 516
    const-string v0, "Java Function"
    :try_end_10
    .catch Lcom/blm/sdk/connection/BlmException; {:try_start_10 .. :try_end_10} :catch_0
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    :try_start_11
    monitor-exit v1

    goto :goto_0

    .line 518
    :cond_8
    monitor-exit v1

    goto :goto_0

    .line 520
    :catch_0
    move-exception v2

    .line 522
    monitor-exit v1
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_0

    goto :goto_0
.end method

.method public type()I
    .locals 4

    .prologue
    .line 331
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 333
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmObject;->push()V

    .line 334
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v0

    .line 335
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/blm/sdk/connection/BlmLib;->pop(I)V

    .line 336
    monitor-exit v1

    return v0

    .line 337
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
