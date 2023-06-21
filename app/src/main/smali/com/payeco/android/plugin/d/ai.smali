.class final Lcom/payeco/android/plugin/d/ai;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/ab;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/ab;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/ai;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onCompletion(Landroid/media/MediaPlayer;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ai;->a:Lcom/payeco/android/plugin/d/ab;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/payeco/android/plugin/d/ab;->b:Z

    return-void
.end method
