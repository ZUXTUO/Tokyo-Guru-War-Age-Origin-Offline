.class public Lcom/digitalsky/ghoul/AndroidUtil;
.super Ljava/lang/Object;
.source "AndroidUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getActivity()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    return-object v0
.end method

.method public static getPathFreeSpace(Ljava/lang/String;)J
    .locals 10
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 29
    const-wide/16 v6, 0x0

    .line 33
    .local v6, "ret":J
    :try_start_0
    new-instance v5, Landroid/os/StatFs;

    invoke-direct {v5, p0}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 34
    .local v5, "sf":Landroid/os/StatFs;
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0x12

    if-ge v8, v9, :cond_0

    .line 36
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v8

    int-to-long v2, v8

    .line 37
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v8

    int-to-long v0, v8

    .line 38
    .local v0, "blockNum":J
    mul-long v6, v2, v0

    .line 50
    .end local v0    # "blockNum":J
    .end local v2    # "blockSize":J
    .end local v5    # "sf":Landroid/os/StatFs;
    :goto_0
    return-wide v6

    .line 42
    .restart local v5    # "sf":Landroid/os/StatFs;
    :cond_0
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBytes()J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v6

    goto :goto_0

    .line 45
    .end local v5    # "sf":Landroid/os/StatFs;
    :catch_0
    move-exception v4

    .line 47
    .local v4, "e":Ljava/lang/Exception;
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static sendMessageToUnity(Ljava/lang/String;)V
    .locals 2
    .param p0, "param"    # Ljava/lang/String;

    .prologue
    .line 22
    invoke-static {}, Lcom/digitalsky/ghoul/AndroidUtil;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 23
    const-string v0, "_AndroidMsgReceiver"

    const-string v1, "OnMessage"

    invoke-static {v0, v1, p0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 25
    :cond_0
    return-void
.end method
