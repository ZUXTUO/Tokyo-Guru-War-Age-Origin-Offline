.class Lcom/blm/sdk/http/Cda$2$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/http/Cda$2;->onSuccess(ILjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/blm/sdk/http/Cda$2;


# direct methods
.method constructor <init>(Lcom/blm/sdk/http/Cda$2;)V
    .locals 0

    .prologue
    .line 190
    iput-object p1, p0, Lcom/blm/sdk/http/Cda$2$1;->a:Lcom/blm/sdk/http/Cda$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 193
    iget-object v0, p0, Lcom/blm/sdk/http/Cda$2$1;->a:Lcom/blm/sdk/http/Cda$2;

    iget-object v0, v0, Lcom/blm/sdk/http/Cda$2;->a:Ljava/lang/String;

    const-string v1, "0"

    invoke-static {v0, v1}, Lcom/blm/sdk/http/Cda;->access$000(Ljava/lang/String;Ljava/lang/String;)V

    .line 194
    return-void
.end method
