.class public abstract Lcom/blm/sdk/connection/JavaFunction;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field protected L:Lcom/blm/sdk/connection/BlmLib;


# direct methods
.method public constructor <init>(Lcom/blm/sdk/connection/BlmLib;)V
    .locals 0
    .param p1, "L"    # Lcom/blm/sdk/connection/BlmLib;

    .prologue
    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    iput-object p1, p0, Lcom/blm/sdk/connection/JavaFunction;->L:Lcom/blm/sdk/connection/BlmLib;

    .line 58
    return-void
.end method


# virtual methods
.method public abstract execute()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation
.end method

.method public getParam(I)Lcom/blm/sdk/connection/BlmObject;
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 70
    iget-object v0, p0, Lcom/blm/sdk/connection/JavaFunction;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p1}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    return-object v0
.end method

.method public register(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 80
    iget-object v1, p0, Lcom/blm/sdk/connection/JavaFunction;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/connection/JavaFunction;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p0}, Lcom/blm/sdk/connection/BlmLib;->pushJavaFunction(Lcom/blm/sdk/connection/JavaFunction;)V

    .line 83
    iget-object v0, p0, Lcom/blm/sdk/connection/JavaFunction;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, p1}, Lcom/blm/sdk/connection/BlmLib;->setGlobal(Ljava/lang/String;)V

    .line 84
    monitor-exit v1

    .line 85
    return-void

    .line 84
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
