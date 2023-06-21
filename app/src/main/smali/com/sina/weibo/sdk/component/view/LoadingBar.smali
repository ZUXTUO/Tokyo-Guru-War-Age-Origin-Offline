.class public Lcom/sina/weibo/sdk/component/view/LoadingBar;
.super Landroid/widget/TextView;
.source "LoadingBar.java"


# static fields
.field private static final MAX_PROGRESS:I = 0x64


# instance fields
.field private mHander:Landroid/os/Handler;

.field private mPaint:Landroid/graphics/Paint;

.field private mProgress:I

.field private mProgressColor:I

.field private mRunnable:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 19
    invoke-direct {p0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 60
    new-instance v0, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;

    invoke-direct {v0, p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;-><init>(Lcom/sina/weibo/sdk/component/view/LoadingBar;)V

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mRunnable:Ljava/lang/Runnable;

    .line 20
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->init(Landroid/content/Context;)V

    .line 21
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 24
    invoke-direct {p0, p1, p2}, Landroid/widget/TextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 60
    new-instance v0, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;

    invoke-direct {v0, p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;-><init>(Lcom/sina/weibo/sdk/component/view/LoadingBar;)V

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mRunnable:Ljava/lang/Runnable;

    .line 25
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->init(Landroid/content/Context;)V

    .line 26
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    .line 29
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 60
    new-instance v0, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;

    invoke-direct {v0, p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar$1;-><init>(Lcom/sina/weibo/sdk/component/view/LoadingBar;)V

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mRunnable:Ljava/lang/Runnable;

    .line 30
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->init(Landroid/content/Context;)V

    .line 31
    return-void
.end method

.method static synthetic access$0(Lcom/sina/weibo/sdk/component/view/LoadingBar;)I
    .locals 1

    .prologue
    .line 14
    iget v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgress:I

    return v0
.end method

.method static synthetic access$1(Lcom/sina/weibo/sdk/component/view/LoadingBar;I)V
    .locals 0

    .prologue
    .line 14
    iput p1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgress:I

    return-void
.end method

.method private getRect()Landroid/graphics/Rect;
    .locals 8

    .prologue
    const/4 v7, 0x0

    .line 52
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getLeft()I

    move-result v1

    .line 53
    .local v1, "left":I
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getTop()I

    move-result v3

    .line 54
    .local v3, "top":I
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getLeft()I

    move-result v4

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getRight()I

    move-result v5

    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getLeft()I

    move-result v6

    sub-int/2addr v5, v6

    iget v6, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgress:I

    mul-int/2addr v5, v6

    div-int/lit8 v5, v5, 0x64

    add-int v2, v4, v5

    .line 55
    .local v2, "right":I
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getBottom()I

    move-result v0

    .line 56
    .local v0, "bottom":I
    new-instance v4, Landroid/graphics/Rect;

    sub-int v5, v2, v1

    sub-int v6, v0, v3

    invoke-direct {v4, v7, v7, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v4
.end method

.method private init(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 34
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mHander:Landroid/os/Handler;

    .line 35
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mPaint:Landroid/graphics/Paint;

    .line 36
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->initSkin()V

    .line 37
    return-void
.end method


# virtual methods
.method public drawProgress(I)V
    .locals 4
    .param p1, "progress"    # I

    .prologue
    .line 70
    const/4 v0, 0x7

    if-ge p1, v0, :cond_0

    .line 71
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mHander:Landroid/os/Handler;

    iget-object v1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mRunnable:Ljava/lang/Runnable;

    const-wide/16 v2, 0x46

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 76
    :goto_0
    invoke-virtual {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->invalidate()V

    .line 77
    return-void

    .line 73
    :cond_0
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mHander:Landroid/os/Handler;

    iget-object v1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 74
    iput p1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgress:I

    goto :goto_0
.end method

.method public initSkin()V
    .locals 1

    .prologue
    .line 40
    const v0, -0xb26f02

    iput v0, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgressColor:I

    .line 41
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 3
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .prologue
    .line 45
    invoke-super {p0, p1}, Landroid/widget/TextView;->onDraw(Landroid/graphics/Canvas;)V

    .line 46
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mProgressColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 47
    invoke-direct {p0}, Lcom/sina/weibo/sdk/component/view/LoadingBar;->getRect()Landroid/graphics/Rect;

    move-result-object v0

    .line 48
    .local v0, "r":Landroid/graphics/Rect;
    iget-object v1, p0, Lcom/sina/weibo/sdk/component/view/LoadingBar;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 49
    return-void
.end method
