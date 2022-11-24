.class Lcom/digitalsky/sdk/sanalyze/Sanalyze$1$1;
.super Ljava/lang/Object;
.source "Sanalyze.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1$1;->this$1:Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 72
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1$1;->this$1:Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;

    invoke-static {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;->access$0(Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;)Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    move-result-object v0

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->CHANNEL:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$0(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Ljava/lang/String;)V

    .line 73
    return-void
.end method
