.class public Lcom/digitalsky/sdk/common/Constant;
.super Ljava/lang/Object;
.source "Constant.java"


# static fields
.field public static APP_ID:Ljava/lang/String; = null

.field public static APP_KEY:[B = null

.field public static CHANNEL:Ljava/lang/String; = null

.field private static CONFIG_NAME:Ljava/lang/String; = null

.field public static DEBUG_LOG:Z = false

.field public static IS_OVERSEA:Z = false

.field private static KEFU_URL:Ljava/lang/String; = null

.field private static KEFU_URL_OVERSEA:Ljava/lang/String; = null

.field public static final LOGIN_CANCEL:I = -0x2

.field public static final LOGIN_EXIT:I = -0x4

.field public static final LOGIN_FAIL:I = -0x1

.field public static final LOGIN_NOT_INIT:I = -0x3

.field public static final LOGIN_SUCCESS:I = 0x0

.field public static final LOGOUT_FAIL:I = -0xb

.field public static final LOGOUT_SUCCESS:I = -0xa

.field public static final PAY_CANCEL:I = -0x2

.field public static final PAY_EXIT:I = -0x6

.field public static final PAY_FAIL:I = -0x1

.field public static final PAY_NEED_LOGIN:I = -0x5

.field public static final PAY_PARA_ERR:I = -0x7

.field public static final PAY_PAYING:I = -0x3

.field public static final PAY_SUCCESS:I = 0x0

.field private static RELEASE_VERIFY_URL:Ljava/lang/String; = null

.field private static RELEASE_VERIFY_URL_OVERSEA:Ljava/lang/String; = null

.field public static SDK_INIT:Z = false

.field public static final SDK_INIT_FALI:I = -0x15

.field public static final SDK_INIT_SUCCESS:I = -0x14

.field public static SECRET:Ljava/lang/String;

.field public static TAG:Ljava/lang/String;

.field public static TEST_MODE:Z

.field private static TEST_VERIFY_URL:Ljava/lang/String;

.field public static VERSION:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 13
    const-string v0, "FreeSDK_"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    .line 15
    const-string v0, "freesdk.config"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->CONFIG_NAME:Ljava/lang/String;

    .line 41
    sput-boolean v1, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z

    .line 42
    sput-boolean v1, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z

    .line 43
    sput-boolean v1, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z

    .line 46
    const-string v0, "http://new.ucsystem.ppgame.com/kefu"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->KEFU_URL:Ljava/lang/String;

    .line 47
    const-string v0, "http://new-oversea.ucsystem.ppgame.com/kefu"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->KEFU_URL_OVERSEA:Ljava/lang/String;

    .line 50
    const-string v0, "http://l.ucenter.ppgame.com/third_login_2"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->RELEASE_VERIFY_URL:Ljava/lang/String;

    .line 51
    const-string v0, "http://tw.l.ucenter.ppgame.com/third_login_2"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->RELEASE_VERIFY_URL_OVERSEA:Ljava/lang/String;

    .line 52
    const-string v0, "http://112.126.88.85:8184/third_login_2"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->TEST_VERIFY_URL:Ljava/lang/String;

    .line 54
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    .line 55
    const/16 v0, 0x10

    new-array v0, v0, [B

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->APP_KEY:[B

    .line 56
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    .line 57
    const-string v0, ""

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->CHANNEL:Ljava/lang/String;

    .line 59
    const-string v0, "1.0"

    sput-object v0, Lcom/digitalsky/sdk/common/Constant;->VERSION:Ljava/lang/String;

    .line 69
    sput-boolean v1, Lcom/digitalsky/sdk/common/Constant;->SDK_INIT:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static config(Ljava/lang/String;)V
    .locals 5
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 73
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 75
    .local v0, "config":Lorg/json/JSONObject;
    :try_start_1
    const-string v2, "TEST_MODE"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    sput-boolean v2, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    .line 79
    :goto_0
    :try_start_2
    const-string v2, "IS_OVERSEA"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    sput-boolean v2, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0

    .line 83
    :goto_1
    :try_start_3
    const-string v2, "DEBUG_LOG"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    sput-boolean v2, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0

    .line 87
    :goto_2
    :try_start_4
    const-string v2, "TEST_VERIFY_URL"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/digitalsky/sdk/common/Constant;->TEST_VERIFY_URL:Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_0

    .line 95
    .end local v0    # "config":Lorg/json/JSONObject;
    :goto_3
    return-void

    .line 91
    :catch_0
    move-exception v1

    .line 93
    .local v1, "e":Lorg/json/JSONException;
    sget-object v2, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 88
    .end local v1    # "e":Lorg/json/JSONException;
    .restart local v0    # "config":Lorg/json/JSONObject;
    :catch_1
    move-exception v2

    goto :goto_3

    .line 84
    :catch_2
    move-exception v2

    goto :goto_2

    .line 80
    :catch_3
    move-exception v2

    goto :goto_1

    .line 76
    :catch_4
    move-exception v2

    goto :goto_0
.end method

.method public static getKefuUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 62
    sget-boolean v0, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->KEFU_URL_OVERSEA:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->KEFU_URL:Ljava/lang/String;

    goto :goto_0
.end method

.method public static getVerifyUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 66
    sget-boolean v0, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->TEST_VERIFY_URL:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    sget-boolean v0, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z

    if-eqz v0, :cond_1

    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->RELEASE_VERIFY_URL_OVERSEA:Ljava/lang/String;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/digitalsky/sdk/common/Constant;->RELEASE_VERIFY_URL:Ljava/lang/String;

    goto :goto_0
.end method

.method public static init(Landroid/content/Context;)V
    .locals 10
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 99
    const-string v0, ""

    .line 101
    .local v0, "appKey":Ljava/lang/String;
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->CONFIG_NAME:Ljava/lang/String;

    invoke-static {p0, v5}, Lcom/digitalsky/sdk/common/Utils;->loadConfig(Landroid/content/Context;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v2

    .line 102
    .local v2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v2, :cond_3

    .line 104
    const-string v6, "true"

    const-string v5, "TEST_MODE"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    sput-boolean v5, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z

    .line 105
    const-string v6, "true"

    const-string v5, "IS_OVERSEA"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    sput-boolean v5, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z

    .line 107
    const-string v6, "true"

    const-string v5, "DEBUG_LOG"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    sput-boolean v5, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z

    .line 108
    sget-boolean v5, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z

    if-nez v5, :cond_0

    .line 110
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v5

    .line 111
    const-string v6, "/Android/ds_debug"

    .line 110
    invoke-direct {v1, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 112
    .local v1, "debugFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 113
    const/4 v5, 0x1

    sput-boolean v5, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 119
    .end local v1    # "debugFile":Ljava/io/File;
    :cond_0
    :goto_0
    const-string v5, "TEST_VERIFY_URL"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 120
    .local v3, "test_verify_url":Ljava/lang/String;
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 121
    sput-object v3, Lcom/digitalsky/sdk/common/Constant;->TEST_VERIFY_URL:Ljava/lang/String;

    .line 124
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v5, "APP_ID"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    .line 125
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v5, "APP_KEY"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 126
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v5, "APP_SECRET"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    .line 127
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v5, "APP_CHANNEL"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/digitalsky/sdk/common/Constant;->CHANNEL:Ljava/lang/String;

    .line 128
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    sget-object v7, Lcom/digitalsky/sdk/common/Constant;->APP_ID:Ljava/lang/String;

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, " -- "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -- "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/digitalsky/sdk/common/Constant;->SECRET:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -- "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/digitalsky/sdk/common/Constant;->CHANNEL:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    .line 129
    sget-boolean v5, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z

    if-eqz v5, :cond_2

    .line 130
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "TEST_MODE:"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-boolean v7, Lcom/digitalsky/sdk/common/Constant;->TEST_MODE:Z

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -- TEST_VERIFY_URL:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/digitalsky/sdk/common/Constant;->TEST_VERIFY_URL:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 132
    :cond_2
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "DEBUG_LOG:"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-boolean v7, Lcom/digitalsky/sdk/common/Constant;->DEBUG_LOG:Z

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -- IS_OVERSEA:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-boolean v7, Lcom/digitalsky/sdk/common/Constant;->IS_OVERSEA:Z

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    .end local v3    # "test_verify_url":Ljava/lang/String;
    :goto_1
    const/16 v5, 0x10

    new-array v4, v5, [B

    .line 139
    .local v4, "tmp":[B
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    array-length v6, v4

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    array-length v7, v7

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    invoke-static {v5, v8, v4, v8, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 140
    sput-object v4, Lcom/digitalsky/sdk/common/Constant;->APP_KEY:[B

    .line 141
    sput-boolean v9, Lcom/digitalsky/sdk/common/Constant;->SDK_INIT:Z

    .line 142
    return-void

    .line 135
    .end local v4    # "tmp":[B
    :cond_3
    sget-object v5, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "load config fail :"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v7, Lcom/digitalsky/sdk/common/Constant;->CONFIG_NAME:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 115
    :catch_0
    move-exception v5

    goto/16 :goto_0
.end method
