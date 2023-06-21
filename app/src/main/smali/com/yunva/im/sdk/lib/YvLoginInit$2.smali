.class Lcom/yunva/im/sdk/lib/YvLoginInit$2;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yunva/im/sdk/lib/YvLoginInit;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/yunva/im/sdk/lib/YvLoginInit;


# direct methods
.method constructor <init>(Lcom/yunva/im/sdk/lib/YvLoginInit;Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 50
    iput-object p1, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 52
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 53
    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    .line 84
    :goto_0
    return-void

    .line 55
    :sswitch_0
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 57
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 60
    :sswitch_1
    invoke-static {}, Lcom/yunva/im/sdk/lib/YvLoginInit;->YvImDoCallBack()V

    goto :goto_0

    .line 63
    :sswitch_2
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->a()Z

    goto :goto_0

    .line 66
    :sswitch_3
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->e()V

    goto :goto_0

    .line 69
    :sswitch_4
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->f()V

    goto :goto_0

    .line 72
    :sswitch_5
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->b()V

    goto :goto_0

    .line 75
    :sswitch_6
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->g()V

    goto :goto_0

    .line 78
    :sswitch_7
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->c()V

    goto :goto_0

    .line 81
    :sswitch_8
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;->a:Lcom/yunva/im/sdk/lib/YvLoginInit;

    invoke-static {v0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->d()V

    goto :goto_0

    .line 53
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_3
        0x5 -> :sswitch_4
        0x8 -> :sswitch_5
        0x10 -> :sswitch_6
        0x20 -> :sswitch_7
        0x40 -> :sswitch_8
    .end sparse-switch
.end method
