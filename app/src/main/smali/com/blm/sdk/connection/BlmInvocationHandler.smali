.class public Lcom/blm/sdk/connection/BlmInvocationHandler;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# instance fields
.field private obj:Lcom/blm/sdk/connection/BlmObject;


# direct methods
.method public constructor <init>(Lcom/blm/sdk/connection/BlmObject;)V
    .locals 0
    .param p1, "obj"    # Lcom/blm/sdk/connection/BlmObject;

    .prologue
    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput-object p1, p0, Lcom/blm/sdk/connection/BlmInvocationHandler;->obj:Lcom/blm/sdk/connection/BlmObject;

    .line 46
    return-void
.end method


# virtual methods
.method public invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .param p1, "proxy"    # Ljava/lang/Object;
    .param p2, "method"    # Ljava/lang/reflect/Method;
    .param p3, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 53
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmInvocationHandler;->obj:Lcom/blm/sdk/connection/BlmObject;

    iget-object v1, v1, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    monitor-enter v1

    .line 55
    :try_start_0
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v2

    .line 56
    iget-object v3, p0, Lcom/blm/sdk/connection/BlmInvocationHandler;->obj:Lcom/blm/sdk/connection/BlmObject;

    invoke-virtual {v3, v2}, Lcom/blm/sdk/connection/BlmObject;->getField(Ljava/lang/String;)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v2

    .line 58
    invoke-virtual {v2}, Lcom/blm/sdk/connection/BlmObject;->isNil()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 60
    monitor-exit v1

    .line 81
    :goto_0
    return-object v0

    .line 63
    :cond_0
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v3

    .line 67
    const-class v4, Ljava/lang/Void;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    sget-object v4, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 69
    :cond_1
    const/4 v3, 0x0

    invoke-virtual {v2, p3, v3}, Lcom/blm/sdk/connection/BlmObject;->call([Ljava/lang/Object;I)[Ljava/lang/Object;

    .line 81
    :cond_2
    :goto_1
    monitor-exit v1

    goto :goto_0

    .line 82
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 74
    :cond_3
    const/4 v0, 0x1

    :try_start_1
    invoke-virtual {v2, p3, v0}, Lcom/blm/sdk/connection/BlmObject;->call([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    const/4 v2, 0x0

    aget-object v0, v0, v2

    .line 75
    if-eqz v0, :cond_2

    instance-of v2, v0, Ljava/lang/Double;

    if-eqz v2, :cond_2

    .line 77
    check-cast v0, Ljava/lang/Double;

    invoke-static {v0, v3}, Lcom/blm/sdk/connection/BlmLib;->convertBlmNumber(Ljava/lang/Double;Ljava/lang/Class;)Ljava/lang/Number;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    goto :goto_1
.end method
