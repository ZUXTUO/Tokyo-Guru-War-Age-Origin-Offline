.class Lcom/talkingdata/sdk/r;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/hardware/SensorEventListener;


# instance fields
.field final synthetic a:Lcom/talkingdata/sdk/p;

.field private b:I


# direct methods
.method constructor <init>(Lcom/talkingdata/sdk/p;)V
    .locals 1

    iput-object p1, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/talkingdata/sdk/r;->b:I

    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 10

    const/4 v9, 0x1

    const/high16 v8, 0x41900000    # 18.0f

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v2}, Landroid/hardware/Sensor;->getType()I

    move-result v2

    iget-object v3, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v3}, Lcom/talkingdata/sdk/p;->c(Lcom/talkingdata/sdk/p;)J

    move-result-wide v4

    sub-long v4, v0, v4

    const-wide/16 v6, 0xfa

    cmp-long v3, v4, v6

    if-lez v3, :cond_0

    if-eq v2, v9, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v2, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v2, v0, v1}, Lcom/talkingdata/sdk/p;->a(Lcom/talkingdata/sdk/p;J)J

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const-string v1, ""

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "values[0] = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x0

    aget v3, v0, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    aget v1, v0, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    cmpl-float v1, v1, v8

    if-gtz v1, :cond_2

    const/4 v1, 0x1

    aget v1, v0, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    cmpl-float v1, v1, v8

    if-gtz v1, :cond_2

    const/4 v1, 0x2

    aget v0, v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpl-float v0, v0, v8

    if-lez v0, :cond_3

    :cond_2
    iget v0, p0, Lcom/talkingdata/sdk/r;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/talkingdata/sdk/r;->b:I

    :cond_3
    iget v0, p0, Lcom/talkingdata/sdk/r;->b:I

    const/4 v1, 0x5

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->d(Lcom/talkingdata/sdk/p;)Lcom/talkingdata/sdk/p$a;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->e(Lcom/talkingdata/sdk/p;)Landroid/content/Context;

    move-result-object v0

    const-string v1, "android.permission.VIBRATE"

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/t;->b(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->e(Lcom/talkingdata/sdk/p;)Landroid/content/Context;

    move-result-object v0

    const-string v1, "vibrator"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V

    :cond_4
    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->d(Lcom/talkingdata/sdk/p;)Lcom/talkingdata/sdk/p$a;

    move-result-object v0

    invoke-interface {v0}, Lcom/talkingdata/sdk/p$a;->a()V

    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->a(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorManager;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v0}, Lcom/talkingdata/sdk/p;->a(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorManager;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/r;->a:Lcom/talkingdata/sdk/p;

    invoke-static {v1}, Lcom/talkingdata/sdk/p;->b(Lcom/talkingdata/sdk/p;)Landroid/hardware/SensorEventListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    :cond_5
    const/4 v0, 0x0

    iput v0, p0, Lcom/talkingdata/sdk/r;->b:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    :catch_0
    move-exception v0

    goto/16 :goto_0
.end method
