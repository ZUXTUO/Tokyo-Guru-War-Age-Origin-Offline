.class public Lcom/digitalsky/sdk/PluginMgr;
.super Ljava/lang/Object;
.source "PluginMgr.java"


# static fields
.field private static TAG:Ljava/lang/String; = null

.field public static final TAG_IUSER:Ljava/lang/String; = "IUser"

.field public static final TAG_PLUGINS:Ljava/lang/String; = "Plugins"

.field public static final TAG_PLUGINS_CLASS:Ljava/lang/String; = "Plugin_Class"

.field private static instance:Lcom/digitalsky/sdk/PluginMgr;


# instance fields
.field private final PLUGIN_NAME:Ljava/lang/String;

.field private mActs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/digitalsky/sdk/IActivity;",
            ">;"
        }
    .end annotation
.end field

.field private mApps:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/digitalsky/sdk/IApplication;",
            ">;"
        }
    .end annotation
.end field

.field private mDatas:Ljava/util/TreeMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/TreeMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/digitalsky/sdk/data/IData;",
            ">;"
        }
    .end annotation
.end field

.field private mPays:Ljava/util/TreeMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/TreeMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/digitalsky/sdk/pay/IPay;",
            ">;"
        }
    .end annotation
.end field

.field private mUsers:Ljava/util/TreeMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/TreeMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/digitalsky/sdk/user/IUser;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 28
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/sdk/PluginMgr;->instance:Lcom/digitalsky/sdk/PluginMgr;

    .line 34
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/PluginMgr;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    .line 205
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    const-string v0, "plugin.config"

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->PLUGIN_NAME:Ljava/lang/String;

    .line 29
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    .line 30
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    .line 31
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    .line 32
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mActs:Ljava/util/List;

    .line 33
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mApps:Ljava/util/List;

    .line 25
    return-void
.end method

.method public static getInstance()Lcom/digitalsky/sdk/PluginMgr;
    .locals 1

    .prologue
    .line 37
    sget-object v0, Lcom/digitalsky/sdk/PluginMgr;->instance:Lcom/digitalsky/sdk/PluginMgr;

    if-nez v0, :cond_0

    .line 38
    new-instance v0, Lcom/digitalsky/sdk/PluginMgr;

    invoke-direct {v0}, Lcom/digitalsky/sdk/PluginMgr;-><init>()V

    sput-object v0, Lcom/digitalsky/sdk/PluginMgr;->instance:Lcom/digitalsky/sdk/PluginMgr;

    .line 40
    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/PluginMgr;->instance:Lcom/digitalsky/sdk/PluginMgr;

    return-object v0
.end method

.method private loadDefault()V
    .locals 4

    .prologue
    .line 60
    new-instance v0, Lcom/digitalsky/sdk/user/DefaultUser;

    invoke-direct {v0}, Lcom/digitalsky/sdk/user/DefaultUser;-><init>()V

    .line 61
    .local v0, "defaultUser":Lcom/digitalsky/sdk/user/DefaultUser;
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    const-string v2, "default"

    invoke-virtual {v1, v2, v0}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 62
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mActs:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 63
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    const-string v2, "default"

    new-instance v3, Lcom/digitalsky/sdk/pay/DefaultPay;

    invoke-direct {v3}, Lcom/digitalsky/sdk/pay/DefaultPay;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    const-string v2, "default"

    new-instance v3, Lcom/digitalsky/sdk/data/DefaultData;

    invoke-direct {v3}, Lcom/digitalsky/sdk/data/DefaultData;-><init>()V

    invoke-virtual {v1, v2, v3}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    return-void
.end method

.method private loadIActivity(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p3, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 128
    .local p2, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-class v3, Lcom/digitalsky/sdk/IActivity;

    invoke-virtual {v3, p2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 129
    move-object v0, p3

    check-cast v0, Lcom/digitalsky/sdk/IActivity;

    move-object v2, v0

    .line 130
    .local v2, "iAct":Lcom/digitalsky/sdk/IActivity;
    iget-object v3, p0, Lcom/digitalsky/sdk/PluginMgr;->mActs:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 137
    .end local v2    # "iAct":Lcom/digitalsky/sdk/IActivity;
    :cond_0
    :goto_0
    return-void

    .line 132
    :catch_0
    move-exception v1

    .line 135
    .local v1, "e":Ljava/lang/RuntimeException;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 132
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private loadIApplication(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p3, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 141
    .local p2, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-class v3, Lcom/digitalsky/sdk/IApplication;

    invoke-virtual {v3, p2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 142
    move-object v0, p3

    check-cast v0, Lcom/digitalsky/sdk/IApplication;

    move-object v2, v0

    .line 143
    .local v2, "iApp":Lcom/digitalsky/sdk/IApplication;
    iget-object v3, p0, Lcom/digitalsky/sdk/PluginMgr;->mApps:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 150
    .end local v2    # "iApp":Lcom/digitalsky/sdk/IApplication;
    :cond_0
    :goto_0
    return-void

    .line 145
    :catch_0
    move-exception v1

    .line 148
    .local v1, "e":Ljava/lang/RuntimeException;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 145
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private loadIData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 6
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p4, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 115
    .local p3, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-class v3, Lcom/digitalsky/sdk/data/IData;

    invoke-virtual {v3, p3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 116
    move-object v0, p4

    check-cast v0, Lcom/digitalsky/sdk/data/IData;

    move-object v2, v0

    .line 117
    .local v2, "iData":Lcom/digitalsky/sdk/data/IData;
    iget-object v3, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    invoke-virtual {v3, p1, v2}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 124
    .end local v2    # "iData":Lcom/digitalsky/sdk/data/IData;
    :cond_0
    :goto_0
    return-void

    .line 119
    :catch_0
    move-exception v1

    .line 122
    .local v1, "e":Ljava/lang/RuntimeException;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 119
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private loadIPay(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 6
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p4, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 89
    .local p3, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-class v3, Lcom/digitalsky/sdk/pay/IPay;

    invoke-virtual {v3, p3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 90
    move-object v0, p4

    check-cast v0, Lcom/digitalsky/sdk/pay/IPay;

    move-object v2, v0

    .line 91
    .local v2, "iPay":Lcom/digitalsky/sdk/pay/IPay;
    iget-object v3, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    invoke-virtual {v3, p1, v2}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 98
    .end local v2    # "iPay":Lcom/digitalsky/sdk/pay/IPay;
    :cond_0
    :goto_0
    return-void

    .line 93
    :catch_0
    move-exception v1

    .line 95
    .local v1, "e":Ljava/lang/RuntimeException;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 93
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private loadIUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 6
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p4, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 102
    .local p3, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    const-class v3, Lcom/digitalsky/sdk/user/IUser;

    invoke-virtual {v3, p3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 103
    move-object v0, p4

    check-cast v0, Lcom/digitalsky/sdk/user/IUser;

    move-object v2, v0

    .line 104
    .local v2, "iUser":Lcom/digitalsky/sdk/user/IUser;
    iget-object v3, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    invoke-virtual {v3, p1, v2}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 111
    .end local v2    # "iUser":Lcom/digitalsky/sdk/user/IUser;
    :cond_0
    :goto_0
    return-void

    .line 106
    :catch_0
    move-exception v1

    .line 109
    .local v1, "e":Ljava/lang/RuntimeException;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 106
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private loadPlugin(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "channel"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;

    .prologue
    .line 71
    :try_start_0
    invoke-static {p2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 72
    .local v0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v3

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 73
    .local v2, "obj":Ljava/lang/Object;
    invoke-direct {p0, p1, p2, v0, v2}, Lcom/digitalsky/sdk/PluginMgr;->loadIUser(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 74
    invoke-direct {p0, p1, p2, v0, v2}, Lcom/digitalsky/sdk/PluginMgr;->loadIPay(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 75
    invoke-direct {p0, p1, p2, v0, v2}, Lcom/digitalsky/sdk/PluginMgr;->loadIData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 77
    invoke-direct {p0, p2, v0, v2}, Lcom/digitalsky/sdk/PluginMgr;->loadIActivity(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 78
    invoke-direct {p0, p2, v0, v2}, Lcom/digitalsky/sdk/PluginMgr;->loadIApplication(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_6

    .line 85
    .end local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v2    # "obj":Ljava/lang/Object;
    :goto_0
    return-void

    .line 80
    :catch_0
    move-exception v1

    .line 82
    .local v1, "e":Ljava/lang/Exception;
    :goto_1
    sget-object v3, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 80
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    goto :goto_1

    :catch_2
    move-exception v1

    goto :goto_1

    :catch_3
    move-exception v1

    goto :goto_1

    :catch_4
    move-exception v1

    goto :goto_1

    :catch_5
    move-exception v1

    goto :goto_1

    :catch_6
    move-exception v1

    goto :goto_1
.end method

.method private readPlugin(Lorg/xmlpull/v1/XmlPullParser;)V
    .locals 6
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x0

    .line 238
    const/4 v2, 0x2

    const-string v3, "Plugin_Class"

    invoke-interface {p1, v2, v5, v3}, Lorg/xmlpull/v1/XmlPullParser;->require(ILjava/lang/String;Ljava/lang/String;)V

    .line 242
    const-string v2, "name"

    invoke-interface {p1, v5, v2}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 243
    .local v1, "clazz":Ljava/lang/String;
    const-string v2, "channel"

    invoke-interface {p1, v5, v2}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 244
    .local v0, "channel":Ljava/lang/String;
    sget-object v2, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, " -- "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    invoke-direct {p0, v0, v1}, Lcom/digitalsky/sdk/PluginMgr;->loadPlugin(Ljava/lang/String;Ljava/lang/String;)V

    .line 246
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->nextTag()I

    .line 247
    const/4 v2, 0x3

    const-string v3, "Plugin_Class"

    invoke-interface {p1, v2, v5, v3}, Lorg/xmlpull/v1/XmlPullParser;->require(ILjava/lang/String;Ljava/lang/String;)V

    .line 248
    return-void
.end method

.method private readPlugins(Lorg/xmlpull/v1/XmlPullParser;)V
    .locals 4
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x2

    .line 222
    const/4 v1, 0x0

    const-string v2, "Plugins"

    invoke-interface {p1, v3, v1, v2}, Lorg/xmlpull/v1/XmlPullParser;->require(ILjava/lang/String;Ljava/lang/String;)V

    .line 223
    :cond_0
    :goto_0
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1

    .line 235
    return-void

    .line 224
    :cond_1
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v1

    if-ne v1, v3, :cond_0

    .line 227
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v0

    .line 229
    .local v0, "name":Ljava/lang/String;
    const-string v1, "Plugin_Class"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 230
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/PluginMgr;->readPlugin(Lorg/xmlpull/v1/XmlPullParser;)V

    goto :goto_0

    .line 232
    :cond_2
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/PluginMgr;->skip(Lorg/xmlpull/v1/XmlPullParser;)V

    goto :goto_0
.end method

.method private skip(Lorg/xmlpull/v1/XmlPullParser;)V
    .locals 3
    .param p1, "parser"    # Lorg/xmlpull/v1/XmlPullParser;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xmlpull/v1/XmlPullParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 251
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    .line 252
    new-instance v1, Ljava/lang/IllegalStateException;

    invoke-direct {v1}, Ljava/lang/IllegalStateException;-><init>()V

    throw v1

    .line 254
    :cond_0
    const/4 v0, 0x1

    .line 255
    .local v0, "depth":I
    :goto_0
    if-nez v0, :cond_1

    .line 265
    return-void

    .line 256
    :cond_1
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    .line 261
    :pswitch_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 258
    :pswitch_1
    add-int/lit8 v0, v0, -0x1

    .line 259
    goto :goto_0

    .line 256
    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method


# virtual methods
.method public getIActivity()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/digitalsky/sdk/IActivity;",
            ">;"
        }
    .end annotation

    .prologue
    .line 196
    iget-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mActs:Ljava/util/List;

    return-object v0
.end method

.method public getIApplication()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/digitalsky/sdk/IApplication;",
            ">;"
        }
    .end annotation

    .prologue
    .line 200
    iget-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mApps:Ljava/util/List;

    return-object v0
.end method

.method public getIData(Ljava/lang/String;)Lcom/digitalsky/sdk/data/IData;
    .locals 3
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 176
    const/4 v0, 0x0

    .line 177
    .local v0, "data":Lcom/digitalsky/sdk/data/IData;
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->size()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    .line 178
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->firstEntry()Ljava/util/Map$Entry;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "data":Lcom/digitalsky/sdk/data/IData;
    check-cast v0, Lcom/digitalsky/sdk/data/IData;

    .line 179
    .restart local v0    # "data":Lcom/digitalsky/sdk/data/IData;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 180
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mDatas:Ljava/util/TreeMap;

    invoke-virtual {v1, p1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "data":Lcom/digitalsky/sdk/data/IData;
    check-cast v0, Lcom/digitalsky/sdk/data/IData;

    .line 183
    .restart local v0    # "data":Lcom/digitalsky/sdk/data/IData;
    :cond_0
    return-object v0
.end method

.method public getIPay(Ljava/lang/String;)Lcom/digitalsky/sdk/pay/IPay;
    .locals 3
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 165
    const/4 v0, 0x0

    .line 166
    .local v0, "pay":Lcom/digitalsky/sdk/pay/IPay;
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->size()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    .line 167
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->firstEntry()Ljava/util/Map$Entry;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "pay":Lcom/digitalsky/sdk/pay/IPay;
    check-cast v0, Lcom/digitalsky/sdk/pay/IPay;

    .line 168
    .restart local v0    # "pay":Lcom/digitalsky/sdk/pay/IPay;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 169
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    invoke-virtual {v1, p1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "pay":Lcom/digitalsky/sdk/pay/IPay;
    check-cast v0, Lcom/digitalsky/sdk/pay/IPay;

    .line 172
    .restart local v0    # "pay":Lcom/digitalsky/sdk/pay/IPay;
    :cond_0
    return-object v0
.end method

.method public getIPays()Ljava/util/TreeMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/TreeMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/digitalsky/sdk/pay/IPay;",
            ">;"
        }
    .end annotation

    .prologue
    .line 192
    iget-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mPays:Ljava/util/TreeMap;

    return-object v0
.end method

.method public getIUser(Ljava/lang/String;)Lcom/digitalsky/sdk/user/IUser;
    .locals 3
    .param p1, "channel"    # Ljava/lang/String;

    .prologue
    .line 154
    const/4 v0, 0x0

    .line 155
    .local v0, "user":Lcom/digitalsky/sdk/user/IUser;
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->size()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    .line 156
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    invoke-virtual {v1}, Ljava/util/TreeMap;->firstEntry()Ljava/util/Map$Entry;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "user":Lcom/digitalsky/sdk/user/IUser;
    check-cast v0, Lcom/digitalsky/sdk/user/IUser;

    .line 157
    .restart local v0    # "user":Lcom/digitalsky/sdk/user/IUser;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 158
    iget-object v1, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    invoke-virtual {v1, p1}, Ljava/util/TreeMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "user":Lcom/digitalsky/sdk/user/IUser;
    check-cast v0, Lcom/digitalsky/sdk/user/IUser;

    .line 161
    .restart local v0    # "user":Lcom/digitalsky/sdk/user/IUser;
    :cond_0
    return-object v0
.end method

.method public getIUsers()Ljava/util/TreeMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/TreeMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/digitalsky/sdk/user/IUser;",
            ">;"
        }
    .end annotation

    .prologue
    .line 187
    iget-object v0, p0, Lcom/digitalsky/sdk/PluginMgr;->mUsers:Ljava/util/TreeMap;

    return-object v0
.end method

.method public init(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 44
    sget-object v1, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    const-string v2, "init ."

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    const-string v2, "plugin.config"

    invoke-virtual {v1, v2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/digitalsky/sdk/PluginMgr;->pluginInit(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    :goto_0
    sget-object v1, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    const-string v2, "init .."

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 57
    return-void

    .line 48
    :catch_0
    move-exception v0

    .line 52
    .local v0, "e1":Ljava/io/IOException;
    sget-object v1, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    const-string v2, "init not find plugin.config"

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 53
    invoke-direct {p0}, Lcom/digitalsky/sdk/PluginMgr;->loadDefault()V

    goto :goto_0
.end method

.method public pluginInit(Ljava/io/InputStream;)V
    .locals 5
    .param p1, "in"    # Ljava/io/InputStream;

    .prologue
    .line 209
    :try_start_0
    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v1

    .line 210
    .local v1, "parse":Lorg/xmlpull/v1/XmlPullParser;
    const-string v2, "http://xmlpull.org/v1/doc/features.html#process-namespaces"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Lorg/xmlpull/v1/XmlPullParser;->setFeature(Ljava/lang/String;Z)V

    .line 211
    const/4 v2, 0x0

    invoke-interface {v1, p1, v2}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 212
    invoke-interface {v1}, Lorg/xmlpull/v1/XmlPullParser;->nextTag()I

    .line 213
    invoke-direct {p0, v1}, Lcom/digitalsky/sdk/PluginMgr;->readPlugins(Lorg/xmlpull/v1/XmlPullParser;)V
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 219
    .end local v1    # "parse":Lorg/xmlpull/v1/XmlPullParser;
    :goto_0
    return-void

    .line 214
    :catch_0
    move-exception v0

    .line 217
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    sget-object v2, Lcom/digitalsky/sdk/PluginMgr;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 214
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    goto :goto_1
.end method
