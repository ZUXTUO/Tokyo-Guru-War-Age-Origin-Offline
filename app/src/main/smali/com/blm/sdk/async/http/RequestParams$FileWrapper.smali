.class Lcom/blm/sdk/async/http/RequestParams$FileWrapper;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/async/http/RequestParams;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileWrapper"
.end annotation


# instance fields
.field public contentType:Ljava/lang/String;

.field public file:Ljava/io/File;


# direct methods
.method public constructor <init>(Ljava/io/File;Ljava/lang/String;)V
    .locals 0
    .param p1, "file"    # Ljava/io/File;
    .param p2, "contentType"    # Ljava/lang/String;

    .prologue
    .line 437
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 438
    iput-object p1, p0, Lcom/blm/sdk/async/http/RequestParams$FileWrapper;->file:Ljava/io/File;

    .line 439
    iput-object p2, p0, Lcom/blm/sdk/async/http/RequestParams$FileWrapper;->contentType:Ljava/lang/String;

    .line 440
    return-void
.end method
