.class public Lcom/digitalsky/ghoul/installer/InstallerBackActivity;
.super Landroid/app/Activity;
.source "InstallerBackActivity.java"


# instance fields
.field private REPONSECODE:I

.field private isInstalling:Z

.field private m_apkPath:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 11
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 14
    const/16 v0, 0x8cf

    iput v0, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->REPONSECODE:I

    .line 15
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->isInstalling:Z

    .line 11
    return-void
.end method

.method private startInstall()V
    .locals 3

    .prologue
    .line 33
    iget-boolean v1, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->isInstalling:Z

    if-eqz v1, :cond_0

    .line 42
    :goto_0
    return-void

    .line 37
    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->isInstalling:Z

    .line 38
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 40
    .local v0, "intent":Landroid/content/Intent;
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "file://"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->m_apkPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "application/vnd.android.package-archive"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 41
    iget v1, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->REPONSECODE:I

    invoke-virtual {p0, v0, v1}, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_0
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 45
    iget v0, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->REPONSECODE:I

    if-ne p1, v0, :cond_0

    .line 47
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "OnInstallerAndroidMsg|"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget v1, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_INSTALL_FAILED:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/ghoul/installer/Utils;->SendMessageToUnity(Ljava/lang/String;)V

    .line 48
    sget-object v0, Lcom/digitalsky/ghoul/installer/Utils;->TAG:Ljava/lang/String;

    const-string v1, "onActivityResult"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 49
    invoke-virtual {p0}, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->finish()V

    .line 51
    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 18
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 20
    invoke-virtual {p0}, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 21
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "apkPath"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->m_apkPath:Ljava/lang/String;

    .line 22
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 26
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 28
    invoke-direct {p0}, Lcom/digitalsky/ghoul/installer/InstallerBackActivity;->startInstall()V

    .line 29
    return-void
.end method
