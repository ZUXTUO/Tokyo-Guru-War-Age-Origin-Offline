.class public Lcom/digital/cloud/usercenter/page/AccountAdapter;
.super Landroid/widget/BaseAdapter;
.source "AccountAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;
    }
.end annotation


# instance fields
.field private mActivity:Landroid/app/Activity;

.field private mChangeListener:Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

.field private mCurrentSelect:I


# direct methods
.method public constructor <init>(Landroid/app/Activity;Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "changeListener"    # Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

    .prologue
    .line 26
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 24
    const/4 v0, 0x0

    iput v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mCurrentSelect:I

    .line 27
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mActivity:Landroid/app/Activity;

    .line 28
    iput-object p2, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mChangeListener:Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

    .line 29
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AccountAdapter;I)V
    .locals 0

    .prologue
    .line 24
    iput p1, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mCurrentSelect:I

    return-void
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/AccountAdapter;)Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mChangeListener:Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/AccountAdapter;)I
    .locals 1

    .prologue
    .line 24
    iget v0, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mCurrentSelect:I

    return v0
.end method


# virtual methods
.method public getCount()I
    .locals 1

    .prologue
    .line 34
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->getAccounts()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 40
    invoke-static {p1}, Lcom/digital/cloud/usercenter/NormalLogin;->getAccount(I)Lcom/digital/cloud/usercenter/AccountInfo;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 46
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    .line 52
    if-nez p2, :cond_0

    .line 53
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountAdapter;->mActivity:Landroid/app/Activity;

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const-string v4, "layout"

    const-string v5, "user_center_account_list_item"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 54
    const/4 v5, 0x0

    .line 53
    invoke-virtual {v3, v4, p3, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    .line 57
    :cond_0
    invoke-virtual {p0, p1}, Lcom/digital/cloud/usercenter/page/AccountAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/digital/cloud/usercenter/AccountInfo;

    .line 59
    .local v2, "currentItem":Lcom/digital/cloud/usercenter/AccountInfo;
    const-string v3, "id"

    const-string v4, "account_text"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 60
    .local v0, "accountId":Landroid/widget/TextView;
    iget-object v3, v2, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 61
    new-instance v3, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;

    invoke-direct {v3, p0, p1}, Lcom/digital/cloud/usercenter/page/AccountAdapter$1;-><init>(Lcom/digital/cloud/usercenter/page/AccountAdapter;I)V

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 72
    const-string v3, "id"

    const-string v4, "account_delete"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    .line 73
    .local v1, "btn":Landroid/widget/ImageButton;
    new-instance v3, Lcom/digital/cloud/usercenter/page/AccountAdapter$2;

    invoke-direct {v3, p0, p1}, Lcom/digital/cloud/usercenter/page/AccountAdapter$2;-><init>(Lcom/digital/cloud/usercenter/page/AccountAdapter;I)V

    invoke-virtual {v1, v3}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 89
    return-object p2
.end method
