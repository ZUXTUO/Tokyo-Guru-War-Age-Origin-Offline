.class public Lcom/digitalsky/ghoul/installer/Utils;
.super Ljava/lang/Object;
.source "Utils.java"


# static fields
.field public static TAG:Ljava/lang/String;

.field static m_currentActivityHolder:Landroid/app/Activity;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    const-string v0, "TGInstaller"

    sput-object v0, Lcom/digitalsky/ghoul/installer/Utils;->TAG:Ljava/lang/String;

    .line 87
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/ghoul/installer/Utils;->m_currentActivityHolder:Landroid/app/Activity;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static GetCurrentActivity()Landroid/app/Activity;
    .locals 2

    .prologue
    .line 66
    const/4 v0, 0x0

    .line 67
    .local v0, "act":Landroid/app/Activity;
    sget-object v1, Lcom/digitalsky/ghoul/installer/Utils;->m_currentActivityHolder:Landroid/app/Activity;

    if-nez v1, :cond_0

    .line 69
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 76
    :goto_0
    return-object v0

    .line 73
    :cond_0
    sget-object v0, Lcom/digitalsky/ghoul/installer/Utils;->m_currentActivityHolder:Landroid/app/Activity;

    goto :goto_0
.end method

.method public static SendMessageToUnity(Ljava/lang/String;)V
    .locals 2
    .param p0, "param"    # Ljava/lang/String;

    .prologue
    .line 81
    sget-object v0, Lcom/digitalsky/ghoul/installer/Utils;->m_currentActivityHolder:Landroid/app/Activity;

    if-nez v0, :cond_0

    .line 83
    const-string v0, "_AndroidMsgReceiver"

    const-string v1, "OnMessage"

    invoke-static {v0, v1, p0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    :cond_0
    return-void
.end method

.method public static SetCurrentAcitvity(Landroid/app/Activity;)V
    .locals 0
    .param p0, "act"    # Landroid/app/Activity;

    .prologue
    .line 90
    sput-object p0, Lcom/digitalsky/ghoul/installer/Utils;->m_currentActivityHolder:Landroid/app/Activity;

    .line 91
    return-void
.end method

.method public static getExternalFilesDir()Ljava/lang/String;
    .locals 4

    .prologue
    .line 52
    const-string v2, ""

    .line 55
    .local v2, "result":Ljava/lang/String;
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 56
    .local v0, "act":Landroid/app/Activity;
    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Landroid/app/Activity;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 57
    .local v1, "f":Ljava/io/File;
    if-eqz v1, :cond_0

    .line 59
    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v2

    .line 61
    :cond_0
    return-object v2
.end method

.method public static getFilesDirPath()Ljava/lang/String;
    .locals 4

    .prologue
    .line 38
    const-string v2, ""

    .line 41
    .local v2, "result":Ljava/lang/String;
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 42
    .local v0, "act":Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->getFilesDir()Ljava/io/File;

    move-result-object v1

    .line 43
    .local v1, "f":Ljava/io/File;
    if-eqz v1, :cond_0

    .line 45
    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v2

    .line 47
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public static getPackageName()Ljava/lang/String;
    .locals 7

    .prologue
    .line 115
    const-string v4, ""

    .line 116
    .local v4, "pn":Ljava/lang/String;
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 117
    .local v0, "act":Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 118
    .local v3, "packageManager":Landroid/content/pm/PackageManager;
    const/4 v2, 0x0

    .line 120
    .local v2, "packInfo":Landroid/content/pm/PackageInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v3, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 125
    :goto_0
    if-eqz v2, :cond_0

    .line 127
    iget-object v4, v2, Landroid/content/pm/PackageInfo;->packageName:Ljava/lang/String;

    .line 130
    :cond_0
    return-object v4

    .line 121
    :catch_0
    move-exception v1

    .line 122
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getSDCardPath()Ljava/lang/String;
    .locals 5

    .prologue
    .line 21
    const-string v2, ""

    .line 22
    .local v2, "result":Ljava/lang/String;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v3

    const-string v4, "mounted"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 23
    .local v0, "cdCardExist":Z
    if-eqz v0, :cond_0

    .line 26
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    .line 27
    .local v1, "f":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v2

    .line 33
    .end local v1    # "f":Ljava/io/File;
    :goto_0
    return-object v2

    .line 31
    :cond_0
    sget-object v3, Lcom/digitalsky/ghoul/installer/Utils;->TAG:Ljava/lang/String;

    const-string v4, "sd card not exist"

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static getSignatureHashCode()I
    .locals 8

    .prologue
    .line 135
    const/4 v3, 0x0

    .line 136
    .local v3, "hash":I
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 137
    .local v0, "act":Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 138
    .local v5, "packageManager":Landroid/content/pm/PackageManager;
    const/4 v4, 0x0

    .line 140
    .local v4, "packInfo":Landroid/content/pm/PackageInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x40

    invoke-virtual {v5, v6, v7}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 145
    :goto_0
    if-eqz v4, :cond_0

    .line 147
    iget-object v1, v4, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 148
    .local v1, "apkSign":[Landroid/content/pm/Signature;
    array-length v6, v1

    if-lez v6, :cond_0

    .line 150
    const/4 v6, 0x0

    aget-object v6, v1, v6

    invoke-virtual {v6}, Landroid/content/pm/Signature;->hashCode()I

    move-result v3

    .line 153
    .end local v1    # "apkSign":[Landroid/content/pm/Signature;
    :cond_0
    return v3

    .line 141
    :catch_0
    move-exception v2

    .line 142
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v2}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getVersionCode()I
    .locals 7

    .prologue
    .line 95
    const/4 v4, -0x1

    .line 96
    .local v4, "ret":I
    invoke-static {}, Lcom/digitalsky/ghoul/installer/Utils;->GetCurrentActivity()Landroid/app/Activity;

    move-result-object v0

    .line 97
    .local v0, "act":Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 98
    .local v3, "packageManager":Landroid/content/pm/PackageManager;
    const/4 v2, 0x0

    .line 100
    .local v2, "packInfo":Landroid/content/pm/PackageInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v3, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 105
    :goto_0
    if-eqz v2, :cond_0

    .line 107
    iget v4, v2, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 110
    :cond_0
    return v4

    .line 101
    :catch_0
    move-exception v1

    .line 102
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method
