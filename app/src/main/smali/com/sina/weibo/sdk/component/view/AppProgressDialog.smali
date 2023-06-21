.class public Lcom/sina/weibo/sdk/component/view/AppProgressDialog;
.super Landroid/app/Dialog;
.source "AppProgressDialog.java"


# instance fields
.field private info:Landroid/widget/TextView;

.field private myBar:Landroid/widget/ProgressBar;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/16 v5, 0x64

    const/4 v6, 0x0

    const/16 v8, 0x14

    const/4 v7, -0x2

    .line 19
    invoke-direct {p0, p1}, Landroid/app/Dialog;-><init>(Landroid/content/Context;)V

    .line 20
    invoke-virtual {p0, v6}, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->setCanceledOnTouchOutside(Z)V

    .line 21
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 22
    .local v0, "lly":Landroid/widget/LinearLayout;
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    .line 23
    invoke-static {p1, v5}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v4

    invoke-static {p1, v5}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v5

    .line 22
    invoke-direct {v2, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 24
    .local v2, "mllypram":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 25
    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 26
    const/16 v4, 0x11

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 27
    const/4 v4, -0x1

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 28
    new-instance v4, Landroid/widget/ProgressBar;

    invoke-direct {v4, p1}, Landroid/widget/ProgressBar;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->myBar:Landroid/widget/ProgressBar;

    .line 32
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 34
    .local v3, "myBarPram":Landroid/widget/LinearLayout$LayoutParams;
    invoke-static {p1, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v4

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 35
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->myBar:Landroid/widget/ProgressBar;

    invoke-virtual {v4, v3}, Landroid/widget/ProgressBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 37
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->myBar:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 38
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    .line 40
    const-string v4, "\u63d0\u793a"

    invoke-virtual {p0, v4}, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 42
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    const/4 v5, 0x2

    const/high16 v6, 0x41880000    # 17.0f

    invoke-virtual {v4, v5, v6}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 43
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    const-string v5, "\u6b63\u5728\u5904\u7406..."

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 44
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    const v5, -0xadadae

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 45
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    const/16 v5, 0x10

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 46
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 48
    .local v1, "minfoPram":Landroid/widget/LinearLayout$LayoutParams;
    invoke-static {p1, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 49
    invoke-static {p1, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 51
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 52
    iget-object v4, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 53
    invoke-virtual {p0, v0}, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->setContentView(Landroid/view/View;)V

    .line 54
    return-void
.end method


# virtual methods
.method public setMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/AppProgressDialog;->info:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 58
    return-void
.end method
