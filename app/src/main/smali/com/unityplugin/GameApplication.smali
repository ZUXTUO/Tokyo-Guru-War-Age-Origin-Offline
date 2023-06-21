.class public Lcom/unityplugin/GameApplication;
.super Lcom/digitalsky/sdk/FreeSdkApplication;
.source "GameApplication.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Lcom/digitalsky/sdk/FreeSdkApplication;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 7

    .prologue
    .line 15
    invoke-super {p0}, Lcom/digitalsky/sdk/FreeSdkApplication;->onCreate()V

    .line 18
    :try_start_0
    invoke-virtual {p0}, Lcom/unityplugin/GameApplication;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/unityplugin/GameApplication;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x80

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    .line 19
    .local v1, "ai":Landroid/content/pm/ApplicationInfo;
    if-nez v1, :cond_0

    .line 32
    .end local v1    # "ai":Landroid/content/pm/ApplicationInfo;
    :goto_0
    return-void

    .line 21
    .restart local v1    # "ai":Landroid/content/pm/ApplicationInfo;
    :cond_0
    iget-object v2, v1, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 22
    .local v2, "data":Landroid/os/Bundle;
    const-string v4, "YvImSdkAppId"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 23
    .local v0, "YvImSdkAppId":Ljava/lang/Object;
    if-eqz v0, :cond_1

    .line 24
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v4}, Lcom/yunva/im/sdk/lib/YvLoginInit;->initApplicationOnCreate(Landroid/content/Context;Ljava/lang/String;)V

    .line 26
    :cond_1
    const-string v4, "YvImSdkAppId"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 27
    .end local v0    # "YvImSdkAppId":Ljava/lang/Object;
    .end local v1    # "ai":Landroid/content/pm/ApplicationInfo;
    .end local v2    # "data":Landroid/os/Bundle;
    :catch_0
    move-exception v3

    .line 29
    .local v3, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v3}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method
