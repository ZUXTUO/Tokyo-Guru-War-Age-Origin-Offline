.class public Lcom/pg/im/sdk/lib/VioceService;
.super Landroid/app/Service;
.source "SourceFile"


# static fields
.field private static final WHAT_ALARM:I = 0x3e8

.field public static isStarted:Z

.field private static final syncKey:[B


# instance fields
.field private final TAG:Ljava/lang/String;

.field private mApkPackage:Ljava/lang/String;

.field private mBundleResource:Landroid/content/res/Resources;

.field mHandler:Landroid/os/Handler;

.field private service:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 28
    new-array v0, v1, [B

    sput-object v0, Lcom/pg/im/sdk/lib/VioceService;->syncKey:[B

    .line 34
    sput-boolean v1, Lcom/pg/im/sdk/lib/VioceService;->isStarted:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 24
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 26
    const-string v0, "LibVioceService"

    iput-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->TAG:Ljava/lang/String;

    .line 57
    new-instance v0, Lcom/pg/im/sdk/lib/VioceService$1;

    invoke-direct {v0, p0}, Lcom/pg/im/sdk/lib/VioceService$1;-><init>(Lcom/pg/im/sdk/lib/VioceService;)V

    iput-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->mHandler:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 181
    invoke-super {p0, p1}, Landroid/app/Service;->attachBaseContext(Landroid/content/Context;)V

    .line 182
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getService()Ljava/lang/Object;

    .line 183
    iget-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->mBundleResource:Landroid/content/res/Resources;

    if-eqz v0, :cond_0

    .line 184
    invoke-virtual {p0, p1}, Lcom/pg/im/sdk/lib/VioceService;->replaceContextResources(Landroid/content/Context;)V

    .line 186
    :cond_0
    return-void
.end method

.method public getService()Ljava/lang/Object;
    .locals 5

    .prologue
    .line 138
    sget-object v1, Lcom/pg/im/sdk/lib/VioceService;->syncKey:[B

    monitor-enter v1

    .line 139
    :try_start_0
    iget-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->service:Ljava/lang/Object;

    if-nez v0, :cond_1

    .line 140
    const-string v0, "LibVioceService"

    const-string v2, "service is null"

    invoke-static {v0, v2}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 142
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/a/c;->a()Lcom/pg/im/sdk/lib/a/b;

    move-result-object v0

    if-nez v0, :cond_0

    .line 143
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/pg/im/sdk/lib/a/c;->a(Z)V

    .line 145
    :cond_0
    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v0

    invoke-virtual {v0}, Lcom/pg/im/sdk/lib/a/c;->a()Lcom/pg/im/sdk/lib/a/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 146
    if-eqz v0, :cond_1

    .line 155
    :try_start_1
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v2, "blmvoice_for_assets.jar"

    invoke-static {}, Lcom/pg/im/sdk/lib/a/c;->b()Lcom/pg/im/sdk/lib/a/c;

    move-result-object v3

    invoke-virtual {v3}, Lcom/pg/im/sdk/lib/a/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/pg/im/sdk/lib/b/a/a;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ldalvik/system/DexClassLoader;

    move-result-object v0

    .line 157
    if-eqz v0, :cond_2

    .line 159
    const-string v2, "com.pg.atp.service.VioceService"

    invoke-virtual {v0, v2}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 160
    invoke-virtual {v0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->service:Ljava/lang/Object;

    .line 161
    const-string v0, "LibVioceService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getService ok:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/pg/im/sdk/lib/VioceService;->service:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/pg/im/sdk/lib/d/b;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 162
    invoke-static {p0}, Lcom/pg/im/sdk/lib/b/a/a;->a(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->mBundleResource:Landroid/content/res/Resources;

    .line 163
    invoke-static {p0}, Lcom/pg/im/sdk/lib/b/a/a;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->mApkPackage:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 175
    :cond_1
    :goto_0
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 176
    iget-object v0, p0, Lcom/pg/im/sdk/lib/VioceService;->service:Ljava/lang/Object;

    return-object v0

    .line 166
    :cond_2
    :try_start_3
    const-string v0, "LibVioceService"

    const-string v2, "getService==null"

    invoke-static {v0, v2}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 169
    :catch_0
    move-exception v0

    .line 170
    :try_start_4
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 171
    const-string v2, "LibVioceService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " getService   failure.exception:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 175
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 7
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v1, 0x0

    .line 39
    const-string v0, "LibVioceService"

    const-string v2, "onBind..."

    invoke-static {v0, v2}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    :try_start_0
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getService()Ljava/lang/Object;

    move-result-object v0

    .line 43
    if-nez v0, :cond_0

    move-object v0, v1

    .line 54
    :goto_0
    return-object v0

    .line 48
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "onBind"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/app/Service;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-class v6, Landroid/content/Intent;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 49
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p0, v3, v4

    const/4 v4, 0x1

    aput-object p1, v3, v4

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 51
    :catch_0
    move-exception v0

    .line 52
    const-string v2, "LibVioceService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dynamic load onBind failure.exception:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    move-object v0, v1

    .line 54
    goto :goto_0
.end method

.method public onCreate()V
    .locals 2

    .prologue
    .line 113
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 114
    const-string v0, "LibVioceService"

    const-string v1, "onCreate..."

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 115
    const/4 v0, 0x0

    sput-boolean v0, Lcom/pg/im/sdk/lib/VioceService;->isStarted:Z

    .line 116
    return-void
.end method

.method public onDestroy()V
    .locals 6

    .prologue
    .line 120
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 121
    const-string v0, "LibVioceService"

    const-string v1, "onDestroy..."

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 123
    :try_start_0
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getService()Ljava/lang/Object;

    move-result-object v0

    .line 124
    if-nez v0, :cond_0

    .line 134
    :goto_0
    return-void

    .line 128
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "onDestroy"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Service;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 129
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 130
    :catch_0
    move-exception v0

    .line 131
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 132
    const-string v1, "LibVioceService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dynamic load onDestroy failure.exception:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 6
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    const/4 v2, 0x1

    .line 83
    const-string v0, "LibVioceService"

    const-string v1, "onStartCommand..."

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    sput-boolean v2, Lcom/pg/im/sdk/lib/VioceService;->isStarted:Z

    .line 85
    if-nez p1, :cond_0

    .line 86
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    .line 108
    :goto_0
    return v0

    .line 88
    :cond_0
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 89
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    .line 92
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/pg/im/sdk/lib/VioceService;->getService()Ljava/lang/Object;

    move-result-object v0

    .line 93
    if-nez v0, :cond_2

    .line 95
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    goto :goto_0

    .line 97
    :cond_2
    const-string v1, "LibVioceService"

    const-string v2, "call onStartCommand"

    invoke-static {v1, v2}, Lcom/pg/im/sdk/lib/d/b;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 98
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "onStartCommand"

    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Service;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Landroid/content/Intent;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const/4 v4, 0x3

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 99
    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x1

    aput-object p1, v2, v3

    const/4 v3, 0x2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x3

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 104
    :goto_1
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 105
    const/16 v1, 0x3e8

    iput v1, v0, Landroid/os/Message;->what:I

    .line 106
    iput-object p1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 107
    iget-object v1, p0, Lcom/pg/im/sdk/lib/VioceService;->mHandler:Landroid/os/Handler;

    const-wide/16 v2, 0x41

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 108
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    goto :goto_0

    .line 100
    :catch_0
    move-exception v0

    .line 101
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 102
    const-string v1, "LibVioceService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dynamic load onStartCommand failure.exception:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public replaceContextResources(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 195
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "mResources"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 196
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 197
    iget-object v1, p0, Lcom/pg/im/sdk/lib/VioceService;->mBundleResource:Landroid/content/res/Resources;

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 203
    :goto_0
    return-void

    .line 199
    :catch_0
    move-exception v0

    .line 201
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
