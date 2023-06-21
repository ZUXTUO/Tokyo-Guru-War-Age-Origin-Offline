.class public Lcom/digitalsky/sdk/sanalyze/Sanalyze;
.super Ljava/lang/Object;
.source "Sanalyze.java"


# static fields
.field private static _instance:Lcom/digitalsky/sdk/sanalyze/Sanalyze;


# instance fields
.field private ENTER_BACKGROUND_URL:Ljava/lang/String;

.field private EVENT_URL:Ljava/lang/String;

.field private INITIALIZE_URL:Ljava/lang/String;

.field private SCRIPT_ERROR_REPORT_URL:Ljava/lang/String;

.field private ScriptErrorInfo:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private ScriptErrorReportLock:Ljava/lang/Object;

.field private isScriptErrorReportIng:Z

.field private mContext:Landroid/app/Activity;

.field private mKey:Ljava/lang/String;

.field private mSdkVersion:Ljava/lang/String;

.field private mTAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 42
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->_instance:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    const-string v0, "1.0"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mSdkVersion:Ljava/lang/String;

    .line 29
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    .line 31
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    .line 33
    const-string v0, "http://analysis.ppgame.com/data/app_customize/open"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->INITIALIZE_URL:Ljava/lang/String;

    .line 34
    const-string v0, "http://analysis.ppgame.com/data/app_customize/app_min"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ENTER_BACKGROUND_URL:Ljava/lang/String;

    .line 35
    const-string v0, "http://analysis.ppgame.com/data/app_customize/custom"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->EVENT_URL:Ljava/lang/String;

    .line 36
    const-string v0, "http://analysis.ppgame.com/data/luaerror"

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->SCRIPT_ERROR_REPORT_URL:Ljava/lang/String;

    .line 38
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorInfo:Ljava/util/Map;

    .line 39
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportLock:Ljava/lang/Object;

    .line 40
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->isScriptErrorReportIng:Z

    .line 26
    return-void
.end method

.method private ScriptErrorReportCheck()V
    .locals 12

    .prologue
    .line 229
    iget-object v9, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportLock:Ljava/lang/Object;

    monitor-enter v9

    .line 230
    :try_start_0
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v10, "Lua check report"

    invoke-static {v8, v10}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 231
    iget-boolean v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->isScriptErrorReportIng:Z

    if-nez v8, :cond_0

    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorInfo:Ljava/util/Map;

    invoke-interface {v8}, Ljava/util/Map;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 232
    :cond_0
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v10, "Lua no report"

    invoke-static {v8, v10}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 233
    monitor-exit v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 274
    :goto_0
    return-void

    .line 236
    :cond_1
    const/4 v4, 0x0

    .line 238
    .local v4, "httpentity":Ljava/lang/String;
    :try_start_1
    new-instance v7, Lorg/json/JSONObject;

    const/4 v8, 0x0

    invoke-direct {p0, v8}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->eventHead(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 239
    .local v7, "root":Lorg/json/JSONObject;
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 240
    .local v0, "data":Lorg/json/JSONArray;
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorInfo:Ljava/util/Map;

    invoke-interface {v8}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    .line 241
    .local v3, "entryset":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    .line 242
    .local v6, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-nez v8, :cond_3

    .line 249
    const-string v8, "data"

    invoke-virtual {v7, v8, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 250
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, "ScriptError:"

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 251
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorInfo:Ljava/util/Map;

    invoke-interface {v8}, Ljava/util/Map;->clear()V

    .line 252
    invoke-virtual {v7}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->getBytes()[B

    move-result-object v8

    const/4 v10, 0x0

    invoke-static {v8, v10}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v4

    .line 257
    :try_start_2
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v10, "Lua report start"

    invoke-static {v8, v10}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 258
    if-eqz v4, :cond_2

    .line 259
    const/4 v8, 0x1

    iput-boolean v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->isScriptErrorReportIng:Z

    .line 260
    :cond_2
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->SCRIPT_ERROR_REPORT_URL:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v10

    new-instance v11, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;

    invoke-direct {v11, p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$4;-><init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V

    invoke-static {v8, v10, v11}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 229
    monitor-exit v9

    goto :goto_0

    .end local v0    # "data":Lorg/json/JSONArray;
    .end local v3    # "entryset":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .end local v4    # "httpentity":Ljava/lang/String;
    .end local v6    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .end local v7    # "root":Lorg/json/JSONObject;
    :catchall_0
    move-exception v8

    monitor-exit v9
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v8

    .line 243
    .restart local v0    # "data":Lorg/json/JSONArray;
    .restart local v3    # "entryset":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .restart local v4    # "httpentity":Ljava/lang/String;
    .restart local v6    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .restart local v7    # "root":Lorg/json/JSONObject;
    :cond_3
    :try_start_3
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 244
    .local v2, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;"
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 245
    .local v5, "info":Lorg/json/JSONObject;
    const-string v8, "time"

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v5, v8, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 246
    const-string v8, "info"

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v5, v8, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 247
    invoke-virtual {v0, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 253
    .end local v0    # "data":Lorg/json/JSONArray;
    .end local v2    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;"
    .end local v3    # "entryset":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .end local v5    # "info":Lorg/json/JSONObject;
    .end local v6    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    .end local v7    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    .line 254
    .local v1, "e":Lorg/json/JSONException;
    :try_start_4
    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, "Lua report data error"

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 255
    monitor-exit v9
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_0
.end method

.method static synthetic access$0(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 83
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->reportStart(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$2(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 28
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$3(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 29
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$4(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportLock:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$5(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Z)V
    .locals 0

    .prologue
    .line 40
    iput-boolean p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->isScriptErrorReportIng:Z

    return-void
.end method

.method static synthetic access$6(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V
    .locals 0

    .prologue
    .line 228
    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportCheck()V

    return-void
.end method

.method private addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 5
    .param p1, "obj"    # Lorg/json/JSONObject;
    .param p2, "key"    # Ljava/lang/String;

    .prologue
    .line 352
    invoke-static {p2}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 353
    .local v1, "val":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 355
    :try_start_0
    invoke-virtual {p1, p2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 360
    :cond_0
    :goto_0
    return-void

    .line 356
    :catch_0
    move-exception v0

    .line 357
    .local v0, "e":Lorg/json/JSONException;
    iget-object v2, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private eventHead(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "eventId"    # Ljava/lang/String;

    .prologue
    .line 277
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 279
    .local v2, "root":Lorg/json/JSONObject;
    if-eqz p1, :cond_0

    .line 280
    :try_start_0
    const-string v3, "type"

    invoke-virtual {v2, v3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 281
    :cond_0
    const-string v3, "appid"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 282
    const-string v3, "secret"

    sget-object v4, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 283
    const-string v3, "key"

    iget-object v4, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 285
    const-string v3, "android_id"

    const-string v4, "android_id"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 286
    const-string v3, "mac"

    const-string v4, "mac"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 287
    const-string v3, "app_version_name"

    const-string v4, "app_version_name"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 288
    const-string v3, "model"

    const-string v4, "model"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-static {v4, v5}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 289
    const-string v3, "system_name"

    const-string v4, "system_name"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 290
    const-string v3, "system_version"

    const-string v4, "system_version"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 291
    const-string v3, "machine_code"

    const-string v4, "machine_code"

    invoke-static {v4}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1

    .line 298
    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 292
    :catch_0
    move-exception v1

    .line 293
    .local v1, "e1":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 294
    .end local v1    # "e1":Lorg/json/JSONException;
    :catch_1
    move-exception v0

    .line 295
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    iget-object v3, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private getCurrentTime()J
    .locals 4

    .prologue
    .line 364
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    return-wide v0
.end method

.method public static getInstance()Lcom/digitalsky/sdk/sanalyze/Sanalyze;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->_instance:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    if-nez v0, :cond_0

    .line 46
    new-instance v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-direct {v0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->_instance:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    .line 48
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->_instance:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    return-object v0
.end method

.method private getOnlineTime()J
    .locals 8

    .prologue
    const-wide/16 v6, 0x0

    .line 369
    iget-object v3, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    const-string v4, "sanalyze_info"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 370
    .local v2, "sanalyze_info":Landroid/content/SharedPreferences;
    const-string v3, "online_time"

    invoke-interface {v2, v3, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 371
    .local v0, "onlineTime":J
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "online_time"

    invoke-interface {v3, v4, v6, v7}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 373
    return-wide v0
.end method

.method private reportStart(Ljava/lang/String;)V
    .locals 11
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x0

    .line 85
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    const-string v8, "sanalyze_info"

    invoke-virtual {v7, v8, v10}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v6

    .line 86
    .local v6, "sanalyze_info":Landroid/content/SharedPreferences;
    const-string v7, "key"

    const-string v8, ""

    invoke-interface {v6, v7, v8}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 87
    .local v4, "key":Ljava/lang/String;
    iput-object v4, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    .line 89
    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getCurrentTime()J

    move-result-wide v0

    .line 90
    .local v0, "currentTime":J
    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v7

    const-string v8, "start_time"

    invoke-interface {v7, v8, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v7

    invoke-interface {v7}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 92
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 94
    .local v5, "root":Lorg/json/JSONObject;
    :try_start_0
    const-string v7, "appid"

    sget-object v8, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 95
    const-string v7, "ip"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 96
    const-string v7, "type"

    const-string v8, "app_open"

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 97
    const-string v7, "time"

    invoke-virtual {v5, v7, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 98
    const-string v7, "android_id"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 99
    const-string v7, "model"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 100
    const-string v7, "system_name"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 101
    const-string v7, "system_version"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 102
    const-string v7, "operators"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 103
    const-string v7, "secret"

    sget-object v8, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 104
    const-string v7, "key"

    iget-object v8, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 105
    const-string v7, "network"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 106
    const-string v7, "sim_country"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 107
    const-string v7, "sim_serial"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 108
    const-string v7, "wifi_mac"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 109
    const-string v7, "wifi_ssid"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 110
    const-string v7, "country"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 111
    const-string v7, "currency_code"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 112
    const-string v7, "currency_symbol"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 113
    const-string v7, "channel"

    invoke-virtual {v5, v7, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 114
    const-string v7, "lanuage"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 115
    const-string v7, "ram_rem"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 116
    const-string v7, "ram_total"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 117
    const-string v7, "rom_rem"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 118
    const-string v7, "rom_total"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 119
    const-string v7, "sd_card_rem"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 120
    const-string v7, "sd_card_total"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 121
    const-string v7, "resolution"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 122
    const-string v7, "cpu_core"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 123
    const-string v7, "cpu_ghz"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 124
    const-string v7, "cpu_model"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 125
    const-string v7, "cpu_serial"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 126
    const-string v7, "longitude"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 127
    const-string v7, "latitude"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 128
    const-string v7, "android_package_name"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 129
    const-string v7, "app_version_code"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 130
    const-string v7, "app_version_name"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 131
    const-string v7, "device_name"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 132
    const-string v7, "machine_code"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 133
    const-string v7, "phone_number"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 134
    const-string v7, "wifi_bssid"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 135
    const-string v7, "online_time"

    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getOnlineTime()J

    move-result-wide v8

    invoke-virtual {v5, v7, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 136
    const-string v7, "adid"

    invoke-direct {p0, v5, v7}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->addDeviceInfo(Lorg/json/JSONObject;Ljava/lang/String;)V

    .line 137
    const-string v7, "area"

    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->getBrand()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 139
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "info "

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    :goto_0
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    invoke-static {v7, v10}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v3

    .line 146
    .local v3, "httpentity":Ljava/lang/String;
    if-eqz v3, :cond_0

    .line 147
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->INITIALIZE_URL:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v8

    new-instance v9, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;

    invoke-direct {v9, p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;-><init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V

    invoke-static {v7, v8, v9}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 163
    :cond_0
    return-void

    .line 140
    .end local v3    # "httpentity":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 141
    .local v2, "e1":Lorg/json/JSONException;
    iget-object v7, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v8, "reportStart exception"

    invoke-static {v7, v8}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method public getDeviceStringValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 302
    invoke-static {p1}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public init(Landroid/app/Activity;)V
    .locals 4
    .param p1, "ctx"    # Landroid/app/Activity;

    .prologue
    .line 52
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    .line 54
    invoke-static {p1}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->init(Landroid/app/Activity;)V

    .line 56
    sget-object v2, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 57
    new-instance v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;

    invoke-direct {v0, p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$1;-><init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V

    .line 78
    .local v0, "task":Ljava/util/TimerTask;
    new-instance v1, Ljava/util/Timer;

    invoke-direct {v1}, Ljava/util/Timer;-><init>()V

    .line 79
    .local v1, "timer":Ljava/util/Timer;
    const-wide/16 v2, 0x7d0

    invoke-virtual {v1, v0, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 81
    .end local v0    # "task":Ljava/util/TimerTask;
    .end local v1    # "timer":Ljava/util/Timer;
    :cond_0
    return-void
.end method

.method public onEvent(Ljava/lang/String;Ljava/util/Map;)V
    .locals 8
    .param p1, "eventId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 186
    .local p2, "param":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    if-eqz v5, :cond_0

    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 187
    const/4 v1, 0x0

    .line 189
    .local v1, "httpentity":Ljava/lang/String;
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->eventHead(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 190
    .local v3, "root":Lorg/json/JSONObject;
    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_1

    .line 194
    iget-object v5, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "onEvent:"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 195
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {v5, v6}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 201
    .end local v3    # "root":Lorg/json/JSONObject;
    :goto_1
    if-eqz v1, :cond_0

    .line 202
    iget-object v5, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->EVENT_URL:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v6

    new-instance v7, Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;

    invoke-direct {v7, p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze$3;-><init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V

    invoke-static {v5, v6, v7}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 215
    .end local v1    # "httpentity":Ljava/lang/String;
    :cond_0
    return-void

    .line 190
    .restart local v1    # "httpentity":Ljava/lang/String;
    .restart local v3    # "root":Lorg/json/JSONObject;
    :cond_1
    :try_start_1
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 191
    .local v2, "key":Ljava/lang/String;
    invoke-interface {p2, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 192
    .local v4, "value":Ljava/lang/String;
    invoke-virtual {v3, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 196
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "root":Lorg/json/JSONObject;
    .end local v4    # "value":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 198
    .local v0, "e":Lorg/json/JSONException;
    iget-object v5, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public onScriptErrorReport(ILjava/lang/String;)V
    .locals 3
    .param p1, "time"    # I
    .param p2, "val"    # Ljava/lang/String;

    .prologue
    .line 218
    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 219
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportLock:Ljava/lang/Object;

    monitor-enter v1

    .line 220
    :try_start_0
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorInfo:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 221
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v2, "Lua add info"

    invoke-static {v0, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 224
    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ScriptErrorReportCheck()V

    .line 226
    :cond_0
    return-void

    .line 219
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public pause()V
    .locals 18

    .prologue
    .line 316
    sget-object v14, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    if-eqz v14, :cond_0

    sget-object v14, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v14

    if-lez v14, :cond_0

    .line 318
    invoke-direct/range {p0 .. p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getCurrentTime()J

    move-result-wide v2

    .line 319
    .local v2, "currentTime":J
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    const-string v15, "sanalyze_info"

    const/16 v16, 0x0

    invoke-virtual/range {v14 .. v16}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v11

    .line 320
    .local v11, "sanalyze_info":Landroid/content/SharedPreferences;
    const-string v14, "start_time"

    invoke-interface {v11, v14, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v12

    .line 321
    .local v12, "startTime":J
    sub-long v6, v2, v12

    .line 323
    .local v6, "intervalTime":J
    const-string v14, "online_time"

    const-wide/16 v16, 0x0

    move-wide/from16 v0, v16

    invoke-interface {v11, v14, v0, v1}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v8

    .line 324
    .local v8, "onLineTime":J
    add-long/2addr v8, v6

    .line 325
    invoke-interface {v11}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v14

    const-string v15, "online_time"

    invoke-interface {v14, v15, v8, v9}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v14

    invoke-interface {v14}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 327
    new-instance v10, Lorg/json/JSONObject;

    invoke-direct {v10}, Lorg/json/JSONObject;-><init>()V

    .line 329
    .local v10, "root":Lorg/json/JSONObject;
    :try_start_0
    const-string v14, "type"

    const-string v15, "app_min"

    invoke-virtual {v10, v14, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 330
    const-string v14, "appid"

    sget-object v15, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v10, v14, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 331
    const-string v14, "secret"

    sget-object v15, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    invoke-virtual {v10, v14, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 332
    const-string v14, "online_time"

    invoke-virtual {v10, v14, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 333
    const-string v14, "interval_time"

    invoke-virtual {v10, v14, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 334
    const-string v14, "key"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mKey:Ljava/lang/String;

    invoke-virtual {v10, v14, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 339
    :goto_0
    invoke-virtual {v10}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/String;->getBytes()[B

    move-result-object v14

    const/4 v15, 0x0

    invoke-static {v14, v15}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v5

    .line 341
    .local v5, "httpentity":Ljava/lang/String;
    if-eqz v5, :cond_0

    .line 342
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->ENTER_BACKGROUND_URL:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v15

    const/16 v16, 0x0

    invoke-static/range {v14 .. v16}, Lcom/digitalsky/sdk/common/Utils;->asyncRequest(Ljava/lang/String;[BLcom/digitalsky/sdk/common/Utils$Callback;)V

    .line 345
    .end local v2    # "currentTime":J
    .end local v5    # "httpentity":Ljava/lang/String;
    .end local v6    # "intervalTime":J
    .end local v8    # "onLineTime":J
    .end local v10    # "root":Lorg/json/JSONObject;
    .end local v11    # "sanalyze_info":Landroid/content/SharedPreferences;
    .end local v12    # "startTime":J
    :cond_0
    return-void

    .line 335
    .restart local v2    # "currentTime":J
    .restart local v6    # "intervalTime":J
    .restart local v8    # "onLineTime":J
    .restart local v10    # "root":Lorg/json/JSONObject;
    .restart local v11    # "sanalyze_info":Landroid/content/SharedPreferences;
    .restart local v12    # "startTime":J
    :catch_0
    move-exception v4

    .line 336
    .local v4, "e1":Lorg/json/JSONException;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public reportEvent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "event_id"    # Ljava/lang/String;
    .param p2, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 167
    iget-object v6, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mTAG:Ljava/lang/String;

    const-string v7, "reportEvent"

    invoke-static {v6, v7}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 168
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 170
    .local v4, "paramsMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 171
    .local v2, "js":Lorg/json/JSONObject;
    invoke-virtual {v2}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    .line 172
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    if-nez v6, :cond_0

    .line 180
    invoke-virtual {p0, p1, v4}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->onEvent(Ljava/lang/String;Ljava/util/Map;)V

    .line 181
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v2    # "js":Lorg/json/JSONObject;
    :goto_1
    return-void

    .line 173
    .restart local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .restart local v2    # "js":Lorg/json/JSONObject;
    :cond_0
    :try_start_1
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    .line 174
    .local v3, "key":Ljava/lang/String;
    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 175
    .local v5, "value":Ljava/lang/String;
    invoke-interface {v4, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 177
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v2    # "js":Lorg/json/JSONObject;
    .end local v3    # "key":Ljava/lang/String;
    .end local v5    # "value":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 178
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_1
.end method

.method public resume()V
    .locals 6

    .prologue
    .line 306
    sget-object v3, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    if-eqz v3, :cond_0

    sget-object v3, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 308
    invoke-direct {p0}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getCurrentTime()J

    move-result-wide v0

    .line 309
    .local v0, "currentTime":J
    iget-object v3, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mContext:Landroid/app/Activity;

    const-string v4, "sanalyze_info"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 310
    .local v2, "sanalyze_info":Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "start_time"

    invoke-interface {v3, v4, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 313
    .end local v0    # "currentTime":J
    .end local v2    # "sanalyze_info":Landroid/content/SharedPreferences;
    :cond_0
    return-void
.end method

.method public sdkVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 348
    iget-object v0, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->mSdkVersion:Ljava/lang/String;

    return-object v0
.end method
