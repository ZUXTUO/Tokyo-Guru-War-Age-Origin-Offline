.class final Lcom/blm/sdk/http/a$1;
.super Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/http/a;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/blm/sdk/c/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/blm/sdk/c/a;


# direct methods
.method constructor <init>(Lcom/blm/sdk/c/a;)V
    .locals 0

    .prologue
    .line 65
    iput-object p1, p0, Lcom/blm/sdk/http/a$1;->a:Lcom/blm/sdk/c/a;

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
    .line 85
    invoke-super {p0, p1, p2, p3}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onFailure(ILjava/lang/Throwable;Ljava/lang/String;)V

    .line 86
    invoke-static {}, Lcom/blm/sdk/http/a;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->c(Ljava/lang/String;Ljava/lang/Object;)V

    .line 88
    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/http/a$1;->a:Lcom/blm/sdk/c/a;

    if-eqz v0, :cond_0

    .line 91
    iget-object v0, p0, Lcom/blm/sdk/http/a$1;->a:Lcom/blm/sdk/c/a;

    invoke-interface {v0, p3, p1}, Lcom/blm/sdk/c/a;->b(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 96
    :cond_0
    :goto_0
    return-void

    .line 93
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onSuccess(ILjava/lang/String;)V
    .locals 2
    .param p1, "statusCode"    # I
    .param p2, "content"    # Ljava/lang/String;

    .prologue
    .line 69
    invoke-super {p0, p1, p2}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->onSuccess(ILjava/lang/String;)V

    .line 70
    invoke-static {}, Lcom/blm/sdk/http/a;->b()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onSuccess"

    invoke-static {v0, v1}, Lcom/blm/sdk/d/j;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 72
    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/http/a$1;->a:Lcom/blm/sdk/c/a;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/blm/sdk/http/a$1;->a:Lcom/blm/sdk/c/a;

    invoke-static {p2}, Lcom/blm/sdk/d/d;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Lcom/blm/sdk/c/a;->a(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 80
    :cond_0
    :goto_0
    return-void

    .line 77
    :catch_0
    move-exception v0

    goto :goto_0
.end method
