.class public Lcom/digitalsky/ghoul/installer/InstallImpl;
.super Ljava/lang/Object;
.source "InstallImpl.java"


# static fields
.field private static isInstalling:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 86
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digitalsky/ghoul/installer/InstallImpl;->isInstalling:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static coverInstall(Ljava/lang/String;)I
    .locals 13
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    const/4 v12, 0x0

    .line 18
    if-eqz p0, :cond_0

    const-string v10, ""

    invoke-virtual {p0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_1

    .line 20
    :cond_0
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_PATH_ERROR:I

    .line 83
    :goto_0
    return v10

    .line 23
    :cond_1
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 24
    .local v1, "apkFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v10

    if-nez v10, :cond_2

    .line 26
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_FILE_NOT_EXIST:I

    goto :goto_0

    .line 29
    :cond_2
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 30
    .local v0, "act":Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v9

    .line 31
    .local v9, "packageManager":Landroid/content/pm/PackageManager;
    const/4 v8, 0x0

    .line 33
    .local v8, "packInfo":Landroid/content/pm/PackageInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    const/4 v11, 0x0

    invoke-virtual {v9, v10, v11}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v8

    .line 38
    :goto_1
    if-nez v8, :cond_3

    .line 40
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_READ_MY_INFO_FAILED:I

    goto :goto_0

    .line 34
    :catch_0
    move-exception v5

    .line 35
    .local v5, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v5}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_1

    .line 43
    .end local v5    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_3
    invoke-virtual {v9, p0, v12}, Landroid/content/pm/PackageManager;->getPackageArchiveInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v3

    .line 44
    .local v3, "apkPackgeInfo":Landroid/content/pm/PackageInfo;
    if-nez v3, :cond_4

    .line 46
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_READ_APK_INFO_FAILED:I

    goto :goto_0

    .line 49
    :cond_4
    iget-object v2, v3, Landroid/content/pm/PackageInfo;->packageName:Ljava/lang/String;

    .line 50
    .local v2, "apkPackageName":Ljava/lang/String;
    iget-object v6, v8, Landroid/content/pm/PackageInfo;->packageName:Ljava/lang/String;

    .line 51
    .local v6, "installPackageName":Ljava/lang/String;
    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_5

    .line 53
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_PACKAGE_NAME_NOT_EQUAL:I

    goto :goto_0

    .line 71
    :cond_5
    iget v4, v3, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 72
    .local v4, "apkVersion":I
    iget v7, v8, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 73
    .local v7, "installVersion":I
    if-ge v4, v7, :cond_6

    .line 75
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_APK_VERSION_TOO_LOW:I

    goto :goto_0

    .line 82
    :cond_6
    invoke-static {p0}, Lcom/digitalsky/ghoul/installer/InstallImpl;->install(Ljava/lang/String;)Z

    .line 83
    sget v10, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_INSTALLING:I

    goto :goto_0
.end method

.method public static install(Ljava/lang/String;)Z
    .locals 5
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 89
    sget-boolean v3, Lcom/digitalsky/ghoul/installer/InstallImpl;->isInstalling:Z

    if-eqz v3, :cond_0

    .line 105
    :goto_0
    return v2

    .line 94
    :cond_0
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 100
    .local v0, "act":Landroid/app/Activity;
    new-instance v1, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 101
    .local v1, "intent":Landroid/content/Intent;
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "file://"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    const-string v4, "application/vnd.android.package-archive"

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 102
    invoke-virtual {v0, v1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 103
    invoke-static {v2}, Ljava/lang/System;->exit(I)V

    .line 105
    const/4 v2, 0x1

    goto :goto_0
.end method
