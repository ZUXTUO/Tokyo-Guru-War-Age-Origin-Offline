.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/toolbar/FloatButton$FloatButtonOnClickListener;


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
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 493
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public Finish(Z)V
    .locals 1
    .param p1, "isON"    # Z

    .prologue
    .line 497
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$2(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 498
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$3(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 502
    :goto_0
    return-void

    .line 500
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$2;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$4(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    goto :goto_0
.end method
