.class final Lcom/payeco/android/plugin/d/q;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/n;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/n;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->h(Lcom/payeco/android/plugin/d/n;)I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->e(Lcom/payeco/android/plugin/d/n;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " "

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->h(Lcom/payeco/android/plugin/d/n;)I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u8f93\u5165\u4f4d\u6570\u5c11\u4e8e"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->h(Lcom/payeco/android/plugin/d/n;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\u4f4d\u6570"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->h(Lcom/payeco/android/plugin/d/n;)I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u8f93\u5165\u4f4d\u6570\u5c11\u4e8e"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/n;->h(Lcom/payeco/android/plugin/d/n;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\u4f4d\u6570"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/n;->b(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/n;->i(Lcom/payeco/android/plugin/d/n;)Lcom/payeco/android/plugin/d/s;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/n;->f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/payeco/android/plugin/d/s;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/q;->a:Lcom/payeco/android/plugin/d/n;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/n;->dismiss()V

    goto :goto_0
.end method
