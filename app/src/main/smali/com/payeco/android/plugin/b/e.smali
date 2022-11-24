.class final Lcom/payeco/android/plugin/b/e;
.super Ljava/lang/Thread;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/b/b;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/b/b;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/b/e;->a:Lcom/payeco/android/plugin/b/b;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/b/b;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/b/e;-><init>(Lcom/payeco/android/plugin/b/b;)V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    invoke-static {}, Landroid/os/Looper;->prepare()V

    iget-object v0, p0, Lcom/payeco/android/plugin/b/e;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/b/b;->a(Lcom/payeco/android/plugin/b/b;Landroid/os/Looper;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/b/e;->a:Lcom/payeco/android/plugin/b/b;

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->d(Lcom/payeco/android/plugin/b/b;)V

    invoke-static {}, Landroid/os/Looper;->loop()V

    return-void
.end method
