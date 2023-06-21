.class Lcom/digitalsky/sdk/sanalyze/CrashReport$2;
.super Ljava/lang/Object;
.source "CrashReport.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/CrashReport;->reportCrashInfo(Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

.field private final synthetic val$path:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/sanalyze/CrashReport;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    iput-object p2, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;->val$path:Ljava/lang/String;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 110
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;->this$0:Lcom/digitalsky/sdk/sanalyze/CrashReport;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/CrashReport;->access$1(Lcom/digitalsky/sdk/sanalyze/CrashReport;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Dump Report back. data : "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " path:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;->val$path:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 111
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 112
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/CrashReport$2;->val$path:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 114
    :cond_0
    return-void
.end method
