.class public Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;
.super Ljava/lang/Object;
.source "AVProMobileVideo_GlRender.java"


# instance fields
.field private m_FragmentShaderHandle:I

.field private m_FragmentShaderSource:Ljava/lang/String;

.field private m_FrameBufferHandle:I

.field private m_FrameBufferTextureHandle:I

.field private m_FramebufferHeight:I

.field private m_FramebufferWidth:I

.field private m_HasImageData:Z

.field private m_Height:I

.field private m_ImageData:Ljava/nio/ByteBuffer;

.field private m_MatrixFloatBuffer:Ljava/nio/FloatBuffer;

.field private m_MatrixHandle:I

.field private m_ProgramHandle:I

.field private m_QuadPositions:Ljava/nio/FloatBuffer;

.field private m_QuadUVs:Ljava/nio/FloatBuffer;

.field private m_TextureHandle:I

.field private m_VertexAttribHandle:I

.field private m_VertexShaderHandle:I

.field private m_VertexShaderSource:Ljava/lang/String;

.field private m_Width:I

.field private m_aiVertextBufferObjects:[I

.field private m_bBlendEnabled:Z

.field private m_bCanUseGLBindVertexArray:Z

.field private m_bCullFace:Z

.field private m_bDepthTest:Z

.field private m_bTextureFormat_EOS:Z

.field private m_iCurrentProgram:I

.field private m_iFrameBufferBinding:I

.field private m_iRenderBufferBinding:I

.field private m_iVertexArrayObject:I

.field private m_uvAttribHandle:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_aiVertextBufferObjects:[I

    return-void
.end method

.method private static CreateFloatBuffer([F)Ljava/nio/FloatBuffer;
    .locals 3
    .param p0, "values"    # [F

    .prologue
    .line 501
    array-length v2, p0

    mul-int/lit8 v2, v2, 0x4

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 502
    .local v0, "bytes":Ljava/nio/ByteBuffer;
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 503
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v1

    .line 504
    .local v1, "result":Ljava/nio/FloatBuffer;
    invoke-virtual {v1, p0}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    .line 505
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    .line 506
    return-object v1
.end method

.method private CreateGlQuadGeometry()V
    .locals 13

    .prologue
    const/16 v2, 0x1406

    const/4 v12, 0x2

    const v11, 0x8892

    const/4 v10, 0x1

    const/4 v3, 0x0

    .line 438
    const/16 v0, 0xc

    new-array v6, v0, [F

    fill-array-data v6, :array_0

    .line 446
    .local v6, "TriangleVerticesData":[F
    const/16 v0, 0x8

    new-array v7, v0, [F

    fill-array-data v7, :array_1

    .line 454
    .local v7, "UVData":[F
    invoke-static {v6}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateFloatBuffer([F)Ljava/nio/FloatBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadPositions:Ljava/nio/FloatBuffer;

    .line 455
    invoke-static {v7}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateFloatBuffer([F)Ljava/nio/FloatBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadUVs:Ljava/nio/FloatBuffer;

    .line 457
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCanUseGLBindVertexArray:Z

    if-eqz v0, :cond_0

    .line 461
    invoke-static {v10}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v8

    .line 462
    .local v8, "intVertexArrayBuffer":Ljava/nio/IntBuffer;
    invoke-static {v10, v8}, Landroid/opengl/GLES30;->glGenVertexArrays(ILjava/nio/IntBuffer;)V

    .line 463
    invoke-virtual {v8, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iVertexArrayObject:I

    .line 465
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iVertexArrayObject:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    .line 467
    invoke-static {v12}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v9

    .line 468
    .local v9, "intVertextBuffersBuffer":Ljava/nio/IntBuffer;
    invoke-static {v12, v9}, Landroid/opengl/GLES30;->glGenBuffers(ILjava/nio/IntBuffer;)V

    .line 469
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_aiVertextBufferObjects:[I

    invoke-virtual {v9, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    aput v1, v0, v3

    .line 470
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_aiVertextBufferObjects:[I

    invoke-virtual {v9, v10}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    aput v1, v0, v10

    .line 472
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_aiVertextBufferObjects:[I

    aget v0, v0, v3

    invoke-static {v11, v0}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    .line 473
    const/16 v0, 0x30

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadPositions:Ljava/nio/FloatBuffer;

    const v4, 0x88e4

    invoke-static {v11, v0, v1, v4}, Landroid/opengl/GLES30;->glBufferData(IILjava/nio/Buffer;I)V

    .line 474
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    const/4 v1, 0x3

    move v4, v3

    move v5, v3

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES30;->glVertexAttribPointer(IIIZII)V

    .line 475
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glEnableVertexAttribArray(I)V

    .line 477
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_aiVertextBufferObjects:[I

    aget v0, v0, v10

    invoke-static {v11, v0}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    .line 478
    const/16 v0, 0x20

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadUVs:Ljava/nio/FloatBuffer;

    const v4, 0x88e4

    invoke-static {v11, v0, v1, v4}, Landroid/opengl/GLES30;->glBufferData(IILjava/nio/Buffer;I)V

    .line 479
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    move v1, v12

    move v4, v3

    move v5, v3

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES30;->glVertexAttribPointer(IIIZII)V

    .line 480
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glEnableVertexAttribArray(I)V

    .line 482
    invoke-static {v3}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    .line 484
    .end local v8    # "intVertexArrayBuffer":Ljava/nio/IntBuffer;
    .end local v9    # "intVertextBuffersBuffer":Ljava/nio/IntBuffer;
    :cond_0
    return-void

    .line 438
    nop

    :array_0
    .array-data 4
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x0
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        0x0
        0x3f800000    # 1.0f
        -0x40800000    # -1.0f
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x0
    .end array-data

    .line 446
    :array_1
    .array-data 4
        0x0
        0x0
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private CreateGlShaderProgram()V
    .locals 3

    .prologue
    .line 411
    const v1, 0x8b31

    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-direct {p0, v1, v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->LoadGlShader(ILjava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderHandle:I

    .line 412
    const v1, 0x8b30

    iget-object v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-direct {p0, v1, v2}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->LoadGlShader(ILjava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderHandle:I

    .line 414
    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v0

    .line 415
    .local v0, "handle":I
    if-lez v0, :cond_0

    .line 417
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderHandle:I

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 418
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderHandle:I

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 419
    invoke-static {v0}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    .line 421
    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ProgramHandle:I

    .line 423
    :cond_0
    return-void
.end method

.method private CreateGlTexture()V
    .locals 12

    .prologue
    const v11, 0x812f

    const/16 v10, 0x2601

    const/16 v2, 0x1908

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 379
    invoke-static {v3}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v9

    .line 384
    .local v9, "intBuffer":Ljava/nio/IntBuffer;
    invoke-static {v3, v9}, Landroid/opengl/GLES20;->glGenTextures(ILjava/nio/IntBuffer;)V

    .line 385
    invoke-virtual {v9, v1}, Ljava/nio/IntBuffer;->get(I)I

    move-result v3

    iput v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_TextureHandle:I

    .line 387
    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_TextureHandle:I

    if-lez v3, :cond_1

    .line 389
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "CreateGlTexture m_TextureHandle: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_TextureHandle:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 391
    iget-boolean v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    if-eqz v3, :cond_2

    const v0, 0x8d65

    .line 393
    .local v0, "textureFormat":I
    :goto_0
    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_TextureHandle:I

    invoke-static {v0, v3}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 394
    iget-boolean v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_HasImageData:Z

    if-eqz v3, :cond_0

    .line 396
    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Width:I

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Height:I

    const/16 v7, 0x1401

    iget-object v8, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ImageData:Ljava/nio/ByteBuffer;

    move v5, v1

    move v6, v2

    invoke-static/range {v0 .. v8}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 398
    :cond_0
    const/16 v2, 0x2801

    invoke-static {v0, v2, v10}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 399
    const/16 v2, 0x2800

    invoke-static {v0, v2, v10}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 400
    const/16 v2, 0x2802

    invoke-static {v0, v2, v11}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 401
    const/16 v2, 0x2803

    invoke-static {v0, v2, v11}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 403
    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 405
    .end local v0    # "textureFormat":I
    :cond_1
    return-void

    .line 391
    :cond_2
    const/16 v0, 0xde1

    goto :goto_0
.end method

.method private LoadGlShader(ILjava/lang/String;)I
    .locals 1
    .param p1, "type"    # I
    .param p2, "source"    # Ljava/lang/String;

    .prologue
    .line 488
    invoke-static {p1}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result v0

    .line 489
    .local v0, "handle":I
    if-lez v0, :cond_0

    .line 491
    invoke-static {v0, p2}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    .line 492
    invoke-static {v0}, Landroid/opengl/GLES20;->glCompileShader(I)V

    .line 495
    :cond_0
    return v0
.end method

.method private LoadGlShaders_Texture2D()V
    .locals 2

    .prologue
    .line 352
    const-string v0, "#version 100\n"

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 353
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "precision mediump float;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 354
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "attribute vec4 vertexPosition;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 355
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "attribute vec4 vertexUV;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 356
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "uniform mat4 textureMat;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 357
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "varying highp vec2 out_uv;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 358
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 359
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "void main()\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 360
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "{\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 361
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tgl_Position = vec4(vertexPosition.xy, 0.0, 1.0);\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 362
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tout_uv = (textureMat * vertexUV).xy;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 363
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 365
    const-string v0, "#version 100\n"

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 366
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "uniform sampler2D texture;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 367
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "varying highp vec2 out_uv;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 368
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 369
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "void main()\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 370
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "{\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 371
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tgl_FragColor = texture2D(texture, out_uv);\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 372
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 373
    return-void
.end method

.method private LoadGlShaders_TextureOES()V
    .locals 2

    .prologue
    .line 323
    const-string v0, "#version 100\n"

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 324
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "precision mediump float;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 325
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "attribute vec4 vertexPosition;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 326
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "attribute vec4 vertexUV;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 327
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "uniform mat4 textureMat;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 328
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "varying highp vec2 out_uv;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 329
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 330
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "void main()\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 331
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "{\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 332
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tgl_Position = vec4(vertexPosition.xy, 0.0, 1.0);\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 333
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tout_uv = (textureMat * vertexUV).xy;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 334
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexShaderSource:Ljava/lang/String;

    .line 336
    const-string v0, "#version 100\n"

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 337
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "#extension GL_OES_EGL_image_external : require\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 338
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "uniform samplerExternalOES texture;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 339
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "varying highp vec2 out_uv;\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 340
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 341
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "void main()\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 342
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "{\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 343
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\tgl_FragColor = texture2D(texture, out_uv);\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 344
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FragmentShaderSource:Ljava/lang/String;

    .line 345
    return-void
.end method

.method private SetupGlShaderProgram()V
    .locals 2

    .prologue
    .line 429
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ProgramHandle:I

    const-string v1, "vertexPosition"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    .line 430
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ProgramHandle:I

    const-string v1, "vertexUV"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    .line 431
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ProgramHandle:I

    const-string v1, "textureMat"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_MatrixHandle:I

    .line 432
    return-void
.end method


# virtual methods
.method public Blit(Landroid/graphics/SurfaceTexture;I[F)V
    .locals 12
    .param p1, "surfaceTexture"    # Landroid/graphics/SurfaceTexture;
    .param p2, "iNumberFramesAvailable"    # I
    .param p3, "matrix"    # [F

    .prologue
    const/16 v1, 0xbe2

    const/4 v11, 0x5

    const/4 v10, 0x4

    const/4 v9, 0x1

    const/4 v3, 0x0

    .line 219
    const v0, 0x8893

    invoke-static {v0, v3}, Landroid/opengl/GLES20;->glBindBuffer(II)V

    .line 220
    const v0, 0x8892

    invoke-static {v0, v3}, Landroid/opengl/GLES20;->glBindBuffer(II)V

    .line 221
    const/16 v0, 0xb71

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisable(I)V

    .line 222
    const/16 v0, 0xb44

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisable(I)V

    .line 223
    invoke-static {v1}, Landroid/opengl/GLES20;->glDisable(I)V

    .line 224
    invoke-static {v3}, Landroid/opengl/GLES20;->glDepthMask(Z)V

    .line 226
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    if-nez v0, :cond_0

    .line 228
    invoke-static {v1}, Landroid/opengl/GLES20;->glEnable(I)V

    .line 229
    const/16 v0, 0x302

    const/16 v1, 0x303

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glBlendFunc(II)V

    .line 233
    :cond_0
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ProgramHandle:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 235
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCanUseGLBindVertexArray:Z

    if-nez v0, :cond_1

    .line 237
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    const/4 v1, 0x3

    const/16 v2, 0x1406

    const/16 v4, 0xc

    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadPositions:Ljava/nio/FloatBuffer;

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    .line 238
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    .line 240
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    const/4 v1, 0x2

    const/16 v2, 0x1406

    const/16 v4, 0x8

    iget-object v5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_QuadUVs:Ljava/nio/FloatBuffer;

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    .line 241
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    .line 244
    :cond_1
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    if-eqz v0, :cond_2

    const v8, 0x8d65

    .line 245
    .local v8, "textureFormat":I
    :goto_0
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    if-eqz v0, :cond_6

    .line 247
    if-eqz p1, :cond_4

    .line 250
    invoke-static {v9}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v7

    .line 251
    .local v7, "requiredTextureUnitsResultBuffer":Ljava/nio/IntBuffer;
    const v0, 0x8d65

    const v1, 0x8d68

    invoke-static {v0, v1, v7}, Landroid/opengl/GLES20;->glGetTexParameteriv(IILjava/nio/IntBuffer;)V

    .line 253
    invoke-virtual {v7, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v0

    .line 254
    packed-switch v0, :pswitch_data_0

    .line 258
    :goto_1
    const v0, 0x84c0

    invoke-static {v0}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 263
    :goto_2
    if-lez p2, :cond_3

    .line 266
    :try_start_0
    invoke-virtual {p1}, Landroid/graphics/SurfaceTexture;->updateTexImage()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 269
    add-int/lit8 p2, p2, -0x1

    goto :goto_2

    .line 244
    .end local v7    # "requiredTextureUnitsResultBuffer":Ljava/nio/IntBuffer;
    .end local v8    # "textureFormat":I
    :cond_2
    const/16 v8, 0xde1

    goto :goto_0

    .line 256
    .restart local v7    # "requiredTextureUnitsResultBuffer":Ljava/nio/IntBuffer;
    .restart local v8    # "textureFormat":I
    :pswitch_0
    const v0, 0x84c2

    invoke-static {v0}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 257
    :pswitch_1
    const v0, 0x84c1

    invoke-static {v0}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    goto :goto_1

    .line 272
    :catch_0
    move-exception v6

    .line 274
    .local v6, "e":Ljava/lang/IllegalStateException;
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Failed to updateTexImage in Blit: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 277
    .end local v6    # "e":Ljava/lang/IllegalStateException;
    :cond_3
    if-nez p3, :cond_4

    .line 279
    const/16 v0, 0x10

    new-array p3, v0, [F

    .line 280
    invoke-virtual {p1, p3}, Landroid/graphics/SurfaceTexture;->getTransformMatrix([F)V

    .line 291
    .end local v7    # "requiredTextureUnitsResultBuffer":Ljava/nio/IntBuffer;
    :cond_4
    :goto_3
    if-eqz p3, :cond_5

    .line 293
    invoke-static {p3}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateFloatBuffer([F)Ljava/nio/FloatBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_MatrixFloatBuffer:Ljava/nio/FloatBuffer;

    .line 294
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_MatrixHandle:I

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_MatrixFloatBuffer:Ljava/nio/FloatBuffer;

    invoke-static {v0, v9, v3, v1}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZLjava/nio/FloatBuffer;)V

    .line 298
    :cond_5
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCanUseGLBindVertexArray:Z

    if-eqz v0, :cond_7

    .line 301
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iVertexArrayObject:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    .line 302
    invoke-static {v11, v3, v10}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    .line 303
    invoke-static {v3}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    .line 311
    :goto_4
    invoke-static {v8, v3}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 312
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_uvAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisableVertexAttribArray(I)V

    .line 313
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_VertexAttribHandle:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisableVertexAttribArray(I)V

    .line 314
    invoke-static {v3}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 315
    return-void

    .line 286
    :cond_6
    const v0, 0x84c0

    invoke-static {v0}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 287
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_TextureHandle:I

    invoke-static {v8, v0}, Landroid/opengl/GLES20;->glBindTexture(II)V

    goto :goto_3

    .line 307
    :cond_7
    invoke-static {v11, v3, v10}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    goto :goto_4

    .line 254
    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public CreateRenderTarget(II)V
    .locals 12
    .param p1, "width"    # I
    .param p2, "height"    # I

    .prologue
    const v11, 0x8d40

    const/4 v4, 0x1

    const/4 v10, 0x0

    const/4 v1, 0x0

    const/16 v0, 0xde1

    .line 94
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "CreateRenderTarget() called ("

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " x "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 96
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    .line 99
    iput p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferWidth:I

    .line 100
    iput p2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferHeight:I

    .line 102
    invoke-static {v4}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v9

    .line 105
    .local v9, "intBuffer":Ljava/nio/IntBuffer;
    invoke-static {v4, v9}, Landroid/opengl/GLES20;->glGenFramebuffers(ILjava/nio/IntBuffer;)V

    .line 106
    invoke-virtual {v9, v1}, Ljava/nio/IntBuffer;->get(I)I

    move-result v2

    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    .line 107
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "CreateRenderTarget m_FrameBufferHandle: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 110
    invoke-static {v4, v9}, Landroid/opengl/GLES20;->glGenTextures(ILjava/nio/IntBuffer;)V

    .line 111
    invoke-virtual {v9, v1}, Ljava/nio/IntBuffer;->get(I)I

    move-result v2

    iput v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    .line 112
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "CreateRenderTarget m_FrameBufferTextureHandle: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 115
    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    invoke-static {v11, v2}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 118
    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    invoke-static {v0, v2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 121
    const/16 v2, 0x1908

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferWidth:I

    iget v4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferHeight:I

    const/16 v6, 0x1908

    const/16 v7, 0x1401

    const/4 v8, 0x0

    move v5, v1

    invoke-static/range {v0 .. v8}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 122
    const/16 v2, 0x2801

    const/16 v3, 0x2601

    invoke-static {v0, v2, v3}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 123
    const/16 v2, 0x2800

    const/16 v3, 0x2601

    invoke-static {v0, v2, v3}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 124
    const/16 v2, 0x2802

    const v3, 0x812f

    invoke-static {v0, v2, v3}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 125
    const/16 v2, 0x2803

    const v3, 0x812f

    invoke-static {v0, v2, v3}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 128
    const v2, 0x8ce0

    iget v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    invoke-static {v11, v2, v0, v3, v1}, Landroid/opengl/GLES20;->glFramebufferTexture2D(IIIII)V

    .line 130
    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v10, v10, v10, v2}, Landroid/opengl/GLES20;->glClearColor(FFFF)V

    .line 131
    const/16 v2, 0x4500

    invoke-static {v2}, Landroid/opengl/GLES20;->glClear(I)V

    .line 134
    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 135
    invoke-static {v11, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 137
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    .line 139
    return-void
.end method

.method public DestroyRenderTarget()V
    .locals 6

    .prologue
    const v5, 0x8d40

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 148
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DestroyRenderTarget m_FrameBufferHandle: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 149
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    if-eqz v1, :cond_0

    .line 151
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    invoke-static {v5, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 152
    const v1, 0x8ce0

    const/16 v2, 0xde1

    invoke-static {v5, v1, v2, v3, v3}, Landroid/opengl/GLES20;->glFramebufferTexture2D(IIIII)V

    .line 154
    new-array v0, v4, [I

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    aput v1, v0, v3

    .line 155
    .local v0, "handle":[I
    invoke-static {v4, v0, v3}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 156
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    .line 159
    iput v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    .line 161
    invoke-static {v5, v3}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 162
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    .line 166
    .end local v0    # "handle":[I
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DestroyRenderTarget m_FrameBufferTextureHandle: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 167
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    if-eqz v1, :cond_1

    .line 170
    new-array v0, v4, [I

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    aput v1, v0, v3

    .line 171
    .restart local v0    # "handle":[I
    invoke-static {v4, v0, v3}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 172
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    .line 175
    iput v3, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    .line 177
    .end local v0    # "handle":[I
    :cond_1
    return-void
.end method

.method public EndRender()V
    .locals 4

    .prologue
    const/16 v3, 0xbe2

    const/16 v2, 0xb71

    const/16 v1, 0xb44

    .line 202
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    if-eqz v0, :cond_0

    .line 205
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bBlendEnabled:Z

    if-eqz v0, :cond_1

    invoke-static {v3}, Landroid/opengl/GLES20;->glEnable(I)V

    .line 206
    :goto_0
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bDepthTest:Z

    if-eqz v0, :cond_2

    invoke-static {v2}, Landroid/opengl/GLES20;->glEnable(I)V

    .line 207
    :goto_1
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCullFace:Z

    if-eqz v0, :cond_3

    invoke-static {v1}, Landroid/opengl/GLES20;->glEnable(I)V

    .line 209
    :goto_2
    const v0, 0x8d40

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iFrameBufferBinding:I

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 210
    const v0, 0x8d41

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iRenderBufferBinding:I

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glBindRenderbuffer(II)V

    .line 211
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iCurrentProgram:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 213
    :cond_0
    return-void

    .line 205
    :cond_1
    invoke-static {v3}, Landroid/opengl/GLES20;->glDisable(I)V

    goto :goto_0

    .line 206
    :cond_2
    invoke-static {v2}, Landroid/opengl/GLES20;->glDisable(I)V

    goto :goto_1

    .line 207
    :cond_3
    invoke-static {v1}, Landroid/opengl/GLES20;->glDisable(I)V

    goto :goto_2
.end method

.method public GetGlTextureHandle()I
    .locals 1

    .prologue
    .line 89
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferTextureHandle:I

    return v0
.end method

.method public Setup(II[BZZ)V
    .locals 2
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "data"    # [B
    .param p4, "bTextureFormat_EOS"    # Z
    .param p5, "bCanUseGLBindVertexArray"    # Z

    .prologue
    .line 56
    iput p1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Width:I

    .line 57
    iput p2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Height:I

    .line 59
    iput-boolean p4, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    .line 60
    iput-boolean p5, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCanUseGLBindVertexArray:Z

    .line 62
    if-eqz p3, :cond_0

    .line 64
    iget v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Width:I

    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_Height:I

    mul-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x4

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ImageData:Ljava/nio/ByteBuffer;

    .line 65
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ImageData:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "CreateGlTexture image size: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ImageData:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 67
    iget-object v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_ImageData:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 69
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_HasImageData:Z

    .line 72
    :cond_0
    iget-boolean v0, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bTextureFormat_EOS:Z

    if-eqz v0, :cond_1

    .line 74
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->LoadGlShaders_TextureOES()V

    .line 81
    :goto_0
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateGlTexture()V

    .line 82
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateGlShaderProgram()V

    .line 83
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->SetupGlShaderProgram()V

    .line 84
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->CreateGlQuadGeometry()V

    .line 85
    return-void

    .line 78
    :cond_1
    invoke-direct {p0}, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->LoadGlShaders_Texture2D()V

    goto :goto_0
.end method

.method public StartRender()V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 181
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    if-eqz v1, :cond_0

    .line 184
    const/16 v1, 0x8

    invoke-static {v1}, Ljava/nio/IntBuffer;->allocate(I)Ljava/nio/IntBuffer;

    move-result-object v0

    .line 185
    .local v0, "resultBuffer":Ljava/nio/IntBuffer;
    const/16 v1, 0xbe2

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetBooleanv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    if-ne v1, v2, :cond_1

    move v1, v2

    :goto_0
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bBlendEnabled:Z

    .line 186
    const/16 v1, 0xb71

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetBooleanv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    if-ne v1, v2, :cond_2

    move v1, v2

    :goto_1
    iput-boolean v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bDepthTest:Z

    .line 187
    const/16 v1, 0xb44

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetBooleanv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    if-ne v1, v2, :cond_3

    :goto_2
    iput-boolean v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_bCullFace:Z

    .line 188
    const v1, 0x8b8d

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetIntegerv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iCurrentProgram:I

    .line 189
    const v1, 0x8ca6

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetIntegerv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iFrameBufferBinding:I

    .line 190
    const v1, 0x8ca7

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glGetIntegerv(ILjava/nio/IntBuffer;)V

    invoke-virtual {v0, v3}, Ljava/nio/IntBuffer;->get(I)I

    move-result v1

    iput v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_iRenderBufferBinding:I

    .line 193
    const v1, 0x8d40

    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FrameBufferHandle:I

    invoke-static {v1, v2}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 194
    const/16 v1, 0xc11

    invoke-static {v1}, Landroid/opengl/GLES20;->glDisable(I)V

    .line 195
    iget v1, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferWidth:I

    iget v2, p0, Lcom/RenderHeads/AVProVideo/AVProMobileVideo_GlRender;->m_FramebufferHeight:I

    invoke-static {v3, v3, v1, v2}, Landroid/opengl/GLES20;->glViewport(IIII)V

    .line 196
    const/16 v1, 0x4500

    invoke-static {v1}, Landroid/opengl/GLES20;->glClear(I)V

    .line 198
    .end local v0    # "resultBuffer":Ljava/nio/IntBuffer;
    :cond_0
    return-void

    .restart local v0    # "resultBuffer":Ljava/nio/IntBuffer;
    :cond_1
    move v1, v3

    .line 185
    goto :goto_0

    :cond_2
    move v1, v3

    .line 186
    goto :goto_1

    :cond_3
    move v2, v3

    .line 187
    goto :goto_2
.end method
