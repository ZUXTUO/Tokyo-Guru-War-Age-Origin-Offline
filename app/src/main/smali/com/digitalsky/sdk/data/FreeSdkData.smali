.class public Lcom/digitalsky/sdk/data/FreeSdkData;
.super Ljava/lang/Object;
.source "FreeSdkData.java"


# static fields
.field public static TAG:Ljava/lang/String;

.field private static instance:Lcom/digitalsky/sdk/data/FreeSdkData;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 11
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/data/FreeSdkData;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->TAG:Ljava/lang/String;

    .line 12
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->instance:Lcom/digitalsky/sdk/data/FreeSdkData;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDeviceInfo(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    .line 50
    sget-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "getDeivceInfo: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    invoke-static {p0}, Lcom/digitalsky/sdk/sanalyze/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getInstance()Lcom/digitalsky/sdk/data/FreeSdkData;
    .locals 1

    .prologue
    .line 15
    sget-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->instance:Lcom/digitalsky/sdk/data/FreeSdkData;

    if-nez v0, :cond_0

    .line 16
    new-instance v0, Lcom/digitalsky/sdk/data/FreeSdkData;

    invoke-direct {v0}, Lcom/digitalsky/sdk/data/FreeSdkData;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->instance:Lcom/digitalsky/sdk/data/FreeSdkData;

    .line 18
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/data/FreeSdkData;->instance:Lcom/digitalsky/sdk/data/FreeSdkData;

    return-object v0
.end method

.method public static sanalyzeReport(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "event_id"    # Ljava/lang/String;
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 45
    invoke-static {}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->getInstance()Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->reportEvent(Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    const/4 v0, 0x1

    return v0
.end method

.method public static submit(Ljava/lang/String;)Z
    .locals 1
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 30
    const-string v0, ""

    invoke-static {v0, p0}, Lcom/digitalsky/sdk/data/FreeSdkData;->submit(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static submit(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "channel"    # Ljava/lang/String;
    .param p1, "jsonData"    # Ljava/lang/String;

    .prologue
    .line 26
    invoke-static {}, Lcom/digitalsky/sdk/data/FreeSdkData;->getInstance()Lcom/digitalsky/sdk/data/FreeSdkData;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/digitalsky/sdk/data/FreeSdkData;->_submit(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method public _submit(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "jsonData"    # Ljava/lang/String;

    .prologue
    .line 34
    invoke-static {}, Lcom/digitalsky/sdk/PluginMgr;->getInstance()Lcom/digitalsky/sdk/PluginMgr;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/digitalsky/sdk/PluginMgr;->getIData(Ljava/lang/String;)Lcom/digitalsky/sdk/data/IData;

    move-result-object v0

    .line 35
    .local v0, "data":Lcom/digitalsky/sdk/data/IData;
    if-eqz v0, :cond_0

    .line 36
    sget-object v1, Lcom/digitalsky/sdk/data/FreeSdkData;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 37
    invoke-interface {v0, p2}, Lcom/digitalsky/sdk/data/IData;->submit(Ljava/lang/String;)Z

    move-result v1

    .line 41
    :goto_0
    return v1

    .line 39
    :cond_0
    sget-object v1, Lcom/digitalsky/sdk/data/FreeSdkData;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IData not found:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const/4 v1, 0x0

    goto :goto_0
.end method
