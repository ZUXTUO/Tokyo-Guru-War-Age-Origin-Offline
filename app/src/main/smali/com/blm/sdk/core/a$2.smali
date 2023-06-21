.class final Lcom/blm/sdk/core/a$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/blm/sdk/c/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/a;->b(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 84
    iput-object p1, p0, Lcom/blm/sdk/core/a$2;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;I)V
    .locals 2

    .prologue
    .line 88
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 89
    invoke-static {p1}, Lcom/blm/sdk/d/f;->b(Ljava/lang/String;)Lcom/blm/sdk/a/c/b;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/a;->a:Lcom/blm/sdk/a/c/b;

    .line 91
    iget-object v0, p0, Lcom/blm/sdk/core/a$2;->a:Landroid/content/Context;

    sget-object v1, Lcom/blm/sdk/core/a;->a:Lcom/blm/sdk/a/c/b;

    invoke-static {v0, v1}, Lcom/blm/sdk/core/a;->a(Landroid/content/Context;Lcom/blm/sdk/a/c/b;)V

    .line 93
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;I)V
    .locals 1

    .prologue
    .line 98
    const/4 v0, 0x0

    sput-object v0, Lcom/blm/sdk/core/a;->a:Lcom/blm/sdk/a/c/b;

    .line 99
    return-void
.end method
