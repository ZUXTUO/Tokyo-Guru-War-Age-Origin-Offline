.class final Lcom/blm/sdk/core/a$4;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/a;->b(Landroid/content/Context;Lcom/blm/sdk/a/c/d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 206
    iput-object p1, p0, Lcom/blm/sdk/core/a$4;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/blm/sdk/core/a$4;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/16 v3, -0x2712

    .line 209
    invoke-super {p0}, Ljava/lang/Thread;->run()V

    .line 210
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    iget-object v1, p0, Lcom/blm/sdk/core/a$4;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/blm/sdk/connection/BlmLib;->LdoString(Ljava/lang/String;)I

    .line 212
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    iget-object v2, p0, Lcom/blm/sdk/core/a$4;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/blm/sdk/connection/BlmLib;->getField(ILjava/lang/String;)V

    .line 213
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    invoke-static {}, Lcom/blm/sdk/core/ConnectionDSL;->getInstance()Lcom/blm/sdk/core/ConnectionDSL;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/connection/BlmLib;->pushJavaObject(Ljava/lang/Object;)V

    .line 214
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    new-instance v1, Ljava/lang/Integer;

    invoke-direct {v1, v3}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const-string v2, "resultKey"

    invoke-virtual {v0, v1, v2}, Lcom/blm/sdk/connection/BlmLib;->setField(ILjava/lang/String;)V

    .line 215
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    const-string v1, "resultKey"

    invoke-virtual {v0, v1}, Lcom/blm/sdk/connection/BlmLib;->getGlobal(Ljava/lang/String;)V

    .line 217
    invoke-static {}, Lcom/blm/sdk/core/a;->b()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v4, v4, v1}, Lcom/blm/sdk/connection/BlmLib;->pcall(III)I

    move-result v0

    .line 218
    new-instance v1, Landroid/os/Message;

    invoke-direct {v1}, Landroid/os/Message;-><init>()V

    .line 219
    const/16 v2, 0x2710

    iput v2, v1, Landroid/os/Message;->what:I

    .line 220
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 221
    sget-object v0, Lcom/blm/sdk/core/a;->c:Landroid/os/Handler;

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 222
    return-void
.end method
