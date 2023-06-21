.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/toolbar/FloatButton$CoordinateUpdateListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 483
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public Update(FF)V
    .locals 2
    .param p1, "x"    # F
    .param p2, "y"    # F

    .prologue
    .line 487
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    int-to-float v1, v1

    add-float/2addr v1, p1

    float-to-int v1, v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 488
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    int-to-float v1, v1

    add-float/2addr v1, p2

    float-to-int v1, v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 489
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$1(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 490
    return-void
.end method
