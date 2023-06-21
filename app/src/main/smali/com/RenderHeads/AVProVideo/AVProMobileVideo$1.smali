.class final Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;
.super Ljava/lang/Object;
.source "AVProMobileVideo.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->Initialise(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;


# direct methods
.method constructor <init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V
    .locals 0

    .prologue
    .line 304
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    .prologue
    .line 308
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-static {v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$002(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;Landroid/os/Handler;)Landroid/os/Handler;

    .line 309
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    new-instance v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;

    invoke-direct {v1, p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;-><init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;)V

    invoke-static {v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$102(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    .line 319
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-static {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$000(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-static {v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$100(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-static {}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$300()Ljava/util/Random;

    move-result-object v2

    const/16 v3, 0x7d0

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 320
    return-void
.end method
