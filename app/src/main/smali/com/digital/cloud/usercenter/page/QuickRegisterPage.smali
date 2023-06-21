.class public Lcom/digital/cloud/usercenter/page/QuickRegisterPage;
.super Ljava/lang/Object;
.source "QuickRegisterPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;
    }
.end annotation


# static fields
.field private static mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

.field private static mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;


# instance fields
.field private mActivity:Landroid/app/Activity;

.field private mBackButton:Landroid/widget/ImageButton;

.field private mCurrentView:Landroid/view/View;

.field private mEmailButton:Landroid/widget/ToggleButton;

.field private mEmailEditText:Landroid/widget/EditText;

.field private mEmailPasswordEditText:Landroid/widget/EditText;

.field private mEmailPwdToggle:Landroid/widget/ToggleButton;

.field private mRegButton:Landroid/widget/Button;

.field private mTelPwdToggle:Landroid/widget/ToggleButton;

.field private mTelphoneButton:Landroid/widget/ToggleButton;

.field private mTelphoneEditText:Landroid/widget/EditText;

.field private mTelphonePasswordEditText:Landroid/widget/EditText;

.field private mVcodeButton:Landroid/widget/ToggleButton;

.field private mVcodeEditText:Landroid/widget/EditText;

.field private mVcodeTimer:Landroid/os/CountDownTimer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .line 49
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Null:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    return-void
.end method

.method constructor <init>(Landroid/app/Activity;)V
    .locals 1
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    const/4 v0, 0x0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mActivity:Landroid/app/Activity;

    .line 33
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    .line 34
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mBackButton:Landroid/widget/ImageButton;

    .line 35
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 36
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 37
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    .line 38
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mRegButton:Landroid/widget/Button;

    .line 40
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    .line 41
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeEditText:Landroid/widget/EditText;

    .line 42
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    .line 43
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    .line 44
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    .line 45
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    .line 46
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    .line 51
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 58
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mActivity:Landroid/app/Activity;

    .line 59
    return-void
.end method

.method private Login(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "login_identify"    # Ljava/lang/String;
    .param p2, "pwd"    # Ljava/lang/String;

    .prologue
    .line 423
    const-string v0, ""

    const-string v1, "md5"

    new-instance v2, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-static {p1, v0, p2, v1, v2}, Lcom/digital/cloud/usercenter/NormalLogin;->normalLogin(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/NormalLogin$loginListener;)V

    .line 475
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;)V
    .locals 0

    .prologue
    .line 175
    invoke-direct {p0, p1}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->choosePage(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;)V

    return-void
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    .locals 0

    .prologue
    .line 254
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->vcodeBottonEvent()V

    return-void
.end method

.method static synthetic access$10(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    .locals 0

    .prologue
    .line 305
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->submitRegistBottonEvent()V

    return-void
.end method

.method static synthetic access$3(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$4(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$5(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/ToggleButton;
    .locals 1

    .prologue
    .line 37
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    return-object v0
.end method

.method static synthetic access$6(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 32
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$7(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    .locals 0

    .prologue
    .line 241
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->vcodeCountDownStop()V

    return-void
.end method

.method static synthetic access$8(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$9(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 422
    invoke-direct {p0, p1, p2}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->Login(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private choosePage(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;)V
    .locals 10
    .param p1, "p"    # Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .prologue
    const/4 v9, -0x1

    const/4 v8, 0x4

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 176
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v4, "id"

    const-string v5, "linearLayout2"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    .line 177
    .local v2, "tel":Landroid/widget/LinearLayout;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v4, "id"

    const-string v5, "linearLayout3"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 179
    .local v0, "em":Landroid/widget/LinearLayout;
    sput-object p1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .line 180
    sget-object v3, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne p1, v3, :cond_2

    .line 181
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "choosePage Telphone"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 182
    invoke-virtual {v0, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 183
    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 185
    sget-object v3, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sget-object v4, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne v3, v4, :cond_1

    .line 186
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v8}, Landroid/widget/ToggleButton;->setVisibility(I)V

    .line 187
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3}, Landroid/widget/ToggleButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 188
    .local v1, "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 189
    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    iget v5, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-direct {v4, v9, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 188
    invoke-virtual {v3, v4}, Landroid/widget/ToggleButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 190
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 191
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 217
    .end local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    :cond_0
    :goto_0
    return-void

    .line 193
    :cond_1
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 194
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 195
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 196
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    goto :goto_0

    .line 198
    :cond_2
    sget-object v3, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne p1, v3, :cond_0

    .line 199
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "choosePage Email"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 201
    invoke-virtual {v2, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 203
    sget-object v3, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sget-object v4, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne v3, v4, :cond_3

    .line 204
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v8}, Landroid/widget/ToggleButton;->setVisibility(I)V

    .line 205
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3}, Landroid/widget/ToggleButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 206
    .restart local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 207
    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    iget v5, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-direct {v4, v9, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 206
    invoke-virtual {v3, v4}, Landroid/widget/ToggleButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 208
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 209
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    goto :goto_0

    .line 211
    .end local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    :cond_3
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 212
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 213
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 214
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    goto :goto_0
.end method

.method public static showPageSelect(ZZ)V
    .locals 1
    .param p0, "tel"    # Z
    .param p1, "email"    # Z

    .prologue
    .line 62
    if-nez p0, :cond_0

    if-nez p1, :cond_0

    .line 73
    :goto_0
    return-void

    .line 64
    :cond_0
    if-nez p0, :cond_1

    .line 65
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .line 66
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    goto :goto_0

    .line 67
    :cond_1
    if-nez p1, :cond_2

    .line 68
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .line 69
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    goto :goto_0

    .line 71
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Null:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mHidePage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    goto :goto_0
.end method

.method private submitRegistBottonEvent()V
    .locals 4

    .prologue
    const/16 v3, 0x12

    const/4 v2, 0x6

    .line 306
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne v0, v1, :cond_5

    .line 307
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/16 v1, 0x8

    if-ge v0, v1, :cond_1

    .line 308
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_sjhtd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 420
    :cond_0
    :goto_0
    return-void

    .line 310
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_2

    .line 311
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_qsryzm"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 313
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lt v0, v2, :cond_3

    .line 314
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le v0, v3, :cond_4

    .line 315
    :cond_3
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    .line 316
    const-string v1, "string"

    const-string v2, "c_sjdlmmcdbx"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 319
    :cond_4
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 320
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 321
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    .line 322
    new-instance v3, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;

    invoke-direct {v3, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$10;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    .line 320
    invoke-static {v0, v1, v2, v3}, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberRegister(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;)V

    goto :goto_0

    .line 369
    :cond_5
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    if-ne v0, v1, :cond_0

    .line 370
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/CommonTool;->isEmail(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 371
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_yxdzgscw"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 373
    :cond_6
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lt v0, v2, :cond_7

    .line 374
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le v0, v3, :cond_8

    .line 375
    :cond_7
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    .line 376
    const-string v1, "string"

    const-string v2, "c_yxdlmmcdbx"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 379
    :cond_8
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 380
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 381
    new-instance v2, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$11;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$11;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    .line 380
    invoke-static {v0, v1, v2}, Lcom/digital/cloud/usercenter/EmailManage;->EmailRegister(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/EmailManage$registerListener;)V

    goto/16 :goto_0
.end method

.method private vcodeBottonEvent()V
    .locals 3

    .prologue
    .line 256
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    .line 257
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_sjhtd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 258
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->vcodeCountDownStop()V

    .line 302
    :goto_0
    return-void

    .line 262
    :cond_0
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->vcodeCountDownStart()V

    .line 264
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 265
    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    .line 264
    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/TelphoneManage;->requestTelphoneVcode(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    goto :goto_0
.end method

.method private vcodeCountDownStart()V
    .locals 7

    .prologue
    .line 220
    const-string v0, "string"

    const-string v1, "c_second"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    .line 221
    .local v6, "second":Ljava/lang/String;
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "(60)"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOn(Ljava/lang/CharSequence;)V

    .line 222
    new-instance v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$8;

    const-wide/32 v2, 0xea60

    const-wide/16 v4, 0x3e8

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$8;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;JJLjava/lang/String;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 238
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 239
    return-void
.end method

.method private vcodeCountDownStop()V
    .locals 3

    .prologue
    .line 242
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_0

    .line 243
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 244
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 247
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 248
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 249
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const-string v1, "string"

    const-string v2, "c_hqyzm"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOff(Ljava/lang/CharSequence;)V

    .line 250
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const-string v1, "string"

    const-string v2, "c_hqyzm"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOn(Ljava/lang/CharSequence;)V

    .line 251
    return-void
.end method


# virtual methods
.method public show()V
    .locals 4

    .prologue
    const/high16 v3, 0x10000000

    .line 77
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mActivity:Landroid/app/Activity;

    const-string v1, "layout"

    const-string v2, "quick_register_page"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setContentView(I)V

    .line 78
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    .line 80
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "imageButton1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mBackButton:Landroid/widget/ImageButton;

    .line 81
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mBackButton:Landroid/widget/ImageButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$1;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$1;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 89
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 90
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$2;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$2;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 99
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button2"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 100
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$3;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$3;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 110
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button3"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    .line 111
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$4;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$4;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 119
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button6"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mRegButton:Landroid/widget/Button;

    .line 120
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mRegButton:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$5;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$5;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 128
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    .line 129
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 131
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText3"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeEditText:Landroid/widget/EditText;

    .line 132
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 134
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText4"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    .line 135
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 137
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "qr_tele_pwd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    .line 138
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$6;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$6;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 151
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText5"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    .line 152
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 154
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText9"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    .line 155
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 157
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "qr_email_pwd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    .line 158
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$7;-><init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 171
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->vcodeCountDownStop()V

    .line 172
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    invoke-direct {p0, v0}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->choosePage(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;)V

    .line 173
    return-void
.end method
