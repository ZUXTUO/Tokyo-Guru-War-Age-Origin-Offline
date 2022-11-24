.class Lcom/digital/cloud/usercenter/page/ClausePage$1;
.super Ljava/lang/Object;
.source "ClausePage.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/ClausePage;->showPage()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digital/cloud/usercenter/page/ClausePage;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/ClausePage;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ClausePage$1;->this$0:Lcom/digital/cloud/usercenter/page/ClausePage;

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0
    .param p1, "arg0"    # Landroid/view/View;

    .prologue
    .line 50
    invoke-static {}, Lcom/digital/cloud/usercenter/page/ClausePage;->close()V

    .line 51
    return-void
.end method
