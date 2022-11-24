.class public Lcom/digital/cloud/usercenter/page/AutoLoginPage;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# instance fields
.field private isLoginSuccess:Z

.field private loginCount:I

.field private mActivity:Landroid/app/Activity;

.field private mAutoLoginState:I

.field private mLoginButton1:Landroid/widget/Button;

.field private mLoginButton2:Landroid/widget/Button;

.field private mLoginOver:Z

.field private mUserName:Landroid/widget/TextView;

.field private mVcodeTimer:Landroid/os/CountDownTimer;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 2
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mActivity:Landroid/app/Activity;

    .line 22
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    .line 23
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    .line 24
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mUserName:Landroid/widget/TextView;

    .line 25
    iput v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginCount:I

    .line 26
    iput-boolean v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->isLoginSuccess:Z

    .line 27
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 28
    iput v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mAutoLoginState:I

    .line 29
    iput-boolean v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginOver:Z

    .line 33
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mActivity:Landroid/app/Activity;

    .line 34
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 20
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/AutoLoginPage;Z)V
    .locals 0

    .prologue
    .line 26
    iput-boolean p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->isLoginSuccess:Z

    return-void
.end method

.method static synthetic access$10(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Z
    .locals 1

    .prologue
    .line 29
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginOver:Z

    return v0
.end method

.method static synthetic access$11(Lcom/digital/cloud/usercenter/page/AutoLoginPage;Z)V
    .locals 0

    .prologue
    .line 29
    iput-boolean p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginOver:Z

    return-void
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V
    .locals 0

    .prologue
    .line 28
    iput p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mAutoLoginState:I

    return-void
.end method

.method static synthetic access$3(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I
    .locals 1

    .prologue
    .line 25
    iget v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginCount:I

    return v0
.end method

.method static synthetic access$4(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V
    .locals 0

    .prologue
    .line 25
    iput p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginCount:I

    return-void
.end method

.method static synthetic access$5(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/widget/Button;
    .locals 1

    .prologue
    .line 22
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic access$6(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Z
    .locals 1

    .prologue
    .line 26
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->isLoginSuccess:Z

    return v0
.end method

.method static synthetic access$7(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I
    .locals 1

    .prologue
    .line 28
    iget v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mAutoLoginState:I

    return v0
.end method

.method static synthetic access$8(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V
    .locals 0

    .prologue
    .line 137
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginShow()V

    return-void
.end method

.method static synthetic access$9(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Landroid/os/CountDownTimer;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    return-object v0
.end method

.method private autoLoginShow()V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 53
    iput-boolean v3, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->isLoginSuccess:Z

    .line 54
    new-instance v0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;

    invoke-direct {v0, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    invoke-static {v0}, Lcom/digital/cloud/usercenter/AutoLogin;->login(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V

    .line 78
    const-string v0, "string"

    const-string v1, "c_dlz"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    .line 79
    .local v6, "mDlz":Ljava/lang/String;
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "   "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 80
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    const-string v1, "string"

    const-string v2, "c_qx"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 82
    iput v3, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->loginCount:I

    .line 83
    new-instance v0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;

    const-wide/16 v2, 0xfa0

    const-wide/16 v4, 0x1f4

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$2;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;JJLjava/lang/String;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 115
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 118
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$3;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 127
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$4;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$4;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 135
    return-void
.end method

.method public static isAutoLogin()Z
    .locals 1

    .prologue
    .line 37
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->isAutoLogin()Z

    move-result v0

    return v0
.end method

.method private loginShow()V
    .locals 3

    .prologue
    .line 138
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->cancelAutoLogin()V

    .line 139
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    const-string v1, "string"

    const-string v2, "c_dl"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 140
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    const-string v1, "string"

    const-string v2, "c_xzqtfsdl"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 142
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 192
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    new-instance v1, Lcom/digital/cloud/usercenter/page/AutoLoginPage$6;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$6;-><init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 202
    return-void
.end method


# virtual methods
.method public onDestory()V
    .locals 1

    .prologue
    .line 205
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_0

    .line 206
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 207
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mVcodeTimer:Landroid/os/CountDownTimer;

    .line 209
    :cond_0
    return-void
.end method

.method public show()V
    .locals 4

    .prologue
    .line 42
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mActivity:Landroid/app/Activity;

    const-string v2, "layout"

    const-string v3, "auto_login_page"

    invoke-static {v2, v3}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Activity;->setContentView(I)V

    .line 43
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 44
    .local v0, "currentView":Landroid/view/View;
    const-string v1, "id"

    const-string v2, "button1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton1:Landroid/widget/Button;

    .line 45
    const-string v1, "id"

    const-string v2, "button2"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mLoginButton2:Landroid/widget/Button;

    .line 46
    const-string v1, "id"

    const-string v2, "textView1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mUserName:Landroid/widget/TextView;

    .line 47
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->mUserName:Landroid/widget/TextView;

    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->getUserName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 49
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->autoLoginShow()V

    .line 50
    return-void
.end method
