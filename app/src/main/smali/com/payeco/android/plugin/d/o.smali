.class final Lcom/payeco/android/plugin/d/o;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/n;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/n;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->a(Lcom/payeco/android/plugin/d/n;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->c(Lcom/payeco/android/plugin/d/n;)Landroid/content/Context;

    move-result-object v0

    const-string v1, "payeco_plugin_editbg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->d(Lcom/payeco/android/plugin/d/n;)V

    :cond_0
    check-cast p1, Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setPressed(Z)V

    invoke-virtual {p1}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->e(Lcom/payeco/android/plugin/d/n;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->g(Lcom/payeco/android/plugin/d/n;)I

    move-result v2

    if-lt v1, v2, :cond_3

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->g(Lcom/payeco/android/plugin/d/n;)I

    move-result v2

    if-ge v1, v2, :cond_1

    :cond_3
    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->e(Lcom/payeco/android/plugin/d/n;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    rem-int/lit8 v1, v1, 0x5

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, " "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/d/n;->a(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    :goto_1
    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    goto :goto_0

    :cond_4
    iget-object v1, p0, Lcom/payeco/android/plugin/d/o;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/d/n;->a(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    goto :goto_1
.end method
