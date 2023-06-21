.class final Lcom/payeco/android/plugin/d/x;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/d/t;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/d/t;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/x;->a:Lcom/payeco/android/plugin/d/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/x;->a:Lcom/payeco/android/plugin/d/t;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/t;->dismiss()V

    return-void
.end method
