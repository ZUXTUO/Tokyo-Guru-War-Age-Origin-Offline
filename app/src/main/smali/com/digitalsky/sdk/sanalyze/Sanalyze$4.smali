.class Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;
.super Ljava/lang/Object;
.source "Sanalyze.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportCheck()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    .line 260
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 3
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 265
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Lua report end, return:"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 266
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v0

    if-nez p1, :cond_0

    const-string p1, ""

    .end local p1    # "res":Ljava/lang/String;
    :cond_0
    invoke-static {v0, p1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 267
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$4(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 268
    :try_start_0
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$5(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Z)V

    .line 267
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 270
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$6(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V

    .line 271
    return-void

    .line 267
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
