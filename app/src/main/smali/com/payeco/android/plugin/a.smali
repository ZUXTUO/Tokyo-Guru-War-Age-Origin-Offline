.class final Lcom/payeco/android/plugin/a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoCameraActivity;

.field private final synthetic b:Landroid/widget/Button;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoCameraActivity;Landroid/widget/Button;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/a;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    iput-object p2, p0, Lcom/payeco/android/plugin/a;->b:Landroid/widget/Button;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/a;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    return-object v0
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/a;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "\u6b63\u5728\u805a\u7126,\u8bf7\u7a0d\u7b49..."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-object v0, p0, Lcom/payeco/android/plugin/a;->b:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/a;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->a(Lcom/payeco/android/plugin/PayecoCameraActivity;)Landroid/hardware/Camera;

    move-result-object v0

    new-instance v1, Lcom/payeco/android/plugin/b;

    iget-object v2, p0, Lcom/payeco/android/plugin/a;->b:Landroid/widget/Button;

    invoke-direct {v1, p0, v2}, Lcom/payeco/android/plugin/b;-><init>(Lcom/payeco/android/plugin/a;Landroid/widget/Button;)V

    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->autoFocus(Landroid/hardware/Camera$AutoFocusCallback;)V

    return-void
.end method
