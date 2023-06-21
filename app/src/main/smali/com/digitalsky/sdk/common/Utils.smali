.class public Lcom/digitalsky/sdk/common/Utils;
.super Ljava/lang/Object;
.source "Utils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digitalsky/sdk/common/Utils$Callback;,
        Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;
    }
.end annotation


# static fields
.field private static TAG:Ljava/lang/String;

.field public static mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 22
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/common/Utils;->mContext:Landroid/content/Context;

    .line 24
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/common/Utils;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Ljava/lang/String;
    .locals 1

    .prologue
    .line 24
    sget-object v0, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V
    .locals 4
    .param p0, "reqUrl"    # Ljava/lang/String;
    .param p1, "data"    # [B
    .param p2, "callback"    # Lcom/digitalsky/sdk/common/Utils$Callback;

    .prologue
    .line 61
    sget-object v1, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 63
    :try_start_0
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/digitalsky/sdk/common/Utils$2;

    invoke-direct {v2, p0, p1, p2}, Lcom/digitalsky/sdk/common/Utils$2;-><init>(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 89
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 97
    :cond_0
    :goto_0
    return-void

    .line 90
    :catch_0
    move-exception v0

    .line 91
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "return "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 92
    if-eqz p2, :cond_0

    .line 93
    const-string v1, ""

    invoke-interface {p2, v1}, Lcom/digitalsky/sdk/common/Utils$Callback;->onCallback(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static init(Landroid/content/Context;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 27
    sput-object p0, Lcom/digitalsky/sdk/common/Utils;->mContext:Landroid/content/Context;

    .line 29
    return-void
.end method

.method public static loadConfig(Landroid/content/Context;Ljava/lang/String;)Ljava/util/Map;
    .locals 4
    .param p0, "act"    # Landroid/content/Context;
    .param p1, "fileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 140
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    invoke-static {v1}, Lcom/digitalsky/sdk/common/Utils;->loadConfig(Ljava/io/InputStream;)Ljava/util/Map;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 146
    :goto_0
    return-object v1

    .line 141
    :catch_0
    move-exception v0

    .line 144
    .local v0, "e":Ljava/io/IOException;
    sget-object v1, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "loadConfig "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 146
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static loadConfig(Ljava/io/InputStream;)Ljava/util/Map;
    .locals 7
    .param p0, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 125
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 126
    .local v0, "config":Ljava/util/Properties;
    const/4 v2, 0x0

    .line 128
    .local v2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual {v0, p0}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 129
    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3, v0}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local v3, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v2, v3

    .line 135
    .end local v3    # "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v2    # "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_0
    return-object v2

    .line 130
    :catch_0
    move-exception v1

    .line 133
    .local v1, "e":Ljava/io/IOException;
    sget-object v4, Lcom/digitalsky/sdk/common/Utils;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "loadConfig "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static readStream(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 6
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 100
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 101
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    const/16 v3, 0x400

    new-array v1, v3, [B

    .line 102
    .local v1, "buffer":[B
    const/4 v2, 0x0

    .line 103
    .local v2, "read":I
    :goto_0
    array-length v3, v1

    invoke-virtual {p0, v1, v4, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    .line 106
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 107
    new-instance v3, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-direct {v3, v4, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v3

    .line 104
    :cond_0
    invoke-virtual {v0, v1, v4, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0
.end method

.method public static showToast(Ljava/lang/String;)V
    .locals 2
    .param p0, "text"    # Ljava/lang/String;

    .prologue
    .line 113
    new-instance v0, Landroid/os/Handler;

    sget-object v1, Lcom/digitalsky/sdk/common/Utils;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 114
    .local v0, "handler":Landroid/os/Handler;
    new-instance v1, Lcom/digitalsky/sdk/common/Utils$3;

    invoke-direct {v1, p0}, Lcom/digitalsky/sdk/common/Utils$3;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 122
    return-void
.end method

.method public static verify(Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;)V
    .locals 4
    .param p0, "data"    # Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;
    .param p1, "callback"    # Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;

    .prologue
    .line 40
    iget-boolean v1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->skipVerfy:Z

    if-eqz v1, :cond_0

    .line 41
    new-instance v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;

    iget-object v1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;-><init>(Ljava/lang/String;)V

    .line 42
    .local v0, "res":Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;
    iget v1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->platform_type:I

    iput v1, v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->platform_type:I

    .line 43
    iget-object v1, p0, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->ext:Ljava/lang/String;

    iput-object v1, v0, Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;->ext:Ljava/lang/String;

    .line 44
    invoke-interface {p1, v0}, Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;->onCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V

    .line 58
    .end local v0    # "res":Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;
    :goto_0
    return-void

    .line 47
    :cond_0
    invoke-static {}, Lcom/digitalsky/sdk/common/Constant;->getVerifyUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;->toVerifyData()[B

    move-result-object v2

    new-instance v3, Lcom/digitalsky/sdk/common/Utils$1;

    invoke-direct {v3, p0, p1}, Lcom/digitalsky/sdk/common/Utils$1;-><init>(Lcom/digitalsky/sdk/user/FreeSdkVerifyRequest;Lcom/digitalsky/sdk/common/Utils$VerifyCallBack;)V

    invoke-static {v1, v2, v3}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    goto :goto_0
.end method
