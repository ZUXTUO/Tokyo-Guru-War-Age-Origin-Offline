.class final Lcom/payeco/android/plugin/d/y;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/t;

.field private final synthetic b:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/y;->b:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 5

    const/4 v4, 0x1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/y;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/t;->d(Lcom/payeco/android/plugin/d/t;)I

    move-result v2

    if-ge v1, v2, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "\u5bc6\u7801\u4f4d\u6570\u4e0d\u5b9c\u5c0f\u4e8e"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/t;->d(Lcom/payeco/android/plugin/d/t;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u4f4d"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/t;->b(Lcom/payeco/android/plugin/d/t;)Landroid/content/Context;

    move-result-object v1

    const-string v2, "payeco_keyboard_red_bg"

    const-string v3, "drawable"

    invoke-static {v1, v2, v3}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-lez v1, :cond_0

    iget-object v2, p0, Lcom/payeco/android/plugin/d/y;->b:Landroid/widget/EditText;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/payeco/android/plugin/d/y;->b:Landroid/widget/EditText;

    invoke-virtual {v2, v1}, Landroid/widget/EditText;->setBackgroundResource(I)V

    :cond_0
    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/t;->b(Lcom/payeco/android/plugin/d/t;)Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v0, v4}, Lcom/payeco/android/plugin/d/t;->a(Lcom/payeco/android/plugin/d/t;Z)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-virtual {v1}, Lcom/payeco/android/plugin/d/t;->dismiss()V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/t;->e(Lcom/payeco/android/plugin/d/t;)Lcom/payeco/android/plugin/d/z;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/payeco/android/plugin/d/y;->a:Lcom/payeco/android/plugin/d/t;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/t;->e(Lcom/payeco/android/plugin/d/t;)Lcom/payeco/android/plugin/d/z;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/payeco/android/plugin/d/z;->a(Ljava/lang/String;)V

    goto :goto_0
.end method
