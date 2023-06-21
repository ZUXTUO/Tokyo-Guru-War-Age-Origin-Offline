.class Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;
.super Ljava/lang/Object;
.source "ToolBarView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->addItems(Ljava/util/ArrayList;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

.field private final synthetic val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 164
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "arg0"    # Landroid/view/View;

    .prologue
    .line 168
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "type:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 169
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne v0, v1, :cond_0

    .line 170
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->LogoutResponse()V

    .line 171
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$8(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)V

    .line 183
    :goto_0
    return-void

    .line 172
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne v0, v1, :cond_1

    .line 173
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    goto :goto_0

    .line 174
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne v0, v1, :cond_2

    .line 175
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    goto :goto_0

    .line 176
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne v0, v1, :cond_3

    .line 177
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    goto :goto_0

    .line 178
    :cond_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    if-ne v0, v1, :cond_4

    .line 179
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->access$6(Lcom/digital/cloud/usercenter/toolbar/ToolBarView;)Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView$4;->val$itemType:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    goto :goto_0

    .line 180
    :cond_4
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    goto :goto_0
.end method
