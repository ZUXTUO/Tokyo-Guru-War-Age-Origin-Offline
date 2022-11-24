.class public Lcom/digital/cloud/usercenter/toolbar/FloatButton;
.super Landroid/widget/ImageView;
.source "FloatButton.java"


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ClickableViewAccessibility"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;,
        Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;,
        Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;
    }
.end annotation


# instance fields
.field private mButtonOn:Z

.field private mCoordinateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

.field private mFloatButtonOnMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

.field private mIsonClickEnable:Z

.field private mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

.field private mStartX:F

.field private mStartY:F

.field private mTouchStartX:F

.field private mTouchStartY:F

.field private x:F

.field private y:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .line 34
    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 17
    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mCoordinateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    .line 18
    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

    .line 19
    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mFloatButtonOnMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mButtonOn:Z

    .line 21
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mIsonClickEnable:Z

    .line 35
    return-void
.end method


# virtual methods
.method public onClickEnable(Z)V
    .locals 0
    .param p1, "enable"    # Z

    .prologue
    .line 44
    iput-boolean p1, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mIsonClickEnable:Z

    .line 45
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v3, 0x1

    const/high16 v7, 0x40a00000    # 5.0f

    .line 49
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v2

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    .line 50
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v2

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    .line 51
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 76
    :goto_0
    return v3

    .line 53
    :pswitch_0
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mTouchStartX:F

    .line 54
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mTouchStartY:F

    .line 55
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartX:F

    .line 56
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartY:F

    goto :goto_0

    .line 59
    :pswitch_1
    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mCoordinateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iget v5, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartX:F

    sub-float/2addr v4, v5

    iget v5, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iget v6, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartY:F

    sub-float/2addr v5, v6

    invoke-interface {v2, v4, v5}, Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;->Update(FF)V

    .line 60
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartX:F

    .line 61
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iput v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartY:F

    goto :goto_0

    .line 65
    :pswitch_2
    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mCoordinateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iget v5, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartX:F

    sub-float/2addr v4, v5

    iget v5, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iget v6, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mStartY:F

    sub-float/2addr v5, v6

    invoke-interface {v2, v4, v5}, Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;->Update(FF)V

    .line 66
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mTouchStartX:F

    sub-float/2addr v2, v4

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v0

    .line 67
    .local v0, "offsetX":F
    iget v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mTouchStartY:F

    sub-float/2addr v2, v4

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v1

    .line 68
    .local v1, "offsetY":F
    iget-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mIsonClickEnable:Z

    if-eqz v2, :cond_0

    cmpg-float v2, v0, v7

    if-gez v2, :cond_0

    cmpg-float v2, v1, v7

    if-gez v2, :cond_0

    .line 69
    iget-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mButtonOn:Z

    if-eqz v2, :cond_1

    const/4 v2, 0x0

    :goto_1
    iput-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mButtonOn:Z

    .line 70
    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

    iget-boolean v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mButtonOn:Z

    invoke-interface {v2, v4}, Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;->Finish(Z)V

    .line 72
    :cond_0
    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mFloatButtonOnMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->x:F

    iget v5, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->y:F

    invoke-interface {v2, v4, v5}, Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;->Finish(FF)V

    goto :goto_0

    :cond_1
    move v2, v3

    .line 69
    goto :goto_1

    .line 51
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public setUpdateListener(Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;)V
    .locals 0
    .param p1, "coordinateListener"    # Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;
    .param p2, "onClickListener"    # Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;
    .param p3, "onMoveEndListener"    # Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    .prologue
    .line 38
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mCoordinateListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;

    .line 39
    iput-object p2, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mOnClickListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;

    .line 40
    iput-object p3, p0, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->mFloatButtonOnMoveEndListener:Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;

    .line 41
    return-void
.end method
