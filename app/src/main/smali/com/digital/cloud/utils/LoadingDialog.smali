.class public Lcom/digital/cloud/utils/LoadingDialog;
.super Landroid/app/Dialog;
.source "LoadingDialog.java"


# direct methods
.method private constructor <init>(Landroid/content/Context;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "themeResId"    # I

    .prologue
    .line 14
    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 16
    return-void
.end method

.method public static create(Landroid/content/Context;)Lcom/digital/cloud/utils/LoadingDialog;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    .line 21
    new-instance v0, Lcom/digital/cloud/utils/LoadingDialog;

    const-string v1, "style"

    const-string v2, "LoadingDialog"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-direct {v0, p0, v1}, Lcom/digital/cloud/utils/LoadingDialog;-><init>(Landroid/content/Context;I)V

    .line 22
    .local v0, "loadingDialog":Lcom/digital/cloud/utils/LoadingDialog;
    invoke-virtual {v0, v3}, Lcom/digital/cloud/utils/LoadingDialog;->setCancelable(Z)V

    .line 23
    invoke-virtual {v0, v3}, Lcom/digital/cloud/utils/LoadingDialog;->setCanceledOnTouchOutside(Z)V

    .line 24
    const-string v1, "layout"

    const-string v2, "user_center_dialog_loading"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/utils/LoadingDialog;->setContentView(I)V

    .line 25
    invoke-virtual {v0}, Lcom/digital/cloud/utils/LoadingDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    const/16 v2, 0x11

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 26
    return-object v0
.end method


# virtual methods
.method public onWindowFocusChanged(Z)V
    .locals 4
    .param p1, "hasFocus"    # Z

    .prologue
    .line 32
    invoke-super {p0, p1}, Landroid/app/Dialog;->onWindowFocusChanged(Z)V

    .line 33
    const-string v2, "id"

    const-string v3, "loadingImageView"

    invoke-static {v2, v3}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/digital/cloud/utils/LoadingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    .line 34
    .local v1, "imageView":Landroid/widget/ImageView;
    invoke-virtual {v1}, Landroid/widget/ImageView;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/AnimationDrawable;

    .line 35
    .local v0, "animationDrawable":Landroid/graphics/drawable/AnimationDrawable;
    invoke-virtual {v0}, Landroid/graphics/drawable/AnimationDrawable;->start()V

    .line 36
    return-void
.end method
