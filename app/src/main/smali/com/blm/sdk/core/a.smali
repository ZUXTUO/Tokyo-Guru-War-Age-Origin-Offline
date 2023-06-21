.class public Lcom/blm/sdk/core/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static a:Lcom/blm/sdk/a/c/b;

.field static c:Landroid/os/Handler;

.field private static d:Ljava/lang/String;

.field private static e:Lcom/blm/sdk/connection/BlmLib;

.field private static f:Lcom/blm/sdk/a/c/d;


# instance fields
.field public b:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 33
    const-class v0, Lcom/blm/sdk/core/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    .line 35
    const/4 v0, 0x0

    sput-object v0, Lcom/blm/sdk/core/a;->a:Lcom/blm/sdk/a/c/b;

    .line 54
    new-instance v0, Lcom/blm/sdk/core/a$1;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/blm/sdk/core/a$1;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/blm/sdk/core/a;->c:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 30
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic a(I)V
    .locals 0

    .prologue
    .line 30
    invoke-static {p0}, Lcom/blm/sdk/core/a;->b(I)V

    return-void
.end method

.method public static a(Landroid/content/Context;Lcom/blm/sdk/a/c/b;)V
    .locals 2

    .prologue
    .line 108
    if-eqz p1, :cond_4

    .line 109
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/b;->a()Ljava/lang/String;

    move-result-object v0

    .line 110
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "null"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 111
    :cond_0
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "requestId==null || helloId==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 128
    :cond_1
    :goto_0
    return-void

    .line 113
    :cond_2
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 114
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/b;->b()Ljava/lang/Integer;

    move-result-object v0

    .line 115
    invoke-static {p0}, Lcom/blm/sdk/b/a;->a(Landroid/content/Context;)Lcom/blm/sdk/b/a;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/b/a;->b(I)Z

    move-result v0

    .line 116
    if-nez v0, :cond_3

    .line 117
    invoke-static {p0, p1}, Lcom/blm/sdk/core/a;->b(Landroid/content/Context;Lcom/blm/sdk/a/c/b;)V

    .line 118
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "pulled==false"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 121
    :cond_3
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "pulled==true"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 126
    :cond_4
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "idResp==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;Lcom/blm/sdk/a/c/d;)V
    .locals 4

    .prologue
    .line 160
    if-eqz p1, :cond_2

    .line 161
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/d;->b()Lcom/blm/sdk/a/b/g;

    move-result-object v0

    .line 162
    if-eqz v0, :cond_1

    .line 163
    sget-object v1, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v2, "HelloInfo!=null"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 165
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->a()Ljava/lang/String;

    move-result-object v1

    .line 166
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->d()Ljava/lang/String;

    move-result-object v2

    .line 167
    invoke-static {v2}, Lcom/blm/sdk/d/e;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 168
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 170
    sget-object v1, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v2, "md5=md5Val"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 172
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 173
    const-string v1, "LAST_DO_TIME"

    invoke-static {p0, v1, v2, v3}, Lcom/blm/sdk/d/h;->a(Landroid/content/Context;Ljava/lang/String;J)V

    .line 176
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->b()Ljava/lang/Integer;

    move-result-object v0

    .line 177
    invoke-static {p0}, Lcom/blm/sdk/b/a;->a(Landroid/content/Context;)Lcom/blm/sdk/b/a;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/b/a;->a(I)V

    .line 179
    invoke-static {p0, p1}, Lcom/blm/sdk/core/a;->b(Landroid/content/Context;Lcom/blm/sdk/a/c/d;)V

    .line 189
    :goto_0
    return-void

    .line 181
    :cond_0
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "md5!=md5Val"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 184
    :cond_1
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "HelloInfo==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 187
    :cond_2
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "GetHelloResp==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method static synthetic b()Lcom/blm/sdk/connection/BlmLib;
    .locals 1

    .prologue
    .line 30
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    return-object v0
.end method

.method private static b(I)V
    .locals 4

    .prologue
    const/4 v2, -0x1

    .line 227
    const-string v0, ""

    .line 228
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "start execute-1-"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 229
    sget-object v0, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    if-nez v0, :cond_1

    .line 230
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "start execute-2-"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 284
    :cond_0
    :goto_0
    return-void

    .line 233
    :cond_1
    if-eqz p0, :cond_2

    .line 235
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "execute Failure"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 236
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 237
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 239
    new-instance v1, Lcom/blm/sdk/a/b/d;

    invoke-direct {v1}, Lcom/blm/sdk/a/b/d;-><init>()V

    .line 240
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/d;->b(Ljava/lang/String;)V

    .line 241
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    invoke-virtual {v2}, Lcom/blm/sdk/a/c/d;->b()Lcom/blm/sdk/a/b/g;

    move-result-object v2

    invoke-virtual {v2}, Lcom/blm/sdk/a/b/g;->b()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/d;->c(Ljava/lang/String;)V

    .line 242
    sget-object v0, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    invoke-virtual {v0}, Lcom/blm/sdk/a/c/d;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/d;->a(Ljava/lang/String;)V

    .line 243
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    new-instance v2, Lcom/blm/sdk/core/a$5;

    invoke-direct {v2}, Lcom/blm/sdk/core/a$5;-><init>()V

    invoke-static {v0, v1, v2}, Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Lcom/blm/sdk/a/b/d;Lcom/blm/sdk/c/a;)V

    goto :goto_0

    .line 258
    :cond_2
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "execute Success"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 260
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 262
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0, v2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 265
    new-instance v1, Lcom/blm/sdk/a/b/h;

    invoke-direct {v1}, Lcom/blm/sdk/a/b/h;-><init>()V

    .line 266
    sget-object v2, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    invoke-virtual {v2}, Lcom/blm/sdk/a/c/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/blm/sdk/a/b/h;->a(Ljava/lang/String;)V

    .line 267
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    invoke-virtual {v3}, Lcom/blm/sdk/a/c/d;->b()Lcom/blm/sdk/a/b/g;

    move-result-object v3

    invoke-virtual {v3}, Lcom/blm/sdk/a/b/g;->b()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/blm/sdk/a/b/h;->c(Ljava/lang/String;)V

    .line 268
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/h;->b(Ljava/lang/String;)V

    .line 269
    sget-object v0, Lcom/yunva/im/sdk/lib/YvLoginInit;->context:Landroid/content/Context;

    new-instance v2, Lcom/blm/sdk/core/a$6;

    invoke-direct {v2}, Lcom/blm/sdk/core/a$6;-><init>()V

    invoke-static {v0, v1, v2}, Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Lcom/blm/sdk/a/b/h;Lcom/blm/sdk/c/a;)V

    goto/16 :goto_0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 82
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "\u8fdb\u5165pullIdFromServer"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 83
    new-instance v0, Lcom/blm/sdk/a/c/b;

    invoke-direct {v0}, Lcom/blm/sdk/a/c/b;-><init>()V

    .line 84
    new-instance v0, Lcom/blm/sdk/core/a$2;

    invoke-direct {v0, p0}, Lcom/blm/sdk/core/a$2;-><init>(Landroid/content/Context;)V

    invoke-static {p0, v0}, Lcom/blm/sdk/http/a;->b(Landroid/content/Context;Lcom/blm/sdk/c/a;)V

    .line 102
    return-void
.end method

.method public static b(Landroid/content/Context;Lcom/blm/sdk/a/c/b;)V
    .locals 2

    .prologue
    .line 136
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/b;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 137
    sget-object v0, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v1, "checkid-requestId==null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 154
    :goto_0
    return-void

    .line 140
    :cond_0
    new-instance v0, Lcom/blm/sdk/core/a$3;

    invoke-direct {v0, p0}, Lcom/blm/sdk/core/a$3;-><init>(Landroid/content/Context;)V

    invoke-static {p0, p1, v0}, Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Lcom/blm/sdk/a/c/b;Lcom/blm/sdk/c/a;)V

    goto :goto_0
.end method

.method public static b(Landroid/content/Context;Lcom/blm/sdk/a/c/d;)V
    .locals 3

    .prologue
    .line 197
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/d;->b()Lcom/blm/sdk/a/b/g;

    move-result-object v0

    .line 198
    sput-object p1, Lcom/blm/sdk/core/a;->f:Lcom/blm/sdk/a/c/d;

    .line 199
    sget-object v1, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    const-string v2, "start execute"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 200
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->d()Ljava/lang/String;

    move-result-object v1

    .line 201
    invoke-virtual {p1}, Lcom/blm/sdk/a/c/d;->a()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/blm/sdk/constants/Constants;->LAST_REQUEST_ID:Ljava/lang/String;

    .line 202
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->b()Ljava/lang/Integer;

    move-result-object v2

    sput-object v2, Lcom/blm/sdk/constants/Constants;->LAST_HELLO_ID:Ljava/lang/Integer;

    .line 203
    invoke-virtual {v0}, Lcom/blm/sdk/a/b/g;->c()Ljava/lang/String;

    move-result-object v0

    .line 206
    new-instance v2, Lcom/blm/sdk/core/a$4;

    invoke-direct {v2, v1, v0}, Lcom/blm/sdk/core/a$4;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 223
    invoke-virtual {v2}, Lcom/blm/sdk/core/a$4;->start()V

    .line 224
    return-void
.end method


# virtual methods
.method public a(Landroid/content/Context;)V
    .locals 6

    .prologue
    .line 39
    invoke-static {}, Lcom/blm/sdk/core/ConnectionDSL;->getInstance()Lcom/blm/sdk/core/ConnectionDSL;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/blm/sdk/core/ConnectionDSL;->init(Landroid/content/Context;)V

    .line 40
    invoke-static {}, Lcom/blm/sdk/connection/BlmStateFactory;->newBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    .line 41
    sget-object v0, Lcom/blm/sdk/core/a;->e:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->openLibs()V

    .line 43
    iput-object p1, p0, Lcom/blm/sdk/core/a;->b:Landroid/content/Context;

    .line 44
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 45
    const/16 v1, 0x2711

    iput v1, v0, Landroid/os/Message;->what:I

    .line 46
    iput-object p1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 47
    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    .line 48
    const/16 v2, 0xf

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    .line 50
    sget-object v2, Lcom/blm/sdk/core/a;->d:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mill:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 51
    sget-object v2, Lcom/blm/sdk/core/a;->c:Landroid/os/Handler;

    mul-int/lit16 v1, v1, 0x3e8

    int-to-long v4, v1

    invoke-virtual {v2, v0, v4, v5}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 52
    return-void
.end method
