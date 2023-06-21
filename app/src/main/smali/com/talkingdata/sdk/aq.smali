.class public Lcom/talkingdata/sdk/aq;
.super Ljava/lang/Object;


# static fields
.field public static final a:I = 0x1

.field public static final b:I = 0x2

.field public static final c:I = 0x3

.field public static final d:I = 0x5

.field public static final e:I = 0x6

.field static final f:I = 0x2bf20

.field private static g:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/talkingdata/sdk/ar;

    sget-object v1, Lcom/talkingdata/sdk/as;->e:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/talkingdata/sdk/ar;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/talkingdata/sdk/aq;->g:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static final a()Landroid/os/Handler;
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/aq;->g:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic a(Landroid/os/Message;)V
    .locals 0

    invoke-static {p0}, Lcom/talkingdata/sdk/aq;->b(Landroid/os/Message;)V

    return-void
.end method

.method public static b()I
    .locals 8

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    const-string v1, "pref_longtime"

    const-string v2, "PREF_ACTIVE_APP_KEY"

    const-wide/16 v4, 0x0

    invoke-static {v0, v1, v2, v4, v5}, Lcom/talkingdata/sdk/n;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)J

    move-result-wide v0

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Ljava/util/Calendar;->get(I)I

    move-result v3

    mul-int/lit8 v3, v3, 0x64

    const/16 v4, 0xb

    invoke-virtual {v2, v4}, Ljava/util/Calendar;->get(I)I

    move-result v2

    add-int/2addr v2, v3

    const-wide/16 v4, 0x64

    div-long v4, v0, v4

    div-int/lit8 v3, v2, 0x64

    int-to-long v6, v3

    sub-long/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->abs(J)J

    move-result-wide v4

    const-wide/16 v6, 0x1

    cmp-long v3, v4, v6

    if-ltz v3, :cond_0

    const/4 v0, 0x2

    :goto_0
    return v0

    :cond_0
    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static final b(Landroid/os/Message;)V
    .locals 4

    :try_start_0
    iget v0, p0, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :goto_0
    :pswitch_0
    return-void

    :pswitch_1
    iget-object v0, p0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/talkingdata/sdk/aw;

    sget-object v1, Lcom/talkingdata/sdk/as;->b:Ljava/lang/String;

    sget-object v2, Lcom/talkingdata/sdk/as;->c:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Lcom/talkingdata/sdk/bo;->a(Lcom/talkingdata/sdk/aw;Ljava/lang/String;Ljava/lang/String;Z)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/bm;->a(Ljava/lang/String;)V

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    :pswitch_2
    invoke-static {}, Lcom/talkingdata/sdk/bm;->a()V

    goto :goto_0

    :pswitch_3
    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/bm;->a(Landroid/content/Context;)V

    sget-object v0, Lcom/talkingdata/sdk/aq;->g:Landroid/os/Handler;

    const/4 v1, 0x5

    const-wide/32 v2, 0x2bf20

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    sget-object v0, Lcom/talkingdata/sdk/aq;->g:Landroid/os/Handler;

    const/4 v1, 0x6

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_0

    :pswitch_4
    sget-object v0, Lcom/talkingdata/sdk/aq;->g:Landroid/os/Handler;

    const/4 v1, 0x5

    const-wide/32 v2, 0x2bf20

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z

    new-instance v0, Lcom/talkingdata/sdk/aw;

    const-string v1, "env"

    const-string v2, "current"

    invoke-direct {v0, v1, v2}, Lcom/talkingdata/sdk/aw;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lcom/talkingdata/sdk/as;->b:Ljava/lang/String;

    sget-object v2, Lcom/talkingdata/sdk/as;->c:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-static {v0, v1, v2, v3}, Lcom/talkingdata/sdk/bo;->a(Lcom/talkingdata/sdk/aw;Ljava/lang/String;Ljava/lang/String;Z)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/bm;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
        :pswitch_4
        :pswitch_0
    .end packed-switch
.end method

.method private static c()V
    .locals 6

    :try_start_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    const/4 v1, 0x6

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    mul-int/lit8 v1, v1, 0x64

    const/16 v2, 0xb

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v0

    add-int/2addr v0, v1

    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    const-string v2, "pref_longtime"

    const-string v3, "PREF_ACTIVE_APP_KEY"

    int-to-long v4, v0

    invoke-static {v1, v2, v3, v4, v5}, Lcom/talkingdata/sdk/n;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
