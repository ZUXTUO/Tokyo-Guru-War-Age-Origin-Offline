.class public final Lcom/payeco/android/plugin/d/aa;
.super Landroid/app/Dialog;


# static fields
.field private static a:Lcom/payeco/android/plugin/d/aa;


# instance fields
.field private b:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroid/content/Context;I)V
    .locals 4

    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    const-string v0, "payeco_plugin_wait_dialog"

    invoke-static {p1, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    const-string v0, "payeco_waitHttpResDialog"

    const-string v2, "id"

    invoke-static {p1, v0, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    const-string v2, "payeco_loading_text"

    const-string v3, "id"

    invoke-static {p1, v2, v3}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/payeco/android/plugin/d/aa;->b:Landroid/widget/TextView;

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/d/aa;->setContentView(Landroid/view/View;)V

    return-void
.end method

.method public static a()V
    .locals 2

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/aa;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/aa;->dismiss()V

    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    const-string v0, "payeco"

    const-string v1, "ProgressDialog -close"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 3

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/aa;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    if-nez v0, :cond_1

    new-instance v0, Lcom/payeco/android/plugin/d/aa;

    const-string v1, "payeco_fullHeightDialog"

    const-string v2, "style"

    invoke-static {p0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-direct {v0, p0, v1}, Lcom/payeco/android/plugin/d/aa;-><init>(Landroid/content/Context;I)V

    sput-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    :cond_1
    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    iget-object v0, v0, Lcom/payeco/android/plugin/d/aa;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    invoke-virtual {v0, p2}, Lcom/payeco/android/plugin/d/aa;->setCancelable(Z)V

    sget-object v0, Lcom/payeco/android/plugin/d/aa;->a:Lcom/payeco/android/plugin/d/aa;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/aa;->show()V

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ProgressDialog -show "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " -cancelFlag="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
