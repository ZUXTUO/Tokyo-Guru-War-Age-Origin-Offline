.class Lcom/digitalsky/sdk/FreeSdkSplash$1;
.super Ljava/lang/Object;
.source "FreeSdkSplash.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/FreeSdkSplash;->start(Ljava/lang/Class;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/FreeSdkSplash;

.field private final synthetic val$intent:Landroid/content/Intent;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/FreeSdkSplash;Landroid/content/Intent;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/FreeSdkSplash$1;->this$0:Lcom/digitalsky/sdk/FreeSdkSplash;

    iput-object p2, p0, Lcom/digitalsky/sdk/FreeSdkSplash$1;->val$intent:Landroid/content/Intent;

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 65
    iget-object v0, p0, Lcom/digitalsky/sdk/FreeSdkSplash$1;->this$0:Lcom/digitalsky/sdk/FreeSdkSplash;

    iget-object v1, p0, Lcom/digitalsky/sdk/FreeSdkSplash$1;->val$intent:Landroid/content/Intent;

    invoke-virtual {v0, v1}, Lcom/digitalsky/sdk/FreeSdkSplash;->startActivity(Landroid/content/Intent;)V

    .line 66
    iget-object v0, p0, Lcom/digitalsky/sdk/FreeSdkSplash$1;->this$0:Lcom/digitalsky/sdk/FreeSdkSplash;

    invoke-virtual {v0}, Lcom/digitalsky/sdk/FreeSdkSplash;->finish()V

    .line 67
    return-void
.end method
