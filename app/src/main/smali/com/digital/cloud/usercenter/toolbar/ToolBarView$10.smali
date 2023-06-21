.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->halfHide()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

.field private final synthetic val$limit:I


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;I)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    iput p2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->val$limit:I

    .line 436
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 5
    .param p1, "updatedAnimation"    # Landroid/animation/ValueAnimator;

    .prologue
    .line 441
    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 442
    .local v0, "animatedValue":I
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    rsub-int/lit8 v2, v0, -0x14

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 443
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    const/high16 v2, 0x3f800000    # 1.0f

    int-to-float v3, v0

    iget v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->val$limit:I

    int-to-float v4, v4

    div-float/2addr v3, v4

    const/high16 v4, 0x3f000000    # 0.5f

    mul-float/2addr v3, v4

    sub-float/2addr v2, v3

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 444
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$10;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 446
    return-void
.end method
