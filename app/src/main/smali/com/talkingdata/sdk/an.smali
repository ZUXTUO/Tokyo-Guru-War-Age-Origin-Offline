.class public Lcom/talkingdata/sdk/an;
.super Ljava/lang/Object;


# static fields
.field static a:Landroid/app/Application;

.field private static b:Z

.field private static c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lcom/talkingdata/sdk/an;->b:Z

    sput-boolean v0, Lcom/talkingdata/sdk/an;->c:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Landroid/content/Context;)V
    .locals 7

    invoke-static {}, Lcom/talkingdata/sdk/ap;->a()V

    invoke-static {}, Lcom/talkingdata/sdk/aq;->a()Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    invoke-static {p0}, Lcom/talkingdata/sdk/an;->b(Landroid/content/Context;)V

    invoke-static {}, Lcom/talkingdata/sdk/bp;->k()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/talkingdata/sdk/au;->c(Ljava/lang/String;)V

    :cond_0
    new-instance v0, Lcom/talkingdata/sdk/k;

    invoke-direct {v0}, Lcom/talkingdata/sdk/k;-><init>()V

    :try_start_0
    sget-object v1, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    const-string v2, ""

    const-string v3, "tdunique-dyn-act"

    const-class v4, Lcom/talkingdata/sdk/f;

    const-class v5, Lcom/talkingdata/sdk/g;

    const-string v6, "com.talkingdata.sdk.ota.ta"

    invoke-virtual/range {v0 .. v6}, Lcom/talkingdata/sdk/k;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Ljava/lang/String;)Lcom/talkingdata/sdk/m;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/f;

    invoke-interface {v0}, Lcom/talkingdata/sdk/f;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/talkingdata/sdk/an;->c:Z

    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 3

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    if-eqz v0, :cond_2

    new-instance v0, Lcom/talkingdata/sdk/aw;

    invoke-direct {v0, p0, p1}, Lcom/talkingdata/sdk/aw;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_0

    invoke-virtual {v0, p2}, Lcom/talkingdata/sdk/aw;->a(Ljava/util/Map;)V

    :cond_0
    sget-boolean v1, Lcom/talkingdata/sdk/util/TDLog;->b:Z

    if-nez v1, :cond_1

    if-eqz p2, :cond_1

    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result v1

    if-lez v1, :cond_1

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p2}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    :cond_1
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    const/4 v2, 0x1

    iput v2, v1, Landroid/os/Message;->what:I

    iput-object v0, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-static {}, Lcom/talkingdata/sdk/aq;->a()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    :goto_0
    return-void

    :cond_2
    const-string v0, "TalkingDataSDK \u6ca1\u6709\u521d\u59cb\u5316\uff0c\u8bf7\u5148\u8c03\u7528init\u65b9\u6cd5\u8fdb\u884c\u521d\u59cb\u5316"

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static a()Z
    .locals 1

    sget-boolean v0, Lcom/talkingdata/sdk/an;->c:Z

    return v0
.end method

.method public static b()V
    .locals 2

    invoke-static {}, Lcom/talkingdata/sdk/aq;->a()Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method private static b(Landroid/content/Context;)V
    .locals 5

    const/16 v0, 0xe

    invoke-static {v0}, Lcom/talkingdata/sdk/t;->a(I)Z

    move-result v0

    if-eqz v0, :cond_3

    :try_start_0
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_2

    check-cast p0, Landroid/app/Activity;

    invoke-virtual {p0}, Landroid/app/Activity;->getApplication()Landroid/app/Application;

    move-result-object v0

    sput-object v0, Lcom/talkingdata/sdk/an;->a:Landroid/app/Application;

    :cond_0
    :goto_0
    sget-object v0, Lcom/talkingdata/sdk/an;->a:Landroid/app/Application;

    if-eqz v0, :cond_1

    sget-boolean v0, Lcom/talkingdata/sdk/an;->b:Z

    if-nez v0, :cond_1

    const-string v0, "android.app.Application$ActivityLifecycleCallbacks"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/an;->a:Landroid/app/Application;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "registerActivityLifecycleCallbacks"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Lcom/talkingdata/sdk/ak;

    invoke-direct {v1}, Lcom/talkingdata/sdk/ak;-><init>()V

    sget-object v2, Lcom/talkingdata/sdk/an;->a:Landroid/app/Application;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    invoke-virtual {v0, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/talkingdata/sdk/an;->b:Z

    :cond_1
    :goto_1
    return-void

    :cond_2
    instance-of v0, p0, Landroid/app/Application;

    if-eqz v0, :cond_0

    check-cast p0, Landroid/app/Application;

    sput-object p0, Lcom/talkingdata/sdk/an;->a:Landroid/app/Application;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_1

    :cond_3
    new-instance v0, Lcom/talkingdata/sdk/ao;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ao;-><init>()V

    :try_start_1
    const-string v1, "android.app.ActivityManagerNative"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "gDefault"

    const-string v3, "android.app.IActivityManager"

    invoke-static {v1, v0, v2, v3}, Lcom/talkingdata/sdk/t;->a(Ljava/lang/Class;Lcom/talkingdata/sdk/o;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/talkingdata/sdk/an;->b:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    const-string v1, "TDLog"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "registerActivityLifecycleListener "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
