.class public Lcom/blm/sdk/d/f;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 28
    const-class v0, Lorg/json/JSONObject;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    return-void
.end method

.method public static a(Ljava/lang/String;)Lcom/blm/sdk/a/c/d;
    .locals 5

    .prologue
    .line 212
    new-instance v1, Lcom/blm/sdk/a/c/d;

    invoke-direct {v1}, Lcom/blm/sdk/a/c/d;-><init>()V

    .line 213
    const/4 v0, 0x0

    .line 215
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 216
    const-string v3, "requestId"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 217
    const-string v4, "info"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 218
    new-instance v0, Lcom/blm/sdk/a/b/g;

    invoke-direct {v0}, Lcom/blm/sdk/a/b/g;-><init>()V

    .line 219
    const-string v4, "info"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 220
    const-string v4, "id"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 221
    const-string v4, "id"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/blm/sdk/a/b/g;->a(Ljava/lang/Integer;)V

    .line 223
    :cond_0
    const-string v4, "md5Val"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 224
    const-string v4, "md5Val"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/blm/sdk/a/b/g;->a(Ljava/lang/String;)V

    .line 226
    :cond_1
    const-string v4, "name"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 227
    const-string v4, "name"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/blm/sdk/a/b/g;->b(Ljava/lang/String;)V

    .line 229
    :cond_2
    const-string v4, "osType"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 230
    const-string v4, "osType"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v4}, Lcom/blm/sdk/a/b/g;->b(Ljava/lang/Integer;)V

    .line 232
    :cond_3
    const-string v4, "blm"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 233
    const-string v4, "blm"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/a/b/g;->c(Ljava/lang/String;)V

    .line 236
    :cond_4
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/c/d;->a(Lcom/blm/sdk/a/b/g;)V

    .line 237
    invoke-virtual {v1, v3}, Lcom/blm/sdk/a/c/d;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 241
    :goto_0
    return-object v1

    .line 238
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 108
    new-instance v0, Lcom/blm/sdk/a/b/b;

    invoke-direct {v0}, Lcom/blm/sdk/a/b/b;-><init>()V

    .line 110
    invoke-static {p0}, Lcom/blm/sdk/d/g;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->r(Ljava/lang/String;)V

    .line 111
    sget-object v1, Lcom/blm/sdk/constants/Constants;->APP_ID:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->j(Ljava/lang/String;)V

    .line 112
    invoke-static {p0}, Lcom/blm/sdk/d/g;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->k(Ljava/lang/String;)V

    .line 113
    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->l(Ljava/lang/String;)V

    .line 114
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->b(Ljava/lang/Integer;)V

    .line 115
    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->b(Ljava/lang/String;)V

    .line 116
    const-string v1, "1.0.3"

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->a(Ljava/lang/String;)V

    .line 118
    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->s(Ljava/lang/String;)V

    .line 119
    invoke-static {p0}, Lcom/blm/sdk/d/g;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->p(Ljava/lang/String;)V

    .line 120
    invoke-static {p0}, Lcom/blm/sdk/d/g;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->q(Ljava/lang/String;)V

    .line 121
    invoke-static {p0}, Lcom/blm/sdk/d/g;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->t(Ljava/lang/String;)V

    .line 122
    invoke-static {p0}, Lcom/blm/sdk/d/g;->f(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->c(Ljava/lang/Integer;)V

    .line 124
    invoke-static {p0}, Lcom/blm/sdk/d/g;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->i(Ljava/lang/String;)V

    .line 125
    invoke-static {}, Lcom/blm/sdk/d/g;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->g(Ljava/lang/String;)V

    .line 126
    invoke-static {}, Lcom/blm/sdk/d/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->h(Ljava/lang/String;)V

    .line 127
    invoke-static {p0}, Lcom/blm/sdk/d/g;->h(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->d(Ljava/lang/Integer;)V

    .line 128
    invoke-static {}, Lcom/blm/sdk/d/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->f(Ljava/lang/String;)V

    .line 130
    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->n(Ljava/lang/String;)V

    .line 131
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->c(Ljava/lang/String;)V

    .line 132
    const-string v1, "REGISTER_OR_LOAD"

    invoke-static {p0, v1, v3}, Lcom/blm/sdk/d/h;->b(Landroid/content/Context;Ljava/lang/String;I)I

    move-result v1

    .line 133
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/blm/sdk/a/b/b;->a(Ljava/lang/Integer;)V

    .line 134
    if-ne v1, v3, :cond_0

    .line 135
    const-string v1, "REGISTER_OR_LOAD"

    const/4 v2, 0x2

    invoke-static {p0, v1, v2}, Lcom/blm/sdk/d/h;->a(Landroid/content/Context;Ljava/lang/String;I)V

    .line 138
    :cond_0
    const-string v1, "1.0.3"

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->d(Ljava/lang/String;)V

    .line 139
    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->o(Ljava/lang/String;)V

    .line 140
    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->m(Ljava/lang/String;)V

    .line 141
    invoke-static {p0}, Lcom/blm/sdk/d/i;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/b;->e(Ljava/lang/String;)V

    .line 143
    invoke-static {v0}, Lcom/blm/sdk/d/f;->a(Lcom/blm/sdk/a/b/b;)Ljava/lang/String;

    move-result-object v0

    .line 145
    return-object v0
.end method

.method public static a(Lcom/blm/sdk/a/b/a;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 91
    const-string v0, ""

    .line 92
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 94
    :try_start_0
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_ACTIONTYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->f()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 95
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_APPID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 96
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_OSTYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->c()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 97
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_SDKVERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 98
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_UUID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 99
    sget-object v2, Lcom/blm/sdk/constants/Constants;->ACTIONREQ_VERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/a;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 100
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 104
    :goto_0
    return-object v0

    .line 101
    :catch_0
    move-exception v1

    .line 102
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/b;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 34
    const-string v0, ""

    .line 35
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 37
    :try_start_0
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_RESQUEST_TYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->e()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 38
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_UUID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->f()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 39
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_OSTYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->g()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 40
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MOBILE_TYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->h()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 41
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MAC:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->i()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 42
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_MOBILE_VERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 43
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SYSTEM_COUNT:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 45
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_APP_ID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_APP_VERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->k()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 47
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_CHANNERL_ID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->l()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 48
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SOFT_OWNER:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->m()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 49
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SDK_VERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 51
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_DOUBLECARD:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->n()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 52
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_PHONENUM:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->o()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 53
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_SECOND_PHONUM:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->p()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 54
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IMEI:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->q()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 55
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IMSI:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->r()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 57
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_ISP:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->s()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 58
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_ANDROID_ID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->t()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 59
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IDFA:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->u()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_IP:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->w()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 61
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_NETWORKTYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->v()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    sget-object v2, Lcom/blm/sdk/constants/Constants;->AUTHREQ_OSVERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/b;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 63
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 67
    :goto_0
    return-object v0

    .line 64
    :catch_0
    move-exception v1

    .line 65
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/c;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 169
    const-string v0, ""

    .line 170
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 172
    :try_start_0
    sget-object v2, Lcom/blm/sdk/constants/Constants;->CHECKREQ_APPID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 173
    sget-object v2, Lcom/blm/sdk/constants/Constants;->CHECKREQ_OSTYPE:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/c;->d()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 174
    sget-object v2, Lcom/blm/sdk/constants/Constants;->CHECKREQ_SDKVERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/c;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 175
    sget-object v2, Lcom/blm/sdk/constants/Constants;->CHECKREQ_UUID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/c;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 176
    sget-object v2, Lcom/blm/sdk/constants/Constants;->CHECKREQ_VERSION:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/c;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 177
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 181
    :goto_0
    return-object v0

    .line 178
    :catch_0
    move-exception v1

    .line 179
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/d;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 152
    const-string v0, ""

    .line 153
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 155
    :try_start_0
    const-string v2, "errMsg"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/d;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 156
    const-string v2, "requestId"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/d;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 157
    const-string v2, "androidParam"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/d;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 158
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 162
    :goto_0
    return-object v0

    .line 159
    :catch_0
    move-exception v1

    .line 160
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/e;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 283
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 285
    :try_start_0
    const-string v0, "appId"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->k()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "appVersion"

    .line 286
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->l()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "model"

    .line 287
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->i()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "osType"

    .line 288
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->a()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "osVersion"

    .line 289
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "sdkVersion"

    .line 290
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->m()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "uuid"

    .line 291
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "vendor"

    .line 292
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->h()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "requestType"

    .line 293
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->s()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "imsi"

    .line 294
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "imei"

    .line 295
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "mac"

    .line 296
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "idfa"

    .line 297
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->f()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "androidId"

    .line 298
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->g()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "ip"

    .line 299
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->n()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "connectionType"

    .line 300
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->o()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "operatorType"

    .line 301
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->r()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "longitude"

    .line 302
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->p()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "latitude"

    .line 303
    invoke-virtual {p0}, Lcom/blm/sdk/a/b/e;->q()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->putOpt(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 308
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 304
    :catch_0
    move-exception v0

    .line 305
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/f;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 269
    const-string v0, ""

    .line 270
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 272
    :try_start_0
    sget-object v2, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_LASTID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/f;->a()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 273
    sget-object v2, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_NEXTID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/f;->b()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 274
    sget-object v2, Lcom/blm/sdk/constants/Constants;->GETNEXTSCPREQ_REQUESTID:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/f;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 275
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 279
    :goto_0
    return-object v0

    .line 276
    :catch_0
    move-exception v1

    .line 277
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Lcom/blm/sdk/a/b/h;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 74
    const-string v0, ""

    .line 75
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 77
    :try_start_0
    const-string v2, "requestId"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 78
    const-string v2, "userData"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 79
    const-string v2, "androidParam"

    invoke-virtual {p0}, Lcom/blm/sdk/a/b/h;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 80
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 84
    :goto_0
    return-object v0

    .line 81
    :catch_0
    move-exception v1

    .line 82
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static b(Ljava/lang/String;)Lcom/blm/sdk/a/c/b;
    .locals 4

    .prologue
    .line 248
    new-instance v0, Lcom/blm/sdk/a/c/b;

    invoke-direct {v0}, Lcom/blm/sdk/a/c/b;-><init>()V

    .line 250
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 253
    const-string v2, "requestId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 254
    const-string v3, "blmId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 255
    const-string v3, "blmId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 256
    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/c/b;->a(Ljava/lang/Integer;)V

    .line 258
    :cond_0
    invoke-virtual {v0, v2}, Lcom/blm/sdk/a/c/b;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 262
    :goto_0
    return-object v0

    .line 259
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static c(Ljava/lang/String;)Lcom/blm/sdk/a/c/c;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 312
    sget-object v1, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "json:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 313
    new-instance v1, Lcom/blm/sdk/a/c/c;

    invoke-direct {v1}, Lcom/blm/sdk/a/c/c;-><init>()V

    .line 316
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v2

    .line 322
    :goto_0
    if-nez v3, :cond_0

    .line 323
    sget-object v1, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    const-string v2, "json error"

    invoke-static {v1, v2}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 371
    :goto_1
    return-object v0

    .line 317
    :catch_0
    move-exception v2

    .line 318
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    .line 319
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    const-string v3, "json error"

    invoke-static {v2, v3}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    move-object v3, v0

    goto :goto_0

    .line 328
    :cond_0
    :try_start_1
    const-string v2, "result"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    .line 329
    invoke-virtual {v1, v2}, Lcom/blm/sdk/a/c/c;->a(I)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 336
    :goto_2
    :try_start_2
    const-string v2, "msg"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 337
    invoke-virtual {v1, v2}, Lcom/blm/sdk/a/c/c;->a(Ljava/lang/String;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    .line 343
    :goto_3
    :try_start_3
    const-string v2, "tasks"

    invoke-virtual {v3, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    .line 344
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 345
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_3

    .line 346
    const/4 v0, 0x0

    :goto_4
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v0, v4, :cond_2

    .line 347
    invoke-virtual {v3, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 348
    if-eqz v4, :cond_1

    .line 349
    new-instance v5, Lcom/blm/sdk/a/a/a;

    invoke-direct {v5}, Lcom/blm/sdk/a/a/a;-><init>()V

    .line 350
    const-string v6, "id"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    .line 351
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/blm/sdk/a/a/a;->a(Ljava/lang/Integer;)V

    .line 352
    const-string v6, "binUrl"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 353
    invoke-virtual {v5, v6}, Lcom/blm/sdk/a/a/a;->c(Ljava/lang/String;)V

    .line 354
    const-string v6, "md5"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 355
    invoke-virtual {v5, v6}, Lcom/blm/sdk/a/a/a;->d(Ljava/lang/String;)V

    .line 356
    const-string v6, "className"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 357
    invoke-virtual {v5, v6}, Lcom/blm/sdk/a/a/a;->a(Ljava/lang/String;)V

    .line 358
    const-string v6, "function"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 359
    invoke-virtual {v5, v4}, Lcom/blm/sdk/a/a/a;->b(Ljava/lang/String;)V

    .line 360
    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_3

    .line 346
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 330
    :catch_1
    move-exception v2

    .line 331
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    .line 332
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    const-string v4, "result"

    invoke-static {v2, v4}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 338
    :catch_2
    move-exception v2

    .line 339
    sget-object v2, Lcom/blm/sdk/d/f;->a:Ljava/lang/String;

    const-string v4, "msg"

    invoke-static {v2, v4}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_2
    move-object v0, v2

    .line 367
    :cond_3
    :try_start_4
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/c/c;->a(Ljava/util/List;)V
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_3

    :goto_5
    move-object v0, v1

    .line 371
    goto/16 :goto_1

    .line 368
    :catch_3
    move-exception v0

    goto :goto_5
.end method
