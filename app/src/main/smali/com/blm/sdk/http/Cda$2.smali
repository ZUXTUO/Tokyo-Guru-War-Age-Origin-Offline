.class final Lcom/blm/sdk/http/Cda$2;
.super Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/http/Cda;->hp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 181
    iput-object p1, p0, Lcom/blm/sdk/http/Cda$2;->a:Ljava/lang/String;

    invoke-direct {p0}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(ILjava/lang/Throwable;Ljava/lang/String;)V
    .locals 2
    .param p1, "statusCode"    # I
    .param p2, "error"    # Ljava/lang/Throwable;
    .param p3, "content"    # Ljava/lang/String;

    .prologue
    .line 201
    invoke-super {p0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onFailure(ILjava/lang/Throwable;Ljava/lang/String;)V

    .line 202
    const-string v0, "Cda"

    const-string v1, "httpPost onFailure"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 203
    invoke-static {}, Lcom/blm/sdk/http/Cda;->access$100()Ljava/util/concurrent/Executor;

    move-result-object v0

    new-instance v1, Lcom/blm/sdk/http/Cda$2$2;

    invoke-direct {v1, p0}, Lcom/blm/sdk/http/Cda$2$2;-><init>(Lcom/blm/sdk/http/Cda$2;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 209
    return-void
.end method

.method public onSuccess(ILjava/lang/String;)V
    .locals 3
    .param p1, "statusCode"    # I
    .param p2, "content"    # Ljava/lang/String;

    .prologue
    .line 185
    invoke-super {p0, p1, p2}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onSuccess(ILjava/lang/String;)V

    .line 186
    const-string v0, "Cda"

    const-string v1, "httpPost onSuccess"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 187
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "content:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/b;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 190
    invoke-static {}, Lcom/blm/sdk/http/Cda;->access$100()Ljava/util/concurrent/Executor;

    move-result-object v0

    new-instance v1, Lcom/blm/sdk/http/Cda$2$1;

    invoke-direct {v1, p0}, Lcom/blm/sdk/http/Cda$2$1;-><init>(Lcom/blm/sdk/http/Cda$2;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 196
    return-void
.end method
