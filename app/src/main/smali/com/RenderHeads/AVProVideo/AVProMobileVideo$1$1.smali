.class final Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;
.super Ljava/lang/Object;
.source "AVProMobileVideo.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;


# direct methods
.method constructor <init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;)V
    .locals 0

    .prologue
    .line 310
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;->this$1:Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    .prologue
    .line 314
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;->this$1:Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;

    iget-object v1, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-static {v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$200(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V

    .line 315
    invoke-static {}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$300()Ljava/util/Random;

    move-result-object v1

    const/16 v2, 0x3e8

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/lit16 v0, v1, 0x3e8

    .line 316
    .local v0, "nextDelay":I
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1$1;->this$1:Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;

    iget-object v1, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-static {v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->access$000(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)Landroid/os/Handler;

    move-result-object v1

    int-to-long v2, v0

    invoke-virtual {v1, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 317
    return-void
.end method
