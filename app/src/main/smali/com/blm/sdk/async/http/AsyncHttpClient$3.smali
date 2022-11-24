.class Lcom/blm/sdk/async/http/AsyncHttpClient$3;
.super Lorg/apache/http/impl/client/DefaultRedirectHandler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/async/http/AsyncHttpClient;->setEnableRedirects(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/blm/sdk/async/http/AsyncHttpClient;

.field final synthetic val$enableRedirects:Z


# direct methods
.method constructor <init>(Lcom/blm/sdk/async/http/AsyncHttpClient;Z)V
    .locals 0
    .param p1, "this$0"    # Lcom/blm/sdk/async/http/AsyncHttpClient;

    .prologue
    .line 302
    iput-object p1, p0, Lcom/blm/sdk/async/http/AsyncHttpClient$3;->this$0:Lcom/blm/sdk/async/http/AsyncHttpClient;

    iput-boolean p2, p0, Lcom/blm/sdk/async/http/AsyncHttpClient$3;->val$enableRedirects:Z

    invoke-direct {p0}, Lorg/apache/http/impl/client/DefaultRedirectHandler;-><init>()V

    return-void
.end method


# virtual methods
.method public isRedirectRequested(Lorg/apache/http/HttpResponse;Lorg/apache/http/protocol/HttpContext;)Z
    .locals 1
    .param p1, "response"    # Lorg/apache/http/HttpResponse;
    .param p2, "context"    # Lorg/apache/http/protocol/HttpContext;

    .prologue
    .line 305
    iget-boolean v0, p0, Lcom/blm/sdk/async/http/AsyncHttpClient$3;->val$enableRedirects:Z

    return v0
.end method
