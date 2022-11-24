.class public Lcom/blm/sdk/core/CoreLib;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 36
    const-class v0, Lcom/blm/sdk/core/CoreLib;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/CoreLib;->a:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(I)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # I

    .prologue
    .line 35
    invoke-static {p0}, Lcom/blm/sdk/core/CoreLib;->getPhase(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static completeJarReport(Landroid/content/Context;Ljava/lang/String;II)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phase"    # Ljava/lang/String;
    .param p2, "id"    # I
    .param p3, "errmsg"    # I

    .prologue
    .line 133
    const-string v0, ""

    .line 134
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 136
    :try_start_0
    const-string v2, "uuid"

    invoke-static {p0}, Lcom/blm/sdk/d/i;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 137
    const-string v2, "phase"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 138
    const-string v2, "id"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 139
    const-string v2, "imei"

    invoke-static {p0}, Lcom/blm/sdk/d/g;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 140
    const-string v2, "imsi"

    invoke-static {p0}, Lcom/blm/sdk/d/g;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 141
    const-string v2, "mac"

    invoke-static {p0}, Lcom/blm/sdk/d/g;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 142
    const-string v2, "androidId"

    invoke-static {p0}, Lcom/blm/sdk/d/g;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 143
    const-string v2, "os_ver"

    invoke-static {}, Lcom/blm/sdk/d/g;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 144
    const-string v2, "manufacturer"

    invoke-static {}, Lcom/blm/sdk/d/g;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 145
    const-string v2, "model"

    invoke-static {}, Lcom/blm/sdk/d/g;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 146
    const-string v2, "action"

    const-string v3, "jar"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 147
    const-string v2, "time"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v1, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 148
    const-string v2, "errmsg"

    invoke-virtual {v1, v2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 149
    const-string v2, "appId"

    sget-object v3, Lcom/blm/sdk/constants/Constants;->APP_ID:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 151
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    .line 154
    const-string v1, "https://hs.1wabao.com/report"

    .line 155
    invoke-static {v1, v0}, Lcom/blm/sdk/core/CoreLib;->sendPost(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 160
    :goto_0
    return-object v0

    .line 157
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static getPhase(I)Ljava/lang/String;
    .locals 1
    .param p0, "result"    # I

    .prologue
    .line 190
    if-nez p0, :cond_0

    .line 191
    const-string v0, "Execute Success"

    .line 209
    :goto_0
    return-object v0

    .line 192
    :cond_0
    const/4 v0, 0x1

    if-ne p0, v0, :cond_1

    .line 193
    const-string v0, "Class no find"

    goto :goto_0

    .line 194
    :cond_1
    const/4 v0, 0x2

    if-ne p0, v0, :cond_2

    .line 195
    const-string v0, "Structural private"

    goto :goto_0

    .line 196
    :cond_2
    const/4 v0, 0x3

    if-ne p0, v0, :cond_3

    .line 197
    const-string v0, "can not create object"

    goto :goto_0

    .line 198
    :cond_3
    const/4 v0, 0x4

    if-ne p0, v0, :cond_4

    .line 199
    const-string v0, "can not find method"

    goto :goto_0

    .line 200
    :cond_4
    const/4 v0, 0x5

    if-ne p0, v0, :cond_5

    .line 201
    const-string v0, "Parameter mismatch"

    goto :goto_0

    .line 202
    :cond_5
    const/4 v0, 0x6

    if-ne p0, v0, :cond_6

    .line 203
    const-string v0, "Method call exception"

    goto :goto_0

    .line 204
    :cond_6
    const/4 v0, 0x7

    if-ne p0, v0, :cond_7

    .line 205
    const-string v0, "context is null"

    goto :goto_0

    .line 206
    :cond_7
    const/16 v0, 0x8

    if-ne p0, v0, :cond_8

    .line 207
    const-string v0, "jar not found"

    goto :goto_0

    .line 209
    :cond_8
    const-string v0, ""

    goto :goto_0
.end method

.method public static init(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "appId"    # Ljava/lang/String;

    .prologue
    .line 49
    sget-object v0, Lcom/blm/sdk/core/CoreLib;->a:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "init appId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 50
    if-eqz p0, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 51
    :cond_0
    sget-object v0, Lcom/blm/sdk/core/CoreLib;->a:Ljava/lang/String;

    const-string v1, "init failed"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 131
    :goto_0
    return-void

    .line 54
    :cond_1
    sput-object p1, Lcom/blm/sdk/constants/Constants;->APP_ID:Ljava/lang/String;

    .line 55
    sput-object p0, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    .line 57
    new-instance v0, Lcom/blm/sdk/core/CoreLib$1;

    invoke-direct {v0}, Lcom/blm/sdk/core/CoreLib$1;-><init>()V

    invoke-static {p0, v0}, Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Lcom/blm/sdk/c/a;)V

    .line 70
    new-instance v0, Lcom/blm/sdk/core/CoreLib$2;

    invoke-direct {v0}, Lcom/blm/sdk/core/CoreLib$2;-><init>()V

    invoke-static {p0, v0}, Lcom/blm/sdk/http/a;->c(Landroid/content/Context;Lcom/blm/sdk/c/a;)V

    .line 83
    new-instance v0, Lcom/blm/sdk/core/a;

    invoke-direct {v0}, Lcom/blm/sdk/core/a;-><init>()V

    invoke-virtual {v0, p0}, Lcom/blm/sdk/core/a;->a(Landroid/content/Context;)V

    .line 85
    const-string v0, "https://hs.1wabao.com/get"

    const/4 v1, 0x0

    const/4 v2, 0x0

    new-instance v3, Lcom/blm/sdk/core/CoreLib$3;

    invoke-direct {v3, p0}, Lcom/blm/sdk/core/CoreLib$3;-><init>(Landroid/content/Context;)V

    invoke-static {p0, v0, v1, v2, v3}, Lcom/blm/sdk/http/Cda;->ri(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILcom/blm/sdk/c/a;)V

    goto :goto_0
.end method

.method private static isN()Z
    .locals 2

    .prologue
    .line 39
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 40
    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    .line 41
    const/4 v0, 0x0

    .line 43
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static sendPost(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "params"    # Ljava/lang/String;

    .prologue
    .line 164
    const-string v1, ""

    .line 169
    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 170
    invoke-static {p1}, Lcom/blm/sdk/http/Cda;->het(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 171
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 172
    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 173
    const-string v3, "POST"

    invoke-virtual {v0, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 174
    new-instance v3, Ljava/io/PrintWriter;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/PrintWriter;-><init>(Ljava/io/OutputStream;)V

    .line 175
    invoke-virtual {v3, v2}, Ljava/io/PrintWriter;->print(Ljava/lang/String;)V

    .line 176
    invoke-virtual {v3}, Ljava/io/PrintWriter;->flush()V

    .line 177
    invoke-virtual {v3}, Ljava/io/PrintWriter;->close()V

    .line 178
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 179
    invoke-static {v0}, Lcom/pg/im/sdk/lib/d/a;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0

    .line 181
    const-string v2, "DownService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "completeJarReportRep--"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v0}, Lcom/blm/sdk/http/Cda;->hdt(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 186
    :goto_0
    return-object v0

    .line 182
    :catch_0
    move-exception v0

    .line 183
    const-string v2, "DownService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "fail--"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    move-object v0, v1

    .line 184
    goto :goto_0
.end method
