.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOn()V
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 7
    .param p1, "arg0"    # Landroid/animation/ValueAnimator;

    .prologue
    const/high16 v6, 0x3f800000    # 1.0f

    const-wide v4, 0x3f847ae147ae147bL    # 0.01

    .line 327
    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 328
    .local v0, "frameValue":I
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$9(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v1

    if-gt v0, v1, :cond_1

    .line 329
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$10(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/ImageView;

    move-result-object v1

    int-to-double v2, v0

    mul-double/2addr v2, v4

    double-to-float v2, v2

    add-float/2addr v2, v6

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setScaleX(F)V

    .line 330
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$10(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/ImageView;

    move-result-object v1

    int-to-double v2, v0

    mul-double/2addr v2, v4

    double-to-float v2, v2

    add-float/2addr v2, v6

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setScaleY(F)V

    .line 335
    :cond_0
    :goto_0
    return-void

    .line 331
    :cond_1
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$9(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v1

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$11(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v2

    add-int/2addr v1, v2

    if-le v0, v1, :cond_0

    .line 332
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$12(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/RelativeLayout$LayoutParams;

    move-result-object v1

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$13(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v2

    add-int/2addr v2, v0

    iget-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v3}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$9(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v3

    sub-int/2addr v2, v3

    iget-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v3}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$11(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v3

    sub-int/2addr v2, v3

    iput v2, v1, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 333
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$10(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/ImageView;

    move-result-object v1

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$6;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$12(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/RelativeLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method
