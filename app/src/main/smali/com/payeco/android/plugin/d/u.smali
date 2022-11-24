.class final Lcom/payeco/android/plugin/d/u;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/t;

.field private final synthetic b:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/u;->a:Lcom/payeco/android/plugin/d/t;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/u;->b:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/u;->b:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void
.end method
