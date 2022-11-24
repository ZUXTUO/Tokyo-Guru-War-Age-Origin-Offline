.class Lcom/talkingdata/sdk/l;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/talkingdata/sdk/k;


# direct methods
.method constructor <init>(Lcom/talkingdata/sdk/k;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iput-object p2, p0, Lcom/talkingdata/sdk/l;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iget-object v1, p0, Lcom/talkingdata/sdk/l;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/k;->a(Lcom/talkingdata/sdk/k;Ljava/lang/String;)Lcom/talkingdata/sdk/m;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iget-boolean v1, v1, Lcom/talkingdata/sdk/k;->g:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iput-object v0, v1, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    iget-object v1, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v0, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_0
    const-wide/16 v0, 0xbb8

    :try_start_2
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    iget-object v0, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iget-object v0, v0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    invoke-interface {v0}, Lcom/talkingdata/sdk/m;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iget-object v1, p0, Lcom/talkingdata/sdk/l;->b:Lcom/talkingdata/sdk/k;

    iget-object v1, v1, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/k;->a(Lcom/talkingdata/sdk/k;Lcom/talkingdata/sdk/m;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :cond_1
    :goto_0
    return-void

    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
