.class Lcom/sina/weibo/sdk/component/view/CommentComponentView$1;
.super Ljava/lang/Object;
.source "CommentComponentView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sina/weibo/sdk/component/view/CommentComponentView;->init(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/sina/weibo/sdk/component/view/CommentComponentView;


# direct methods
.method constructor <init>(Lcom/sina/weibo/sdk/component/view/CommentComponentView;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$1;->this$0:Lcom/sina/weibo/sdk/component/view/CommentComponentView;

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 87
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$1;->this$0:Lcom/sina/weibo/sdk/component/view/CommentComponentView;

    invoke-static {v0}, Lcom/sina/weibo/sdk/component/view/CommentComponentView;->access$0(Lcom/sina/weibo/sdk/component/view/CommentComponentView;)V

    .line 88
    return-void
.end method
