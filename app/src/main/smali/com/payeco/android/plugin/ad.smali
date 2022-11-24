.class final Lcom/payeco/android/plugin/ad;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoVedioActivity;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/ad;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/ad;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/PayecoVedioActivity;->setResult(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/ad;->a:Lcom/payeco/android/plugin/PayecoVedioActivity;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->finish()V

    return-void
.end method
