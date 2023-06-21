.class final Lcom/payeco/android/plugin/d/g;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/app/DatePickerDialog$OnDateSetListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/a;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/a;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onDateSet(Landroid/widget/DatePicker;III)V
    .locals 5

    const/4 v4, 0x1

    const/4 v3, 0x2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0, v4, p2}, Ljava/util/Calendar;->set(II)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0, v3, p3}, Ljava/util/Calendar;->set(II)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v0

    const/4 v1, 0x5

    invoke-virtual {v0, v1, p4}, Ljava/util/Calendar;->set(II)V

    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/util/Calendar;->get(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\u6708 / "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u5e74"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->k(Lcom/payeco/android/plugin/d/a;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/util/Calendar;->get(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0xa

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "0"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v2}, Lcom/payeco/android/plugin/d/a;->h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/g;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v1}, Lcom/payeco/android/plugin/d/a;->j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/payeco/android/plugin/d/a;->a(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V

    return-void
.end method
