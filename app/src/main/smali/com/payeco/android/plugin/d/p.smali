.class final Lcom/payeco/android/plugin/d/p;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/n;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/n;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 4

    const/4 v3, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->e(Lcom/payeco/android/plugin/d/n;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    rem-int/lit8 v0, v0, 0x5

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x2

    invoke-virtual {v1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/n;->a(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    :goto_0
    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    :cond_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/p;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/n;->a(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    goto :goto_0
.end method
