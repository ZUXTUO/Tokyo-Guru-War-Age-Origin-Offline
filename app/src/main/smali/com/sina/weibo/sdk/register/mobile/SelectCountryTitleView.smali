.class public Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;
.super Landroid/widget/RelativeLayout;
.source "SelectCountryTitleView.java"


# instance fields
.field private mTitleTv:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 15
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 16
    invoke-direct {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->initView()V

    .line 17
    return-void
.end method

.method private initView()V
    .locals 6

    .prologue
    const/4 v5, -0x2

    .line 21
    new-instance v1, Landroid/widget/AbsListView$LayoutParams;

    const/4 v2, -0x1

    .line 22
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->getContext()Landroid/content/Context;

    move-result-object v3

    const/16 v4, 0x18

    invoke-static {v3, v4}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v3

    .line 21
    invoke-direct {v1, v2, v3}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    .line 23
    .local v1, "mlly":Landroid/widget/AbsListView$LayoutParams;
    invoke-virtual {p0, v1}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 24
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 25
    const-string v3, "tableview_sectionheader_background.png"

    .line 24
    invoke-static {v2, v3}, Lcom/sina/weibo/sdk/utils/ResourceManager;->getDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 26
    new-instance v2, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    .line 27
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 28
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v0, v5, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 30
    .local v0, "mTitleTvLp":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v2, 0xf

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 31
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->getContext()Landroid/content/Context;

    move-result-object v2

    const/16 v3, 0xa

    invoke-static {v2, v3}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v2

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 32
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 33
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    const/4 v3, 0x3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 34
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    const v3, -0x6d6d6e

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 35
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    const/16 v3, 0x10

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 36
    iget-object v2, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->addView(Landroid/view/View;)V

    .line 38
    return-void
.end method


# virtual methods
.method public setTitle(Ljava/lang/String;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;

    .prologue
    .line 41
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->mTitleTv:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 42
    return-void
.end method

.method public update(Ljava/lang/String;)V
    .locals 0
    .param p1, "title"    # Ljava/lang/String;

    .prologue
    .line 44
    invoke-virtual {p0, p1}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryTitleView;->setTitle(Ljava/lang/String;)V

    .line 45
    return-void
.end method
