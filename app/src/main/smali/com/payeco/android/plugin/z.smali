.class final Lcom/payeco/android/plugin/z;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoVedioActivity;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Lcom/payeco/android/plugin/PayecoVedioActivity;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Lcom/payeco/android/plugin/PayecoVedioActivity;I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->b(Lcom/payeco/android/plugin/PayecoVedioActivity;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v2}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Lcom/payeco/android/plugin/PayecoVedioActivity;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "\u79d2"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->c(Lcom/payeco/android/plugin/PayecoVedioActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoVedioActivity;->d(Lcom/payeco/android/plugin/PayecoVedioActivity;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Lcom/payeco/android/plugin/PayecoVedioActivity;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoVedioActivity;->e(Lcom/payeco/android/plugin/PayecoVedioActivity;)I

    move-result v1

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/z;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->f(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    :cond_0
    return-void
.end method
