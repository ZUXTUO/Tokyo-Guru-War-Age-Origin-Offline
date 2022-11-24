.class public Lcom/digitalsky/sdk/user/SubmitData;
.super Ljava/lang/Object;
.source "SubmitData.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digitalsky/sdk/user/SubmitData$TYPE;
    }
.end annotation


# static fields
.field public static final KEY_ACCOUNT_ID:Ljava/lang/String; = "accountId"

.field public static final KEY_BALANCE:Ljava/lang/String; = "balance"

.field public static final KEY_COIN:Ljava/lang/String; = "coin"

.field public static final KEY_EXP_SUM:Ljava/lang/String; = "expSum"

.field public static final KEY_EXT:Ljava/lang/String; = "ext"

.field public static final KEY_FREE_COIN:Ljava/lang/String; = "freeCoin"

.field public static final KEY_LAST_LOGOUTTIME:Ljava/lang/String; = "lastLogoutTime"

.field public static final KEY_LAST_OPERATION:Ljava/lang/String; = "lastOperation"

.field public static final KEY_LOGINTIME:Ljava/lang/String; = "loginTime"

.field public static final KEY_LOGOUTTIME:Ljava/lang/String; = "logoutTime"

.field public static final KEY_MONEY:Ljava/lang/String; = "money"

.field public static final KEY_MONEY_SUM:Ljava/lang/String; = "moneySum"

.field public static final KEY_ONLINETIME:Ljava/lang/String; = "onlineTime"

.field public static final KEY_ORDER_ID:Ljava/lang/String; = "orderId"

.field public static final KEY_PARTY_NAME:Ljava/lang/String; = "partyName"

.field public static final KEY_PAYSTATE:Ljava/lang/String; = "payState"

.field public static final KEY_PAYTIME:Ljava/lang/String; = "payTime"

.field public static final KEY_REGTIME:Ljava/lang/String; = "regTime"

.field public static final KEY_ROLE_CTIME:Ljava/lang/String; = "roleCTime"

.field public static final KEY_ROLE_EXP:Ljava/lang/String; = "roleExp"

.field public static final KEY_ROLE_ID:Ljava/lang/String; = "roleId"

.field public static final KEY_ROLE_LEVEL:Ljava/lang/String; = "roleLevel"

.field public static final KEY_ROLE_LEVELMTIME:Ljava/lang/String; = "roleLevelMTime"

.field public static final KEY_ROLE_NAME:Ljava/lang/String; = "roleName"

.field public static final KEY_SCENE:Ljava/lang/String; = "scene"

.field public static final KEY_TYPE:Ljava/lang/String; = "type"

.field public static final KEY_VIP_LEVEL:Ljava/lang/String; = "vipLevel"

.field public static final KEY_ZONE_ID:Ljava/lang/String; = "zoneId"

.field public static final KEY_ZONE_NAME:Ljava/lang/String; = "zoneName"


# instance fields
.field public L_balance:J

.field public L_coin:J

.field public L_expSum:J

.field public L_freeCoin:J

.field public L_lastLogoutTime:J

.field public L_loginTime:J

.field public L_logoutTime:J

.field public L_money:J

.field public L_moneySum:J

.field public L_onlineTime:J

.field public L_payState:J

.field public L_payTime:J

.field public L_roleCTime:J

.field public L_roleExp:J

.field public L_roleLevel:J

.field public L_roleLevelMTime:J

.field public L_zoneId:J

.field private TAG:Ljava/lang/String;

.field public accountId:Ljava/lang/String;

.field public balance:Ljava/lang/String;

.field public coin:Ljava/lang/String;

.field public expSum:Ljava/lang/String;

.field public ext:Lorg/json/JSONObject;

.field public freeCoin:Ljava/lang/String;

.field public lastLogoutTime:Ljava/lang/String;

.field public lastOperation:Ljava/lang/String;

.field public loginTime:Ljava/lang/String;

.field public logoutTime:Ljava/lang/String;

.field public money:Ljava/lang/String;

.field public moneySum:Ljava/lang/String;

.field public onlineTime:Ljava/lang/String;

.field public orderId:Ljava/lang/String;

.field public partyName:Ljava/lang/String;

.field public payState:Ljava/lang/String;

.field public payTime:Ljava/lang/String;

.field public regTime:Ljava/lang/String;

.field public roleCTime:Ljava/lang/String;

.field public roleExp:Ljava/lang/String;

.field public roleId:Ljava/lang/String;

.field public roleLevel:Ljava/lang/String;

.field public roleLevelMTime:Ljava/lang/String;

.field public roleName:Ljava/lang/String;

.field public scene:Ljava/lang/String;

.field public type:Ljava/lang/String;

.field public vipLevel:Ljava/lang/String;

.field public zoneId:Ljava/lang/String;

.field public zoneName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    const-wide/16 v2, 0x0

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/SubmitData;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->TAG:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleId:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleName:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevel:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneId:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneName:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->balance:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->partyName:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->vipLevel:Ljava/lang/String;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleCTime:Ljava/lang/String;

    .line 41
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevelMTime:Ljava/lang/String;

    .line 44
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->accountId:Ljava/lang/String;

    .line 45
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->regTime:Ljava/lang/String;

    .line 46
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->loginTime:Ljava/lang/String;

    .line 47
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastLogoutTime:Ljava/lang/String;

    .line 48
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->coin:Ljava/lang/String;

    .line 49
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->freeCoin:Ljava/lang/String;

    .line 50
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payState:Ljava/lang/String;

    .line 51
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->orderId:Ljava/lang/String;

    .line 52
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payTime:Ljava/lang/String;

    .line 53
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->money:Ljava/lang/String;

    .line 54
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->logoutTime:Ljava/lang/String;

    .line 55
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->onlineTime:Ljava/lang/String;

    .line 56
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleExp:Ljava/lang/String;

    .line 57
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->expSum:Ljava/lang/String;

    .line 58
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->scene:Ljava/lang/String;

    .line 59
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->moneySum:Ljava/lang/String;

    .line 60
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastOperation:Ljava/lang/String;

    .line 62
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_zoneId:J

    .line 63
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_loginTime:J

    .line 64
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_lastLogoutTime:J

    .line 65
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleCTime:J

    .line 66
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevelMTime:J

    .line 67
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevel:J

    .line 68
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_coin:J

    .line 69
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_freeCoin:J

    .line 70
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payState:J

    .line 71
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payTime:J

    .line 72
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_balance:J

    .line 73
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_money:J

    .line 74
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_logoutTime:J

    .line 75
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_onlineTime:J

    .line 76
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleExp:J

    .line 77
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_expSum:J

    .line 78
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_moneySum:J

    .line 80
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;

    .line 116
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 4
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    const-wide/16 v2, 0x0

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digitalsky/sdk/common/Constant;->TAG:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-class v1, Lcom/digitalsky/sdk/user/SubmitData;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->TAG:Ljava/lang/String;

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleId:Ljava/lang/String;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleName:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevel:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneId:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneName:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->balance:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->partyName:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->vipLevel:Ljava/lang/String;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleCTime:Ljava/lang/String;

    .line 41
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevelMTime:Ljava/lang/String;

    .line 44
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->accountId:Ljava/lang/String;

    .line 45
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->regTime:Ljava/lang/String;

    .line 46
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->loginTime:Ljava/lang/String;

    .line 47
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastLogoutTime:Ljava/lang/String;

    .line 48
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->coin:Ljava/lang/String;

    .line 49
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->freeCoin:Ljava/lang/String;

    .line 50
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payState:Ljava/lang/String;

    .line 51
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->orderId:Ljava/lang/String;

    .line 52
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payTime:Ljava/lang/String;

    .line 53
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->money:Ljava/lang/String;

    .line 54
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->logoutTime:Ljava/lang/String;

    .line 55
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->onlineTime:Ljava/lang/String;

    .line 56
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleExp:Ljava/lang/String;

    .line 57
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->expSum:Ljava/lang/String;

    .line 58
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->scene:Ljava/lang/String;

    .line 59
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->moneySum:Ljava/lang/String;

    .line 60
    const-string v0, ""

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastOperation:Ljava/lang/String;

    .line 62
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_zoneId:J

    .line 63
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_loginTime:J

    .line 64
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_lastLogoutTime:J

    .line 65
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleCTime:J

    .line 66
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevelMTime:J

    .line 67
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevel:J

    .line 68
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_coin:J

    .line 69
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_freeCoin:J

    .line 70
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payState:J

    .line 71
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payTime:J

    .line 72
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_balance:J

    .line 73
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_money:J

    .line 74
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_logoutTime:J

    .line 75
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_onlineTime:J

    .line 76
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleExp:J

    .line 77
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_expSum:J

    .line 78
    iput-wide v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_moneySum:J

    .line 80
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;

    .line 119
    invoke-direct {p0, p1}, Lcom/digitalsky/sdk/user/SubmitData;->initData(Ljava/lang/String;)V

    .line 120
    return-void
.end method

.method private Str2L(Ljava/lang/String;)J
    .locals 3
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    .line 184
    const-wide/16 v0, 0x0

    .line 186
    .local v0, "ret":J
    :try_start_0
    invoke-static {p1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 189
    :goto_0
    return-wide v0

    .line 187
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private initData(Ljava/lang/String;)V
    .locals 4
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    .line 124
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 125
    .local v1, "obj":Lorg/json/JSONObject;
    const-string v2, "type"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    .line 126
    const-string v2, "roleId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleId:Ljava/lang/String;

    .line 127
    const-string v2, "roleName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleName:Ljava/lang/String;

    .line 128
    const-string v2, "roleLevel"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevel:Ljava/lang/String;

    .line 129
    const-string v2, "zoneId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneId:Ljava/lang/String;

    .line 130
    const-string v2, "zoneName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneName:Ljava/lang/String;

    .line 131
    const-string v2, "balance"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->balance:Ljava/lang/String;

    .line 132
    const-string v2, "partyName"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->partyName:Ljava/lang/String;

    .line 133
    const-string v2, "vipLevel"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->vipLevel:Ljava/lang/String;

    .line 134
    const-string v2, "roleCTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleCTime:Ljava/lang/String;

    .line 135
    const-string v2, "roleLevelMTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevelMTime:Ljava/lang/String;

    .line 137
    const-string v2, "accountId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->accountId:Ljava/lang/String;

    .line 138
    const-string v2, "regTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->regTime:Ljava/lang/String;

    .line 139
    const-string v2, "loginTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->loginTime:Ljava/lang/String;

    .line 140
    const-string v2, "lastLogoutTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastLogoutTime:Ljava/lang/String;

    .line 141
    const-string v2, "coin"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->coin:Ljava/lang/String;

    .line 142
    const-string v2, "freeCoin"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->freeCoin:Ljava/lang/String;

    .line 143
    const-string v2, "payState"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->payState:Ljava/lang/String;

    .line 144
    const-string v2, "orderId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->orderId:Ljava/lang/String;

    .line 145
    const-string v2, "payTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->payTime:Ljava/lang/String;

    .line 146
    const-string v2, "money"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->money:Ljava/lang/String;

    .line 147
    const-string v2, "logoutTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->logoutTime:Ljava/lang/String;

    .line 148
    const-string v2, "onlineTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->onlineTime:Ljava/lang/String;

    .line 149
    const-string v2, "roleExp"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleExp:Ljava/lang/String;

    .line 150
    const-string v2, "expSum"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->expSum:Ljava/lang/String;

    .line 151
    const-string v2, "scene"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->scene:Ljava/lang/String;

    .line 152
    const-string v2, "money"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->moneySum:Ljava/lang/String;

    .line 153
    const-string v2, "lastOperation"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastOperation:Ljava/lang/String;

    .line 155
    const-string v2, "ext"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    iput-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 161
    .end local v1    # "obj":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 156
    :catch_0
    move-exception v0

    .line 159
    .local v0, "e":Lorg/json/JSONException;
    iget-object v2, p0, Lcom/digitalsky/sdk/user/SubmitData;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method public setDataL()V
    .locals 2

    .prologue
    .line 164
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneId:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_zoneId:J

    .line 165
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->loginTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_loginTime:J

    .line 166
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastLogoutTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_lastLogoutTime:J

    .line 167
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleCTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleCTime:J

    .line 168
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevelMTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevelMTime:J

    .line 169
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevel:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleLevel:J

    .line 170
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->coin:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_coin:J

    .line 171
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->freeCoin:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_freeCoin:J

    .line 172
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payState:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payState:J

    .line 173
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->payTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_payTime:J

    .line 174
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->balance:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_balance:J

    .line 175
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->money:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_money:J

    .line 176
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->logoutTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_logoutTime:J

    .line 177
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->onlineTime:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_onlineTime:J

    .line 178
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleExp:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_roleExp:J

    .line 179
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->expSum:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_expSum:J

    .line 180
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->moneySum:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/digitalsky/sdk/user/SubmitData;->Str2L(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/digitalsky/sdk/user/SubmitData;->L_moneySum:J

    .line 181
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 195
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "type:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleLevel:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 196
    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "zoneId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "zoneName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->zoneName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "balance:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->balance:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 197
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "partyName:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->partyName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "vipLevel:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->vipLevel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleCTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleCTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 198
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleLevelMTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleLevelMTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "accountId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->accountId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "regTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 199
    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->regTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "loginTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->loginTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "lastLogoutTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastLogoutTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "coin:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 200
    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->coin:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "freeCoin:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->freeCoin:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "payState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->payState:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "orderId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->orderId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 201
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "payTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->payTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "money:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->money:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "logoutTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->logoutTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 202
    const-string v1, "onlineTime:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->onlineTime:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "roleExp:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->roleExp:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "expSum:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->expSum:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "scene:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 203
    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->scene:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "moneySum:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->moneySum:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "lastOperation:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->lastOperation:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ext:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/digitalsky/sdk/user/SubmitData;->ext:Lorg/json/JSONObject;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 195
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
