.class final Lcom/blm/sdk/http/Cda$1;
.super Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/http/Cda;->ri(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILcom/blm/sdk/c/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/blm/sdk/c/a;

.field final synthetic b:I

.field final synthetic c:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/blm/sdk/c/a;ILjava/lang/String;)V
    .locals 0

    .prologue
    .line 128
    iput-object p1, p0, Lcom/blm/sdk/http/Cda$1;->a:Lcom/blm/sdk/c/a;

    iput p2, p0, Lcom/blm/sdk/http/Cda$1;->b:I

    iput-object p3, p0, Lcom/blm/sdk/http/Cda$1;->c:Ljava/lang/String;

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
    .line 155
    invoke-super {p0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onFailure(ILjava/lang/Throwable;Ljava/lang/String;)V

    .line 156
    const-string v0, "Cda"

    invoke-virtual {p2}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->c(Ljava/lang/String;Ljava/lang/Object;)V

    .line 157
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$1;->a:Lcom/blm/sdk/c/a;

    if-eqz v0, :cond_0

    .line 158
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$1;->a:Lcom/blm/sdk/c/a;

    invoke-interface {v0, p3, p1}, Lcom/blm/sdk/c/a;->b(Ljava/lang/String;I)V

    .line 161
    :cond_0
    iget v0, p0, Lcom/blm/sdk/http/Cda$1;->b:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 162
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$1;->c:Ljava/lang/String;

    const-string v1, "1"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    :cond_1
    return-void
.end method

.method public onSuccess(ILjava/lang/String;)V
    .locals 3
    .param p1, "statusCode"    # I
    .param p2, "content"    # Ljava/lang/String;

    .prologue
    .line 132
    invoke-super {p0, p1, p2}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onSuccess(ILjava/lang/String;)V

    .line 133
    const-string v0, "Cda"

    const-string v1, "onSuccess"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 134
    const-string v0, "Cda"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "statusCode:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 135
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

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 136
    const-string v0, ""

    .line 138
    :try_start_0
    invoke-static {p2}, Lcom/blm/sdk/d/d;->d(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 143
    :goto_0
    iget-object v1, p0, Lcom/blm/sdk/http/Cda$1;->a:Lcom/blm/sdk/c/a;

    if-eqz v1, :cond_0

    .line 144
    iget-object v1, p0, Lcom/blm/sdk/http/Cda$1;->a:Lcom/blm/sdk/c/a;

    invoke-interface {v1, v0, p1}, Lcom/blm/sdk/c/a;->a(Ljava/lang/String;I)V

    .line 147
    :cond_0
    iget v0, p0, Lcom/blm/sdk/http/Cda$1;->b:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 148
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$1;->c:Ljava/lang/String;

    const-string v1, "0"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    .line 150
    :cond_1
    return-void

    .line 139
    :catch_0
    move-exception v1

    .line 140
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
