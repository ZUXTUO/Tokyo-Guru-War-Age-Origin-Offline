.class Lcom/digitalsky/sdk/sanalyze/CrashReport$1;
.super Ljava/lang/Object;
.source "CrashReport.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/CrashReport;->checkCrashFile()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/sanalyze/CrashReport;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 12

    .prologue
    const/4 v6, 0x0

    .line 50
    const-wide/16 v4, 0x0

    .line 51
    .local v4, "lastTime":J
    const/4 v3, 0x0

    .line 52
    .local v3, "newPath":Ljava/lang/String;
    :try_start_0
    new-instance v7, Ljava/io/File;

    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$0(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    .line 54
    .local v2, "files":[Ljava/io/File;
    array-length v8, v2

    move v7, v6

    :goto_0
    if-lt v7, v8, :cond_0

    .line 64
    array-length v7, v2

    :goto_1
    if-lt v6, v7, :cond_2

    .line 71
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_4

    .line 72
    iget-object v6, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v6, v3, v4, v5}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$2(Lcom/digitalsky/sdk/sanalyze/CrashReport;Ljava/lang/String;J)V

    .line 79
    .end local v2    # "files":[Ljava/io/File;
    :goto_2
    return-void

    .line 54
    .restart local v2    # "files":[Ljava/io/File;
    :cond_0
    aget-object v1, v2, v7

    .line 55
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v9

    const-string v10, ".dmp"

    invoke-virtual {v9, v10}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-lez v9, :cond_1

    .line 56
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v10

    cmp-long v9, v10, v4

    if-lez v9, :cond_1

    .line 57
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    .line 58
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    .line 59
    iget-object v9, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v9}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, "path:"

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " time:"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 54
    :cond_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 64
    .end local v1    # "file":Ljava/io/File;
    :cond_2
    aget-object v1, v2, v6

    .line 65
    .restart local v1    # "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_3

    .line 66
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v8}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, "delete path:"

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " time:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 64
    :cond_3
    add-int/lit8 v6, v6, 0x1

    goto/16 :goto_1

    .line 74
    .end local v1    # "file":Ljava/io/File;
    :cond_4
    iget-object v6, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v6}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "No crash file."

    invoke-static {v6, v7}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_2

    .line 76
    .end local v2    # "files":[Ljava/io/File;
    :catch_0
    move-exception v0

    .line 77
    .local v0, "e":Ljava/lang/Exception;
    iget-object v6, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$1;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v6}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_2
.end method
