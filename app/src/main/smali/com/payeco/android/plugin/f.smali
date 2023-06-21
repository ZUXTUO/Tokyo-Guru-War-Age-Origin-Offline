.class final Lcom/payeco/android/plugin/f;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoCameraActivity;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoCameraActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/f;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/f;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/PayecoCameraActivity;->setResult(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/f;->a:Lcom/payeco/android/plugin/PayecoCameraActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->finish()V

    return-void
.end method
