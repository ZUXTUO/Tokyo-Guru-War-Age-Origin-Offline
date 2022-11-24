.class public Lcom/digital/cloud/usercenter/page/MySpinnerPage;
.super Ljava/lang/Object;
.source "MySpinnerPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/page/MySpinnerPage$Item;
    }
.end annotation


# instance fields
.field private mActivity:Landroid/app/Activity;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 1
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/MySpinnerPage;->mActivity:Landroid/app/Activity;

    .line 17
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/MySpinnerPage;->mActivity:Landroid/app/Activity;

    .line 18
    return-void
.end method


# virtual methods
.method public addItem(Lcom/digital/cloud/usercenter/page/MySpinnerPage$Item;)V
    .locals 0
    .param p1, "it"    # Lcom/digital/cloud/usercenter/page/MySpinnerPage$Item;

    .prologue
    .line 22
    return-void
.end method

.method public show()V
    .locals 0

    .prologue
    .line 26
    return-void
.end method
