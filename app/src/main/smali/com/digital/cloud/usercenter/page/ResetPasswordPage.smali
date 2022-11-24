.class public Lcom/digital/cloud/usercenter/page/ResetPasswordPage;
.super Ljava/lang/Object;
.source "ResetPasswordPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;
    }
.end annotation


# static fields
.field private static mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

.field private static mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;


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
    .line 50
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .line 51
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Null:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    return-void
.end method

.method constructor <init>(Landroid/app/Activity;)V
    .locals 1
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    const/4 v0, 0x0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mActivity:Landroid/app/Activity;

    .line 34
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 35
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mBackButton:Landroid/widget/ImageButton;

    .line 36
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 37
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 38
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    .line 39
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mRegButton:Landroid/widget/Button;

    .line 41
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    .line 42
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeEditText:Landroid/widget/EditText;

    .line 43
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    .line 44
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailEditText:Landroid/widget/EditText;

    .line 45
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    .line 47
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    .line 48
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    .line 53
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 60
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mActivity:Landroid/app/Activity;

    .line 61
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;)V
    .locals 0

    .prologue
    .line 186
    invoke-direct {p0, p1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->choosePage(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;)V

    return-void
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V
    .locals 0

    .prologue
    .line 269
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeBottonEvent()V

    return-void
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V
    .locals 0

    .prologue
    .line 319
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->submitPwdResetBottonEvent()V

    return-void
.end method

.method static synthetic access$3(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$4(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$5(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/widget/ToggleButton;
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    return-object v0
.end method

.method static synthetic access$6(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 33
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$7(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V
    .locals 0

    .prologue
    .line 256
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeCountDownStop()V

    return-void
.end method

.method private choosePage(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;)V
    .locals 10
    .param p1, "p"    # Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .prologue
    const/4 v9, -0x1

    const/4 v8, 0x4

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 187
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 188
    const-string v4, "id"

    const-string v5, "linearLayout2"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    .line 187
    check-cast v2, Landroid/widget/LinearLayout;

    .line 189
    .local v2, "tel":Landroid/widget/LinearLayout;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 190
    const-string v4, "id"

    const-string v5, "linearLayout3"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 189
    check-cast v0, Landroid/widget/LinearLayout;

    .line 192
    .local v0, "em":Landroid/widget/LinearLayout;
    sput-object p1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .line 193
    sget-object v3, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne p1, v3, :cond_2

    .line 194
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "choosePage Telphone"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    invoke-virtual {v0, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 196
    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 198
    sget-object v3, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sget-object v4, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne v3, v4, :cond_1

    .line 199
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v8}, Landroid/widget/ToggleButton;->setVisibility(I)V

    .line 200
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 201
    invoke-virtual {v3}, Landroid/widget/ToggleButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 202
    .local v1, "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    .line 203
    iget v5, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-direct {v4, v9, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 202
    invoke-virtual {v3, v4}, Landroid/widget/ToggleButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 204
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 205
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 232
    .end local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    :cond_0
    :goto_0
    return-void

    .line 207
    :cond_1
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 208
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 209
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 210
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    goto :goto_0

    .line 212
    :cond_2
    sget-object v3, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne p1, v3, :cond_0

    .line 213
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "choosePage Email"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 215
    invoke-virtual {v2, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 217
    sget-object v3, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sget-object v4, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne v3, v4, :cond_3

    .line 218
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v8}, Landroid/widget/ToggleButton;->setVisibility(I)V

    .line 219
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 220
    invoke-virtual {v3}, Landroid/widget/ToggleButton;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 221
    .restart local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    .line 222
    iget v5, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-direct {v4, v9, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 221
    invoke-virtual {v3, v4}, Landroid/widget/ToggleButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 223
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 224
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    goto :goto_0

    .line 226
    .end local v1    # "oldLayout":Landroid/view/ViewGroup$LayoutParams;
    :cond_3
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 227
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 228
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v7}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 229
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    invoke-virtual {v3, v6}, Landroid/widget/ToggleButton;->setChecked(Z)V

    goto :goto_0
.end method

.method public static showPageSelect(ZZ)V
    .locals 1
    .param p0, "tel"    # Z
    .param p1, "email"    # Z

    .prologue
    .line 64
    if-nez p0, :cond_0

    if-nez p1, :cond_0

    .line 75
    :goto_0
    return-void

    .line 66
    :cond_0
    if-nez p0, :cond_1

    .line 67
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .line 68
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    goto :goto_0

    .line 69
    :cond_1
    if-nez p1, :cond_2

    .line 70
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .line 71
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    goto :goto_0

    .line 73
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Null:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mHidePage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    goto :goto_0
.end method

.method private submitPwdResetBottonEvent()V
    .locals 4

    .prologue
    const/16 v3, 0x12

    const/4 v2, 0x6

    .line 320
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne v0, v1, :cond_5

    .line 321
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/16 v1, 0x8

    if-ge v0, v1, :cond_1

    .line 322
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_sjhtd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 428
    :cond_0
    :goto_0
    return-void

    .line 324
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_2

    .line 325
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

    .line 327
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lt v0, v2, :cond_3

    .line 328
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le v0, v3, :cond_4

    .line 329
    :cond_3
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_sjdlmmcdbx"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 332
    :cond_4
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 333
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 334
    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 335
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 336
    iget-object v2, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    .line 337
    new-instance v3, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;

    invoke-direct {v3, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$10;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    .line 333
    invoke-static {v0, v1, v2, v3}, Lcom/digital/cloud/usercenter/TelphoneManage;->phoneNumberPwdReset(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/TelphoneManage$registerListener;)V

    goto :goto_0

    .line 379
    :cond_5
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    if-ne v0, v1, :cond_0

    .line 380
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/CommonTool;->isEmail(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 381
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

    .line 383
    :cond_6
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-lt v0, v2, :cond_7

    .line 384
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le v0, v3, :cond_8

    .line 385
    :cond_7
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_yxdlmmcdbx"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 388
    :cond_8
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->showLoading()V

    .line 389
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 390
    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 391
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 392
    new-instance v2, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$11;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$11;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    .line 389
    invoke-static {v0, v1, v2}, Lcom/digital/cloud/usercenter/EmailManage;->EmailPwdReset(Ljava/lang/String;Ljava/lang/String;Lcom/digital/cloud/usercenter/EmailManage$registerListener;)V

    goto/16 :goto_0
.end method

.method private vcodeBottonEvent()V
    .locals 3

    .prologue
    .line 271
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    .line 272
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_sjhtd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 273
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeCountDownStop()V

    .line 316
    :goto_0
    return-void

    .line 277
    :cond_0
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeCountDownStart()V

    .line 279
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 280
    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$9;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    .line 279
    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/TelphoneManage;->requestTelphoneVcode(Ljava/lang/String;Lcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    goto :goto_0
.end method

.method private vcodeCountDownStart()V
    .locals 7

    .prologue
    .line 235
    const-string v0, "string"

    const-string v1, "c_second"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    .line 236
    .local v6, "mSecond":Ljava/lang/String;
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "(60)"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOn(Ljava/lang/CharSequence;)V

    .line 237
    new-instance v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$8;

    const-wide/32 v2, 0xea60

    const-wide/16 v4, 0x3e8

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$8;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;JJLjava/lang/String;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 253
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 254
    return-void
.end method

.method private vcodeCountDownStop()V
    .locals 3

    .prologue
    .line 257
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_0

    .line 258
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 259
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 262
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setChecked(Z)V

    .line 263
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setEnabled(Z)V

    .line 264
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const-string v1, "string"

    const-string v2, "p_hqyzm"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOff(Ljava/lang/CharSequence;)V

    .line 265
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    const-string v1, "string"

    const-string v2, "p_hqyzm"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setTextOn(Ljava/lang/CharSequence;)V

    .line 266
    return-void
.end method


# virtual methods
.method public show()V
    .locals 4

    .prologue
    const/high16 v3, 0x10000000

    .line 79
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mActivity:Landroid/app/Activity;

    const-string v1, "layout"

    const-string v2, "reset_password_page"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setContentView(I)V

    .line 80
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 82
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 83
    const-string v1, "id"

    const-string v2, "imageButton1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    .line 82
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mBackButton:Landroid/widget/ImageButton;

    .line 84
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mBackButton:Landroid/widget/ImageButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$1;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$1;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 93
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    .line 94
    const-string v1, "id"

    const-string v2, "button1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    .line 93
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    .line 95
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$2;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$2;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 105
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button2"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    .line 106
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$3;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$3;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 117
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button3"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    .line 118
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeButton:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$4;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$4;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 126
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "button6"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mRegButton:Landroid/widget/Button;

    .line 127
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mRegButton:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$5;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$5;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 135
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    .line 136
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphoneEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 138
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText3"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeEditText:Landroid/widget/EditText;

    .line 139
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mVcodeEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 141
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText4"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    .line 142
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelphonePasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 145
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "rp_tele_pwd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    .line 146
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mTelPwdToggle:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$6;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$6;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 159
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText5"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailEditText:Landroid/widget/EditText;

    .line 160
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 162
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText9"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    .line 163
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 165
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "editText9"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    .line 166
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPasswordEditText:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 168
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentView:Landroid/view/View;

    const-string v1, "id"

    const-string v2, "rp_email_pwd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ToggleButton;

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    .line 169
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mEmailPwdToggle:Landroid/widget/ToggleButton;

    new-instance v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$7;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$7;-><init>(Lcom/digital/cloud/usercenter/page/ResetPasswordPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 182
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->vcodeCountDownStop()V

    .line 183
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->mCurrentPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    invoke-direct {p0, v0}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;->choosePage(Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;)V

    .line 184
    return-void
.end method
