.class Lcom/blm/sdk/async/http/AsyncHttpResponseHandler$ResponderHandler;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "ResponderHandler"
.end annotation


# instance fields
.field private final mResponder:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;)V
    .locals 1
    .param p1, "service"    # Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;

    .prologue
    .line 126
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 127
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler$ResponderHandler;->mResponder:Ljava/lang/ref/WeakReference;

    .line 128
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 132
    iget-object v0, p0, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler$ResponderHandler;->mResponder:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;

    .line 133
    if-eqz v0, :cond_0

    .line 134
    invoke-virtual {v0, p1}, Lcom/blm/sdk/async/http/AsyncHttpResponseHandler;->handleMessage(Landroid/os/Message;)V

    .line 136
    :cond_0
    return-void
.end method
