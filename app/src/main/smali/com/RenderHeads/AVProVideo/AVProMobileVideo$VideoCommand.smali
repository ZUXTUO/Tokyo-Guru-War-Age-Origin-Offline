.class final Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;
.super Ljava/lang/Object;
.source "AVProMobileVideo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "VideoCommand"
.end annotation


# instance fields
.field _command:I

.field _floatValue:F

.field _intValue:I

.field final synthetic this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;


# direct methods
.method private constructor <init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V
    .locals 1

    .prologue
    .line 108
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->this$0:Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 110
    const/4 v0, -0x1

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    .line 111
    const/4 v0, 0x0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_intValue:I

    .line 112
    const/4 v0, 0x0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_floatValue:F

    return-void
.end method

.method synthetic constructor <init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;B)V
    .locals 0
    .param p1, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .prologue
    .line 108
    invoke-direct {p0, p1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;-><init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V

    return-void
.end method
