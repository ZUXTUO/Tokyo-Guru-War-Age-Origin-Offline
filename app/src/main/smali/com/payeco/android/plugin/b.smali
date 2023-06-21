.class final Lcom/payeco/android/plugin/b;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/hardware/Camera$AutoFocusCallback;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/a;

.field private final synthetic b:Landroid/widget/Button;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/a;Landroid/widget/Button;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/b;->a:Lcom/payeco/android/plugin/a;

    iput-object p2, p0, Lcom/payeco/android/plugin/b;->b:Landroid/widget/Button;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/b;)Lcom/payeco/android/plugin/a;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/b;->a:Lcom/payeco/android/plugin/a;

    return-object v0
.end method


# virtual methods
.method public final onAutoFocus(ZLandroid/hardware/Camera;)V
    .locals 4

    iget-object v0, p0, Lcom/payeco/android/plugin/b;->a:Lcom/payeco/android/plugin/a;

    invoke-static {v0}, Lcom/payeco/android/plugin/a;->a(Lcom/payeco/android/plugin/a;)Lcom/payeco/android/plugin/PayecoCameraActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoCameraActivity;->a(Lcom/payeco/android/plugin/PayecoCameraActivity;)Landroid/hardware/Camera;

    move-result-object v0

    new-instance v1, Lcom/payeco/android/plugin/c;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/c;-><init>(Lcom/payeco/android/plugin/b;)V

    new-instance v2, Lcom/payeco/android/plugin/d;

    invoke-direct {v2, p0}, Lcom/payeco/android/plugin/d;-><init>(Lcom/payeco/android/plugin/b;)V

    new-instance v3, Lcom/payeco/android/plugin/e;

    invoke-direct {v3, p0}, Lcom/payeco/android/plugin/e;-><init>(Lcom/payeco/android/plugin/b;)V

    invoke-virtual {v0, v1, v2, v3}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/b;->b:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    return-void
.end method
