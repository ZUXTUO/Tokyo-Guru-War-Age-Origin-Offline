.class Lcom/talkingdata/sdk/q;
.super Landroid/os/Handler;


# instance fields
.field final synthetic a:Lcom/talkingdata/sdk/p;


# direct methods
.method constructor <init>(Lcom/talkingdata/sdk/p;Landroid/os/Looper;)V
    .locals 0

    iput-object p1, p0, Lcom/talkingdata/sdk/q;->a:Lcom/talkingdata/sdk/p;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    iget-object v0, p0, Lcom/talkingdata/sdk/q;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->a(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorManager;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/q;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->a(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorManager;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/q;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v1}, Lcom/talkingdata/sdk/p;->b(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorEventListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_0
    .end packed-switch
.end method
