.class public Lcom/digitalsky/ghoul/reader/AssetReader;
.super Ljava/lang/Object;
.source "AssetReader.java"


# instance fields
.field private m_inputStream:Ljava/io/InputStream;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    .line 9
    return-void
.end method


# virtual methods
.method public Open(Ljava/lang/String;)I
    .locals 5
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    .line 16
    :try_start_0
    iget-object v2, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    if-eqz v2, :cond_0

    .line 18
    iget-object v2, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 19
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    .line 22
    :cond_0
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 24
    .local v0, "at":Landroid/app/Activity;
    const-string v2, "ghoul AssetReader"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "activity name"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/app/Activity;->getLocalClassName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 26
    sget-object v2, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    invoke-virtual {v2, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    .line 27
    iget-object v2, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->available()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 32
    .end local v0    # "at":Landroid/app/Activity;
    :goto_0
    return v2

    .line 29
    :catch_0
    move-exception v1

    .line 31
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "ghoul AssetReader"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Open exception:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 32
    const/4 v2, -0x1

    goto :goto_0
.end method

.method public Read([B)I
    .locals 4
    .param p1, "buff"    # [B

    .prologue
    .line 38
    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    if-nez v1, :cond_1

    .line 40
    :cond_0
    const/4 v1, -0x1

    .line 53
    :goto_0
    return v1

    .line 45
    :cond_1
    :try_start_0
    iget-object v1, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    invoke-virtual {v1, p1}, Ljava/io/InputStream;->read([B)I

    .line 46
    iget-object v1, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 47
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/digitalsky/ghoul/reader/AssetReader;->m_inputStream:Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 48
    const/4 v1, 0x0

    goto :goto_0

    .line 50
    :catch_0
    move-exception v0

    .line 52
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ghoul AssetReader"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Read exception:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    const/4 v1, -0x2

    goto :goto_0
.end method
