.class Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;
.super Ljava/lang/Object;
.source "Sanalyze.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/Sanalyze;->onEvent(Ljava/lang/String;Ljava/util/Map;)V
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
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    .line 202
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 207
    if-nez p1, :cond_0

    .line 208
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onEvent result null"

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 212
    :goto_0
    return-void

    .line 210
    :cond_0
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "onEvent result:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
