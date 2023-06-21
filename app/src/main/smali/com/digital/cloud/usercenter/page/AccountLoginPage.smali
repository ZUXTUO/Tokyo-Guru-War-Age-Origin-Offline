.class public Lcom/digital/cloud/usercenter/page/AccountLoginPage;
.super Ljava/lang/Object;
.source "AccountLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# static fields
.field private static mIsClauseShow:Z


# instance fields
.field private mAccountAdapter:Lcom/digital/cloud/usercenter/page/AccountAdapter;

.field private mAccountBtn:Landroid/widget/ToggleButton;

.field private mAccountLoginButton:Landroid/widget/Button;

.field private mActivity:Landroid/app/Activity;

.field private mBackButton:Landroid/widget/ImageButton;

.field private mClause:Landroid/widget/Button;

.field private mIsAgreeClause:Landroid/widget/CheckBox;

.field private mIsAgreeClauseText:Landroid/widget/TextView;

.field private mLoginOver:Z

.field private mPandaImage:Landroid/widget/ImageView;

.field private mPopup:Landroid/widget/ListPopupWindow;

.field private mRegisterButton:Landroid/widget/Button;

.field private mResetPassword:Landroid/widget/Button;

.field private mUserName:Landroid/widget/EditText;

.field private mUserPwd:Landroid/widget/EditText;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 47
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsClauseShow:Z

    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;)V
    .locals 2
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    const/4 v1, 0x0

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    .line 38
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mRegisterButton:Landroid/widget/Button;

    .line 39
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    .line 40
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mBackButton:Landroid/widget/ImageButton;

    .line 41
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mResetPassword:Landroid/widget/Button;

    .line 42
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserName:Landroid/widget/EditText;

    .line 43
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    .line 44
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    .line 45
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClauseText:Landroid/widget/TextView;

    .line 46
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mClause:Landroid/widget/Button;

    .line 48
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mLoginOver:Z

    .line 50
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountBtn:Landroid/widget/ToggleButton;

    .line 51
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    .line 52
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountAdapter:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    .line 54
    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPandaImage:Landroid/widget/ImageView;

    .line 57
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    .line 58
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserName:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ListPopupWindow;
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    return-object v0
.end method

.method static synthetic access$3(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ToggleButton;
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountBtn:Landroid/widget/ToggleButton;

    return-object v0
.end method

.method static synthetic access$4(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/ImageView;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPandaImage:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$5(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 37
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$6()Z
    .locals 1

    .prologue
    .line 47
    sget-boolean v0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsClauseShow:Z

    return v0
.end method

.method static synthetic access$7(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Landroid/widget/CheckBox;
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    return-object v0
.end method

.method static synthetic access$8(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)Z
    .locals 1

    .prologue
    .line 48
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mLoginOver:Z

    return v0
.end method

.method static synthetic access$9(Lcom/digital/cloud/usercenter/page/AccountLoginPage;Z)V
    .locals 0

    .prologue
    .line 48
    iput-boolean p1, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mLoginOver:Z

    return-void
.end method

.method public static setClause(Z)V
    .locals 0
    .param p0, "isShow"    # Z

    .prologue
    .line 61
    sput-boolean p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsClauseShow:Z

    .line 62
    return-void
.end method


# virtual methods
.method public show()V
    .locals 11

    .prologue
    const/high16 v10, 0x10000000

    const/4 v9, 0x1

    const/4 v8, -0x2

    const/4 v7, 0x4

    const/4 v6, 0x0

    .line 66
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    const-string v4, "layout"

    const-string v5, "account_login_page"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/app/Activity;->setContentView(I)V

    .line 67
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    .line 69
    .local v2, "currentView":Landroid/view/View;
    const-string v3, "id"

    const-string v4, "account_layout"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/RelativeLayout;

    .line 71
    .local v1, "accountLayout":Landroid/widget/RelativeLayout;
    new-instance v3, Landroid/widget/ListPopupWindow;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    invoke-direct {v3, v4}, Landroid/widget/ListPopupWindow;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    .line 72
    new-instance v3, Lcom/digital/cloud/usercenter/page/AccountAdapter;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mActivity:Landroid/app/Activity;

    new-instance v5, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;

    invoke-direct {v5, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$1;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-direct {v3, v4, v5}, Lcom/digital/cloud/usercenter/page/AccountAdapter;-><init>(Landroid/app/Activity;Lcom/digital/cloud/usercenter/page/AccountAdapter$ChangeListener;)V

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountAdapter:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    .line 81
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountAdapter:Lcom/digital/cloud/usercenter/page/AccountAdapter;

    invoke-virtual {v3, v4}, Landroid/widget/ListPopupWindow;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 82
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    invoke-virtual {v3, v8}, Landroid/widget/ListPopupWindow;->setWidth(I)V

    .line 83
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    invoke-virtual {v3, v8}, Landroid/widget/ListPopupWindow;->setHeight(I)V

    .line 84
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    invoke-virtual {v3, v1}, Landroid/widget/ListPopupWindow;->setAnchorView(Landroid/view/View;)V

    .line 85
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    invoke-virtual {v3, v9}, Landroid/widget/ListPopupWindow;->setModal(Z)V

    .line 86
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    new-instance v4, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v4, v6}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v4}, Landroid/widget/ListPopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 87
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPopup:Landroid/widget/ListPopupWindow;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$2;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$2;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/ListPopupWindow;->setOnDismissListener(Landroid/widget/PopupWindow$OnDismissListener;)V

    .line 98
    const-string v3, "id"

    const-string v4, "select_list"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ToggleButton;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountBtn:Landroid/widget/ToggleButton;

    .line 99
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountBtn:Landroid/widget/ToggleButton;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$3;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/ToggleButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 111
    const-string v3, "id"

    const-string v4, "editText1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/EditText;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserName:Landroid/widget/EditText;

    .line 112
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserName:Landroid/widget/EditText;

    invoke-virtual {v3, v10}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 114
    const-string v3, "id"

    const-string v4, "editText3"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/EditText;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    .line 115
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    invoke-virtual {v3, v10}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 116
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$4;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 129
    const-string v3, "id"

    const-string v4, "imageView1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageView;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mPandaImage:Landroid/widget/ImageView;

    .line 130
    invoke-static {v6}, Lcom/digital/cloud/usercenter/NormalLogin;->getAccount(I)Lcom/digital/cloud/usercenter/AccountInfo;

    move-result-object v0

    .line 131
    .local v0, "account":Lcom/digital/cloud/usercenter/AccountInfo;
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserName:Landroid/widget/EditText;

    iget-object v4, v0, Lcom/digital/cloud/usercenter/AccountInfo;->mId:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 132
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mUserPwd:Landroid/widget/EditText;

    iget-object v4, v0, Lcom/digital/cloud/usercenter/AccountInfo;->mPwd:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 134
    const-string v3, "id"

    const-string v4, "checkBox1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/CheckBox;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    .line 135
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    invoke-virtual {v3, v9}, Landroid/widget/CheckBox;->setChecked(Z)V

    .line 136
    const-string v3, "id"

    const-string v4, "textView1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClauseText:Landroid/widget/TextView;

    .line 137
    const-string v3, "id"

    const-string v4, "button4"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/Button;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mClause:Landroid/widget/Button;

    .line 138
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mClause:Landroid/widget/Button;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$5;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$5;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 146
    sget-boolean v3, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsClauseShow:Z

    if-eqz v3, :cond_1

    .line 147
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    invoke-virtual {v3, v6}, Landroid/widget/CheckBox;->setVisibility(I)V

    .line 148
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClauseText:Landroid/widget/TextView;

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setVisibility(I)V

    .line 149
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mClause:Landroid/widget/Button;

    invoke-virtual {v3, v6}, Landroid/widget/Button;->setVisibility(I)V

    .line 156
    :goto_0
    const-string v3, "id"

    const-string v4, "button1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/Button;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mRegisterButton:Landroid/widget/Button;

    .line 157
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mRegisterButton:Landroid/widget/Button;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$6;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$6;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 170
    const-string v3, "id"

    const-string v4, "imageButton1"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageButton;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mBackButton:Landroid/widget/ImageButton;

    .line 171
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mBackButton:Landroid/widget/ImageButton;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$7;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$7;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 179
    sget-boolean v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    if-eqz v3, :cond_0

    .line 180
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mBackButton:Landroid/widget/ImageButton;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 183
    :cond_0
    const-string v3, "id"

    const-string v4, "button3"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/Button;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mResetPassword:Landroid/widget/Button;

    .line 184
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mResetPassword:Landroid/widget/Button;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$8;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$8;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 192
    const-string v3, "id"

    const-string v4, "button2"

    invoke-static {v3, v4}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/Button;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    .line 193
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    new-instance v4, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;

    invoke-direct {v4, p0}, Lcom/digital/cloud/usercenter/page/AccountLoginPage$9;-><init>(Lcom/digital/cloud/usercenter/page/AccountLoginPage;)V

    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 268
    return-void

    .line 151
    :cond_1
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClause:Landroid/widget/CheckBox;

    invoke-virtual {v3, v7}, Landroid/widget/CheckBox;->setVisibility(I)V

    .line 152
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mIsAgreeClauseText:Landroid/widget/TextView;

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setVisibility(I)V

    .line 153
    iget-object v3, p0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;->mClause:Landroid/widget/Button;

    invoke-virtual {v3, v7}, Landroid/widget/Button;->setVisibility(I)V

    goto/16 :goto_0
.end method
