.class final Lcom/payeco/android/plugin/d/ad;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/ab;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/ab;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/ab;->e(Lcom/payeco/android/plugin/d/ab;)I

    move-result v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/ab;->b(Lcom/payeco/android/plugin/d/ab;I)I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->g(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->h(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->i(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->j(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->b(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->c(Lcom/payeco/android/plugin/d/ab;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ad;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/ab;->d(Lcom/payeco/android/plugin/d/ab;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    return-void
.end method
