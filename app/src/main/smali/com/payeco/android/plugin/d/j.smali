.class final Lcom/payeco/android/plugin/d/j;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/a;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/a;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 4

    const/16 v2, 0xb

    const/4 v3, 0x1

    const-string v0, ""

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->k(Lcom/payeco/android/plugin/d/a;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-lt v0, v2, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "payeco_keyboard_red_bg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->l(Lcom/payeco/android/plugin/d/a;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "\u8bf7\u70b9\u51fb\u8f93\u5165\u6709\u6548\u671f"

    invoke-static {v0, v1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ge v0, v2, :cond_2

    const-string v0, ""

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, ""

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->f(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "payeco_keyboard_red_bg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->l(Lcom/payeco/android/plugin/d/a;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    const-string v1, "\u8bf7\u8f93\u5165\u6709\u6548\u671f"

    invoke-static {v0, v1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->d(Lcom/payeco/android/plugin/d/a;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->n(Lcom/payeco/android/plugin/d/a;)I

    move-result v2

    if-ge v1, v2, :cond_3

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "CVN\u4f4d\u6570\u4e0d\u5b9c\u5c0f\u4e8e"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->n(Lcom/payeco/android/plugin/d/a;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\u4f4d"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "payeco_keyboard_red_bg"

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/d/a;->a(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0, v3}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Z)V

    goto/16 :goto_0

    :cond_3
    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-virtual {v1}, Lcom/payeco/android/plugin/d/a;->dismiss()V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->o(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/d/l;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->o(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/d/l;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->f(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/payeco/android/plugin/d/j;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v3}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3, v0}, Lcom/payeco/android/plugin/d/l;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0
.end method
