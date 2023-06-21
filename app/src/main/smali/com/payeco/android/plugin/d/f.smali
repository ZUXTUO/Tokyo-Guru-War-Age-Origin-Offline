.class final Lcom/payeco/android/plugin/d/f;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/d;

.field private final synthetic b:Landroid/widget/ArrayAdapter;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/d;Landroid/widget/ArrayAdapter;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/f;->b:Landroid/widget/ArrayAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 4

    iget-object v0, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v1, v0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/f;->b:Landroid/widget/ArrayAdapter;

    invoke-virtual {v0, p3}, Landroid/widget/ArrayAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v2, "\u6708"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v0, v0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0xa

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v0, v0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "0"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v2, v2, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    :cond_0
    const-string v0, "spinner"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u5f53\u524d\u6708\u4efd\u9009\u5219\uff1a"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v2, v2, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public final onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/f;->a:Lcom/payeco/android/plugin/d/d;

    iget-object v0, v0, Lcom/payeco/android/plugin/d/d;->a:Lcom/payeco/android/plugin/d/a;

    const-string v1, ""

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    return-void
.end method
