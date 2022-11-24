.class public Lcom/talkingdata/sdk/ah;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/talkingdata/sdk/ah$a;
    }
.end annotation


# static fields
.field private static a:Ljava/lang/String;

.field private static b:Ljava/lang/String;

.field private static c:Ljava/lang/String;

.field private static d:Ljava/lang/String;

.field private static e:Ljava/lang/String;

.field private static f:Ljava/lang/String;

.field private static g:Ljava/lang/String;

.field private static h:Lcom/talkingdata/sdk/ah;

.field private static j:Ljava/lang/String;

.field private static p:Lorg/json/JSONObject;


# instance fields
.field private i:Ljava/lang/String;

.field private k:Lcom/talkingdata/sdk/ah$a;

.field private l:Ljava/lang/String;

.field private m:I

.field private n:Ljava/lang/String;

.field private o:Lorg/json/JSONObject;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "account"

    sput-object v0, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v0, "accountId"

    sput-object v0, Lcom/talkingdata/sdk/ah;->b:Ljava/lang/String;

    const-string v0, "name"

    sput-object v0, Lcom/talkingdata/sdk/ah;->c:Ljava/lang/String;

    const-string v0, "gender"

    sput-object v0, Lcom/talkingdata/sdk/ah;->d:Ljava/lang/String;

    const-string v0, "age"

    sput-object v0, Lcom/talkingdata/sdk/ah;->e:Ljava/lang/String;

    const-string v0, "type"

    sput-object v0, Lcom/talkingdata/sdk/ah;->f:Ljava/lang/String;

    const-string v0, "accountCus"

    sput-object v0, Lcom/talkingdata/sdk/ah;->g:Ljava/lang/String;

    const-string v0, "default"

    sput-object v0, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/talkingdata/sdk/ah$a;->c:Lcom/talkingdata/sdk/ah$a;

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->k:Lcom/talkingdata/sdk/ah$a;

    return-void
.end method

.method protected static a()Lcom/talkingdata/sdk/ah;
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    return-object v0
.end method

.method public static a(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    sget-object v1, Lcom/talkingdata/sdk/ah;->b:Ljava/lang/String;

    invoke-interface {v0, v1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v2, "register"

    invoke-static {v1, v2, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static a(Ljava/util/Map;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v0

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/au;->b(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static declared-synchronized b(Ljava/lang/String;)Lcom/talkingdata/sdk/ah;
    .locals 4

    const-class v1, Lcom/talkingdata/sdk/ah;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ah;->e()Ljava/util/Map;

    move-result-object v0

    sget-object v2, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v3, "login"

    invoke-static {v2, v3, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    :try_start_1
    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private b(Ljava/util/Map;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lcom/talkingdata/sdk/au;->a()Lcom/talkingdata/sdk/au;

    move-result-object v0

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    invoke-virtual {v0, v1}, Lcom/talkingdata/sdk/au;->a(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private c()V
    .locals 3

    :try_start_0
    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->e()Ljava/util/Map;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v2, "update"

    invoke-static {v1, v2, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    invoke-direct {p0, v0}, Lcom/talkingdata/sdk/ah;->b(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static c(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    iget-object v0, v0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Lcom/talkingdata/sdk/ah;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ah;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    :cond_1
    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    invoke-direct {v0, p0}, Lcom/talkingdata/sdk/ah;->g(Ljava/lang/String;)V

    sget-object v0, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    invoke-direct {v0}, Lcom/talkingdata/sdk/ah;->e()Ljava/util/Map;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/ah;->h:Lcom/talkingdata/sdk/ah;

    invoke-direct {v1, v0}, Lcom/talkingdata/sdk/ah;->b(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static d()V
    .locals 2

    sget-object v0, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    invoke-static {v0}, Lcom/talkingdata/sdk/bp;->d(Ljava/lang/String;)V

    sget-object v0, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    sget-object v1, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/talkingdata/sdk/bp;->b(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private e()Ljava/util/Map;
    .locals 3

    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    :try_start_0
    sget-object v1, Lcom/talkingdata/sdk/ah;->b:Ljava/lang/String;

    iget-object v2, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/talkingdata/sdk/ah;->e:Ljava/lang/String;

    iget v2, p0, Lcom/talkingdata/sdk/ah;->m:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/talkingdata/sdk/ah;->d:Ljava/lang/String;

    iget-object v2, p0, Lcom/talkingdata/sdk/ah;->k:Lcom/talkingdata/sdk/ah$a;

    invoke-virtual {v2}, Lcom/talkingdata/sdk/ah$a;->name()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/talkingdata/sdk/ah;->c:Ljava/lang/String;

    iget-object v2, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/talkingdata/sdk/ah;->f:Ljava/lang/String;

    iget-object v2, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_2

    const-string v1, "custom"

    iget-object v2, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :goto_0
    return-object v0

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static f()Ljava/util/Map;
    .locals 3

    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    :try_start_0
    const-string v1, "name"

    sget-object v2, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_0

    const-string v1, "custom"

    sget-object v2, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-object v0

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static declared-synchronized f(Ljava/lang/String;)V
    .locals 2

    const-class v1, Lcom/talkingdata/sdk/ah;

    monitor-enter v1

    :try_start_0
    invoke-static {p0}, Lcom/talkingdata/sdk/bp;->d(Ljava/lang/String;)V

    const/4 v0, 0x0

    sput-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-static {p0}, Lcom/talkingdata/sdk/ah;->h(Ljava/lang/String;)V

    invoke-static {}, Lcom/talkingdata/sdk/an;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static g()V
    .locals 3

    :try_start_0
    invoke-static {}, Lcom/talkingdata/sdk/ah;->f()Ljava/util/Map;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/ah;->a(Ljava/util/Map;)V

    sget-object v1, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v2, "roleUpdate"

    invoke-static {v1, v2, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private g(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iput-object p1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-static {v0}, Lcom/talkingdata/sdk/bp;->b(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    if-eqz v0, :cond_4

    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    sget-object v0, Lcom/talkingdata/sdk/ah;->c:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/talkingdata/sdk/ah;->c:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    :cond_0
    sget-object v0, Lcom/talkingdata/sdk/ah;->d:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/talkingdata/sdk/ah;->d:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/ah$a;->valueOf(Ljava/lang/String;)Lcom/talkingdata/sdk/ah$a;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->k:Lcom/talkingdata/sdk/ah$a;

    :cond_1
    sget-object v0, Lcom/talkingdata/sdk/ah;->e:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/talkingdata/sdk/ah;->e:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/talkingdata/sdk/ah;->m:I

    :cond_2
    sget-object v0, Lcom/talkingdata/sdk/ah;->f:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    sget-object v0, Lcom/talkingdata/sdk/ah;->f:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    :cond_3
    sget-object v0, Lcom/talkingdata/sdk/ah;->g:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    sget-object v0, Lcom/talkingdata/sdk/ah;->g:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :cond_4
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private static h(Ljava/lang/String;)V
    .locals 3

    invoke-static {p0}, Lcom/talkingdata/sdk/bp;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object p0, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    sput-object v1, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-static {}, Lcom/talkingdata/sdk/ah;->g()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-static {}, Lcom/talkingdata/sdk/ah;->d()V

    invoke-static {}, Lcom/talkingdata/sdk/ah;->f()Ljava/util/Map;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/ah;->a(Ljava/util/Map;)V

    sget-object v1, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v2, "roleCreate"

    invoke-static {v1, v2, v0}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public a(I)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setAge#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " age:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    iget v0, p0, Lcom/talkingdata/sdk/ah;->m:I

    if-eq v0, p1, :cond_0

    iput p1, p0, Lcom/talkingdata/sdk/ah;->m:I

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public a(Lcom/talkingdata/sdk/ah$a;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->k:Lcom/talkingdata/sdk/ah$a;

    if-eq v0, p1, :cond_0

    iput-object p1, p0, Lcom/talkingdata/sdk/ah;->k:Lcom/talkingdata/sdk/ah$a;

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized a(Ljava/lang/String;I)V
    .locals 2

    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setAccountKV#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " key:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " value:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setAccountKV#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " key:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " value:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->o:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public b()V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.logout#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    sget-object v0, Lcom/talkingdata/sdk/ah;->a:Ljava/lang/String;

    const-string v1, "logout"

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->e()Ljava/util/Map;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/talkingdata/sdk/an;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {}, Lcom/talkingdata/sdk/an;->b()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized b(Ljava/lang/String;I)V
    .locals 2

    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setRoleKV#currnetRoleName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/talkingdata/sdk/ah;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " key:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " value:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    sget-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :try_start_1
    sget-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    invoke-static {}, Lcom/talkingdata/sdk/ah;->d()V

    invoke-static {}, Lcom/talkingdata/sdk/ah;->g()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    monitor-enter p0

    :try_start_0
    sget-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sput-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :try_start_1
    sget-object v0, Lcom/talkingdata/sdk/ah;->p:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {}, Lcom/talkingdata/sdk/ah;->d()V

    invoke-static {}, Lcom/talkingdata/sdk/ah;->g()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setName#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " name:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    iput-object p1, p0, Lcom/talkingdata/sdk/ah;->l:Ljava/lang/String;

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public e(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Account.setAccountType#currnetAccountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/talkingdata/sdk/ah;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " accountType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/talkingdata/sdk/util/TDLog;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    iput-object p1, p0, Lcom/talkingdata/sdk/ah;->n:Ljava/lang/String;

    invoke-direct {p0}, Lcom/talkingdata/sdk/ah;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method
