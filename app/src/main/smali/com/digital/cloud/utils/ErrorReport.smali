.class public Lcom/digital/cloud/utils/ErrorReport;
.super Ljava/lang/Object;
.source "ErrorReport.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;
    }
.end annotation


# static fields
.field private static REPORT_URL:Ljava/lang/String;

.field private static TAG:Ljava/lang/String;

.field private static enableReport:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    const-string v0, "http://125.71.203.241:9321/webpost_paltform.php"

    sput-object v0, Lcom/digital/cloud/utils/ErrorReport;->REPORT_URL:Ljava/lang/String;

    .line 27
    const-class v0, Lcom/digital/cloud/utils/ErrorReport;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    .line 28
    const/4 v0, 0x0

    sput-boolean v0, Lcom/digital/cloud/utils/ErrorReport;->enableReport:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0()Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static asyncHttpRequest(Ljava/lang/String;Lorg/apache/http/entity/StringEntity;Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;)V
    .locals 3
    .param p0, "httpUrl"    # Ljava/lang/String;
    .param p1, "httpentity"    # Lorg/apache/http/entity/StringEntity;
    .param p2, "listener"    # Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;

    .prologue
    .line 100
    sget-object v0, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "url: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 101
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/digital/cloud/utils/ErrorReport$2;

    invoke-direct {v1, p0, p1, p2}, Lcom/digital/cloud/utils/ErrorReport$2;-><init>(Ljava/lang/String;Lorg/apache/http/entity/StringEntity;Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 124
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 125
    return-void
.end method

.method public static enable(Z)V
    .locals 0
    .param p0, "enable"    # Z

    .prologue
    .line 35
    sput-boolean p0, Lcom/digital/cloud/utils/ErrorReport;->enableReport:Z

    .line 36
    return-void
.end method

.method private static eventHead(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "eventId"    # Ljava/lang/String;

    .prologue
    .line 75
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 77
    .local v2, "root":Lorg/json/JSONObject;
    if-eqz p0, :cond_0

    .line 78
    :try_start_0
    const-string v3, "type"

    invoke-virtual {v2, v3, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 79
    :cond_0
    const-string v3, "appid"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 80
    const-string v3, "key"

    sget-object v4, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppKey:[B

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 82
    const-string v3, "android_id"

    const-string v4, "android_id"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 83
    const-string v3, "mac"

    const-string v4, "mac"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 84
    const-string v3, "app_version_name"

    const-string v4, "app_version_name"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 85
    const-string v3, "model"

    const-string v4, "model"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-static {v4, v5}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 86
    const-string v3, "system_name"

    const-string v4, "system_name"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 87
    const-string v3, "system_version"

    const-string v4, "system_version"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 88
    const-string v3, "machine_code"

    const-string v4, "machine_code"

    invoke-static {v4}, Lorg/deviceinfo/DeviceInfo;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1

    .line 95
    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 89
    :catch_0
    move-exception v1

    .line 90
    .local v1, "e1":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 91
    .end local v1    # "e1":Lorg/json/JSONException;
    :catch_1
    move-exception v0

    .line 92
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0
.end method

.method public static log(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p0, "eventId"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 39
    sget-boolean v4, Lcom/digital/cloud/utils/ErrorReport;->enableReport:Z

    if-nez v4, :cond_0

    .line 72
    :goto_0
    return-void

    .line 41
    :cond_0
    const/4 v1, 0x0

    .line 44
    .local v1, "httpentity":Lorg/apache/http/entity/StringEntity;
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-static {p0}, Lcom/digital/cloud/utils/ErrorReport;->eventHead(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 45
    .local v3, "root":Lorg/json/JSONObject;
    const-string v4, "msg"

    invoke-virtual {v3, v4, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    sget-object v4, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "log:"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    new-instance v2, Lorg/apache/http/entity/StringEntity;

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Lorg/apache/http/entity/StringEntity;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1

    .line 49
    .end local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .local v2, "httpentity":Lorg/apache/http/entity/StringEntity;
    if-eqz v2, :cond_1

    .line 50
    :try_start_1
    sget-object v4, Lcom/digital/cloud/utils/ErrorReport;->REPORT_URL:Ljava/lang/String;

    new-instance v5, Lcom/digital/cloud/utils/ErrorReport$1;

    invoke-direct {v5}, Lcom/digital/cloud/utils/ErrorReport$1;-><init>()V

    invoke-static {v4, v2, v5}, Lcom/digital/cloud/utils/ErrorReport;->asyncHttpRequest(Ljava/lang/String;Lorg/apache/http/entity/StringEntity;Lcom/digital/cloud/utils/ErrorReport$asyncHttpRequestListener;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_2

    move-object v1, v2

    .line 63
    .end local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    goto :goto_0

    .end local v3    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 65
    .local v0, "e":Lorg/json/JSONException;
    :goto_1
    sget-object v4, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    const-string v5, "log: JSONException"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 67
    .end local v0    # "e":Lorg/json/JSONException;
    :catch_1
    move-exception v0

    .line 69
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    :goto_2
    sget-object v4, Lcom/digital/cloud/utils/ErrorReport;->TAG:Ljava/lang/String;

    const-string v5, "log: UnsupportedEncodingException"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 67
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    .end local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v3    # "root":Lorg/json/JSONObject;
    :catch_2
    move-exception v0

    move-object v1, v2

    .end local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    goto :goto_2

    .line 63
    .end local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    :catch_3
    move-exception v0

    move-object v1, v2

    .end local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    goto :goto_1

    .end local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    :cond_1
    move-object v1, v2

    .end local v2    # "httpentity":Lorg/apache/http/entity/StringEntity;
    .restart local v1    # "httpentity":Lorg/apache/http/entity/StringEntity;
    goto :goto_0
.end method
