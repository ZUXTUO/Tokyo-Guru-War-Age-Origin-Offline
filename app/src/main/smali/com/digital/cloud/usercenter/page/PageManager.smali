.class public Lcom/digital/cloud/usercenter/page/PageManager;
.super Ljava/lang/Object;
.source "PageManager.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/ShowPageListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/page/PageManager$PageType;
    }
.end annotation


# static fields
.field private static synthetic $SWITCH_TABLE$com$digital$cloud$usercenter$page$PageManager$PageType:[I

.field private static mActivity:Landroid/app/Activity;

.field private static mParentActivity:Landroid/app/Activity;

.field private static mThis:Lcom/digital/cloud/usercenter/page/PageManager;


# instance fields
.field private mAccountLoginPage:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

.field private mAccountState:I

.field private mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

.field private mFirstLoginPage:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

.field private mQuickRegisterPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

.field private mResetPasswordPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;


# direct methods
.method static synthetic $SWITCH_TABLE$com$digital$cloud$usercenter$page$PageManager$PageType()[I
    .locals 3

    .prologue
    .line 12
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->$SWITCH_TABLE$com$digital$cloud$usercenter$page$PageManager$PageType:[I

    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->values()[Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_4

    :goto_1
    :try_start_1
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AutoLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_3

    :goto_2
    :try_start_2
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :goto_3
    :try_start_3
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->QuickRegisterPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_1

    :goto_4
    :try_start_4
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ResetPasswordPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_0

    :goto_5
    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->$SWITCH_TABLE$com$digital$cloud$usercenter$page$PageManager$PageType:[I

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_5

    :catch_1
    move-exception v1

    goto :goto_4

    :catch_2
    move-exception v1

    goto :goto_3

    :catch_3
    move-exception v1

    goto :goto_2

    :catch_4
    move-exception v1

    goto :goto_1
.end method

.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 14
    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    .line 15
    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->mParentActivity:Landroid/app/Activity;

    .line 16
    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->mThis:Lcom/digital/cloud/usercenter/page/PageManager;

    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;Landroid/app/Activity;)V
    .locals 1
    .param p1, "ctx"    # Landroid/app/Activity;
    .param p2, "parentCtx"    # Landroid/app/Activity;

    .prologue
    const/4 v0, 0x0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 19
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mFirstLoginPage:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    .line 20
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountLoginPage:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 21
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mQuickRegisterPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    .line 22
    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mResetPasswordPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 24
    const/4 v0, 0x0

    iput v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountState:I

    .line 35
    sput-object p1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    .line 36
    sput-object p2, Lcom/digital/cloud/usercenter/page/PageManager;->mParentActivity:Landroid/app/Activity;

    .line 37
    sput-object p0, Lcom/digital/cloud/usercenter/page/PageManager;->mThis:Lcom/digital/cloud/usercenter/page/PageManager;

    .line 38
    return-void
.end method

.method public static getInstance()Lcom/digital/cloud/usercenter/page/PageManager;
    .locals 1

    .prologue
    .line 41
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager;->mThis:Lcom/digital/cloud/usercenter/page/PageManager;

    return-object v0
.end method


# virtual methods
.method public GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;
    .locals 2
    .param p1, "type"    # Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .prologue
    .line 53
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->$SWITCH_TABLE$com$digital$cloud$usercenter$page$PageManager$PageType()[I

    move-result-object v0

    invoke-virtual {p1}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    .line 76
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 55
    :pswitch_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    if-nez v0, :cond_0

    .line 56
    new-instance v0, Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    .line 57
    :cond_0
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    goto :goto_0

    .line 59
    :pswitch_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mFirstLoginPage:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    if-nez v0, :cond_1

    .line 60
    new-instance v0, Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/page/FirstLoginPage;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mFirstLoginPage:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    .line 61
    :cond_1
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mFirstLoginPage:Lcom/digital/cloud/usercenter/page/FirstLoginPage;

    goto :goto_0

    .line 63
    :pswitch_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountLoginPage:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    if-nez v0, :cond_2

    .line 64
    new-instance v0, Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/page/AccountLoginPage;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountLoginPage:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    .line 65
    :cond_2
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountLoginPage:Lcom/digital/cloud/usercenter/page/AccountLoginPage;

    goto :goto_0

    .line 67
    :pswitch_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mQuickRegisterPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    if-nez v0, :cond_3

    .line 68
    new-instance v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mQuickRegisterPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    .line 69
    :cond_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mQuickRegisterPage:Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    goto :goto_0

    .line 71
    :pswitch_4
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mResetPasswordPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    if-nez v0, :cond_4

    .line 72
    new-instance v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mResetPasswordPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    .line 73
    :cond_4
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mResetPasswordPage:Lcom/digital/cloud/usercenter/page/ResetPasswordPage;

    goto :goto_0

    .line 53
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public getAccountState()I
    .locals 1

    .prologue
    .line 121
    iget v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountState:I

    return v0
.end method

.method public onDestory()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 45
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    if-eqz v0, :cond_0

    .line 46
    iget-object v0, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAutoLoginPage:Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->onDestory()V

    .line 48
    :cond_0
    sput-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mThis:Lcom/digital/cloud/usercenter/page/PageManager;

    .line 49
    sput-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    .line 50
    return-void
.end method

.method public setAccountState(IZ)V
    .locals 2
    .param p1, "state"    # I
    .param p2, "isShow"    # Z

    .prologue
    .line 107
    iput p1, p0, Lcom/digital/cloud/usercenter/page/PageManager;->mAccountState:I

    .line 108
    if-eqz p2, :cond_0

    .line 109
    packed-switch p1, :pswitch_data_0

    .line 118
    :cond_0
    :goto_0
    return-void

    .line 111
    :pswitch_0
    const-string v0, "string"

    const-string v1, "c_qjkdndyxwcjhbc"

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPageParent(Ljava/lang/String;)V

    goto :goto_0

    .line 109
    :pswitch_data_0
    .packed-switch 0x9
        :pswitch_0
    .end packed-switch
.end method

.method public show()V
    .locals 1

    .prologue
    .line 82
    invoke-static {}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->isAutoLogin()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 83
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AutoLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    .line 90
    :goto_0
    return-void

    .line 85
    :cond_0
    sget-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    if-eqz v0, :cond_1

    .line 86
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    goto :goto_0

    .line 88
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {p0, v0}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    goto :goto_0
.end method

.method public showErrorPage(Ljava/lang/String;)V
    .locals 3
    .param p1, "info"    # Ljava/lang/String;

    .prologue
    .line 93
    new-instance v0, Landroid/app/AlertDialog$Builder;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_qd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 94
    return-void
.end method

.method public showErrorPageParent(Ljava/lang/String;)V
    .locals 3
    .param p1, "info"    # Ljava/lang/String;

    .prologue
    .line 97
    new-instance v0, Landroid/app/AlertDialog$Builder;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mParentActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "string"

    const-string v2, "c_qd"

    invoke-static {v1, v2}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 98
    return-void
.end method

.method public showWelcome(Ljava/lang/String;)V
    .locals 3
    .param p1, "userinfo"    # Ljava/lang/String;

    .prologue
    .line 101
    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mParentActivity:Landroid/app/Activity;

    const-class v2, Lcom/digital/cloud/usercenter/page/WelcomePage;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 102
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "userinfo"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 103
    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager;->mParentActivity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 104
    return-void
.end method
