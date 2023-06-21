.class public Lcom/blm/sdk/constants/Constants;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static ACTIONREQ_ACTIONTYPE:Ljava/lang/String; = null

.field public static ACTIONREQ_APPID:Ljava/lang/String; = null

.field public static ACTIONREQ_OSTYPE:Ljava/lang/String; = null

.field public static ACTIONREQ_SDKVERSION:Ljava/lang/String; = null

.field public static ACTIONREQ_UUID:Ljava/lang/String; = null

.field public static ACTIONREQ_VERSION:Ljava/lang/String; = null

.field public static APP_ID:Ljava/lang/String; = null

.field public static AUTHREQ_ANDROID_ID:Ljava/lang/String; = null

.field public static AUTHREQ_APP_ID:Ljava/lang/String; = null

.field public static AUTHREQ_APP_VERSION:Ljava/lang/String; = null

.field public static AUTHREQ_CHANNERL_ID:Ljava/lang/String; = null

.field public static AUTHREQ_DOUBLECARD:Ljava/lang/String; = null

.field public static AUTHREQ_IDFA:Ljava/lang/String; = null

.field public static AUTHREQ_IMEI:Ljava/lang/String; = null

.field public static AUTHREQ_IMSI:Ljava/lang/String; = null

.field public static AUTHREQ_IP:Ljava/lang/String; = null

.field public static AUTHREQ_ISP:Ljava/lang/String; = null

.field public static AUTHREQ_MAC:Ljava/lang/String; = null

.field public static AUTHREQ_MOBILE_TYPE:Ljava/lang/String; = null

.field public static AUTHREQ_MOBILE_VERSION:Ljava/lang/String; = null

.field public static AUTHREQ_NETWORKTYPE:Ljava/lang/String; = null

.field public static AUTHREQ_OSTYPE:Ljava/lang/String; = null

.field public static AUTHREQ_OSVERSION:Ljava/lang/String; = null

.field public static AUTHREQ_PHONENUM:Ljava/lang/String; = null

.field public static AUTHREQ_RESQUEST_TYPE:Ljava/lang/String; = null

.field public static AUTHREQ_SDK_VERSION:Ljava/lang/String; = null

.field public static AUTHREQ_SECOND_PHONUM:Ljava/lang/String; = null

.field public static AUTHREQ_SOFT_OWNER:Ljava/lang/String; = null

.field public static AUTHREQ_SYSTEM_COUNT:Ljava/lang/String; = null

.field public static AUTHREQ_UUID:Ljava/lang/String; = null

.field public static CHECKREQ_APPID:Ljava/lang/String; = null

.field public static CHECKREQ_OSTYPE:Ljava/lang/String; = null

.field public static CHECKREQ_SDKVERSION:Ljava/lang/String; = null

.field public static CHECKREQ_UUID:Ljava/lang/String; = null

.field public static CHECKREQ_VERSION:Ljava/lang/String; = null

.field public static final CHECKRESP_HELLOID:Ljava/lang/String; = "blmId"

.field public static final CHECKRESP_REQUESTID:Ljava/lang/String; = "requestId"

.field public static final CHINA_MOBILE:I = 0x1

.field public static final CHINA_TELECOM:I = 0x3

.field public static final CHINA_UNICOM:I = 0x2

.field public static final DB_NAME:Ljava/lang/String; = "jb.db"

.field public static final DEV_UUID:Ljava/lang/String; = "dev_uuid"

.field public static final DOWN_THREAD_COUNT:I = 0x4

.field public static final ERRREPORTREQ_ERRMSG:Ljava/lang/String; = "errMsg"

.field public static final ERRREPORTREQ_PARMS:Ljava/lang/String; = "androidParam"

.field public static final ERRREPORTREQ_REQUESTID:Ljava/lang/String; = "requestId"

.field public static final GETHELLOREQ_REQUESTID:Ljava/lang/String; = "requestId"

.field public static final GETHELLORESP_INFO:Ljava/lang/String; = "info"

.field public static final GETHELLORESP_REQUESTID:Ljava/lang/String; = "requestId"

.field public static GETNEXTSCPREQ_LASTID:Ljava/lang/String; = null

.field public static GETNEXTSCPREQ_NEXTID:Ljava/lang/String; = null

.field public static GETNEXTSCPREQ_REQUESTID:Ljava/lang/String; = null

.field public static GLOABLE_CONTEXT:Landroid/content/Context; = null

.field public static final HELLOINFO_HELLO:Ljava/lang/String; = "blm"

.field public static final HELLOINFO_ID:Ljava/lang/String; = "id"

.field public static final HELLOINFO_MD5VAL:Ljava/lang/String; = "md5Val"

.field public static final HELLOINFO_NAME:Ljava/lang/String; = "name"

.field public static final HELLOINFO_OSTYPE:Ljava/lang/String; = "osType"

.field public static final IS_FIRST_START:Ljava/lang/String; = "is_first_start"

.field public static IS_LOG_ON:Z = false

.field public static final LAST_DO_TIME:Ljava/lang/String; = "LAST_DO_TIME"

.field public static LAST_HELLO_ID:Ljava/lang/Integer; = null

.field public static LAST_REQUEST_ID:Ljava/lang/String; = null

.field public static final LOADDATAREQ_REQUESTID:Ljava/lang/String; = "requestId"

.field public static final LOADDATAREQ_USERDATA:Ljava/lang/String; = "userData"

.field public static final NETWORK_CELL_2G:I = 0x2

.field public static final NETWORK_CELL_3G:I = 0x3

.field public static final NETWORK_CELL_4G:I = 0x4

.field public static final NETWORK_CONNECTTION_UNKOWN:I = 0x0

.field public static final NETWORK_WIFI:I = 0x1

.field public static final OTHER_OPERATOR:I = 0x4

.field public static final REGISTER_OR_LOAD:Ljava/lang/String; = "REGISTER_OR_LOAD"

.field public static final ROOT_PATH:Ljava/lang/String; = "blm_jb"

.field public static final SP_NAME:Ljava/lang/String; = "jb_sp"

.field public static final TABLE_HELLO_ID:Ljava/lang/String; = "helloid"

.field public static final TABLE_NAME:Ljava/lang/String; = "table_name"

.field public static final UPLOAD_INFO_TIME:Ljava/lang/String; = "UPLOAD_INFO_TIME"

.field public static final VERSION_CODE:I = 0x1

.field public static final VERSION_NAME:Ljava/lang/String; = "1.0.3"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 8
    sput-boolean v1, Lcom/blm/sdk/constants/Constants;->IS_LOG_ON:Z

    .line 10
    const-string v0, "APP_ID"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->APP_ID:Ljava/lang/String;

    .line 16
    const-string v0, "last_request_id"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->LAST_REQUEST_ID:Ljava/lang/String;

    .line 18
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/constants/Constants;->LAST_HELLO_ID:Ljava/lang/Integer;

    .line 60
    const-string v0, "uuid"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->CHECKREQ_UUID:Ljava/lang/String;

    .line 61
    const-string v0, "osType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->CHECKREQ_OSTYPE:Ljava/lang/String;

    .line 62
    const-string v0, "appId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->CHECKREQ_APPID:Ljava/lang/String;

    .line 63
    const-string v0, "version"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->CHECKREQ_VERSION:Ljava/lang/String;

    .line 64
    const-string v0, "sdkVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->CHECKREQ_SDKVERSION:Ljava/lang/String;

    .line 66
    const-string v0, "uuid"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_UUID:Ljava/lang/String;

    .line 67
    const-string v0, "osType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_OSTYPE:Ljava/lang/String;

    .line 68
    const-string v0, "appId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_APPID:Ljava/lang/String;

    .line 69
    const-string v0, "version"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_VERSION:Ljava/lang/String;

    .line 70
    const-string v0, "sdkVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_SDKVERSION:Ljava/lang/String;

    .line 71
    const-string v0, "actionType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_ACTIONTYPE:Ljava/lang/String;

    .line 73
    const-string v0, "requestType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_RESQUEST_TYPE:Ljava/lang/String;

    .line 74
    const-string v0, "uuid"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_UUID:Ljava/lang/String;

    .line 75
    const-string v0, "osType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_OSTYPE:Ljava/lang/String;

    .line 76
    const-string v0, "mobileType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MOBILE_TYPE:Ljava/lang/String;

    .line 77
    const-string v0, "mac"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MAC:Ljava/lang/String;

    .line 78
    const-string v0, "mobileVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MOBILE_VERSION:Ljava/lang/String;

    .line 79
    const-string v0, "systemCount"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SYSTEM_COUNT:Ljava/lang/String;

    .line 81
    const-string v0, "appId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_APP_ID:Ljava/lang/String;

    .line 82
    const-string v0, "appVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_APP_VERSION:Ljava/lang/String;

    .line 83
    const-string v0, "channelId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_CHANNERL_ID:Ljava/lang/String;

    .line 84
    const-string v0, "softOwner"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SOFT_OWNER:Ljava/lang/String;

    .line 85
    const-string v0, "sdkVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SDK_VERSION:Ljava/lang/String;

    .line 87
    const-string v0, "doubleCard"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_DOUBLECARD:Ljava/lang/String;

    .line 88
    const-string v0, "phoneNum"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_PHONENUM:Ljava/lang/String;

    .line 89
    const-string v0, "secondPhoNum"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SECOND_PHONUM:Ljava/lang/String;

    .line 90
    const-string v0, "imei"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IMEI:Ljava/lang/String;

    .line 91
    const-string v0, "imsi"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IMSI:Ljava/lang/String;

    .line 93
    const-string v0, "isp"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_ISP:Ljava/lang/String;

    .line 94
    const-string v0, "androidId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_ANDROID_ID:Ljava/lang/String;

    .line 95
    const-string v0, "idfa"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IDFA:Ljava/lang/String;

    .line 96
    const-string v0, "ip"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IP:Ljava/lang/String;

    .line 97
    const-string v0, "networkType"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_NETWORKTYPE:Ljava/lang/String;

    .line 98
    const-string v0, "osVersion"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->AUTHREQ_OSVERSION:Ljava/lang/String;

    .line 100
    const-string v0, "requestId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_REQUESTID:Ljava/lang/String;

    .line 101
    const-string v0, "lastId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_LASTID:Ljava/lang/String;

    .line 102
    const-string v0, "nextId"

    sput-object v0, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_NEXTID:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
