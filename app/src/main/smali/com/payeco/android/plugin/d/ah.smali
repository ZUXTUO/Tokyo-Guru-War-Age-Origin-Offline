.class final Lcom/payeco/android/plugin/d/ah;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/ab;

.field private final synthetic b:I


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/ab;I)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/ah;->a:Lcom/payeco/android/plugin/d/ab;

    iput p2, p0, Lcom/payeco/android/plugin/d/ah;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    :try_start_0
    iget v0, p0, Lcom/payeco/android/plugin/d/ah;->b:I

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v0, v0

    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ah;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/ab;->a()I
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
