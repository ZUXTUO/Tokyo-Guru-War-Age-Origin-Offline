.class final Lcom/payeco/android/plugin/d/d;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/a;

.field private final synthetic b:Landroid/widget/ArrayAdapter;

.field private final synthetic c:Landroid/widget/Spinner;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/a;Landroid/widget/ArrayAdapter;Landroid/widget/Spinner;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/d;->b:Landroid/widget/ArrayAdapter;

    iput-object p3, p0, Lcom/payeco/android/plugin/d/d;->c:Landroid/widget/Spinner;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6

    const v5, 0x1090009

    const v4, 0x1090008

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/d;->b:Landroid/widget/ArrayAdapter;

    invoke-virtual {v0, p3}, Landroid/widget/ArrayAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v2, "\u5e74"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    const-string v0, "spinner"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u5e74\u4efd\u9009\u5219\uff1a"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->f(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p3, :cond_0

    new-instance v0, Landroid/widget/ArrayAdapter;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->g(Lcom/payeco/android/plugin/d/a;)Ljava/util/List;

    move-result-object v2

    invoke-direct {v0, v1, v4, v2}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    invoke-virtual {v0, v5}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->c:Landroid/widget/Spinner;

    invoke-virtual {v1, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->c:Landroid/widget/Spinner;

    new-instance v2, Lcom/payeco/android/plugin/d/e;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/e;-><init>(Lcom/payeco/android/plugin/d/d;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v1, v2}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    :goto_0
    return-void

    :cond_0
    new-instance v0, Landroid/widget/ArrayAdapter;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->i(Lcom/payeco/android/plugin/d/a;)Ljava/util/List;

    move-result-object v2

    invoke-direct {v0, v1, v4, v2}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    invoke-virtual {v0, v5}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->c:Landroid/widget/Spinner;

    invoke-virtual {v1, v0}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/d;->c:Landroid/widget/Spinner;

    new-instance v2, Lcom/payeco/android/plugin/d/f;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/f;-><init>(Lcom/payeco/android/plugin/d/d;Landroid/widget/ArrayAdapter;)V

    invoke-virtual {v1, v2}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    goto :goto_0
.end method

.method public final onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    const-string v1, ""

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    return-void
.end method
