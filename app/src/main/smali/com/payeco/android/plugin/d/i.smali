.class final Lcom/payeco/android/plugin/d/i;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/a;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/a;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/i;->a:Lcom/payeco/android/plugin/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/i;->a:Lcom/payeco/android/plugin/d/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/d/a;->d(Lcom/payeco/android/plugin/d/a;)Landroid/widget/EditText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void
.end method
