.class public Lcom/sina/weibo/sdk/component/view/TitleBar;
.super Landroid/widget/RelativeLayout;
.source "TitleBar.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;
    }
.end annotation


# static fields
.field public static final TITLE_BAR_HEIGHT:I = 0x2d


# instance fields
.field private mClickListener:Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;

.field private mLeftBtn:Landroid/widget/TextView;

.field private mTitleText:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 26
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 27
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->initViews()V

    .line 28
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 36
    invoke-direct {p0, p1, p2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 37
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->initViews()V

    .line 38
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    .line 31
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 32
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->initViews()V

    .line 33
    return-void
.end method

.method static synthetic access$0(Lcom/sina/weibo/sdk/component/view/TitleBar;)Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mClickListener:Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;

    return-object v0
.end method

.method private initViews()V
    .locals 9

    .prologue
    const/16 v8, 0xa

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, -0x2

    .line 41
    new-instance v2, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    .line 42
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    invoke-virtual {v2, v6}, Landroid/widget/TextView;->setClickable(Z)V

    .line 43
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    const/high16 v3, 0x41880000    # 17.0f

    invoke-virtual {v2, v7, v3}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 44
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    const/16 v3, -0x7e00

    const v4, 0x66ff8200

    invoke-static {v3, v4}, Lcom/sina/weibo/sdk/utils/ResourceManager;->createColorStateList(II)Landroid/content/res/ColorStateList;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    .line 45
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v0, v5, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 48
    .local v0, "leftBtnLp":Landroid/widget/RelativeLayout$LayoutParams;
    const/4 v2, 0x5

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 49
    const/16 v2, 0xf

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 50
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v2

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 51
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v2

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 52
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 53
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    new-instance v3, Lcom/sina/weibo/sdk/component/view/TitleBar$1;

    invoke-direct {v3, p0}, Lcom/sina/weibo/sdk/component/view/TitleBar$1;-><init>(Lcom/sina/weibo/sdk/component/view/TitleBar;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 61
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/component/view/TitleBar;->addView(Landroid/view/View;)V

    .line 63
    new-instance v2, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    .line 64
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    const/high16 v3, 0x41900000    # 18.0f

    invoke-virtual {v2, v7, v3}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 65
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    const v3, -0xadadae

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 66
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    sget-object v3, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 67
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    invoke-virtual {v2, v6}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 68
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 69
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v3

    const/16 v4, 0xa0

    invoke-static {v3, v4}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxWidth(I)V

    .line 70
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v1, v5, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 73
    .local v1, "titleTextLy":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v2, 0xd

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 74
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 75
    iget-object v2, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/component/view/TitleBar;->addView(Landroid/view/View;)V

    .line 77
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    .line 78
    const/4 v3, -0x1

    .line 79
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v4

    const/16 v5, 0x2d

    invoke-static {v4, v5}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 77
    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 81
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "weibosdk_navigationbar_background.9.png"

    .line 80
    invoke-static {v2, v3}, Lcom/sina/weibo/sdk/utils/ResourceManager;->getNinePatchDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 82
    return-void
.end method


# virtual methods
.method public setLeftBtnBg(Landroid/graphics/drawable/Drawable;)V
    .locals 1
    .param p1, "bgDrawable"    # Landroid/graphics/drawable/Drawable;

    .prologue
    .line 93
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 94
    return-void
.end method

.method public setLeftBtnText(Ljava/lang/String;)V
    .locals 1
    .param p1, "left"    # Ljava/lang/String;

    .prologue
    .line 89
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mLeftBtn:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 90
    return-void
.end method

.method public setTitleBarClickListener(Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;)V
    .locals 0
    .param p1, "listener"    # Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;

    .prologue
    .line 97
    iput-object p1, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mClickListener:Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;

    .line 98
    return-void
.end method

.method public setTitleBarText(Ljava/lang/String;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;

    .prologue
    .line 85
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/TitleBar;->mTitleText:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 86
    return-void
.end method
