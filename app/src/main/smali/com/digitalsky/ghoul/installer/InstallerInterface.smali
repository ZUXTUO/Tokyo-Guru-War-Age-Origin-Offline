.class public Lcom/digitalsky/ghoul/installer/InstallerInterface;
.super Ljava/lang/Object;
.source "InstallerInterface.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 28
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSignatureHashCode()I
    .locals 1

    .prologue
    .line 33
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->getSignatureHashCode()I

    move-result v0

    return v0
.end method

.method public static getVersionCode()I
    .locals 1

    .prologue
    .line 23
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->getVersionCode()I

    move-result v0

    return v0
.end method

.method public static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    .line 18
    sget-object v0, Lcom/digitalsky/ghoul/installer/Utils;->TAG:Ljava/lang/String;

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 19
    return-void
.end method

.method public static startInstaller(Ljava/lang/String;)I
    .locals 2
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 8
    sget-object v0, Lcom/digitalsky/ghoul/installer/Utils;->TAG:Ljava/lang/String;

    const-string v1, "startInstaller"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 13
    invoke-static {p0}, Lcom/digitalsky/ghoul/installer/InstallImpl;->coverInstall(Ljava/lang/String;)I

    move-result v0

    return v0
.end method
