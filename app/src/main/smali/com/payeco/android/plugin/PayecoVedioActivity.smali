.class public Lcom/payeco/android/plugin/PayecoVedioActivity;
.super Landroid/app/Activity;


# instance fields
.field private a:Landroid/widget/Button;

.field private b:Landroid/widget/Button;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/media/MediaRecorder;

.field private g:Landroid/os/Handler;

.field private h:Landroid/hardware/Camera;

.field private i:Landroid/view/SurfaceView;

.field private j:Landroid/view/SurfaceHolder;

.field private k:I

.field private l:I

.field private m:I

.field private n:I

.field private o:Z

.field private p:Z

.field private q:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const/4 v0, 0x3

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->k:I

    const/16 v0, 0x140

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->m:I

    const/16 v0, 0xf0

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->n:I

    new-instance v0, Lcom/payeco/android/plugin/z;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/z;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->q:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoVedioActivity;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->l:I

    return v0
.end method

.method private a(Ljava/lang/String;)Landroid/view/View;
    .locals 1

    const-string v0, "id"

    invoke-static {p0, p1, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method private a()V
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    :cond_0
    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoVedioActivity;I)V
    .locals 0

    iput p1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->l:I

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/PayecoVedioActivity;Landroid/hardware/Camera;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    return-void
.end method

.method static synthetic b(Lcom/payeco/android/plugin/PayecoVedioActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->e:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic c(Lcom/payeco/android/plugin/PayecoVedioActivity;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->g:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic d(Lcom/payeco/android/plugin/PayecoVedioActivity;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->q:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/PayecoVedioActivity;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->k:I

    return v0
.end method

.method static synthetic f(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 5

    const/4 v4, 0x0

    const/4 v3, 0x1

    :try_start_0
    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->o:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->g:Landroid/os/Handler;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->q:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->e:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->l:I

    const/4 v1, 0x0

    iput v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->l:I

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->o:Z

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u60a8\u5f55\u5236\u4e86 "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u79d2\u949f\u7684\u89c6\u9891"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    if-nez v0, :cond_1

    invoke-static {}, Landroid/hardware/Camera;->open()Landroid/hardware/Camera;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->j:Landroid/view/SurfaceHolder;

    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->setPreviewDisplay(Landroid/view/SurfaceHolder;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :cond_1
    :goto_0
    :try_start_2
    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->startPreview()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->a:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->d:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->b:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->c:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->p:Z

    :goto_1
    return-void

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoVedioActivity -stop.mCamera.setPreviewDisplay error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoVedioActivity -stop error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iput-boolean v4, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->p:Z

    const-string v0, "\u89c6\u9891\u505c\u6b62\u5931\u8d25..."

    invoke-static {p0, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_1
.end method

.method static synthetic g(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 6

    const/4 v5, 0x1

    const/4 v4, 0x0

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -startRecord ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->o:Z

    if-nez v0, :cond_0

    iput-boolean v5, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->o:Z

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->a:Landroid/widget/Button;

    invoke-virtual {v0, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->d:Landroid/widget/Button;

    invoke-virtual {v0, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->b:Landroid/widget/Button;

    invoke-virtual {v0, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->c:Landroid/widget/Button;

    invoke-virtual {v0, v4}, Landroid/widget/Button;->setEnabled(Z)V

    :try_start_0
    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a()V

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    new-instance v1, Landroid/media/MediaRecorder;

    invoke-direct {v1}, Landroid/media/MediaRecorder;-><init>()V

    iput-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    iget-object v2, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->i:Landroid/view/SurfaceView;

    invoke-virtual {v2}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    invoke-interface {v2}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setPreviewDisplay(Landroid/view/Surface;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setVideoSource(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setAudioSource(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setOutputFormat(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    iget v2, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->m:I

    iget v3, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->n:I

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaRecorder;->setVideoSize(II)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setVideoFrameRate(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setVideoEncoder(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    const v2, 0x1b7740

    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setMaxDuration(I)V

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->prepare()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->start()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->e:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->g:Landroid/os/Handler;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->q:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoVedioActivity -startRecord error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iput-boolean v4, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->p:Z

    const-string v0, "\u89c6\u9891\u5f55\u5236\u5931\u8d25..."

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method

.method static synthetic h(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 3

    :try_start_0
    sget-object v0, Lcom/payeco/android/plugin/b/a;->d:Ljava/lang/String;

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "video/mp4"

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v1}, Lcom/payeco/android/plugin/PayecoVedioActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "PayecoVedioActivity -startPlay error."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v0, "\u89c6\u9891\u64ad\u653e\u5931\u8d25\uff01"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method

.method static synthetic i(Lcom/payeco/android/plugin/PayecoVedioActivity;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->p:Z

    return v0
.end method

.method static synthetic j(Lcom/payeco/android/plugin/PayecoVedioActivity;)Landroid/hardware/Camera;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->h:Landroid/hardware/Camera;

    return-object v0
.end method

.method static synthetic k(Lcom/payeco/android/plugin/PayecoVedioActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 5

    const/4 v4, 0x1

    const/4 v3, 0x0

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -onCreate ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0, v3}, Lcom/payeco/android/plugin/PayecoVedioActivity;->setRequestedOrientation(I)V

    invoke-virtual {p0, v4}, Lcom/payeco/android/plugin/PayecoVedioActivity;->requestWindowFeature(I)Z

    const-string v0, "payeco_plugin_vedio"

    const-string v1, "layout"

    invoke-static {p0, v0, v1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->setContentView(I)V

    invoke-virtual {p0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "vedioTime"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->k:I

    :try_start_0
    const-string v0, "VedioWidth"

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->m:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    :try_start_1
    const-string v0, "VedioHeight"

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->n:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :goto_1
    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "PayecoVedioActivity -init toTime="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->k:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "PayecoVedioActivity -init width="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->m:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "payeco"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "PayecoVedioActivity -init height="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->n:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "time"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->e:Landroid/widget/TextView;

    const-string v0, "luXiang_bt"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->a:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->a:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/aa;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/aa;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "bofang_bt"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->b:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->b:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/ab;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/ab;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->b:Landroid/widget/Button;

    invoke-virtual {v0, v3}, Landroid/widget/Button;->setEnabled(Z)V

    const-string v0, "queren"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->c:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->c:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/ac;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/ac;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->c:Landroid/widget/Button;

    invoke-virtual {v0, v3}, Landroid/widget/Button;->setEnabled(Z)V

    const-string v0, "cancel"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->d:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->d:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/ad;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/ad;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->g:Landroid/os/Handler;

    const-string v0, "surfaceview"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/SurfaceView;

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->i:Landroid/view/SurfaceView;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->i:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    const/4 v1, 0x3

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setType(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->i:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    const/16 v1, 0x320

    const/16 v2, 0x1e0

    invoke-interface {v0, v1, v2}, Landroid/view/SurfaceHolder;->setFixedSize(II)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->i:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    iput-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->j:Landroid/view/SurfaceHolder;

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->j:Landroid/view/SurfaceHolder;

    invoke-interface {v0, v4}, Landroid/view/SurfaceHolder;->setKeepScreenOn(Z)V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->j:Landroid/view/SurfaceHolder;

    new-instance v1, Lcom/payeco/android/plugin/ae;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/ae;-><init>(Lcom/payeco/android/plugin/PayecoVedioActivity;)V

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -onCreate ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catch_0
    move-exception v0

    goto/16 :goto_1

    :catch_1
    move-exception v0

    goto/16 :goto_0
.end method

.method protected onDestroy()V
    .locals 2

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -onDestroy ..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->g:Landroid/os/Handler;

    iget-object v1, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->q:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/payeco/android/plugin/PayecoVedioActivity;->a()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V

    iget-object v0, p0, Lcom/payeco/android/plugin/PayecoVedioActivity;->f:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    const-string v0, "payeco"

    const-string v1, "PayecoVedioActivity -onDestroy ok."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
