.class public Lcom/digital/cloud/usercenter/page/WelcomePage;
.super Landroid/app/Activity;
.source "WelcomePage.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 7
    .param p1, "b"    # Landroid/os/Bundle;

    .prologue
    .line 14
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 16
    const-string v4, "style"

    const-string v5, "MyPopDialog"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {p0, v4}, Lcom/digital/cloud/usercenter/page/WelcomePage;->setTheme(I)V

    .line 17
    const-string v4, "layout"

    const-string v5, "welcome_page"

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {p0, v4}, Lcom/digital/cloud/usercenter/page/WelcomePage;->setContentView(I)V

    .line 18
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/page/WelcomePage;->getWindow()Landroid/view/Window;

    move-result-object v4

    const/16 v5, 0x30

    invoke-virtual {v4, v5}, Landroid/view/Window;->setGravity(I)V

    .line 20
    new-instance v1, Lcom/digital/cloud/usercenter/page/WelcomePage$1;

    invoke-direct {v1, p0}, Lcom/digital/cloud/usercenter/page/WelcomePage$1;-><init>(Lcom/digital/cloud/usercenter/page/WelcomePage;)V

    .line 26
    .local v1, "runnable":Ljava/lang/Runnable;
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    .line 27
    .local v0, "handler":Landroid/os/Handler;
    const-wide/16 v4, 0x5dc

    invoke-virtual {v0, v1, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 29
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/page/WelcomePage;->getIntent()Landroid/content/Intent;

    move-result-object v4

    const-string v5, "userinfo"

    invoke-virtual {v4, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 30
    .local v2, "userinfo":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/digital/cloud/usercenter/page/WelcomePage;->getWindow()Landroid/view/Window;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v4

    const-string v5, "id"

    const-string v6, "textView1"

    invoke-static {v5, v6}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v4, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 31
    .local v3, "welcomeText":Landroid/widget/TextView;
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 32
    return-void
.end method
