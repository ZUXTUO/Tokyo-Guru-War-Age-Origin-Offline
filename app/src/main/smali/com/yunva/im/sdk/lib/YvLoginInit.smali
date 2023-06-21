.class public Lcom/yunva/im/sdk/lib/YvLoginInit;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yunva/im/sdk/lib/YvLoginInit$a;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "YvLoginInit"

.field public static context:Landroid/content/Context;

.field private static flag:Z

.field public static handler:Landroid/os/Handler;

.field public static mAppId:Ljava/lang/String;

.field public static mtime:J


# instance fields
.field private lbsUtil:Lcom/pg/im/sdk/lib/c/a;

.field private mGetLbsInfoReturnListener:Lcom/yunva/im/sdk/lib/YvLoginInit$a;

.field private mHandler:Landroid/os/Handler;

.field private orTest:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 30
    const/4 v0, 0x1

    sput-boolean v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->flag:Z

    .line 34
    new-instance v0, Lcom/yunva/im/sdk/lib/YvLoginInit$1;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/yunva/im/sdk/lib/YvLoginInit$1;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->handler:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    new-instance v0, Lcom/yunva/im/sdk/lib/YvLoginInit$a;

    invoke-direct {v0, p0}, Lcom/yunva/im/sdk/lib/YvLoginInit$a;-><init>(Lcom/yunva/im/sdk/lib/YvLoginInit;)V

    iput-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mGetLbsInfoReturnListener:Lcom/yunva/im/sdk/lib/YvLoginInit$a;

    .line 50
    new-instance v0, Lcom/yunva/im/sdk/lib/YvLoginInit$2;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/yunva/im/sdk/lib/YvLoginInit$2;-><init>(Lcom/yunva/im/sdk/lib/YvLoginInit;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    .line 153
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->orTest:Z

    .line 89
    return-void
.end method

.method public static native YvImDoCallBack()V
.end method

.method static synthetic access$000()Z
    .locals 1

    .prologue
    .line 26
    sget-boolean v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->flag:Z

    return v0
.end method

.method static synthetic access$002(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    .line 26
    sput-boolean p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->flag:Z

    return p0
.end method

.method static synthetic access$100(Lcom/yunva/im/sdk/lib/YvLoginInit;)Lcom/pg/im/sdk/lib/c/a;
    .locals 1
    .param p0, "x0"    # Lcom/yunva/im/sdk/lib/YvLoginInit;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    return-object v0
.end method

.method private static checkService(Landroid/content/Context;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 293
    :try_start_0
    new-instance v0, Landroid/content/ComponentName;

    const-class v1, Lcom/pg/im/sdk/lib/VioceService;

    invoke-direct {v0, p0, v1}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 294
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v1, v0, v2}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 300
    return-void

    .line 297
    :catch_0
    move-exception v0

    .line 298
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "not found services \u914d\u7f6e\u9519\u8bef\uff1aAndroidManifest.xml \u914d\u7f6e\u6587\u4ef6 \u7f3a\u5c11\u914d\u7f6e services ---> com.pg.im.sdk.lib.service.VioceService \u8bf7\u914d\u7f6e\u540e\u91cd\u8bd5\uff01\uff01"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static getCLib()Ljava/lang/Class;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .prologue
    .line 130
    :try_start_0
    const-string v0, "com.blm.sdk.core.CoreLib"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 135
    :goto_0
    return-object v0

    .line 131
    :catch_0
    move-exception v0

    .line 132
    const-string v0, "YvLoginInit"

    const-string v1, "CLib not found"

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static initApplicationOnCreate(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2
    .param p0, "application"    # Landroid/content/Context;
    .param p1, "appId"    # Ljava/lang/String;

    .prologue
    .line 92
    const-wide/32 v0, 0x1b7740

    invoke-static {p0, p1, v0, v1}, Lcom/yunva/im/sdk/lib/YvLoginInit;->initApplicationOnCreate(Landroid/content/Context;Ljava/lang/String;J)V

    .line 93
    return-void
.end method

.method public static initApplicationOnCreate(Landroid/content/Context;Ljava/lang/String;J)V
    .locals 2
    .param p0, "application"    # Landroid/content/Context;
    .param p1, "appId"    # Ljava/lang/String;
    .param p2, "time"    # J

    .prologue
    .line 96
    sput-object p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    .line 97
    sput-object p1, Lcom/yunva/im/sdk/lib/YvLoginInit;->mAppId:Ljava/lang/String;

    .line 98
    sput-wide p2, Lcom/yunva/im/sdk/lib/YvLoginInit;->mtime:J

    .line 99
    invoke-static {p0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->checkService(Landroid/content/Context;)V

    .line 101
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/pg/im/sdk/lib/a/c;->a(Z)V

    .line 103
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->handler:Landroid/os/Handler;

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/a;->a(Landroid/content/Context;Landroid/os/Handler;)V

    .line 104
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/blm/sdk/core/CoreLib;->init(Landroid/content/Context;Ljava/lang/String;)V

    .line 106
    return-void
.end method

.method private static initCLib(Ljava/lang/Class;Landroid/content/Context;Ljava/lang/String;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 141
    .local p0, "clibClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-string v0, "init"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    const-class v3, Landroid/content/Context;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-class v3, Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-virtual {p0, v0, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 147
    const/4 v1, 0x2

    :try_start_1
    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    invoke-virtual {v0, p0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 151
    :goto_0
    return-void

    .line 142
    :catch_0
    move-exception v0

    .line 143
    const-string v0, "YvLoginInit"

    const-string v1, "init method not found !"

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->c(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 148
    :catch_1
    move-exception v0

    .line 149
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private initc()I
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 207
    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    if-eqz v2, :cond_1

    .line 253
    :cond_0
    :goto_0
    return v0

    .line 211
    :cond_1
    :try_start_0
    sget-object v2, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    if-eqz v2, :cond_2

    .line 212
    sget-object v2, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    sput-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    .line 213
    const-string v2, "dalvikvm"

    const-string v3, " This is Unity ..."

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 224
    :catch_0
    move-exception v2

    .line 227
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getContext()Landroid/content/Context;

    move-result-object v2

    if-eqz v2, :cond_3

    .line 228
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getContext()Landroid/content/Context;

    move-result-object v2

    sput-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    .line 229
    const-string v2, "dalvikvm"

    const-string v3, " This is Cocos2dx ..."

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 239
    :catch_1
    move-exception v2

    .line 241
    :try_start_2
    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    if-eqz v2, :cond_4

    .line 242
    const-string v2, "dalvikvm"

    const-string v3, " This is Android  ..."

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Error; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    .line 247
    :catch_2
    move-exception v2

    .line 249
    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    if-eqz v2, :cond_5

    .line 250
    const-string v1, "dalvikvm"

    const-string v2, " This is unknown engine ..."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 216
    :cond_2
    :try_start_3
    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;
    :try_end_3
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_3 .. :try_end_3} :catch_0

    if-nez v2, :cond_0

    move v0, v1

    .line 219
    goto :goto_0

    .line 232
    :cond_3
    :try_start_4
    sget-object v2, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;
    :try_end_4
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_4 .. :try_end_4} :catch_1

    if-nez v2, :cond_0

    move v0, v1

    .line 235
    goto :goto_0

    :cond_4
    move v0, v1

    .line 245
    goto :goto_0

    :cond_5
    move v0, v1

    .line 253
    goto :goto_0
.end method

.method private static loadYayaCoreLibIfIncluded(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "appId"    # Ljava/lang/String;

    .prologue
    .line 120
    invoke-static {}, Lcom/yunva/im/sdk/lib/YvLoginInit;->getCLib()Ljava/lang/Class;

    move-result-object v0

    .line 121
    if-eqz v0, :cond_0

    .line 122
    const-string v1, "YvLoginInit"

    const-string v2, "initCLib"

    invoke-static {v1, v2}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 123
    invoke-static {v0, p0, p1}, Lcom/yunva/im/sdk/lib/YvLoginInit;->initCLib(Ljava/lang/Class;Landroid/content/Context;Ljava/lang/String;)V

    .line 125
    :cond_0
    return-void
.end method

.method private onCreateVoiceService(Ljava/lang/Long;Ljava/lang/Long;Z)V
    .locals 4
    .param p1, "appId"    # Ljava/lang/Long;
    .param p2, "userId"    # Ljava/lang/Long;
    .param p3, "isTest"    # Z

    .prologue
    .line 264
    :try_start_0
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v0

    invoke-virtual {v0, p3}, Lcom/pg/im/sdk/lib/a/c;->a(Z)V

    .line 266
    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    const-class v2, Lcom/pg/im/sdk/lib/VioceService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 267
    const-string v1, "appId"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 269
    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 270
    const-string v0, "YvLoginInit"

    const-string v1, "startService_onCreateVoiceService"

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 275
    :goto_0
    return-void

    .line 271
    :catch_0
    move-exception v0

    .line 272
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private static postToMain(Ljava/lang/Runnable;)V
    .locals 2
    .param p0, "runnable"    # Ljava/lang/Runnable;

    .prologue
    .line 110
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    .line 111
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_0

    .line 112
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    .line 117
    :goto_0
    return-void

    .line 114
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 115
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private readMetaDataFromService(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 282
    :try_start_0
    new-instance v0, Landroid/content/ComponentName;

    const-class v1, Lcom/pg/im/sdk/lib/VioceService;

    invoke-direct {v0, p1, v1}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 283
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v1, v0, v2}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 289
    return-void

    .line 286
    :catch_0
    move-exception v0

    .line 287
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "not found services \u914d\u7f6e\u9519\u8bef\uff1aAndroidManifest.xml \u914d\u7f6e\u6587\u4ef6 \u7f3a\u5c11\u914d\u7f6e services ---> com.pg.im.sdk.lib.service.VioceService \u8bf7\u914d\u7f6e\u540e\u91cd\u8bd5\uff01\uff01"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public YvImDispatchAsync()V
    .locals 2

    .prologue
    .line 303
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 304
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 307
    :goto_0
    return-void

    .line 306
    :cond_0
    invoke-static {}, Lcom/yunva/im/sdk/lib/YvLoginInit;->YvImDoCallBack()V

    goto :goto_0
.end method

.method public YvImGetGpsCallBack(IIIII)I
    .locals 7
    .param p1, "locate_gps"    # I
    .param p2, "locate_wifi"    # I
    .param p3, "locate_cell"    # I
    .param p4, "locate_network"    # I
    .param p5, "locate_bluetooth"    # I

    .prologue
    const/16 v6, 0x40

    const/16 v5, 0x20

    const/16 v4, 0x10

    const/16 v3, 0x8

    const/4 v2, 0x4

    .line 322
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    iget-object v1, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mGetLbsInfoReturnListener:Lcom/yunva/im/sdk/lib/YvLoginInit$a;

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/c/a;->a(Landroid/content/Context;Lcom/pg/im/sdk/lib/c/b;)Lcom/pg/im/sdk/lib/c/a;

    move-result-object v0

    iput-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    .line 324
    and-int/lit8 v0, p1, 0x1

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 326
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_7

    .line 327
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 332
    :cond_0
    :goto_0
    and-int/lit8 v0, p1, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    .line 333
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_8

    .line 334
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 340
    :cond_1
    :goto_1
    and-int/lit8 v0, p1, 0x4

    if-ne v0, v2, :cond_2

    .line 341
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_9

    .line 342
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 348
    :cond_2
    :goto_2
    and-int/lit8 v0, p1, 0x8

    if-ne v0, v3, :cond_3

    .line 349
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_a

    .line 350
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v3}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 356
    :cond_3
    :goto_3
    and-int/lit8 v0, p1, 0x10

    if-ne v0, v4, :cond_4

    .line 357
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_b

    .line 358
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 364
    :cond_4
    :goto_4
    and-int/lit8 v0, p1, 0x20

    if-ne v0, v5, :cond_5

    .line 365
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_c

    .line 366
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v5}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 372
    :cond_5
    :goto_5
    and-int/lit8 v0, p1, 0x40

    if-ne v0, v6, :cond_6

    .line 373
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_d

    .line 374
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v6}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 380
    :cond_6
    :goto_6
    const/4 v0, 0x0

    return v0

    .line 329
    :cond_7
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->a()Z

    goto :goto_0

    .line 336
    :cond_8
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->e()V

    goto :goto_1

    .line 344
    :cond_9
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->f()V

    goto :goto_2

    .line 352
    :cond_a
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->b()V

    goto :goto_3

    .line 360
    :cond_b
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->g()V

    goto :goto_4

    .line 368
    :cond_c
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->c()V

    goto :goto_5

    .line 376
    :cond_d
    iget-object v0, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->lbsUtil:Lcom/pg/im/sdk/lib/c/a;

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/c/a;->d()V

    goto :goto_6
.end method

.method public native YvImUpdateGps(IILjava/lang/String;)V
.end method

.method public YvInitCallBack(JZ)V
    .locals 2
    .param p1, "appid"    # J
    .param p3, "test"    # Z

    .prologue
    .line 181
    iput-boolean p3, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->orTest:Z

    .line 182
    if-eqz p3, :cond_0

    .line 183
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 185
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 187
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 191
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 193
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 199
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 201
    const-string v0, "System.err"

    const-string v1, "\u8b66\u544a: \u5f53\u524dyunva-IMSDK \u8fd0\u884c\u73af\u5883\u4e3a\u6d4b\u8bd5\u73af\u5883\uff0c\u8bf7\u5728\u5e94\u7528\u4e0a\u7ebf\u65f6\u66f4\u6539\u4e3a\u6b63\u5f0f\u73af\u5883\uff01\uff01."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    :cond_0
    return-void
.end method

.method public YvLoginCallBack(JJ)I
    .locals 5
    .param p1, "appid"    # J
    .param p3, "yunvaid"    # J

    .prologue
    .line 156
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 157
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "the application is null. Please create the Application class, and call the method for initApplicationOnCreate(Application application, String appId) "

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 158
    :cond_0
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mAppId:Ljava/lang/String;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mAppId:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 159
    :cond_1
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "the initApplicationOnCreate appId is null, or it and the init sdk appId is not the same appId."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 162
    :cond_2
    invoke-direct {p0}, Lcom/yunva/im/sdk/lib/YvLoginInit;->initc()I

    move-result v0

    .line 163
    if-nez v0, :cond_3

    .line 164
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "com.pg.im.sdk.lib.YvLoginInit.context  is null .Please initialize  "

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 168
    :cond_3
    sget-object v1, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    invoke-direct {p0, v1}, Lcom/yunva/im/sdk/lib/YvLoginInit;->readMetaDataFromService(Landroid/content/Context;)V

    .line 169
    sget-boolean v1, Lcom/pg/im/sdk/lib/VioceService;->isStarted:Z

    if-nez v1, :cond_4

    .line 170
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    iget-boolean v3, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->orTest:Z

    invoke-direct {p0, v1, v2, v3}, Lcom/yunva/im/sdk/lib/YvLoginInit;->onCreateVoiceService(Ljava/lang/Long;Ljava/lang/Long;Z)V

    .line 173
    :cond_4
    iget-boolean v1, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->orTest:Z

    if-eqz v1, :cond_5

    .line 174
    iget-object v1, p0, Lcom/yunva/im/sdk/lib/YvLoginInit;->mHandler:Landroid/os/Handler;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 177
    :cond_5
    return v0
.end method
