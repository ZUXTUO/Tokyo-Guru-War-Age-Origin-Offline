.class Lcom/digital/cloud/usercenter/page/AccountAdapter$1;
.super Ljava/lang/Object;
.source "AccountAdapter.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AccountAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

.field private final synthetic val$position:I


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AccountAdapter;I)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    iput p2, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->val$position:I

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "arg0"    # Landroid/view/View;

    .prologue
    .line 65
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    iget v1, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->val$position:I

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->access$0(Lcom/digital/cloud/usercenter/page/AccountAdapter;I)V

    .line 66
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->access$1(Lcom/digital/cloud/usercenter/page/AccountAdapter;)Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 67
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    invoke-static {v0}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->access$1(Lcom/digital/cloud/usercenter/page/AccountAdapter;)Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

    move-result-object v1

    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;->this$0:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    invoke-static {v2}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->access$2(Lcom/digital/cloud/usercenter/page/AccountAdapter;)I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/AccountInfo;

    invoke-interface {v1, v0}, Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;->onChange(Lcom/digital/cloud/usercenter/AccountInfo;)V

    .line 70
    :cond_0
    return-void
.end method
