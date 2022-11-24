.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnMoveEndListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 505
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public Finish(FF)V
    .locals 7
    .param p1, "x"    # F
    .param p2, "y"    # F
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    .line 511
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    const/16 v5, -0x14

    iput v5, v4, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 512
    new-instance v2, Landroid/graphics/Point;

    invoke-direct {v2}, Landroid/graphics/Point;-><init>()V

    .line 513
    .local v2, "size":Landroid/graphics/Point;
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x11

    if-lt v4, v5, :cond_0

    .line 514
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$5(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 519
    :goto_0
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v4

    sget v5, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewHeight:I

    int-to-float v5, v5

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v0

    .line 520
    .local v0, "height":I
    const/4 v4, 0x2

    new-array v3, v4, [I

    .line 521
    .local v3, "sl":[I
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-virtual {v4, v3}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->getLocationOnScreen([I)V

    .line 522
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    const/4 v5, 0x1

    aget v5, v3, v5

    sub-int v1, v4, v5

    .line 524
    .local v1, "offset":I
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v5

    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    if-ge v4, v1, :cond_1

    move v4, v1

    :goto_1
    iput v4, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 525
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v5

    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    iget v6, v2, Landroid/graphics/Point;->y:I

    sub-int/2addr v6, v0

    add-int/2addr v6, v1

    if-le v4, v6, :cond_2

    iget v4, v2, Landroid/graphics/Point;->y:I

    sub-int/2addr v4, v0

    add-int/2addr v4, v1

    :goto_2
    iput v4, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 526
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 527
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$7(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 528
    return-void

    .line 516
    .end local v0    # "height":I
    .end local v1    # "offset":I
    .end local v3    # "sl":[I
    :cond_0
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$5(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    goto :goto_0

    .line 524
    .restart local v0    # "height":I
    .restart local v1    # "offset":I
    .restart local v3    # "sl":[I
    :cond_1
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_1

    .line 525
    :cond_2
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$3;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v4

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_2
.end method
