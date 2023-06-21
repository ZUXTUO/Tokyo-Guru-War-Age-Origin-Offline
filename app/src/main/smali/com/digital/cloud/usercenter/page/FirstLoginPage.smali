.class public Lcom/digital/cloud/usercenter/page/FirstLoginPage;
.super Ljava/lang/Object;
.source "FirstLoginPage.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# instance fields
.field private mAccountLoginButton:Landroid/widget/Button;

.field private mActivity:Landroid/app/Activity;

.field private mGuestLoginButton:Landroid/widget/Button;

.field private mLoginOver:Z


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 1
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    const/4 v0, 0x0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mActivity:Landroid/app/Activity;

    .line 19
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mGuestLoginButton:Landroid/widget/Button;

    .line 20
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    .line 21
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mLoginOver:Z

    .line 24
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mActivity:Landroid/app/Activity;

    .line 25
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)Z
    .locals 1

    .prologue
    .line 21
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mLoginOver:Z

    return v0
.end method

.method static synthetic access$1(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 18
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digital/cloud/usercenter/page/FirstLoginPage;Z)V
    .locals 0

    .prologue
    .line 21
    iput-boolean p1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mLoginOver:Z

    return-void
.end method


# virtual methods
.method public show()V
    .locals 4

    .prologue
    .line 29
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mActivity:Landroid/app/Activity;

    const-string v2, "layout"

    const-string v3, "first_login_page"

    invoke-static {v2, v3}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/app/Activity;->setContentView(I)V

    .line 30
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 31
    .local v0, "first_login_page_view":Landroid/view/View;
    const-string v1, "id"

    const-string v2, "button1"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mGuestLoginButton:Landroid/widget/Button;

    .line 32
    const-string v1, "id"

    const-string v2, "button2"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    .line 34
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mGuestLoginButton:Landroid/widget/Button;

    new-instance v2, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage$1;-><init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)V

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 78
    iget-object v1, p0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;->mAccountLoginButton:Landroid/widget/Button;

    new-instance v2, Lcom/digital/cloud/usercenter/page/FirstLoginPage$2;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/page/FirstLoginPage$2;-><init>(Lcom/digital/cloud/usercenter/page/FirstLoginPage;)V

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 85
    return-void
.end method
