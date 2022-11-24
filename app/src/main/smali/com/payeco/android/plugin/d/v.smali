.class final Lcom/payeco/android/plugin/d/v;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/t;

.field private final synthetic b:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/v;->a:Lcom/payeco/android/plugin/d/t;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/v;->b:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 4

    iget-object v0, p0, Lcom/payeco/android/plugin/d/v;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/t;->a(Lcom/payeco/android/plugin/d/t;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/v;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/t;->b(Lcom/payeco/android/plugin/d/t;)Landroid/content/Context;

    move-result-object v0

    const-string v1, "payeco_plugin_editbg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/v;->b:Landroid/widget/EditText;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/v;->a:Lcom/payeco/android/plugin/d/t;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/t;->a(Lcom/payeco/android/plugin/d/t;Z)V

    :cond_0
    check-cast p1, Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setPressed(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/v;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/v;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/t;->c(Lcom/payeco/android/plugin/d/t;)I

    move-result v2

    if-lt v1, v2, :cond_1

    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/v;->b:Landroid/widget/EditText;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method
