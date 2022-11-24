.class public Lcom/digitalsky/talkingdata/TDSdk;
.super Ljava/lang/Object;
.source "TDSdk.java"


# static fields
.field private static _instance:Lcom/digitalsky/talkingdata/TDSdk;


# instance fields
.field private APP_ID:Ljava/lang/String;

.field private CHANNEL_ID:Ljava/lang/String;

.field private CONFIG_NAME:Ljava/lang/String;

.field private TAG:Ljava/lang/String;

.field private mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 27
    const/4 v0, 0x0

    sput-object v0, Lcom/digitalsky/talkingdata/TDSdk;->_instance:Lcom/digitalsky/talkingdata/TDSdk;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digitalsky/talkingdata/TDSdk;->mContext:Landroid/content/Context;

    .line 21
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/talkingdata/TDSdk;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/talkingdata/TDSdk;->TAG:Ljava/lang/String;

    .line 23
    const-string v0, "talkingdata.config"

    iput-object v0, p0, Lcom/digitalsky/talkingdata/TDSdk;->CONFIG_NAME:Ljava/lang/String;

    .line 24
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/talkingdata/TDSdk;->APP_ID:Ljava/lang/String;

    .line 25
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/talkingdata/TDSdk;->CHANNEL_ID:Ljava/lang/String;

    .line 18
    return-void
.end method

.method public static getInstance()Lcom/digitalsky/talkingdata/TDSdk;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/digitalsky/talkingdata/TDSdk;->_instance:Lcom/digitalsky/talkingdata/TDSdk;

    if-nez v0, :cond_0

    .line 46
    new-instance v0, Lcom/digitalsky/talkingdata/TDSdk;

    invoke-direct {v0}, Lcom/digitalsky/talkingdata/TDSdk;-><init>()V

    sput-object v0, Lcom/digitalsky/talkingdata/TDSdk;->_instance:Lcom/digitalsky/talkingdata/TDSdk;

    .line 48
    :cond_0
    sget-object v0, Lcom/digitalsky/talkingdata/TDSdk;->_instance:Lcom/digitalsky/talkingdata/TDSdk;

    return-object v0
.end method

.method private loadconfig(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 30
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 32
    .local v0, "config":Ljava/util/Properties;
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    iget-object v3, p0, Lcom/digitalsky/talkingdata/TDSdk;->CONFIG_NAME:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 33
    const-string v2, "APP_ID"

    invoke-virtual {v0, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/talkingdata/TDSdk;->APP_ID:Ljava/lang/String;

    .line 34
    const-string v2, "CHANNEL_ID"

    invoke-virtual {v0, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/talkingdata/TDSdk;->CHANNEL_ID:Ljava/lang/String;

    .line 35
    iget-object v2, p0, Lcom/digitalsky/talkingdata/TDSdk;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "APP_ID:\u3000"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/digitalsky/talkingdata/TDSdk;->APP_ID:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 42
    :goto_0
    return-void

    .line 36
    :catch_0
    move-exception v1

    .line 38
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 39
    .end local v1    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v1

    .line 40
    .local v1, "e":Ljava/lang/NumberFormatException;
    invoke-virtual {v1}, Ljava/lang/NumberFormatException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public onAppCreate(Landroid/content/Context;)V
    .locals 3
    .param p1, "arg0"    # Landroid/content/Context;

    .prologue
    .line 119
    iput-object p1, p0, Lcom/digitalsky/talkingdata/TDSdk;->mContext:Landroid/content/Context;

    .line 120
    invoke-direct {p0, p1}, Lcom/digitalsky/talkingdata/TDSdk;->loadconfig(Landroid/content/Context;)V

    .line 121
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/talkingdata/TDSdk;->APP_ID:Ljava/lang/String;

    iget-object v2, p0, Lcom/digitalsky/talkingdata/TDSdk;->CHANNEL_ID:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 122
    return-void
.end method

.method public onCreate(Landroid/app/Activity;)V
    .locals 0
    .param p1, "context"    # Landroid/app/Activity;

    .prologue
    .line 52
    iput-object p1, p0, Lcom/digitalsky/talkingdata/TDSdk;->mContext:Landroid/content/Context;

    .line 53
    return-void
.end method

.method public submit(Ljava/lang/String;)Z
    .locals 13
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    const/4 v9, 0x1

    .line 56
    iget-object v10, p0, Lcom/digitalsky/talkingdata/TDSdk;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    const-string v12, "submit: "

    invoke-direct {v11, v12}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 59
    .local v2, "data":Lorg/json/JSONObject;
    const-string v10, "type"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 60
    .local v7, "type":Ljava/lang/String;
    const-string v10, "register"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 61
    const-string v10, "userId"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 62
    .local v8, "userId":Ljava/lang/String;
    invoke-static {v8}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onRegister(Ljava/lang/String;)V

    .line 115
    .end local v2    # "data":Lorg/json/JSONObject;
    .end local v7    # "type":Ljava/lang/String;
    .end local v8    # "userId":Ljava/lang/String;
    :goto_0
    return v9

    .line 64
    .restart local v2    # "data":Lorg/json/JSONObject;
    .restart local v7    # "type":Ljava/lang/String;
    :cond_0
    const-string v10, "login"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2

    .line 65
    const-string v10, "userId"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 66
    .restart local v8    # "userId":Ljava/lang/String;
    invoke-static {v8}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onLogin(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 111
    .end local v2    # "data":Lorg/json/JSONObject;
    .end local v7    # "type":Ljava/lang/String;
    .end local v8    # "userId":Ljava/lang/String;
    :catch_0
    move-exception v3

    .line 113
    .local v3, "e":Lorg/json/JSONException;
    invoke-virtual {v3}, Lorg/json/JSONException;->printStackTrace()V

    .line 115
    .end local v3    # "e":Lorg/json/JSONException;
    :cond_1
    const/4 v9, 0x0

    goto :goto_0

    .line 68
    .restart local v2    # "data":Lorg/json/JSONObject;
    .restart local v7    # "type":Ljava/lang/String;
    :cond_2
    :try_start_1
    const-string v10, "createRole"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 69
    const-string v10, "roleData"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 70
    .local v6, "roleData":Ljava/lang/String;
    invoke-static {v6}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCreateRole(Ljava/lang/String;)V

    goto :goto_0

    .line 72
    .end local v6    # "roleData":Ljava/lang/String;
    :cond_3
    const-string v10, "pay"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 73
    const-string v10, "userId"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 74
    .restart local v8    # "userId":Ljava/lang/String;
    const-string v10, "orderId"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 75
    .local v4, "orderId":Ljava/lang/String;
    const-string v10, "amount"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    .line 76
    .local v0, "amount":I
    const-string v10, "currency"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 77
    .local v1, "currency":Ljava/lang/String;
    const-string v10, "payType"

    invoke-virtual {v2, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 78
    .local v5, "payType":Ljava/lang/String;
    invoke-static {v8, v4, v0, v1, v5}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onPay(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 80
    .end local v0    # "amount":I
    .end local v1    # "currency":Ljava/lang/String;
    .end local v4    # "orderId":Ljava/lang/String;
    .end local v5    # "payType":Ljava/lang/String;
    .end local v8    # "userId":Ljava/lang/String;
    :cond_4
    const-string v10, "custEvent1"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 81
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent1()V

    goto :goto_0

    .line 83
    :cond_5
    const-string v10, "custEvent2"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6

    .line 84
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent2()V

    goto :goto_0

    .line 86
    :cond_6
    const-string v10, "custEvent3"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_7

    .line 87
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent3()V

    goto :goto_0

    .line 89
    :cond_7
    const-string v10, "custEvent4"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_8

    .line 90
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent4()V

    goto/16 :goto_0

    .line 92
    :cond_8
    const-string v10, "custEvent5"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_9

    .line 93
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent5()V

    goto/16 :goto_0

    .line 95
    :cond_9
    const-string v10, "custEvent6"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_a

    .line 96
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent6()V

    goto/16 :goto_0

    .line 98
    :cond_a
    const-string v10, "custEvent7"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_b

    .line 99
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent7()V

    goto/16 :goto_0

    .line 101
    :cond_b
    const-string v10, "custEvent8"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_c

    .line 102
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent8()V

    goto/16 :goto_0

    .line 104
    :cond_c
    const-string v10, "custEvent9"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_d

    .line 105
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent9()V

    goto/16 :goto_0

    .line 107
    :cond_d
    const-string v10, "custEvent10"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_1

    .line 108
    invoke-static {}, Lcom/tendcloud/appcpa/TalkingDataAppCpa;->onCustEvent10()V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method
