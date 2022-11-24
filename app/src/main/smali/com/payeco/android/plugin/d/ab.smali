.class public final Lcom/payeco/android/plugin/d/ab;
.super Landroid/widget/PopupWindow;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ViewConstructor"
    }
.end annotation


# static fields
.field private static c:Lcom/payeco/android/plugin/d/ab;


# instance fields
.field public a:Z

.field public b:Z

.field private d:Landroid/content/Context;

.field private e:Landroid/view/View;

.field private f:Landroid/widget/Button;

.field private g:Landroid/widget/Button;

.field private h:Landroid/widget/Button;

.field private i:Landroid/widget/Button;

.field private j:Landroid/widget/TextView;

.field private k:I

.field private l:I

.field private m:Landroid/os/Handler;

.field private n:Landroid/media/MediaRecorder;

.field private o:Landroid/media/MediaPlayer;

.field private p:Lcom/payeco/android/plugin/d/aj;

.field private q:Ljava/lang/Runnable;


# direct methods
.method private constructor <init>(Landroid/view/View;Landroid/content/Context;I)V
    .locals 3

    const/4 v0, -0x1

    const/4 v2, 0x0

    invoke-direct {p0, p1, v0, v0, v2}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    const/4 v0, 0x5

    iput v0, p0, Lcom/payeco/android/plugin/d/ab;->k:I

    new-instance v0, Lcom/payeco/android/plugin/d/ac;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/d/ac;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->q:Ljava/lang/Runnable;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/ab;->d:Landroid/content/Context;

    iput-object p1, p0, Lcom/payeco/android/plugin/d/ab;->e:Landroid/view/View;

    iput p3, p0, Lcom/payeco/android/plugin/d/ab;->k:I

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->m:Landroid/os/Handler;

    const-string v0, "time"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/ab;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->j:Landroid/widget/TextView;

    const-string v0, "btnStart"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/ab;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->f:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->f:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/ad;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/ad;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "btnPlay"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/ab;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->h:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->h:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/ae;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/ae;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->h:Landroid/widget/Button;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    const-string v0, "btnFinish"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/ab;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->i:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->i:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/af;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/af;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->i:Landroid/widget/Button;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    const-string v0, "btnCancel"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/ab;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->g:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->g:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/ag;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/ag;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private a(I)I
    .locals 4

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v0, 0x1

    invoke-static {}, Lcom/payeco/android/plugin/c/g;->b()Z

    move-result v3

    if-nez v3, :cond_0

    :goto_0
    return v0

    :cond_0
    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/ab;->b:Z

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/ab;->a:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x3

    goto :goto_0

    :cond_2
    :try_start_0
    new-instance v0, Landroid/media/MediaRecorder;

    invoke-direct {v0}, Landroid/media/MediaRecorder;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioSource(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFormat(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    sget-object v1, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->prepare()V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->start()V

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/payeco/android/plugin/d/ah;

    invoke-direct {v1, p0, p1}, Lcom/payeco/android/plugin/d/ah;-><init>(Lcom/payeco/android/plugin/d/ab;I)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/payeco/android/plugin/d/ab;->a:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v2

    goto :goto_0

    :catch_0
    move-exception v0

    iput-boolean v2, p0, Lcom/payeco/android/plugin/d/ab;->a:Z

    const/4 v0, 0x4

    goto :goto_0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/ab;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/ab;->l:I

    return v0
.end method

.method private a(Ljava/lang/String;)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->e:Landroid/view/View;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ab;->d:Landroid/content/Context;

    invoke-static {v0, v1, p1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public static a(Landroid/content/Context;Landroid/view/View;ILcom/payeco/android/plugin/d/aj;)Lcom/payeco/android/plugin/d/ab;
    .locals 3

    const/4 v2, 0x0

    const-string v0, "payeco_plugin_record"

    invoke-static {p0, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    sget-object v1, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    if-nez v1, :cond_0

    new-instance v1, Lcom/payeco/android/plugin/d/ab;

    invoke-direct {v1, v0, p0, p2}, Lcom/payeco/android/plugin/d/ab;-><init>(Landroid/view/View;Landroid/content/Context;I)V

    sput-object v1, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    new-instance v0, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/BitmapDrawable;-><init>()V

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/d/ab;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-object v0, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/ab;->update()V

    sget-object v0, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    const/16 v1, 0x50

    invoke-virtual {v0, p1, v1, v2, v2}, Lcom/payeco/android/plugin/d/ab;->showAtLocation(Landroid/view/View;III)V

    sget-object v0, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    iput-object p3, v0, Lcom/payeco/android/plugin/d/ab;->p:Lcom/payeco/android/plugin/d/aj;

    :cond_0
    sget-object v0, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    return-object v0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/ab;I)V
    .locals 0

    iput p1, p0, Lcom/payeco/android/plugin/d/ab;->l:I

    return-void
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/ab;I)I
    .locals 1

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/d/ab;->a(I)I

    move-result v0

    return v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->j:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic c(Lcom/payeco/android/plugin/d/ab;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->m:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic d(Lcom/payeco/android/plugin/d/ab;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->q:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/d/ab;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/ab;->k:I

    return v0
.end method

.method static synthetic f(Lcom/payeco/android/plugin/d/ab;)Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->d:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic g(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->i:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic h(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->h:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic i(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->f:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic j(Lcom/payeco/android/plugin/d/ab;)Landroid/widget/Button;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->g:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic k(Lcom/payeco/android/plugin/d/ab;)Lcom/payeco/android/plugin/d/aj;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->p:Lcom/payeco/android/plugin/d/aj;

    return-object v0
.end method


# virtual methods
.method public final a()I
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-boolean v1, p0, Lcom/payeco/android/plugin/d/ab;->a:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    invoke-virtual {v1}, Landroid/media/MediaRecorder;->stop()V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    invoke-virtual {v1}, Landroid/media/MediaRecorder;->release()V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/payeco/android/plugin/d/ab;->n:Landroid/media/MediaRecorder;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/payeco/android/plugin/d/ab;->a:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public final b()I
    .locals 3

    const/4 v0, 0x1

    const/4 v1, 0x0

    iget-boolean v2, p0, Lcom/payeco/android/plugin/d/ab;->a:Z

    if-eqz v2, :cond_0

    :goto_0
    return v0

    :cond_0
    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/ab;->b:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x2

    goto :goto_0

    :cond_1
    :try_start_0
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/ab;->o:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->o:Landroid/media/MediaPlayer;

    sget-object v2, Lcom/payeco/android/plugin/b/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->o:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->o:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->o:Landroid/media/MediaPlayer;

    new-instance v2, Lcom/payeco/android/plugin/d/ai;

    invoke-direct {v2, p0}, Lcom/payeco/android/plugin/d/ai;-><init>(Lcom/payeco/android/plugin/d/ab;)V

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/payeco/android/plugin/d/ab;->b:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    goto :goto_0

    :catch_0
    move-exception v0

    iput-boolean v1, p0, Lcom/payeco/android/plugin/d/ab;->b:Z

    const/4 v0, 0x3

    goto :goto_0
.end method

.method public final dismiss()V
    .locals 3

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/ab;->m:Landroid/os/Handler;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/ab;->q:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iput-object v2, p0, Lcom/payeco/android/plugin/d/ab;->m:Landroid/os/Handler;

    sput-object v2, Lcom/payeco/android/plugin/d/ab;->c:Lcom/payeco/android/plugin/d/ab;

    invoke-super {p0}, Landroid/widget/PopupWindow;->dismiss()V

    return-void
.end method
