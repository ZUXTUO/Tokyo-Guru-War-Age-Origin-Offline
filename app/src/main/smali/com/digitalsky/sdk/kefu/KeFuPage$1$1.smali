.class Lcom/digitalsky/sdk/kefu/KeFuPage$1$1;
.super Ljava/lang/Object;
.source "KeFuPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/kefu/KeFuPage$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digitalsky/sdk/kefu/KeFuPage$1;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/kefu/KeFuPage$1;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/kefu/KeFuPage$1$1;->this$1:Lcom/digitalsky/sdk/kefu/KeFuPage$1;

    .line 125
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 130
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v1

    .line 131
    invoke-virtual {v1}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 130
    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 132
    .local v0, "linerParams":Landroid/widget/LinearLayout$LayoutParams;
    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 133
    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 134
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getWidth()I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 135
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$0()Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getHeight()I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 136
    invoke-static {}, Lcom/digitalsky/sdk/kefu/KeFuPage;->access$3()Landroid/webkit/WebView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 137
    return-void
.end method
