.class final Lcom/blm/sdk/core/b$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 121
    iput-object p1, p0, Lcom/blm/sdk/core/b$2;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/blm/sdk/core/b$2;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/blm/sdk/core/b$2;->c:Ljava/lang/String;

    iput-object p4, p0, Lcom/blm/sdk/core/b$2;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 124
    new-instance v0, Lcom/blm/sdk/down/c;

    iget-object v1, p0, Lcom/blm/sdk/core/b$2;->a:Landroid/content/Context;

    iget-object v2, p0, Lcom/blm/sdk/core/b$2;->b:Ljava/lang/String;

    iget-object v3, p0, Lcom/blm/sdk/core/b$2;->c:Ljava/lang/String;

    iget-object v4, p0, Lcom/blm/sdk/core/b$2;->d:Ljava/lang/String;

    const/4 v5, 0x4

    invoke-direct/range {v0 .. v5}, Lcom/blm/sdk/down/c;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 125
    invoke-virtual {v0}, Lcom/blm/sdk/down/c;->a()I

    move-result v1

    .line 128
    :try_start_0
    new-instance v2, Lcom/blm/sdk/core/b$2$1;

    invoke-direct {v2, p0, v1}, Lcom/blm/sdk/core/b$2$1;-><init>(Lcom/blm/sdk/core/b$2;I)V

    invoke-virtual {v0, v2}, Lcom/blm/sdk/down/c;->a(Lcom/blm/sdk/down/a;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 141
    :goto_0
    return-void

    .line 138
    :catch_0
    move-exception v0

    .line 139
    invoke-static {}, Lcom/blm/sdk/core/b;->a()Landroid/os/Handler;

    move-result-object v0

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method
