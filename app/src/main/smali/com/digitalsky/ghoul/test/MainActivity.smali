.class public Lcom/digitalsky/ghoul/test/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 33
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->getSDCardPath()Ljava/lang/String;

    move-result-object v1

    .line 34
    .local v1, "sdCard":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, "/installer.apk"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 35
    .local v2, "testPath":Ljava/lang/String;
    invoke-static {v2}, Lcom/digitalsky/ghoul/installer/InstallerInterface;->startInstaller(Ljava/lang/String;)I

    move-result v0

    .line 36
    .local v0, "ret":I
    sget v3, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_VERSION_EQUAL:I

    if-ne v0, v3, :cond_0

    .line 38
    const-string v3, "has installed"

    const/4 v4, 0x1

    invoke-static {p0, v3, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/Toast;->show()V

    .line 40
    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 18
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 19
    const/high16 v1, 0x7f030000

    invoke-virtual {p0, v1}, Lcom/digitalsky/ghoul/test/MainActivity;->setContentView(I)V

    .line 21
    invoke-static {p0}, Lcom/digitalsky/ghoul/installer/Utils;->SetCurrentAcitvity(Landroid/app/Activity;)V

    .line 23
    invoke-static {}, Lcom/digitalsky/ghoul/installer/InstallerInterface;->getVersionCode()I

    .line 24
    invoke-static {}, Lcom/digitalsky/ghoul/installer/InstallerInterface;->getPackageName()Ljava/lang/String;

    .line 25
    invoke-static {}, Lcom/digitalsky/ghoul/installer/InstallerInterface;->getSignatureHashCode()I

    .line 27
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    .line 28
    .local v0, "sdcardDir":Ljava/io/File;
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->getFilesDirPath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/digitalsky/ghoul/AndroidUtil;->getPathFreeSpace(Ljava/lang/String;)J

    .line 29
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 50
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 52
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 44
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 46
    return-void
.end method
