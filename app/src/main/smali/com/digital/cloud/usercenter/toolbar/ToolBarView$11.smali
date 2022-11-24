.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


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


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 448
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 2
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 471
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setClickable(Z)V

    .line 472
    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 2
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 465
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setClickable(Z)V

    .line 466
    return-void
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 0
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 460
    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 2
    .param p1, "arg0"    # Landroid/animation/Animator;

    .prologue
    .line 453
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$11;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$17(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Lcom/digital/cloud/usercenter/toolbar/FloatButton;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/FloatButton;->setClickable(Z)V

    .line 454
    return-void
.end method
