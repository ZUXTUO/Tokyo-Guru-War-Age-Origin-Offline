.class public Lcom/digitalsky/ghoul/reader/AssetReaderEx;
.super Ljava/lang/Object;
.source "AssetReaderEx.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static Load(Ljava/lang/String;)[B
    .locals 7
    .param p0, "fileName"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 12
    const/4 v1, 0x0

    .line 15
    .local v1, "inputStream":Ljava/io/InputStream;
    :try_start_0
    sget-object v4, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-virtual {v4}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v4

    invoke-virtual {v4, p0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    .line 16
    if-nez v1, :cond_0

    move-object v2, v3

    .line 28
    :goto_0
    return-object v2

    .line 21
    :cond_0
    invoke-virtual {v1}, Ljava/io/InputStream;->available()I

    move-result v4

    new-array v2, v4, [B

    .line 22
    .local v2, "ret":[B
    invoke-virtual {v1, v2}, Ljava/io/InputStream;->read([B)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 25
    .end local v2    # "ret":[B
    :catch_0
    move-exception v0

    .line 27
    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "ghoul AssetReaderEx"

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Load exception:"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, v3

    .line 28
    goto :goto_0
.end method
