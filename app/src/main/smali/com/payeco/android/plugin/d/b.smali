.class final Lcom/payeco/android/plugin/d/b;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/a;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/a;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "payeco_plugin_editbg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->c(Lcom/payeco/android/plugin/d/a;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Z)V

    :cond_0
    move-object v0, p1

    check-cast v0, Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/view/View;->setPressed(Z)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->d(Lcom/payeco/android/plugin/d/a;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->e(Lcom/payeco/android/plugin/d/a;)I

    move-result v2

    if-lt v1, v2, :cond_1

    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-virtual {v0}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/b;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->d(Lcom/payeco/android/plugin/d/a;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method
