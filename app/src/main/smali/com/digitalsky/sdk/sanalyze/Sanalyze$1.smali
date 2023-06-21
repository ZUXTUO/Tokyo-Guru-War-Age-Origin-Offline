.class Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;
.super Ljava/util/TimerTask;
.source "Sanalyze.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/Sanalyze;->init(Landroid/app/Activity;)V
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
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    .line 57
    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;)Lcom/digitalsky/sdk/sanalyze/Sanalyze;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 67
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1$1;

    invoke-direct {v1, p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1$1;-><init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 74
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 75
    return-void
.end method
