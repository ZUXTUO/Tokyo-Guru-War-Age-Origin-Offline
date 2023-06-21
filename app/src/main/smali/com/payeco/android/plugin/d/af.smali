.class final Lcom/payeco/android/plugin/d/af;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/ab;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/ab;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    iget-boolean v0, v0, Lcom/payeco/android/plugin/d/ab;->a:Z

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    iget-boolean v0, v0, Lcom/payeco/android/plugin/d/ab;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->k(Lcom/payeco/android/plugin/d/ab;)Lcom/payeco/android/plugin/d/aj;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/ab;->k(Lcom/payeco/android/plugin/d/ab;)Lcom/payeco/android/plugin/d/aj;

    move-result-object v0

    sget-object v1, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/payeco/android/plugin/d/aj;->a(Ljava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/payeco/android/plugin/d/af;->a:Lcom/payeco/android/plugin/d/ab;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/ab;->dismiss()V

    goto :goto_0
.end method
