.class public Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
.super Ljava/lang/Object;
.source "AVProMobileVideo.java"

# interfaces
.implements Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;
.implements Landroid/media/MediaPlayer$OnCompletionListener;
.implements Landroid/media/MediaPlayer$OnErrorListener;
.implements Landroid/media/MediaPlayer$OnPreparedListener;
.implements Landroid/media/MediaPlayer$OnVideoSizeChangedListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;
    }
.end annotation


# static fields
.field private static final EXT_DASH:Ljava/lang/String; = ".mpd"

.field private static final EXT_HLS:Ljava/lang/String; = ".m3u8"

.field private static final EXT_SS:Ljava/lang/String; = ".ism"

.field private static VideoCommand_Pause:I = 0x0

.field private static VideoCommand_Play:I = 0x0

.field private static VideoCommand_Seek:I = 0x0

.field private static VideoCommand_Stop:I = 0x0

.field private static VideoState_Buffering:I = 0x0

.field private static VideoState_Finished:I = 0x0

.field private static VideoState_Idle:I = 0x0

.field private static VideoState_Opening:I = 0x0

.field private static VideoState_Paused:I = 0x0

.field private static VideoState_Playing:I = 0x0

.field private static VideoState_Prepared:I = 0x0

.field private static VideoState_Preparing:I = 0x0

.field private static VideoState_Stopped:I = 0x0

.field public static final kUnityGfxRendererOpenGLES20:I = 0x8

.field public static final kUnityGfxRendererOpenGLES30:I = 0xb

.field private static s_AllPlayers:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/RenderHeads/AVProVideo/AVProMobileVideo;",
            ">;"
        }
    .end annotation
.end field

.field private static s_PlayersIndex:Ljava/lang/Integer;

.field private static s_Random:Ljava/util/Random;

.field private static s_bCompressedWatermarkDataGood:Z

.field private static s_bWatermarked:Z


# instance fields
.field private m_AudioMuted:Z

.field private m_AudioPan:F

.field private m_AudioVolume:F

.field private m_CommandQueue:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue",
            "<",
            "Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;",
            ">;"
        }
    .end annotation
.end field

.field private m_Context:Landroid/content/Context;

.field private m_DurationMs:J

.field private m_FrameCount:I

.field m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

.field m_GlRender_Watermark:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

.field private m_Height:I

.field private m_MediaPlayerAPI:Landroid/media/MediaPlayer;

.field private m_Playback_FrameRate:F

.field private m_Playback_LastSystemTimeMS:J

.field private m_Playback_NumberFrames:J

.field private m_Playback_Rate:F

.field private m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

.field private m_VideoState:I

.field private m_WatermarkPosition:Landroid/graphics/Point;

.field private m_WatermarkPositionRunnable:Ljava/lang/Runnable;

.field private m_WatermarkScale:F

.field private m_WatermarkSizeHandler:Landroid/os/Handler;

.field private m_Width:I

.field private m_bCanUseGLBindVertexArray:Z

.field private m_bInPrepared:Z

.field private m_bIsStream:Z

.field private m_bLooping:Z

.field private m_bSourceHasAudio:Z

.field private m_bSourceHasSubtitles:Z

.field private m_bSourceHasTimedText:Z

.field private m_bSourceHasVideo:Z

.field private m_bVideo_AcceptCommands:Z

.field private m_bVideo_CreateRenderSurface:Z

.field private m_bVideo_DestoyRenderSurface:Z

.field private m_bVideo_RenderSurfaceCreated:Z

.field private m_bWatermarkDataGood:Z

.field private m_iNumberFramesAvailable:I

.field private m_iOpenGLVersion:I

.field private m_iPlayerIndex:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x3

    const/4 v3, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 61
    const/4 v0, 0x0

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    .line 63
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    .line 64
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_PlayersIndex:Ljava/lang/Integer;

    .line 66
    sput-boolean v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    .line 68
    sput-boolean v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bCompressedWatermarkDataGood:Z

    .line 103
    sput v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Play:I

    .line 104
    sput v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Pause:I

    .line 105
    sput v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Stop:I

    .line 106
    sput v4, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Seek:I

    .line 116
    sput v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Idle:I

    .line 117
    sput v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Opening:I

    .line 118
    sput v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Preparing:I

    .line 119
    sput v4, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Prepared:I

    .line 120
    const/4 v0, 0x4

    sput v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Buffering:I

    .line 121
    const/4 v0, 0x5

    sput v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Playing:I

    .line 122
    const/4 v0, 0x6

    sput v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    .line 123
    const/4 v0, 0x7

    sput v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Paused:I

    .line 124
    const/16 v0, 0x8

    sput v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Finished:I

    .line 1313
    const-string v0, "AVProLocal"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 1314
    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 200
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bWatermarkDataGood:Z

    .line 75
    const/4 v0, -0x1

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iPlayerIndex:I

    .line 201
    const/4 v0, 0x1

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    .line 202
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    .line 204
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    .line 205
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 206
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    .line 207
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    .line 209
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasVideo:Z

    .line 210
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasAudio:Z

    .line 211
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasTimedText:Z

    .line 212
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasSubtitles:Z

    .line 214
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Idle:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 216
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioVolume:F

    .line 217
    const/high16 v0, 0x3f000000    # 0.5f

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioPan:F

    .line 218
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioMuted:Z

    .line 220
    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_FrameCount:I

    .line 222
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z

    .line 224
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_FrameRate:F

    .line 225
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    .line 226
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    .line 227
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_LastSystemTimeMS:J

    .line 231
    sget-boolean v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v0, :cond_0

    .line 233
    sget-boolean v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_bImagePrepared:Z

    if-nez v0, :cond_0

    .line 235
    invoke-static {}, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->PrepareImage()Z

    move-result v0

    sput-boolean v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bCompressedWatermarkDataGood:Z

    .line 238
    :cond_0
    return-void
.end method

.method private AddVideoCommandInt(II)V
    .locals 2
    .param p1, "command"    # I
    .param p2, "intData"    # I

    .prologue
    .line 904
    new-instance v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;-><init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;B)V

    .line 905
    .local v0, "videoCommand":Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;
    iput p1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    .line 906
    iput p2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_intValue:I

    .line 908
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_CommandQueue:Ljava/util/Queue;

    invoke-interface {v1, v0}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 910
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateCommandQueue()V

    .line 911
    return-void
.end method

.method private ChangeWatermarkPosition()V
    .locals 4

    .prologue
    const/high16 v3, 0x40800000    # 4.0f

    .line 1047
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPosition:Landroid/graphics/Point;

    const/4 v1, 0x0

    sget-object v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    invoke-virtual {v2}, Ljava/util/Random;->nextFloat()F

    move-result v2

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    float-to-int v1, v1

    iput v1, v0, Landroid/graphics/Point;->x:I

    .line 1048
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPosition:Landroid/graphics/Point;

    const/high16 v1, 0x3f800000    # 1.0f

    sget-object v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    invoke-virtual {v2}, Ljava/util/Random;->nextFloat()F

    move-result v2

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    float-to-int v1, v1

    iput v1, v0, Landroid/graphics/Point;->y:I

    .line 1049
    const/high16 v0, 0x40a00000    # 5.0f

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkScale:F

    .line 1052
    return-void
.end method

.method private CreateAndBindSinkTexture(I)V
    .locals 2
    .param p1, "glTextureHandle"    # I

    .prologue
    .line 1062
    new-instance v1, Landroid/graphics/SurfaceTexture;

    invoke-direct {v1, p1}, Landroid/graphics/SurfaceTexture;-><init>(I)V

    iput-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    .line 1063
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v1, p0}, Landroid/graphics/SurfaceTexture;->setOnFrameAvailableListener(Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;)V

    .line 1065
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    if-eqz v1, :cond_0

    .line 1068
    new-instance v0, Landroid/view/Surface;

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-direct {v0, v1}, Landroid/view/Surface;-><init>(Landroid/graphics/SurfaceTexture;)V

    .line 1069
    .local v0, "surface":Landroid/view/Surface;
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v1, v0}, Landroid/media/MediaPlayer;->setSurface(Landroid/view/Surface;)V

    .line 1070
    invoke-virtual {v0}, Landroid/view/Surface;->release()V

    .line 1072
    .end local v0    # "surface":Landroid/view/Surface;
    :cond_0
    return-void
.end method

.method public static GetPluginVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 155
    const-string v0, "1.3.9"

    return-object v0
.end method

.method public static RenderPlayer(I)V
    .locals 2
    .param p0, "playerIndex"    # I

    .prologue
    .line 164
    sget-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    .line 165
    if-eqz v0, :cond_0

    .line 167
    sget-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .line 168
    invoke-virtual {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->Render()Z

    .line 170
    :cond_0
    return-void
.end method

.method public static RendererSetupPlayer(II)V
    .locals 5
    .param p0, "playerIndex"    # I
    .param p1, "iDeviceIndex"    # I

    .prologue
    const/4 v4, 0x2

    .line 174
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "RendererSetupPlayer called with index: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " | iDeviceIndex: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 176
    sget-object v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    .line 177
    if-eqz v2, :cond_2

    .line 179
    sget-object v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .line 182
    .local v1, "theClass":Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
    const/4 v0, 0x0

    .line 183
    .local v0, "bOverride":Z
    const/16 v2, 0x8

    if-ne p1, v2, :cond_3

    iput v4, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    const/4 v0, 0x1

    .line 185
    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    .line 187
    iget v2, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    if-le v2, v4, :cond_4

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x12

    if-lt v2, v3, :cond_4

    const/4 v2, 0x1

    :goto_1
    iput-boolean v2, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    .line 188
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Overriding: OpenGL ES version: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 189
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Overriding: OpenGL ES Can use glBindArray: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-boolean v3, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    .line 193
    :cond_1
    invoke-virtual {v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->RendererSetup()V

    .line 195
    .end local v0    # "bOverride":Z
    .end local v1    # "theClass":Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
    :cond_2
    return-void

    .line 184
    .restart local v0    # "bOverride":Z
    .restart local v1    # "theClass":Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
    :cond_3
    const/16 v2, 0xb

    if-ne p1, v2, :cond_0

    const/4 v2, 0x3

    iput v2, v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    const/4 v0, 0x1

    goto :goto_0

    .line 187
    :cond_4
    const/4 v2, 0x0

    goto :goto_1
.end method

.method private ResetPlaybackFrameRate()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1076
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_FrameRate:F

    .line 1077
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    .line 1078
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    .line 1079
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_LastSystemTimeMS:J

    .line 1080
    return-void
.end method

.method private UpdateAudioVolumes()V
    .locals 8

    .prologue
    const/high16 v7, 0x40000000    # 2.0f

    const/high16 v6, 0x3f800000    # 1.0f

    .line 813
    const/4 v2, 0x0

    .line 814
    .local v2, "leftVolume":F
    const/4 v4, 0x0

    .line 817
    .local v4, "rightVolume":F
    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioMuted:Z

    if-nez v5, :cond_1

    .line 820
    iget v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioPan:F

    mul-float v3, v5, v7

    .line 821
    .local v3, "pan":F
    sub-float v1, v7, v3

    .line 824
    .local v1, "leftPan":F
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioVolume:F

    .line 826
    .local v0, "audioVolume":F
    mul-float v2, v0, v1

    .line 827
    mul-float v4, v0, v3

    .line 829
    cmpl-float v5, v2, v6

    if-lez v5, :cond_0

    const/high16 v2, 0x3f800000    # 1.0f

    .line 830
    :cond_0
    cmpl-float v5, v4, v6

    if-lez v5, :cond_1

    const/high16 v4, 0x3f800000    # 1.0f

    .line 836
    .end local v0    # "audioVolume":F
    .end local v1    # "leftPan":F
    .end local v3    # "pan":F
    :cond_1
    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v5, :cond_2

    .line 839
    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v5, v2, v4}, Landroid/media/MediaPlayer;->setVolume(FF)V

    .line 841
    :cond_2
    return-void
.end method

.method private UpdateCommandQueue()V
    .locals 3

    .prologue
    .line 1008
    iget-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    if-eqz v1, :cond_4

    .line 1012
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_CommandQueue:Ljava/util/Queue;

    invoke-interface {v1}, Ljava/util/Queue;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    .line 1014
    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_CommandQueue:Ljava/util/Queue;

    invoke-interface {v1}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;

    .line 1016
    .local v0, "videoCommand":Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;
    iget v1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Play:I

    if-ne v1, v2, :cond_1

    .line 1018
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_play()V

    goto :goto_0

    .line 1020
    :cond_1
    iget v1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Pause:I

    if-ne v1, v2, :cond_2

    .line 1022
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_pause()V

    goto :goto_0

    .line 1024
    :cond_2
    iget v1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Stop:I

    if-ne v1, v2, :cond_3

    .line 1026
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_stop()V

    goto :goto_0

    .line 1028
    :cond_3
    iget v1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_command:I

    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Seek:I

    if-ne v1, v2, :cond_0

    .line 1030
    iget v1, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;->_intValue:I

    invoke-direct {p0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_seek(I)V

    goto :goto_0

    .line 1034
    .end local v0    # "videoCommand":Lcom/RenderHeads/AVProVideo/AVProMobileVideo$VideoCommand;
    :cond_4
    return-void
.end method

.method private UpdateGetDuration()V
    .locals 4

    .prologue
    .line 999
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 1001
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v0

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_DurationMs:J

    .line 1003
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Video duration is: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_DurationMs:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1004
    return-void
.end method

.method private UpdatePlaybackFrameRate()V
    .locals 8

    .prologue
    .line 1085
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 1086
    .local v2, "systemTimeMS":J
    iget-wide v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_LastSystemTimeMS:J

    sub-long v0, v2, v4

    .line 1087
    .local v0, "frameTime":J
    iput-wide v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_LastSystemTimeMS:J

    .line 1089
    iget-wide v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    const-wide/16 v6, 0x1

    add-long/2addr v4, v6

    iput-wide v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    .line 1090
    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    long-to-float v5, v0

    add-float/2addr v4, v5

    iput v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    .line 1092
    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    const/high16 v5, 0x447a0000    # 1000.0f

    cmpl-float v4, v4, v5

    if-lez v4, :cond_0

    .line 1094
    iget-wide v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    long-to-float v4, v4

    iget v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    const v6, 0x3a83126f    # 0.001f

    mul-float/2addr v5, v6

    div-float/2addr v4, v5

    iput v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_FrameRate:F

    .line 1096
    const-wide/16 v4, 0x0

    iput-wide v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_NumberFrames:J

    .line 1097
    const/4 v4, 0x0

    iput v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_Rate:F

    .line 1099
    :cond_0
    return-void
.end method

.method private _pause()V
    .locals 2

    .prologue
    .line 862
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Buffering:I

    if-le v0, v1, :cond_1

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    if-eq v0, v1, :cond_1

    .line 864
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 866
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V

    .line 869
    :cond_0
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->ResetPlaybackFrameRate()V

    .line 871
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Paused:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 873
    :cond_1
    return-void
.end method

.method private _play()V
    .locals 1

    .prologue
    .line 847
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 849
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    .line 853
    :cond_0
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->ResetPlaybackFrameRate()V

    .line 855
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Playing:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 856
    return-void
.end method

.method private _seek(I)V
    .locals 1
    .param p1, "timeMs"    # I

    .prologue
    .line 896
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 898
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V

    .line 900
    :cond_0
    return-void
.end method

.method private _stop()V
    .locals 2

    .prologue
    .line 879
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Buffering:I

    if-le v0, v1, :cond_1

    .line 881
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 883
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 886
    :cond_0
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->ResetPlaybackFrameRate()V

    .line 888
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 890
    :cond_1
    return-void
.end method

.method static synthetic access$000(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkSizeHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$002(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;Landroid/os/Handler;)Landroid/os/Handler;
    .locals 0
    .param p0, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
    .param p1, "x1"    # Landroid/os/Handler;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkSizeHandler:Landroid/os/Handler;

    return-object p1
.end method

.method static synthetic access$100(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)Ljava/lang/Runnable;
    .locals 1
    .param p0, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPositionRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$102(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0
    .param p0, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;
    .param p1, "x1"    # Ljava/lang/Runnable;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPositionRunnable:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic access$200(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V
    .locals 0
    .param p0, "x0"    # Lcom/RenderHeads/AVProVideo/AVProMobileVideo;

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->ChangeWatermarkPosition()V

    return-void
.end method

.method static synthetic access$300()Ljava/util/Random;
    .locals 1

    .prologue
    .line 47
    sget-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    return-object v0
.end method

.method private static getGlVersionFromeDeviceConfig(Landroid/content/Context;)I
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 1138
    const/4 v2, 0x1

    .line 1140
    .local v2, "iReturn":I
    if-eqz p0, :cond_0

    .line 1142
    const-string v3, "activity"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/ActivityManager;

    move-object v0, v3

    check-cast v0, Landroid/app/ActivityManager;

    .line 1143
    .local v0, "activityManager":Landroid/app/ActivityManager;
    if-eqz v0, :cond_0

    .line 1145
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getDeviceConfigurationInfo()Landroid/content/pm/ConfigurationInfo;

    move-result-object v1

    .line 1146
    .local v1, "configInfo":Landroid/content/pm/ConfigurationInfo;
    if-eqz v1, :cond_0

    .line 1148
    iget v3, v1, Landroid/content/pm/ConfigurationInfo;->reqGlEsVersion:I

    const/high16 v4, 0x30000

    if-lt v3, v4, :cond_1

    .line 1150
    const/4 v2, 0x3

    .line 1160
    .end local v0    # "activityManager":Landroid/app/ActivityManager;
    .end local v1    # "configInfo":Landroid/content/pm/ConfigurationInfo;
    :cond_0
    :goto_0
    return v2

    .line 1152
    .restart local v0    # "activityManager":Landroid/app/ActivityManager;
    .restart local v1    # "configInfo":Landroid/content/pm/ConfigurationInfo;
    :cond_1
    iget v3, v1, Landroid/content/pm/ConfigurationInfo;->reqGlEsVersion:I

    const/high16 v4, 0x20000

    if-lt v3, v4, :cond_0

    .line 1154
    const/4 v2, 0x2

    goto :goto_0
.end method

.method private static getMajorVersion(I)I
    .locals 1
    .param p0, "glEsVersion"    # I

    .prologue
    .line 1165
    const/high16 v0, -0x10000

    and-int/2addr v0, p0

    shr-int/lit8 v0, v0, 0x10

    return v0
.end method

.method private static getUserAgentForExoPlayer(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "applicationName"    # Ljava/lang/String;

    .prologue
    .line 1173
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 1174
    .local v0, "packageName":Ljava/lang/String;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v2

    .line 1175
    iget-object v1, v2, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1181
    .end local v0    # "packageName":Ljava/lang/String;
    .local v1, "versionName":Ljava/lang/String;
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " (Linux;Android "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 1179
    .end local v1    # "versionName":Ljava/lang/String;
    :catch_0
    move-exception v2

    const-string v1, "?"

    .restart local v1    # "versionName":Ljava/lang/String;
    goto :goto_0
.end method

.method private static getVersionFromPackageManager(Landroid/content/Context;)I
    .locals 7
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x1

    .line 1109
    if-eqz p0, :cond_0

    .line 1111
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v6

    .line 1112
    invoke-virtual {v6}, Landroid/content/pm/PackageManager;->getSystemAvailableFeatures()[Landroid/content/pm/FeatureInfo;

    move-result-object v2

    .line 1113
    .local v2, "featureInfos":[Landroid/content/pm/FeatureInfo;
    if-eqz v2, :cond_0

    array-length v6, v2

    if-lez v6, :cond_0

    .line 1115
    move-object v0, v2

    .local v0, "arr$":[Landroid/content/pm/FeatureInfo;
    array-length v4, v2

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v4, :cond_0

    aget-object v1, v0, v3

    .line 1118
    .local v1, "featureInfo":Landroid/content/pm/FeatureInfo;
    iget-object v6, v1, Landroid/content/pm/FeatureInfo;->name:Ljava/lang/String;

    if-nez v6, :cond_1

    .line 1120
    iget v6, v1, Landroid/content/pm/FeatureInfo;->reqGlEsVersion:I

    if-eqz v6, :cond_0

    .line 1122
    iget v5, v1, Landroid/content/pm/FeatureInfo;->reqGlEsVersion:I

    invoke-static {v5}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->getMajorVersion(I)I

    move-result v5

    .line 1133
    .end local v0    # "arr$":[Landroid/content/pm/FeatureInfo;
    .end local v1    # "featureInfo":Landroid/content/pm/FeatureInfo;
    .end local v2    # "featureInfos":[Landroid/content/pm/FeatureInfo;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :cond_0
    return v5

    .line 1115
    .restart local v0    # "arr$":[Landroid/content/pm/FeatureInfo;
    .restart local v1    # "featureInfo":Landroid/content/pm/FeatureInfo;
    .restart local v2    # "featureInfos":[Landroid/content/pm/FeatureInfo;
    .restart local v3    # "i$":I
    .restart local v4    # "len$":I
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method private static setMediaPlayerDataSourceFromZip(Landroid/media/MediaPlayer;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9
    .param p0, "mediaPlayer"    # Landroid/media/MediaPlayer;
    .param p1, "zipFileName"    # Ljava/lang/String;
    .param p2, "fileNameInZip"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .prologue
    .line 484
    new-instance v8, Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    invoke-direct {v8, p1}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;-><init>(Ljava/lang/String;)V

    .line 485
    .local v8, "zip":Lcom/android/vending/expansion/zipfile/ZipResourceFile;
    new-instance v7, Ljava/io/FileInputStream;

    invoke-direct {v7, p1}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 488
    .local v7, "fis":Ljava/io/FileInputStream;
    :try_start_0
    invoke-virtual {v7}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v1

    .line 490
    .local v1, "zipfd":Ljava/io/FileDescriptor;
    invoke-static {v8, p2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->zipFindFile(Lcom/android/vending/expansion/zipfile/ZipResourceFile;Ljava/lang/String;)Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;

    move-result-object v6

    .line 491
    .local v6, "entry":Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    iget-wide v2, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mOffset:J

    iget-wide v4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mUncompressedLength:J

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 495
    invoke-virtual {v7}, Ljava/io/FileInputStream;->close()V

    .line 496
    return-void

    .line 495
    .end local v1    # "zipfd":Ljava/io/FileDescriptor;
    .end local v6    # "entry":Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    :catchall_0
    move-exception v0

    invoke-virtual {v7}, Ljava/io/FileInputStream;->close()V

    throw v0
.end method

.method private static zipFindFile(Lcom/android/vending/expansion/zipfile/ZipResourceFile;Ljava/lang/String;)Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    .locals 8
    .param p0, "zip"    # Lcom/android/vending/expansion/zipfile/ZipResourceFile;
    .param p1, "fileNameInZip"    # Ljava/lang/String;

    .prologue
    .line 501
    invoke-virtual {p0}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;->getAllEntries()[Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;

    move-result-object v0

    .local v0, "arr$":[Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_1

    aget-object v1, v0, v2

    .line 503
    .local v1, "entry":Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    iget-object v4, v1, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mFileName:Ljava/lang/String;

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 505
    return-object v1

    .line 501
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 508
    .end local v1    # "entry":Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;
    :cond_1
    new-instance v4, Ljava/lang/RuntimeException;

    const-string v5, "File \"%s\"not found in zip"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p1, v6, v7

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v4
.end method


# virtual methods
.method public CanPlay()Z
    .locals 2

    .prologue
    .line 474
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Paused:I

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Playing:I

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Finished:I

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public CloseVideo()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 647
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Prepared:I

    if-lt v0, v1, :cond_0

    .line 649
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_pause()V

    .line 652
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_stop()V

    .line 655
    invoke-direct {p0, v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->_seek(I)V

    .line 659
    :cond_0
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Idle:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 661
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_CommandQueue:Ljava/util/Queue;

    .line 662
    iput-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    .line 663
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Width:I

    .line 664
    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Height:I

    .line 666
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    if-eqz v0, :cond_1

    .line 668
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 670
    :cond_1
    iput-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    .line 672
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_2

    .line 675
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    .line 678
    :cond_2
    return-void
.end method

.method public Deinitialise()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 327
    invoke-virtual {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->CloseVideo()V

    .line 329
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 331
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 332
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 333
    iput-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    .line 336
    :cond_0
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-eqz v0, :cond_1

    .line 338
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->DestroyRenderTarget()V

    .line 341
    :cond_1
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    if-eqz v0, :cond_2

    .line 343
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0}, Landroid/graphics/SurfaceTexture;->release()V

    .line 344
    iput-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    .line 348
    :cond_2
    sget-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iPlayerIndex:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 349
    return-void
.end method

.method public GetAudioPan()F
    .locals 1

    .prologue
    .line 787
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioPan:F

    return v0
.end method

.method public GetCurrentTimeMs()J
    .locals 3

    .prologue
    .line 722
    const-wide/16 v0, 0x0

    .line 724
    .local v0, "result":J
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v2, :cond_0

    .line 726
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result v2

    int-to-long v0, v2

    .line 729
    :cond_0
    return-wide v0
.end method

.method public GetDurationMs()J
    .locals 2

    .prologue
    .line 702
    iget-wide v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_DurationMs:J

    return-wide v0
.end method

.method public GetFrameCount()I
    .locals 1

    .prologue
    .line 697
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_FrameCount:I

    return v0
.end method

.method public GetHeight()I
    .locals 1

    .prologue
    .line 712
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Height:I

    return v0
.end method

.method public GetPlaybackRate()F
    .locals 1

    .prologue
    .line 717
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Playback_FrameRate:F

    return v0
.end method

.method public GetPlayerIndex()I
    .locals 1

    .prologue
    .line 434
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iPlayerIndex:I

    return v0
.end method

.method public GetTextureHandle()I
    .locals 1

    .prologue
    .line 440
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    if-eqz v0, :cond_1

    .line 442
    :cond_0
    const/4 v0, 0x0

    .line 444
    :goto_0
    return v0

    :cond_1
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->GetGlTextureHandle()I

    move-result v0

    goto :goto_0
.end method

.method public GetVolume()F
    .locals 1

    .prologue
    .line 776
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioVolume:F

    return v0
.end method

.method public GetWidth()I
    .locals 1

    .prologue
    .line 707
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Width:I

    return v0
.end method

.method public HasAudio()Z
    .locals 1

    .prologue
    .line 739
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasAudio:Z

    return v0
.end method

.method public HasSubtitles()Z
    .locals 1

    .prologue
    .line 749
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasSubtitles:Z

    return v0
.end method

.method public HasTimedText()Z
    .locals 1

    .prologue
    .line 744
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasTimedText:Z

    return v0
.end method

.method public HasVideo()Z
    .locals 1

    .prologue
    .line 734
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasVideo:Z

    return v0
.end method

.method public Initialise(Landroid/content/Context;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    .line 242
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_PlayersIndex:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    iput v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iPlayerIndex:I

    .line 244
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_AllPlayers:Ljava/util/Map;

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iPlayerIndex:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v3, v4, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 245
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_PlayersIndex:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    sput-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_PlayersIndex:Ljava/lang/Integer;

    .line 247
    sget-boolean v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v3, :cond_2

    .line 250
    sget-boolean v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bCompressedWatermarkDataGood:Z

    if-nez v3, :cond_1

    .line 323
    :cond_0
    :goto_0
    return-void

    .line 256
    :cond_1
    invoke-static {}, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->CheckWatermarkData()Z

    move-result v3

    iput-boolean v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bWatermarkDataGood:Z

    .line 257
    iget-boolean v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bWatermarkDataGood:Z

    if-eqz v3, :cond_0

    .line 265
    :cond_2
    iput-object p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    .line 266
    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    check-cast v3, Landroid/app/Activity;

    move-object v0, v3

    check-cast v0, Landroid/app/Activity;

    .line 271
    .local v0, "activity":Landroid/app/Activity;
    new-instance v3, Ljava/util/LinkedList;

    invoke-direct {v3}, Ljava/util/LinkedList;-><init>()V

    iput-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_CommandQueue:Ljava/util/Queue;

    .line 272
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    if-nez v3, :cond_3

    .line 274
    new-instance v3, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Random;-><init>(J)V

    sput-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_Random:Ljava/util/Random;

    .line 276
    :cond_3
    new-instance v3, Landroid/graphics/Point;

    invoke-direct {v3}, Landroid/graphics/Point;-><init>()V

    iput-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPosition:Landroid/graphics/Point;

    .line 278
    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    invoke-static {v3}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->getVersionFromPackageManager(Landroid/content/Context;)I

    move-result v2

    .line 279
    .local v2, "iPackageManagerOpenGLESVersion":I
    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    invoke-static {v3}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->getGlVersionFromeDeviceConfig(Landroid/content/Context;)I

    move-result v1

    .line 280
    .local v1, "iDeviceInfoOpenGLESVersion":I
    if-lt v2, v7, :cond_5

    if-lt v1, v7, :cond_5

    .line 282
    iput v7, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    .line 288
    :cond_4
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "OpenGL ES version: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 290
    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    if-le v3, v6, :cond_6

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x12

    if-lt v3, v4, :cond_6

    const/4 v3, 0x1

    :goto_2
    iput-boolean v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    .line 291
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "OpenGL ES Can use glBindArray: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-boolean v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    .line 293
    new-instance v3, Landroid/media/MediaPlayer;

    invoke-direct {v3}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    .line 295
    sget-boolean v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v3, :cond_0

    .line 298
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->ChangeWatermarkPosition()V

    .line 303
    new-instance v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;

    invoke-direct {v3, p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo$1;-><init>(Lcom/RenderHeads/AVProVideo/AVProMobileVideo;)V

    invoke-virtual {v0, v3}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 284
    :cond_5
    if-lt v2, v6, :cond_4

    if-lt v1, v6, :cond_4

    .line 286
    iput v6, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iOpenGLVersion:I

    goto :goto_1

    .line 290
    :cond_6
    const/4 v3, 0x0

    goto :goto_2
.end method

.method public IsFinished()Z
    .locals 2

    .prologue
    .line 468
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Finished:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsLooping()Z
    .locals 1

    .prologue
    .line 692
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bLooping:Z

    return v0
.end method

.method public IsMuted()Z
    .locals 1

    .prologue
    .line 765
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioMuted:Z

    return v0
.end method

.method public IsPaused()Z
    .locals 2

    .prologue
    .line 456
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Paused:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsPlaying()Z
    .locals 2

    .prologue
    .line 450
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Playing:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsSeeking()Z
    .locals 2

    .prologue
    .line 462
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Preparing:I

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v1, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Buffering:I

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public MuteAudio(Z)V
    .locals 0
    .param p1, "muted"    # Z

    .prologue
    .line 759
    iput-boolean p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioMuted:Z

    .line 760
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateAudioVolumes()V

    .line 761
    return-void
.end method

.method public OpenVideoFromFile(Ljava/lang/String;)Z
    .locals 19
    .param p1, "filePath"    # Ljava/lang/String;

    .prologue
    .line 513
    const/4 v10, 0x0

    .line 518
    .local v10, "bReturn":Z
    invoke-virtual/range {p0 .. p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->CloseVideo()V

    .line 521
    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Opening:I

    move-object/from16 v0, p0

    iput v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 523
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    .line 524
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 525
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    .line 528
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasVideo:Z

    .line 529
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasAudio:Z

    .line 530
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasTimedText:Z

    .line 531
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasSubtitles:Z

    .line 533
    const-wide/16 v4, 0x0

    move-object/from16 v0, p0

    iput-wide v4, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_DurationMs:J

    .line 535
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_FrameCount:I

    .line 537
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z

    .line 539
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v2, :cond_3

    .line 541
    const/4 v9, 0x1

    .line 546
    .local v9, "bFileGood":Z
    :try_start_0
    const-string v2, "http://"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "https://"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "rtsp://"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 551
    :cond_0
    invoke-static/range {p1 .. p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v16

    .line 552
    .local v16, "uri":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    move-object/from16 v0, v16

    invoke-virtual {v2, v4, v0}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 554
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3

    .line 621
    .end local v16    # "uri":Landroid/net/Uri;
    :cond_1
    :goto_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 622
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnVideoSizeChangedListener(Landroid/media/MediaPlayer$OnVideoSizeChangedListener;)V

    .line 623
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 624
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 626
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bLooping:Z

    invoke-virtual {v2, v4}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 628
    if-eqz v9, :cond_2

    .line 634
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bInPrepared:Z

    .line 635
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->prepareAsync()V

    .line 636
    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Preparing:I

    move-object/from16 v0, p0

    iput v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 639
    :cond_2
    move v10, v9

    .line 642
    .end local v9    # "bFileGood":Z
    :cond_3
    return v10

    .line 560
    .restart local v9    # "bFileGood":Z
    :cond_4
    :try_start_1
    const-string v15, ".obb!/"

    .line 561
    .local v15, "lookFor":Ljava/lang/String;
    move-object/from16 v0, p1

    invoke-virtual {v0, v15}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v13

    .line 562
    .local v13, "iIndexIntoString":I
    if-ltz v13, :cond_5

    .line 564
    const/16 v2, 0xb

    invoke-virtual {v15}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v4, v13

    add-int/lit8 v4, v4, -0x2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v18

    .line 565
    .local v18, "zipPathName":Ljava/lang/String;
    invoke-virtual {v15}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, v13

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v17

    .line 570
    .local v17, "zipFileName":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, v18

    move-object/from16 v1, v17

    invoke-static {v2, v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->setMediaPlayerDataSourceFromZip(Landroid/media/MediaPlayer;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .end local v13    # "iIndexIntoString":I
    .end local v15    # "lookFor":Ljava/lang/String;
    .end local v17    # "zipFileName":Ljava/lang/String;
    .end local v18    # "zipPathName":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 584
    :try_start_2
    const-string v2, "/assets/"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v2

    add-int/lit8 v2, v2, 0x8

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    .line 585
    .local v12, "fileName":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    invoke-virtual {v2, v12}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v8

    .line 586
    .local v8, "assetFileDesc":Landroid/content/res/AssetFileDescriptor;
    if-eqz v8, :cond_1

    .line 589
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v8}, Landroid/content/res/AssetFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-virtual {v8}, Landroid/content/res/AssetFileDescriptor;->getStartOffset()J

    move-result-wide v4

    invoke-virtual {v8}, Landroid/content/res/AssetFileDescriptor;->getLength()J

    move-result-wide v6

    invoke-virtual/range {v2 .. v7}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_0

    .end local v8    # "assetFileDesc":Landroid/content/res/AssetFileDescriptor;
    .end local v12    # "fileName":Ljava/lang/String;
    :catch_1
    move-exception v2

    .line 599
    :try_start_3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "file://"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, p1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v16

    .line 600
    .restart local v16    # "uri":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Context:Landroid/content/Context;

    move-object/from16 v0, v16

    invoke-virtual {v2, v4, v0}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto/16 :goto_0

    .line 607
    .end local v16    # "uri":Landroid/net/Uri;
    :catch_2
    move-exception v2

    :try_start_4
    new-instance v14, Ljava/io/FileInputStream;

    move-object/from16 v0, p1

    invoke-direct {v14, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 608
    .local v14, "inputStream":Ljava/io/FileInputStream;
    invoke-virtual {v14}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v3

    .line 609
    .local v3, "fileDescriptor":Ljava/io/FileDescriptor;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    const-wide/16 v4, 0x0

    invoke-virtual {v14}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v6

    invoke-virtual {v6}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v6

    invoke-virtual/range {v2 .. v7}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto/16 :goto_0

    .line 615
    .end local v3    # "fileDescriptor":Ljava/io/FileDescriptor;
    .end local v14    # "inputStream":Ljava/io/FileInputStream;
    :catch_3
    move-exception v11

    .line 617
    .local v11, "e":Ljava/io/IOException;
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Failed to open video file: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 618
    const/4 v9, 0x0

    goto/16 :goto_0

    .line 574
    .end local v11    # "e":Ljava/io/IOException;
    .restart local v13    # "iIndexIntoString":I
    .restart local v15    # "lookFor":Ljava/lang/String;
    :cond_5
    :try_start_5
    new-instance v2, Ljava/io/IOException;

    const-string v4, "Not an obb file"

    invoke-direct {v2, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0
.end method

.method public Pause()V
    .locals 2

    .prologue
    .line 797
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Pause:I

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->AddVideoCommandInt(II)V

    .line 798
    return-void
.end method

.method public Play()V
    .locals 2

    .prologue
    .line 792
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Play:I

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->AddVideoCommandInt(II)V

    .line 793
    return-void
.end method

.method public Render()Z
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 915
    const/4 v1, 0x0

    .line 917
    .local v1, "result":Z
    sget-boolean v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v2, :cond_0

    sget-boolean v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bCompressedWatermarkDataGood:Z

    if-eqz v2, :cond_7

    iget-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bWatermarkDataGood:Z

    if-eqz v2, :cond_7

    .line 919
    :cond_0
    iget-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    if-eqz v2, :cond_2

    .line 921
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-eqz v2, :cond_1

    .line 923
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->DestroyRenderTarget()V

    .line 925
    :cond_1
    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 926
    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    .line 928
    :cond_2
    iget-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    if-eqz v2, :cond_8

    .line 930
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-eqz v2, :cond_3

    .line 932
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->DestroyRenderTarget()V

    .line 933
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Width:I

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Height:I

    invoke-virtual {v2, v3, v4}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateRenderTarget(II)V

    .line 936
    :cond_3
    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 937
    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    .line 938
    iput-boolean v6, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    .line 941
    iget-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z

    if-nez v2, :cond_4

    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    sget v3, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Prepared:I

    if-lt v2, v3, :cond_4

    .line 943
    iput-boolean v6, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    .line 944
    sget v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 948
    :cond_4
    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioVolume:F

    invoke-virtual {p0, v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->SetVolume(F)V

    .line 958
    :goto_0
    monitor-enter p0

    .line 960
    :try_start_0
    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iNumberFramesAvailable:I

    if-lez v2, :cond_6

    iget-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    if-eqz v2, :cond_6

    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-eqz v2, :cond_6

    .line 965
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->StartRender()V

    .line 968
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iNumberFramesAvailable:I

    const/4 v5, 0x0

    invoke-virtual {v2, v3, v4, v5}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->Blit(Landroid/graphics/SurfaceTexture;I[F)V

    .line 969
    const/4 v2, 0x0

    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iNumberFramesAvailable:I

    .line 973
    sget-boolean v2, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v2, :cond_5

    .line 975
    const/16 v2, 0x10

    new-array v0, v2, [F

    .line 976
    .local v0, "mtxWM":[F
    const/4 v2, 0x0

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkScale:F

    aput v3, v0, v2

    const/4 v2, 0x1

    const/4 v3, 0x0

    aput v3, v0, v2

    const/4 v2, 0x2

    const/4 v3, 0x0

    aput v3, v0, v2

    const/4 v2, 0x3

    const/4 v3, 0x0

    aput v3, v0, v2

    .line 977
    const/4 v2, 0x4

    const/4 v3, 0x0

    aput v3, v0, v2

    const/4 v2, 0x5

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkScale:F

    neg-float v3, v3

    aput v3, v0, v2

    const/4 v2, 0x6

    const/4 v3, 0x0

    aput v3, v0, v2

    const/4 v2, 0x7

    const/4 v3, 0x0

    aput v3, v0, v2

    .line 978
    const/16 v2, 0x8

    const/4 v3, 0x0

    aput v3, v0, v2

    const/16 v2, 0x9

    const/4 v3, 0x0

    aput v3, v0, v2

    const/16 v2, 0xa

    const/high16 v3, 0x3f800000    # 1.0f

    aput v3, v0, v2

    const/16 v2, 0xb

    const/4 v3, 0x0

    aput v3, v0, v2

    .line 979
    const/16 v2, 0xc

    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPosition:Landroid/graphics/Point;

    iget v3, v3, Landroid/graphics/Point;->x:I

    neg-int v3, v3

    int-to-float v3, v3

    aput v3, v0, v2

    const/16 v2, 0xd

    iget-object v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_WatermarkPosition:Landroid/graphics/Point;

    iget v3, v3, Landroid/graphics/Point;->y:I

    int-to-float v3, v3

    aput v3, v0, v2

    const/16 v2, 0xe

    const/4 v3, 0x0

    aput v3, v0, v2

    const/16 v2, 0xf

    const/high16 v3, 0x3f800000    # 1.0f

    aput v3, v0, v2

    .line 981
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Watermark:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4, v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->Blit(Landroid/graphics/SurfaceTexture;I[F)V

    .line 985
    .end local v0    # "mtxWM":[F
    :cond_5
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->EndRender()V

    .line 987
    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_FrameCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_FrameCount:I

    .line 989
    const/4 v1, 0x1

    .line 991
    :cond_6
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 994
    :cond_7
    return v1

    .line 952
    :cond_8
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateCommandQueue()V

    goto/16 :goto_0

    .line 991
    :catchall_0
    move-exception v2

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2
.end method

.method public RendererSetup()V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 353
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-nez v0, :cond_0

    .line 356
    new-instance v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-direct {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;-><init>()V

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    .line 357
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    const/4 v3, 0x0

    const/4 v4, 0x1

    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    move v2, v1

    invoke-virtual/range {v0 .. v5}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->Setup(II[BZZ)V

    .line 358
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Video:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-virtual {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->GetGlTextureHandle()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->CreateAndBindSinkTexture(I)V

    .line 361
    :cond_0
    sget-boolean v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->s_bWatermarked:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Watermark:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    if-nez v0, :cond_1

    .line 363
    new-instance v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    invoke-direct {v0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;-><init>()V

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Watermark:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    .line 364
    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_GlRender_Watermark:Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;

    const/16 v3, 0xfe

    const/16 v4, 0x8d

    sget-object v5, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aImageData:[B

    iget-boolean v7, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bCanUseGLBindVertexArray:Z

    move v6, v1

    invoke-virtual/range {v2 .. v7}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->Setup(II[BZZ)V

    .line 366
    :cond_1
    return-void
.end method

.method public Seek(I)V
    .locals 1
    .param p1, "timeMs"    # I

    .prologue
    .line 807
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Seek:I

    invoke-direct {p0, v0, p1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->AddVideoCommandInt(II)V

    .line 808
    return-void
.end method

.method public SetAudioPan(F)V
    .locals 0
    .param p1, "pan"    # F

    .prologue
    .line 781
    iput p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioPan:F

    .line 782
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateAudioVolumes()V

    .line 783
    return-void
.end method

.method public SetLooping(Z)V
    .locals 2
    .param p1, "bLooping"    # Z

    .prologue
    .line 682
    iput-boolean p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bLooping:Z

    .line 684
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 686
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    iget-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bLooping:Z

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 688
    :cond_0
    return-void
.end method

.method public SetVolume(F)V
    .locals 0
    .param p1, "volume"    # F

    .prologue
    .line 770
    iput p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_AudioVolume:F

    .line 771
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateAudioVolumes()V

    .line 772
    return-void
.end method

.method public Stop()V
    .locals 2

    .prologue
    .line 802
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoCommand_Stop:I

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->AddVideoCommandInt(II)V

    .line 803
    return-void
.end method

.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 1
    .param p1, "mp"    # Landroid/media/MediaPlayer;

    .prologue
    .line 1303
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bLooping:Z

    if-nez v0, :cond_0

    .line 1305
    sget v0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Finished:I

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 1307
    :cond_0
    return-void
.end method

.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 2
    .param p1, "mp"    # Landroid/media/MediaPlayer;
    .param p2, "what"    # I
    .param p3, "extra"    # I

    .prologue
    .line 1294
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "onError what("

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "), extra("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1295
    const/4 v0, 0x0

    return v0
.end method

.method public onFrameAvailable(Landroid/graphics/SurfaceTexture;)V
    .locals 1
    .param p1, "surfaceTexture"    # Landroid/graphics/SurfaceTexture;

    .prologue
    .line 1199
    monitor-enter p0

    .line 1201
    :try_start_0
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iNumberFramesAvailable:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_iNumberFramesAvailable:I

    .line 1203
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdatePlaybackFrameRate()V

    .line 1204
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 7
    .param p1, "mp"    # Landroid/media/MediaPlayer;

    .prologue
    const/4 v6, 0x1

    .line 1213
    sget v5, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Prepared:I

    iput v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 1216
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->UpdateGetDuration()V

    .line 1220
    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z

    if-nez v5, :cond_0

    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_RenderSurfaceCreated:Z

    if-eqz v5, :cond_1

    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    if-nez v5, :cond_1

    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    if-nez v5, :cond_1

    .line 1222
    :cond_0
    iput-boolean v6, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_AcceptCommands:Z

    .line 1223
    sget v5, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->VideoState_Stopped:I

    iput v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_VideoState:I

    .line 1227
    :cond_1
    iget-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bIsStream:Z

    if-eqz v5, :cond_2

    .line 1229
    iput-boolean v6, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasAudio:Z

    .line 1233
    :cond_2
    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    if-eqz v5, :cond_4

    .line 1237
    :try_start_0
    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_MediaPlayerAPI:Landroid/media/MediaPlayer;

    invoke-virtual {v5}, Landroid/media/MediaPlayer;->getTrackInfo()[Landroid/media/MediaPlayer$TrackInfo;

    move-result-object v4

    .line 1238
    .local v4, "trackInfo":[Landroid/media/MediaPlayer$TrackInfo;
    if-eqz v4, :cond_4

    .line 1240
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Source has "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v6, v4

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " tracks"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1242
    array-length v5, v4

    if-lez v5, :cond_4

    .line 1244
    move-object v0, v4

    .local v0, "arr$":[Landroid/media/MediaPlayer$TrackInfo;
    array-length v3, v4

    .local v3, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v3, :cond_4

    aget-object v2, v0, v1

    .line 1246
    .local v2, "info":Landroid/media/MediaPlayer$TrackInfo;
    if-eqz v2, :cond_3

    .line 1248
    invoke-virtual {v2}, Landroid/media/MediaPlayer$TrackInfo;->getTrackType()I

    move-result v5

    packed-switch v5, :pswitch_data_0

    .line 1244
    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1250
    :pswitch_0
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasVideo:Z

    goto :goto_1

    .end local v0    # "arr$":[Landroid/media/MediaPlayer$TrackInfo;
    .end local v1    # "i$":I
    .end local v2    # "info":Landroid/media/MediaPlayer$TrackInfo;
    .end local v3    # "len$":I
    .end local v4    # "trackInfo":[Landroid/media/MediaPlayer$TrackInfo;
    :catch_0
    move-exception v5

    .line 1264
    :cond_4
    return-void

    .line 1251
    .restart local v0    # "arr$":[Landroid/media/MediaPlayer$TrackInfo;
    .restart local v1    # "i$":I
    .restart local v2    # "info":Landroid/media/MediaPlayer$TrackInfo;
    .restart local v3    # "len$":I
    .restart local v4    # "trackInfo":[Landroid/media/MediaPlayer$TrackInfo;
    :pswitch_1
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasAudio:Z

    goto :goto_1

    .line 1252
    :pswitch_2
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasTimedText:Z

    goto :goto_1

    .line 1253
    :pswitch_3
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasSubtitles:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 1248
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public onRenderersError(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .prologue
    .line 1188
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ERROR - onRenderersError: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 1189
    return-void
.end method

.method public onVideoSizeChanged(Landroid/media/MediaPlayer;II)V
    .locals 3
    .param p1, "mp"    # Landroid/media/MediaPlayer;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    const/4 v2, 0x1

    .line 1271
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Width:I

    if-ne v0, p2, :cond_0

    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Height:I

    if-eq v0, p3, :cond_1

    .line 1273
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "onVideoSizeChanged : New size: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " x "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 1275
    iput p2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Width:I

    .line 1276
    iput p3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_Height:I

    .line 1278
    iput-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bSourceHasVideo:Z

    .line 1280
    iput-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_CreateRenderSurface:Z

    .line 1281
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo;->m_bVideo_DestoyRenderSurface:Z

    .line 1287
    :cond_1
    return-void
.end method
