.class Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$1;
.super Ljava/lang/Object;
.source "ToolBarMainPage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->showPage(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage$1;->this$0:Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0
    .param p1, "arg0"    # Landroid/view/View;

    .prologue
    .line 118
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->close()V

    .line 119
    return-void
.end method
