.class public Lcom/blm/sdk/http/Cda;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blm/sdk/http/Cda$a;
    }
.end annotation


# static fields
.field private static a:Ljava/util/concurrent/Executor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 49
    invoke-static {}, Ljava/util/concurrent/Executors;->newCachedThreadPool()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/http/Cda;->a:Ljava/util/concurrent/Executor;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 45
    invoke-static {p0, p1}, Lcom/blm/sdk/http/Cda;->saveCallback(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100()Ljava/util/concurrent/Executor;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/blm/sdk/http/Cda;->a:Ljava/util/concurrent/Executor;

    return-object v0
.end method

.method public static df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "callbackFilePath"    # Ljava/lang/String;
    .param p4, "flag"    # I
    .param p5, "md5"    # Ljava/lang/String;
    .param p6, "listener"    # Lcom/blm/sdk/down/DownloadListener;

    .prologue
    .line 328
    if-nez p0, :cond_0

    .line 329
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "context is null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 332
    :cond_0
    if-nez p2, :cond_2

    .line 333
    const-string v0, "Cda"

    const-string v1, "filePath is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 334
    if-eqz p6, :cond_1

    .line 335
    const/16 v0, 0x69

    const-string v1, "filePath is null"

    invoke-interface {p6, v0, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    .line 354
    :cond_1
    :goto_0
    return-void

    .line 341
    :cond_2
    const-string v0, "/"

    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 342
    const-string v0, "Cda"

    const-string v1, "filePath is error"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 343
    if-eqz p6, :cond_1

    .line 344
    const/16 v0, 0x6a

    const-string v1, "filePath is error"

    invoke-interface {p6, v0, v1}, Lcom/blm/sdk/down/DownloadListener;->onDownloadFail(ILjava/lang/String;)V

    goto :goto_0

    .line 350
    :cond_3
    const-string v0, "/"

    invoke-virtual {p2, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 351
    const/4 v1, 0x0

    invoke-virtual {p2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 352
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p2, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    move-object v0, p0

    move-object v1, p1

    move-object v4, p3

    move v5, p4

    move-object v6, p5

    move-object v7, p6

    .line 353
    invoke-static/range {v0 .. v7}, Lcom/blm/sdk/http/Cda;->df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V

    goto :goto_0
.end method

.method public static df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V
    .locals 11
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "path"    # Ljava/lang/String;
    .param p4, "callbackFilePath"    # Ljava/lang/String;
    .param p5, "threadCount"    # I
    .param p6, "flag"    # I
    .param p7, "md5"    # Ljava/lang/String;
    .param p8, "listener"    # Lcom/blm/sdk/down/DownloadListener;

    .prologue
    .line 388
    sget-object v10, Lcom/blm/sdk/http/Cda;->a:Ljava/util/concurrent/Executor;

    new-instance v0, Lcom/blm/sdk/http/Cda$a;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move-object/from16 v8, p7

    move-object/from16 v9, p8

    invoke-direct/range {v0 .. v9}, Lcom/blm/sdk/http/Cda$a;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V

    invoke-interface {v10, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 389
    return-void
.end method

.method public static df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "path"    # Ljava/lang/String;
    .param p4, "callbackFilePath"    # Ljava/lang/String;
    .param p5, "flag"    # I
    .param p6, "md5"    # Ljava/lang/String;
    .param p7, "listener"    # Lcom/blm/sdk/down/DownloadListener;

    .prologue
    .line 367
    if-nez p0, :cond_0

    .line 368
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "context is null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 370
    :cond_0
    const/4 v5, 0x4

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v6, p5

    move-object v7, p6

    move-object/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blm/sdk/http/Cda;->df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V

    .line 371
    return-void
.end method

.method public static df(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V
    .locals 7
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "callbackFilePath"    # Ljava/lang/String;
    .param p3, "flag"    # I
    .param p4, "md5"    # Ljava/lang/String;
    .param p5, "listener"    # Lcom/blm/sdk/down/DownloadListener;

    .prologue
    .line 315
    sget-object v0, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-static/range {v0 .. v6}, Lcom/blm/sdk/http/Cda;->df(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/blm/sdk/down/DownloadListener;)V

    .line 316
    return-void
.end method

.method public static hdt(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    .line 288
    if-nez p0, :cond_0

    .line 289
    const-string v0, "Cda"

    const-string v1, "str is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 290
    const/4 v0, 0x0

    .line 302
    :goto_0
    return-object v0

    .line 293
    :cond_0
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "str:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 294
    const-string v0, ""

    .line 296
    :try_start_0
    invoke-static {p0}, Lcom/blm/sdk/d/d;->d(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 297
    :catch_0
    move-exception v1

    .line 298
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 299
    const-string v1, "Cda"

    const-string v2, "Decrypt Error"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static het(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "json"    # Ljava/lang/String;

    .prologue
    .line 265
    if-nez p0, :cond_0

    .line 266
    const-string v0, "Cda"

    const-string v1, "json is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 267
    const/4 v0, 0x0

    .line 278
    :goto_0
    return-object v0

    .line 270
    :cond_0
    const-string v0, ""

    .line 272
    :try_start_0
    invoke-static {p0}, Lcom/blm/sdk/d/d;->c(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 273
    :catch_0
    move-exception v1

    .line 274
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 275
    const-string v1, "Cda"

    const-string v2, "Encrypt Error"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static hp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "json"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 224
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    :cond_0
    move-object v0, v1

    .line 245
    :cond_1
    :goto_0
    return-object v0

    .line 227
    :cond_2
    sget-object v0, Landroid/util/Patterns;->WEB_URL:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-nez v0, :cond_3

    move-object v0, v1

    .line 228
    goto :goto_0

    .line 230
    :cond_3
    invoke-static {}, Lcom/blm/sdk/http/a;->a()Lcom/blm/sdk/async/http/AsyncHttpClient;

    move-result-object v0

    .line 232
    :try_start_0
    invoke-virtual {v0}, Lcom/blm/sdk/async/http/AsyncHttpClient;->getHttpClient()Lorg/apache/http/client/HttpClient;

    move-result-object v0

    .line 233
    new-instance v2, Lorg/apache/http/client/methods/HttpPost;

    invoke-direct {v2, p1}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    .line 234
    new-instance v3, Lorg/apache/http/entity/StringEntity;

    const-string v4, "UTF-8"

    invoke-direct {v3, p2, v4}, Lorg/apache/http/entity/StringEntity;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 235
    invoke-virtual {v2, v3}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    .line 236
    invoke-interface {v0, v2}, Lorg/apache/http/client/HttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v2

    .line 237
    const-string v0, ""

    .line 238
    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v3

    invoke-interface {v3}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v3

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_1

    .line 239
    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-static {v0}, Lcom/blm/sdk/http/Cda;->inputStream2String(Ljava/io/InputStream;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 242
    :catch_0
    move-exception v0

    .line 243
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    move-object v0, v1

    .line 245
    goto :goto_0
.end method

.method public static hp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "json"    # Ljava/lang/String;
    .param p2, "callbackFilePath"    # Ljava/lang/String;

    .prologue
    .line 178
    invoke-static {}, Lcom/blm/sdk/http/a;->a()Lcom/blm/sdk/async/http/AsyncHttpClient;

    move-result-object v0

    .line 180
    :try_start_0
    new-instance v3, Lorg/apache/http/entity/StringEntity;

    const-string v1, "utf-8"

    invoke-direct {v3, p1, v1}, Lorg/apache/http/entity/StringEntity;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    sget-object v1, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    const-string v4, "application/json"

    new-instance v5, Lcom/blm/sdk/http/Cda$2;

    invoke-direct {v5, p2}, Lcom/blm/sdk/http/Cda$2;-><init>(Ljava/lang/String;)V

    move-object v2, p0

    invoke-virtual/range {v0 .. v5}, Lcom/blm/sdk/async/http/AsyncHttpClient;->post(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 214
    :goto_0
    return-void

    .line 211
    :catch_0
    move-exception v0

    .line 212
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0
.end method

.method public static inputStream2String(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 5
    .param p0, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 249
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 250
    const/16 v1, 0x400

    new-array v1, v1, [B

    .line 251
    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    .line 252
    new-instance v3, Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v3, v1, v4, v2}, Ljava/lang/String;-><init>([BII)V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 254
    :cond_0
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 255
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static lj(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 10
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "jarPath"    # Ljava/lang/String;
    .param p2, "outPath"    # Ljava/lang/String;
    .param p3, "className"    # Ljava/lang/String;
    .param p4, "methodName"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x4

    const/4 v1, 0x2

    const/4 v0, 0x1

    const/4 v3, 0x0

    .line 643
    if-nez p0, :cond_1

    .line 644
    const/4 v0, 0x7

    .line 731
    :cond_0
    :goto_0
    return v0

    .line 647
    :cond_1
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 648
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_2

    .line 649
    const/16 v0, 0x8

    goto :goto_0

    .line 652
    :cond_2
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 654
    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_3

    .line 655
    invoke-virtual {v5}, Ljava/io/File;->mkdirs()Z

    .line 659
    :cond_3
    invoke-virtual {v5}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v4

    if-eqz v4, :cond_5

    .line 660
    invoke-virtual {v5}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v6

    array-length v7, v6

    move v4, v3

    :goto_1
    if-ge v4, v7, :cond_5

    aget-object v8, v6, v4

    .line 661
    invoke-virtual {v8}, Ljava/io/File;->isFile()Z

    move-result v9

    if-eqz v9, :cond_4

    .line 662
    invoke-virtual {v8}, Ljava/io/File;->delete()Z

    .line 660
    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 674
    :cond_5
    new-instance v4, Ldalvik/system/DexClassLoader;

    const/4 v6, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v7

    invoke-direct {v4, p1, p2, v6, v7}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 677
    :try_start_0
    invoke-virtual {v4, p3}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    .line 678
    if-eqz v4, :cond_0

    .line 682
    invoke-virtual {v4}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v6

    .line 684
    if-nez v6, :cond_6

    move v0, v1

    .line 685
    goto :goto_0

    .line 688
    :cond_6
    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Class;

    const/4 v8, 0x0

    const-class v9, Landroid/content/Context;

    aput-object v9, v7, v8

    invoke-virtual {v4, p4, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 690
    if-nez v4, :cond_7

    move v0, v2

    .line 691
    goto :goto_0

    .line 694
    :cond_7
    const/4 v7, 0x1

    invoke-virtual {v4, v7}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 695
    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object p0, v7, v8

    invoke-virtual {v4, v6, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5

    .line 718
    invoke-virtual {v5}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_9

    .line 719
    invoke-virtual {v5}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    array-length v2, v1

    move v0, v3

    :goto_2
    if-ge v0, v2, :cond_9

    aget-object v4, v1, v0

    .line 720
    invoke-virtual {v4}, Ljava/io/File;->isFile()Z

    move-result v5

    if-eqz v5, :cond_8

    .line 721
    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    .line 719
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 697
    :catch_0
    move-exception v1

    .line 698
    invoke-virtual {v1}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto/16 :goto_0

    .line 701
    :catch_1
    move-exception v0

    .line 702
    invoke-virtual {v0}, Ljava/lang/InstantiationException;->printStackTrace()V

    move v0, v1

    .line 703
    goto/16 :goto_0

    .line 704
    :catch_2
    move-exception v0

    .line 705
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 706
    const/4 v0, 0x3

    goto/16 :goto_0

    .line 707
    :catch_3
    move-exception v0

    .line 708
    invoke-virtual {v0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    move v0, v2

    .line 709
    goto/16 :goto_0

    .line 710
    :catch_4
    move-exception v0

    .line 711
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 712
    const/4 v0, 0x5

    goto/16 :goto_0

    .line 713
    :catch_5
    move-exception v0

    .line 714
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    .line 715
    const/4 v0, 0x6

    goto/16 :goto_0

    .line 726
    :cond_9
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 727
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_a

    .line 728
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_a
    move v0, v3

    .line 731
    goto/16 :goto_0
.end method

.method public static ri(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILcom/blm/sdk/c/a;)V
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "callbackFilePath"    # Ljava/lang/String;
    .param p3, "flag"    # I
    .param p4, "listener"    # Lcom/blm/sdk/c/a;

    .prologue
    .line 66
    if-nez p0, :cond_0

    .line 67
    const-string v0, "Cda"

    const-string v1, "context is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->c(Ljava/lang/String;Ljava/lang/Object;)V

    .line 169
    :goto_0
    return-void

    .line 71
    :cond_0
    if-nez p1, :cond_1

    .line 72
    const-string v0, "Cda"

    const-string v1, "url is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->c(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 76
    :cond_1
    sget-object v0, Landroid/util/Patterns;->WEB_URL:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-nez v0, :cond_2

    .line 77
    const-string v0, "Cda"

    const-string v1, "url is error"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->c(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 81
    :cond_2
    if-nez p2, :cond_3

    .line 82
    const-string v0, "Cda"

    const-string v1, "call back file path is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 86
    :cond_3
    new-instance v1, Lcom/blm/sdk/a/b/e;

    invoke-direct {v1}, Lcom/blm/sdk/a/b/e;-><init>()V

    .line 87
    invoke-static {p0}, Lcom/blm/sdk/d/i;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->a(Ljava/lang/String;)V

    .line 89
    invoke-static {p0}, Lcom/blm/sdk/d/g;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 90
    if-nez v0, :cond_4

    const-string v0, ""

    :cond_4
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->b(Ljava/lang/String;)V

    .line 92
    invoke-static {p0}, Lcom/blm/sdk/d/g;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 93
    if-nez v0, :cond_5

    const-string v0, ""

    :cond_5
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->c(Ljava/lang/String;)V

    .line 95
    invoke-static {p0}, Lcom/blm/sdk/d/g;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 96
    if-nez v0, :cond_6

    const-string v0, ""

    :cond_6
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->d(Ljava/lang/String;)V

    .line 98
    const-string v0, ""

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->e(Ljava/lang/String;)V

    .line 99
    invoke-static {p0}, Lcom/blm/sdk/d/g;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 100
    if-nez v0, :cond_7

    const-string v0, ""

    :cond_7
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->f(Ljava/lang/String;)V

    .line 102
    invoke-static {}, Lcom/blm/sdk/d/g;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->g(Ljava/lang/String;)V

    .line 103
    invoke-static {}, Lcom/blm/sdk/d/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->h(Ljava/lang/String;)V

    .line 104
    invoke-static {}, Lcom/blm/sdk/d/g;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->i(Ljava/lang/String;)V

    .line 105
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->a(Ljava/lang/Integer;)V

    .line 106
    sget-object v0, Lcom/blm/sdk/constants/Constants;->APP_ID:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->j(Ljava/lang/String;)V

    .line 107
    invoke-static {p0}, Lcom/blm/sdk/d/g;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 108
    if-nez v0, :cond_8

    const-string v0, ""

    :cond_8
    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->k(Ljava/lang/String;)V

    .line 109
    const-string v0, "1.0.3"

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->l(Ljava/lang/String;)V

    .line 110
    invoke-static {p0}, Lcom/blm/sdk/d/g;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->m(Ljava/lang/String;)V

    .line 111
    invoke-static {p0}, Lcom/blm/sdk/d/g;->i(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->n(Ljava/lang/String;)V

    .line 112
    invoke-static {p0}, Lcom/blm/sdk/d/g;->j(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->q(Ljava/lang/String;)V

    .line 113
    invoke-static {p0}, Lcom/blm/sdk/d/g;->k(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->o(Ljava/lang/String;)V

    .line 114
    invoke-static {p0}, Lcom/blm/sdk/d/g;->l(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->p(Ljava/lang/String;)V

    .line 115
    const-string v0, "jar"

    invoke-virtual {v1, v0}, Lcom/blm/sdk/a/b/e;->r(Ljava/lang/String;)V

    .line 117
    invoke-static {v1}, Lcom/blm/sdk/d/f;->a(Lcom/blm/sdk/a/b/e;)Ljava/lang/String;

    move-result-object v1

    .line 119
    const-string v0, "Cda"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GetBinReq-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 120
    invoke-static {}, Lcom/blm/sdk/http/a;->a()Lcom/blm/sdk/async/http/AsyncHttpClient;

    move-result-object v0

    .line 123
    :try_start_0
    invoke-static {v1}, Lcom/blm/sdk/d/d;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 124
    const-string v2, "Cda"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GetBinReq-encrypt-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 126
    new-instance v3, Lorg/apache/http/entity/StringEntity;

    const-string v2, "utf-8"

    invoke-direct {v3, v1, v2}, Lorg/apache/http/entity/StringEntity;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 127
    const-string v1, "Cda"

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 128
    const-string v4, "application/json"

    new-instance v5, Lcom/blm/sdk/http/Cda$1;

    invoke-direct {v5, p4, p3, p2}, Lcom/blm/sdk/http/Cda$1;-><init>(Lcom/blm/sdk/c/a;ILjava/lang/String;)V

    move-object v1, p0

    move-object v2, p1

    invoke-virtual/range {v0 .. v5}, Lcom/blm/sdk/async/http/AsyncHttpClient;->post(Landroid/content/Context;Ljava/lang/String;Lorg/apache/http/HttpEntity;Ljava/lang/String;Lcom/blm/sdk/async/http/ResponseHandlerInterface;)Lcom/blm/sdk/async/http/RequestHandle;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 166
    :catch_0
    move-exception v0

    goto/16 :goto_0
.end method

.method public static ri(Ljava/lang/String;Ljava/lang/String;ILcom/blm/sdk/c/a;)V
    .locals 1
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "callbackFilePath"    # Ljava/lang/String;
    .param p2, "flag"    # I
    .param p3, "listener"    # Lcom/blm/sdk/c/a;

    .prologue
    .line 59
    sget-object v0, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    invoke-static {v0, p0, p1, p2, p3}, Lcom/blm/sdk/http/Cda;->ri(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILcom/blm/sdk/c/a;)V

    .line 60
    return-void
.end method

.method private static saveCallback(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p0, "callbackFilePath"    # Ljava/lang/String;
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    .line 735
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file path:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 736
    if-nez p0, :cond_0

    .line 737
    const-string v0, "Cda"

    const-string v1, "callback file path is null"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    .line 799
    :goto_0
    return-void

    .line 741
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 742
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 743
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    .line 744
    if-nez v1, :cond_1

    .line 745
    const-string v1, "Cda"

    const-string v2, "can\'t delete"

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 754
    :cond_1
    const-string v1, "Cda"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "file is exists:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 756
    const-string v1, "Cda"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "is dir:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 759
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x0

    invoke-direct {v2, v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1

    .line 766
    if-eqz v2, :cond_3

    .line 767
    const/4 v1, 0x0

    .line 769
    :try_start_1
    const-string v0, "UTF-8"

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v0

    .line 774
    :goto_1
    if-nez v0, :cond_2

    .line 776
    :try_start_2
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 777
    :catch_0
    move-exception v0

    .line 778
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 760
    :catch_1
    move-exception v0

    .line 761
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 762
    const-string v0, "Cda"

    const-string v1, "callback file path not found"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->d(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 770
    :catch_2
    move-exception v0

    .line 771
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    move-object v0, v1

    goto :goto_1

    .line 785
    :cond_2
    :try_start_3
    invoke-virtual {v2, v0}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 790
    :try_start_4
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 797
    :cond_3
    :goto_2
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 798
    const-string v1, "Cda"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "file is exists:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 791
    :catch_3
    move-exception v0

    .line 792
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 786
    :catch_4
    move-exception v0

    .line 787
    :try_start_5
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 790
    :try_start_6
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_5

    goto :goto_2

    .line 791
    :catch_5
    move-exception v0

    .line 792
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 789
    :catchall_0
    move-exception v0

    .line 790
    :try_start_7
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_6

    .line 793
    :goto_3
    throw v0

    .line 791
    :catch_6
    move-exception v1

    .line 792
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3
.end method
