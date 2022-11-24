.class final Lcom/blm/sdk/core/a$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/core/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 54
    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 56
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 75
    :goto_0
    return-void

    .line 58
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 59
    invoke-static {v0}, Lcom/blm/sdk/core/a;->a(I)V

    goto :goto_0

    .line 62
    :pswitch_1
    invoke-static {}, Lcom/blm/sdk/core/a;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "\u8fdb\u5165handler"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 63
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/content/Context;

    .line 64
    const-string v1, "LAST_DO_TIME"

    const-wide/16 v2, 0x0

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/blm/sdk/d/h;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;)J

    move-result-wide v2

    .line 65
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 66
    sub-long v2, v4, v2

    const-wide/32 v4, 0x4ef6d80

    cmp-long v1, v2, v4

    if-lez v1, :cond_0

    .line 68
    invoke-static {v0}, Lcom/blm/sdk/core/a;->b(Landroid/content/Context;)V

    goto :goto_0

    .line 71
    :cond_0
    invoke-static {}, Lcom/blm/sdk/core/a;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "\u8ddd\u79bb\u4e0a\u6b21\u62c9\u53d6\u5c0f\u4e8e23\u5c0f\u65f6"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 56
    :pswitch_data_0
    .packed-switch 0x2710
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
