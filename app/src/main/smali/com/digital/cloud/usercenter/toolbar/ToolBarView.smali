.class public Lcom/digital/cloud/usercenter/toolbar/ToolBarView;
.super Landroid/widget/RelativeLayout;
.source "ToolBarView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/toolbar/ToolBarView$FloatViewOnClickCallback;
    }
.end annotation


# static fields
.field public static ToolBarViewHeight:I

.field public static ToolBarViewWidth:I


# instance fields
.field private hideAnimator:Landroid/animation/ValueAnimator;

.field private mContext:Landroid/app/Activity;

.field mCoordinateUpdateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

.field private mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

.field private mFBBG:Landroid/widget/ImageView;

.field private mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

.field private mFBBG_delayed:I

.field private mFBBG_height:I

.field private mFBBG_heightAdd:I

.field private mFBBG_scaleOffset:I

.field private mFBBG_time:I

.field private mFBBG_width:I

.field private mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

.field private mFB_height:I

.field private mFB_width:I

.field private mIsExit:Z

.field private mIsToolBarOn:Z

.field private mItem_baseSpace:I

.field mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

.field private mShowItems:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private mThis:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

.field private mToolBarTimer:Landroid/os/CountDownTimer;

.field private mWindowManager:Landroid/view/WindowManager;

.field private mWmParams:Landroid/view/WindowManager$LayoutParams;

.field private mitem_height:I

.field private mitem_width:I

.field onMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 31
    const/16 v0, 0x33

    sput v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewWidth:I

    .line 32
    const/16 v0, 0x2d

    sput v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewHeight:I

    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;)V
    .locals 6
    .param p1, "context"    # Landroid/app/Activity;

    .prologue
    const/16 v5, 0x3c

    const/16 v4, 0x23

    const/4 v3, 0x0

    const/16 v2, 0x28

    const/4 v1, 0x0

    .line 68
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 34
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    .line 35
    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_width:I

    .line 36
    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_height:I

    .line 37
    const/4 v0, 0x7

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_scaleOffset:I

    .line 38
    iput v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_delayed:I

    .line 39
    iput v5, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_heightAdd:I

    .line 40
    const/16 v0, 0x190

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_time:I

    .line 41
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    .line 43
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    .line 44
    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_width:I

    .line 45
    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_height:I

    .line 46
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

    .line 48
    iput v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mitem_width:I

    .line 49
    iput v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mitem_height:I

    .line 50
    iput v5, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mItem_baseSpace:I

    .line 51
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    .line 52
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    .line 53
    iput-boolean v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsToolBarOn:Z

    .line 54
    iput-boolean v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsExit:Z

    .line 56
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    .line 58
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    .line 59
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    .line 61
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    .line 483
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mCoordinateUpdateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    .line 493
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

    .line 505
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->onMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    .line 69
    iput-object p0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mThis:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 70
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    .line 72
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->initFBBG()V

    .line 73
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->initFB()V

    .line 74
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    .line 75
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    .line 76
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    .line 77
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d3

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 82
    :goto_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 83
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const v1, 0x40228

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 87
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 89
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x33

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 90
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, -0x14

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 91
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0xc8

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 92
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    sget v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewWidth:I

    int-to-float v2, v2

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 93
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    sget v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewHeight:I

    int-to-float v2, v2

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 94
    return-void

    .line 79
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 531
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->updateLayout()V

    return-void
.end method

.method static synthetic access$10(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/ImageView;
    .locals 1

    .prologue
    .line 34
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$11(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I
    .locals 1

    .prologue
    .line 38
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_delayed:I

    return v0
.end method

.method static synthetic access$12(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/RelativeLayout$LayoutParams;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    return-object v0
.end method

.method static synthetic access$13(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I
    .locals 1

    .prologue
    .line 44
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_width:I

    return v0
.end method

.method static synthetic access$14(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I
    .locals 1

    .prologue
    .line 39
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_heightAdd:I

    return v0
.end method

.method static synthetic access$15(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I
    .locals 1

    .prologue
    .line 35
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_width:I

    return v0
.end method

.method static synthetic access$16(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    return-object v0
.end method

.method static synthetic access$18(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 295
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOffTimerStart()V

    return-void
.end method

.method static synthetic access$19(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Z
    .locals 1

    .prologue
    .line 54
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsExit:Z

    return v0
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Z
    .locals 1

    .prologue
    .line 53
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsToolBarOn:Z

    return v0
.end method

.method static synthetic access$20(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/ToolBarView;
    .locals 1

    .prologue
    .line 29
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mThis:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    return-object v0
.end method

.method static synthetic access$3(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 318
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOn()V

    return-void
.end method

.method static synthetic access$4(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 366
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOff()V

    return-void
.end method

.method static synthetic access$5(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager;
    .locals 1

    .prologue
    .line 52
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    return-object v0
.end method

.method static synthetic access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$7(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 429
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->halfHide()V

    return-void
.end method

.method static synthetic access$8(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 127
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->exit()V

    return-void
.end method

.method static synthetic access$9(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I
    .locals 1

    .prologue
    .line 37
    iget v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_scaleOffset:I

    return v0
.end method

.method private cancelHide()V
    .locals 1

    .prologue
    .line 424
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    if-eqz v0, :cond_0

    .line 425
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    .line 427
    :cond_0
    return-void
.end method

.method private exit()V
    .locals 1

    .prologue
    .line 128
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsExit:Z

    .line 129
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->close()V

    .line 130
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOff()V

    .line 131
    return-void
.end method

.method private getItemImageRes(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)I
    .locals 2
    .param p1, "type"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    .line 228
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_0

    .line 229
    const-string v0, "drawable"

    const-string v1, "user_center_bar_exit"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 242
    :goto_0
    return v0

    .line 230
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_1

    .line 231
    const-string v0, "drawable"

    const-string v1, "user_center_bar_call"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 232
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_2

    .line 233
    const-string v0, "drawable"

    const-string v1, "user_center_bar_shop"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 234
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_3

    .line 235
    const-string v0, "drawable"

    const-string v1, "user_center_bar_strategy"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 236
    :cond_3
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_4

    .line 237
    const-string v0, "drawable"

    const-string v1, "user_center_bar_info"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 238
    :cond_4
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_5

    .line 239
    const-string v0, "drawable"

    const-string v1, "user_center_bar_bind"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 242
    :cond_5
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getItemName(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)I
    .locals 2
    .param p1, "type"    # Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .prologue
    .line 247
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_0

    .line 248
    const-string v0, "string"

    const-string v1, "p_tool_bar_logout"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 261
    :goto_0
    return v0

    .line 249
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_1

    .line 250
    const-string v0, "string"

    const-string v1, "p_tool_bar_call"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 251
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_2

    .line 252
    const-string v0, "string"

    const-string v1, "p_tool_bar_shop"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 253
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_3

    .line 254
    const-string v0, "string"

    const-string v1, "p_tool_bar_guide"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 255
    :cond_3
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_4

    .line 256
    const-string v0, "string"

    const-string v1, "p_tool_bar_info"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 257
    :cond_4
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne p1, v0, :cond_5

    .line 258
    const-string v0, "string"

    const-string v1, "p_tool_bar_bind"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 261
    :cond_5
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private halfHide()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 430
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->cancelHide()V

    .line 431
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    if-nez v1, :cond_0

    .line 432
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    sget v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewWidth:I

    int-to-float v2, v2

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v1

    div-int/lit8 v0, v1, 0x2

    .line 433
    .local v0, "limit":I
    const/4 v1, 0x2

    new-array v1, v1, [I

    aput v3, v1, v3

    const/4 v2, 0x1

    aput v0, v1, v2

    invoke-static {v1}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v1

    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    .line 434
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    const-wide/16 v2, 0x3e8

    invoke-virtual {v1, v2, v3}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 435
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    const-wide/16 v2, 0xbb8

    invoke-virtual {v1, v2, v3}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 436
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    new-instance v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;

    invoke-direct {v2, p0, v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;I)V

    invoke-virtual {v1, v2}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 448
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    new-instance v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    invoke-virtual {v1, v2}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 475
    .end local v0    # "limit":I
    :cond_0
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    const/16 v2, -0x14

    if-lt v1, v2, :cond_1

    .line 476
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    const/high16 v2, 0x3f800000    # 1.0f

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 477
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->updateLayout()V

    .line 478
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hideAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v1}, Landroid/animation/ValueAnimator;->start()V

    .line 481
    :cond_1
    return-void
.end method

.method private initFB()V
    .locals 4

    .prologue
    .line 280
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_width:I

    int-to-float v1, v1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v0

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_width:I

    .line 281
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_height:I

    int-to-float v1, v1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v0

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_height:I

    .line 283
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    .line 284
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_width:I

    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB_height:I

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

    .line 285
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v1, 0xf

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 286
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v1, 0x14

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 288
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBLayout:Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 289
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->addView(Landroid/view/View;)V

    .line 290
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    const-string v1, "drawable"

    const-string v2, "user_center_tool_bar_icon"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setBackgroundResource(I)V

    .line 291
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mCoordinateUpdateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

    iget-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->onMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    invoke-virtual {v0, v1, v2, v3}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setUpdateListener(Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;)V

    .line 292
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->halfHide()V

    .line 293
    return-void
.end method

.method private initFBBG()V
    .locals 3

    .prologue
    .line 265
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_width:I

    int-to-float v1, v1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v0

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_width:I

    .line 266
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_height:I

    int-to-float v1, v1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v0

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_height:I

    .line 269
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_width:I

    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_height:I

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    .line 270
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v1, 0xf

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 271
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v1, 0x14

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 273
    new-instance v0, Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    .line 274
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBGLayout:Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 275
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    const-string v1, "drawable"

    const-string v2, "user_center_corners"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 276
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG:Landroid/widget/ImageView;

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->addView(Landroid/view/View;)V

    .line 277
    return-void
.end method

.method private toolBarOff()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 367
    iput-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsToolBarOn:Z

    .line 368
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    invoke-virtual {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->onClickEnable(Z)V

    .line 369
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOffTimerEnd()V

    .line 370
    const/4 v1, 0x2

    new-array v1, v1, [I

    aput v2, v1, v2

    const/4 v2, 0x1

    iget v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_scaleOffset:I

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_heightAdd:I

    add-int/2addr v3, v4

    aput v3, v1, v2

    invoke-static {v1}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v0

    .line 371
    .local v0, "anim":Landroid/animation/ValueAnimator;
    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_time:I

    int-to-long v2, v1

    invoke-virtual {v0, v2, v3}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 372
    new-instance v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$8;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$8;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 386
    new-instance v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 420
    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    .line 421
    return-void
.end method

.method private toolBarOffTimerEnd()V
    .locals 1

    .prologue
    .line 314
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_0

    .line 315
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 316
    :cond_0
    return-void
.end method

.method private toolBarOffTimerStart()V
    .locals 6

    .prologue
    .line 296
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    if-nez v0, :cond_0

    .line 297
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$5;

    const-wide/16 v2, 0xbb8

    const-wide/16 v4, 0x3e8

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$5;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;JJ)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    .line 310
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mToolBarTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 311
    return-void
.end method

.method private toolBarOn()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 319
    iput-boolean v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsToolBarOn:Z

    .line 320
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFB:Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    invoke-virtual {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->onClickEnable(Z)V

    .line 321
    const/4 v1, 0x2

    new-array v1, v1, [I

    aput v2, v1, v2

    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_scaleOffset:I

    iget v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_heightAdd:I

    add-int/2addr v2, v3

    aput v2, v1, v4

    invoke-static {v1}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v0

    .line 322
    .local v0, "anim":Landroid/animation/ValueAnimator;
    iget v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_time:I

    int-to-long v2, v1

    invoke-virtual {v0, v2, v3}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 323
    new-instance v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 337
    new-instance v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 363
    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    .line 364
    return-void
.end method

.method private updateLayout()V
    .locals 3

    .prologue
    .line 533
    :try_start_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mThis:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 537
    :goto_0
    return-void

    .line 534
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public addItems(Ljava/util/ArrayList;)V
    .locals 20
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 138
    .local p1, "items":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;>;"
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->size()I

    move-result v14

    if-lez v14, :cond_0

    .line 224
    :goto_0
    return-void

    .line 141
    :cond_0
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v14

    if-lt v4, v14, :cond_1

    .line 219
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_2
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-nez v15, :cond_3

    .line 223
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v15}, Ljava/util/ArrayList;->size()I

    move-result v15

    mul-int/lit8 v15, v15, 0x17

    add-int/lit8 v15, v15, 0x1c

    int-to-float v15, v15

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v14

    move-object/from16 v0, p0

    iput v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mFBBG_heightAdd:I

    goto :goto_0

    .line 143
    :cond_1
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    const-wide v16, 0x3fe851eb851eb852L    # 0.76

    move-object/from16 v0, p0

    iget v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mitem_height:I

    int-to-double v0, v15

    move-wide/from16 v18, v0

    mul-double v16, v16, v18

    move-wide/from16 v0, v16

    double-to-float v15, v0

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v13

    .line 144
    .local v13, "width":I
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    move-object/from16 v0, p0

    iget v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mitem_height:I

    int-to-float v15, v15

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v3

    .line 146
    .local v3, "height":I
    new-instance v9, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v9, v13, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 150
    .local v9, "layout":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v14, 0xf

    invoke-virtual {v9, v14}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 151
    iget v14, v9, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    const/high16 v16, 0x42340000    # 45.0f

    invoke-static/range {v15 .. v16}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v15

    mul-int/2addr v15, v4

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    move-object/from16 v16, v0

    move-object/from16 v0, p0

    iget v0, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mItem_baseSpace:I

    move/from16 v17, v0

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-static/range {v16 .. v17}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v16

    add-int v15, v15, v16

    add-int/2addr v14, v15

    iput v14, v9, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 152
    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 154
    .local v7, "itemType":Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    new-instance v12, Landroid/widget/RelativeLayout;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v12, v14}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 155
    .local v12, "view":Landroid/widget/RelativeLayout;
    invoke-virtual {v12, v9}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 157
    new-instance v8, Landroid/widget/ImageView;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v8, v14}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 158
    .local v8, "itemView":Landroid/widget/ImageView;
    new-instance v5, Landroid/widget/RelativeLayout$LayoutParams;

    int-to-double v14, v3

    const-wide v16, 0x3fe6666666666666L    # 0.7

    mul-double v14, v14, v16

    double-to-int v14, v14

    invoke-direct {v5, v13, v14}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 160
    .local v5, "imageLayout":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v14, 0xe

    invoke-virtual {v5, v14}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 161
    const/16 v14, 0xa

    const/4 v15, -0x1

    invoke-virtual {v5, v14, v15}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 162
    invoke-virtual {v8, v5}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 163
    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->getItemImageRes(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)I

    move-result v14

    invoke-virtual {v8, v14}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 164
    new-instance v14, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;

    move-object/from16 v0, p0

    invoke-direct {v14, v0, v7}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    invoke-virtual {v12, v14}, Landroid/widget/RelativeLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 186
    invoke-virtual {v12, v8}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 188
    new-instance v11, Landroid/widget/RelativeLayout$LayoutParams;

    int-to-double v14, v3

    const-wide v16, 0x3fd3333333333333L    # 0.3

    mul-double v14, v14, v16

    double-to-int v14, v14

    invoke-direct {v11, v13, v14}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 189
    .local v11, "textlayout":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v14, 0xc

    const/4 v15, -0x1

    invoke-virtual {v11, v14, v15}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 190
    const/16 v14, 0xe

    invoke-virtual {v11, v14}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 191
    new-instance v10, Landroid/widget/TextView;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v10, v14}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 192
    .local v10, "text":Landroid/widget/TextView;
    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->getItemName(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)I

    move-result v14

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setText(I)V

    .line 193
    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 194
    const/high16 v14, 0x41000000    # 8.0f

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTextSize(F)V

    .line 195
    const-string v14, "text_color_default"

    invoke-static {v14}, Lcom/digital/cloud/usercenter/ResID;->getColor(Ljava/lang/String;)I

    move-result v14

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 196
    const/16 v14, 0x11

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setGravity(I)V

    .line 197
    invoke-virtual {v12, v10}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 198
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v14, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 202
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v14

    add-int/lit8 v14, v14, -0x1

    if-ge v4, v14, :cond_2

    .line 203
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    const/high16 v15, 0x3f800000    # 1.0f

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v13

    .line 204
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    move-object/from16 v0, p0

    iget v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mitem_height:I

    add-int/lit8 v15, v15, -0x2

    int-to-float v15, v15

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v3

    .line 206
    new-instance v9, Landroid/widget/RelativeLayout$LayoutParams;

    .end local v9    # "layout":Landroid/widget/RelativeLayout$LayoutParams;
    invoke-direct {v9, v13, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 207
    .restart local v9    # "layout":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v14, 0xf

    invoke-virtual {v9, v14}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 208
    iget v14, v9, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    const/high16 v16, 0x42340000    # 45.0f

    invoke-static/range {v15 .. v16}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v15

    mul-int/2addr v15, v4

    .line 209
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    move-object/from16 v16, v0

    move-object/from16 v0, p0

    iget v0, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mItem_baseSpace:I

    move/from16 v17, v0

    add-int/lit8 v17, v17, 0x23

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-static/range {v16 .. v17}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v16

    .line 208
    add-int v15, v15, v16

    add-int/2addr v14, v15

    iput v14, v9, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 210
    new-instance v2, Landroid/widget/ImageView;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mContext:Landroid/app/Activity;

    invoke-direct {v2, v14}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 211
    .local v2, "barLine":Landroid/widget/ImageView;
    invoke-virtual {v2, v9}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 212
    const-string v14, "drawable"

    const-string v15, "user_center_bar_line_v"

    invoke-static {v14, v15}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v14

    invoke-virtual {v2, v14}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 213
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v14, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 141
    .end local v2    # "barLine":Landroid/widget/ImageView;
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_1

    .line 219
    .end local v3    # "height":I
    .end local v5    # "imageLayout":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v7    # "itemType":Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    .end local v8    # "itemView":Landroid/widget/ImageView;
    .end local v9    # "layout":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v10    # "text":Landroid/widget/TextView;
    .end local v11    # "textlayout":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v12    # "view":Landroid/widget/RelativeLayout;
    .end local v13    # "width":I
    :cond_3
    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/View;

    .line 220
    .local v6, "item":Landroid/view/View;
    const/16 v15, 0x8

    invoke-virtual {v6, v15}, Landroid/view/View;->setVisibility(I)V

    .line 221
    move-object/from16 v0, p0

    invoke-virtual {v0, v6}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->addView(Landroid/view/View;)V

    goto/16 :goto_2
.end method

.method public getWinParams()Landroid/view/WindowManager$LayoutParams;
    .locals 1

    .prologue
    .line 134
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method public hide()V
    .locals 4

    .prologue
    .line 111
    iget-boolean v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsExit:Z

    if-eqz v1, :cond_0

    .line 125
    :goto_0
    return-void

    .line 117
    :cond_0
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOffTimerEnd()V

    .line 118
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->cancelHide()V

    .line 120
    :try_start_0
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    invoke-interface {v1, p0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 121
    :catch_0
    move-exception v0

    .line 123
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "show "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public show()V
    .locals 4

    .prologue
    .line 97
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsExit:Z

    .line 99
    :try_start_0
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWindowManager:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mWmParams:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v1, p0, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 100
    iget-boolean v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->mIsToolBarOn:Z

    if-eqz v1, :cond_0

    .line 101
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOff()V

    .line 103
    :cond_0
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->halfHide()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 108
    :goto_0
    return-void

    .line 104
    :catch_0
    move-exception v0

    .line 106
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "show "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
