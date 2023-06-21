.class Lcom/blm/sdk/async/http/RequestParams$StreamWrapper;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/async/http/RequestParams;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "StreamWrapper"
.end annotation


# instance fields
.field public contentType:Ljava/lang/String;

.field public inputStream:Ljava/io/InputStream;

.field public name:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "inputStream"    # Ljava/io/InputStream;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "contentType"    # Ljava/lang/String;

    .prologue
    .line 448
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 449
    iput-object p1, p0, Lcom/blm/sdk/async/http/RequestParams$StreamWrapper;->inputStream:Ljava/io/InputStream;

    .line 450
    iput-object p2, p0, Lcom/blm/sdk/async/http/RequestParams$StreamWrapper;->name:Ljava/lang/String;

    .line 451
    iput-object p3, p0, Lcom/blm/sdk/async/http/RequestParams$StreamWrapper;->contentType:Ljava/lang/String;

    .line 452
    return-void
.end method
