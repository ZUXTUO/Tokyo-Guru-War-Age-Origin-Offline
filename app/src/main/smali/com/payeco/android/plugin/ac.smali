.class final Lcom/payeco/android/plugin/ac;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoVedioActivity;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/ac;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -btnFinish onClick"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/payeco/android/plugin/ac;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    iget-object v0, p0, Lcom/payeco/android/plugin/ac;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->i(Lcom/payeco/android/plugin/PayecoVedioActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, -0x1

    :goto_0
    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->setResult(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/ac;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->finish()V

    return-void

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method
