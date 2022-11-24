.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 337
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 0
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 361
    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 3
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 352
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$16(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 355
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->onClickEnable(Z)V

    .line 356
    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$18(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 357
    return-void

    .line 352
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 353
    .local v0, "item":Landroid/view/View;
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 0
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 348
    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 3
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 342
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$14(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v1

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$15(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v2

    add-int/2addr v1, v2

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$9(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x1e

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 343
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$7;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 344
    return-void
.end method
