.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->toolBarOff()V
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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 386
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 0
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 418
    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 3
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 401
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$12(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/RelativeLayout$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$15(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v1

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 402
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$10(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/ImageView;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$12(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/widget/RelativeLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 404
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v1

    sget v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->ToolBarViewWidth:I

    int-to-float v2, v2

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/CommonTool;->dip2px(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 405
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 406
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->onClickEnable(Z)V

    .line 408
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$19(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 410
    :try_start_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$5(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$20(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 414
    :cond_0
    :goto_0
    return-void

    .line 411
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 0
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 397
    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 3
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 390
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$9;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$16(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 393
    return-void

    .line 390
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 391
    .local v0, "item":Landroid/view/View;
    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0
.end method
