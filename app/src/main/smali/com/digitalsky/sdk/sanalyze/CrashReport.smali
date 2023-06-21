.class public Lcom/digitalsky/sdk/sanalyze/CrashReport;
.super Ljava/lang/Object;
.source "CrashReport.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digitalsky/sdk/sanalyze/CrashReport$asyncHttpRequestListener;
    }
.end annotation


# instance fields
.field private CRASH_REPORT_URL:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mAppId:Ljava/lang/String;

.field private path:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->TAG:Ljava/lang/String;

    .line 26
    iput-object v2, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->path:Ljava/lang/String;

    .line 27
    iput-object v2, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->mAppId:Ljava/lang/String;

    .line 28
    const-string v0, "http://analysis.ppgame.com/data/appdmpservlet"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->CRASH_REPORT_URL:Ljava/lang/String;

    .line 18
    return-void
.end method

.method static synthetic access$0(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->path:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 25
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digitalsky/sdk/sanalyze/CrashReport;Ljava/lang/String;J)V
    .locals 0

    .prologue
    .line 83
    invoke-direct {p0, p1, p2, p3}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->reportCrashInfo(Ljava/lang/String;J)V

    return-void
.end method

.method private checkCrashFile()V
    .locals 2

    .prologue
    .line 45
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;

    invoke-direct {v1, p0}, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;-><init>(Lcom/digitalsky/sdk/sanalyze/CrashReport;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 80
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 81
    return-void
.end method

.method private native nativeInitCrashReport(Ljava/lang/String;)V
.end method

.method private reportCrashInfo(Ljava/lang/String;J)V
    .locals 10
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "crashTime"    # J

    .prologue
    .line 85
    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p1}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 86
    .local v3, "file":Ljava/io/FileInputStream;
    new-instance v4, Ljava/io/BufferedInputStream;

    invoke-direct {v4, v3}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 87
    .local v4, "fileStream":Ljava/io/InputStream;
    const/16 v7, 0x400

    new-array v1, v7, [B

    .line 88
    .local v1, "buff":[B
    const/4 v5, -0x1

    .line 89
    .local v5, "len":I
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 90
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    :goto_0
    const/4 v7, 0x0

    array-length v8, v1

    invoke-virtual {v4, v1, v7, v8}, Ljava/io/InputStream;->read([BII)I

    move-result v5

    if-gtz v5, :cond_0

    .line 94
    iget-object v6, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->CRASH_REPORT_URL:Ljava/lang/String;

    .line 95
    .local v6, "url":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "?appid="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->mAppId:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 96
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&android_id="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "android_id"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 97
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&mac="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "mac"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 98
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&app_version_name="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "app_version_name"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 99
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&crash_time="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 100
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&model="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "model"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "UTF-8"

    invoke-static {v8, v9}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 101
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&system_name="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "system_name"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 102
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&system_version="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "system_version"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 103
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "&machine_code="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "machine_code"

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 105
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v7

    new-instance v8, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;

    invoke-direct {v8, p0, p1}, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;-><init>(Lcom/digitalsky/sdk/sanalyze/CrashReport;Ljava/lang/String;)V

    invoke-static {v6, v7, v8}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 117
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 118
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V

    .line 127
    .end local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v1    # "buff":[B
    .end local v3    # "file":Ljava/io/FileInputStream;
    .end local v4    # "fileStream":Ljava/io/InputStream;
    .end local v5    # "len":I
    .end local v6    # "url":Ljava/lang/String;
    :goto_1
    return-void

    .line 91
    .restart local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v1    # "buff":[B
    .restart local v3    # "file":Ljava/io/FileInputStream;
    .restart local v4    # "fileStream":Ljava/io/InputStream;
    .restart local v5    # "len":I
    :cond_0
    const/4 v7, 0x0

    invoke-virtual {v0, v1, v7, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    goto/16 :goto_0

    .line 119
    .end local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v1    # "buff":[B
    .end local v3    # "file":Ljava/io/FileInputStream;
    .end local v4    # "fileStream":Ljava/io/InputStream;
    .end local v5    # "len":I
    :catch_0
    move-exception v2

    .line 121
    .local v2, "e":Ljava/io/FileNotFoundException;
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/io/FileNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 122
    .end local v2    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v2

    .line 123
    .local v2, "e":Ljava/io/IOException;
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 124
    .end local v2    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v2

    .line 125
    .local v2, "e":Ljava/lang/Exception;
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method


# virtual methods
.method public init(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 3
    .param p1, "ctx"    # Landroid/app/Activity;
    .param p2, "appId"    # Ljava/lang/String;

    .prologue
    .line 33
    iput-object p2, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->mAppId:Ljava/lang/String;

    .line 34
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/Android/data/usercenter."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 35
    const-string v2, "/crash/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 34
    iput-object v1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->path:Ljava/lang/String;

    .line 36
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->path:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 37
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 38
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 40
    :cond_0
    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->checkCrashFile()V

    .line 41
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport;->path:Ljava/lang/String;

    invoke-direct {p0, v1}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->nativeInitCrashReport(Ljava/lang/String;)V

    .line 42
    return-void
.end method
