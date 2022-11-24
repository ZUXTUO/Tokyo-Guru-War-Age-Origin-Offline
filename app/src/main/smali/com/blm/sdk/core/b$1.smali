.class final Lcom/blm/sdk/core/b$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/core/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 45
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 78
    :cond_0
    :goto_0
    return-void

    .line 47
    :pswitch_0
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "filesize"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    .line 48
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "currentSize"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 49
    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 55
    :pswitch_1
    sget-object v1, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    .line 56
    if-eqz v1, :cond_0

    .line 58
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/blm/sdk/a/b/f;

    .line 59
    new-instance v2, Lcom/blm/sdk/core/b$1$1;

    invoke-direct {v2, p0, v1}, Lcom/blm/sdk/core/b$1$1;-><init>(Lcom/blm/sdk/core/b$1;Landroid/content/Context;)V

    invoke-static {v1, v2, v0}, Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Lcom/blm/sdk/c/a;Lcom/blm/sdk/a/b/f;)V

    goto :goto_0

    .line 45
    :pswitch_data_0
    .packed-switch 0x2711
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
