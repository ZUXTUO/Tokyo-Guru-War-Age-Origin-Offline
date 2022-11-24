.class final Lcom/yunva/im/sdk/lib/YvLoginInit$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yunva/im/sdk/lib/YvLoginInit;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 38
    invoke-static {}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$000()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 39
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$002(Z)Z

    .line 40
    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    const-class v2, Lcom/pg/im/sdk/lib/VioceService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 41
    const-string v1, "appId"

    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->mAppId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 42
    const-string v1, "time"

    sget-wide v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->mtime:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 43
    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 44
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 46
    :cond_0
    return-void
.end method
