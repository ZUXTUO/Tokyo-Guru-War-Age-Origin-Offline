.class final Lcom/blm/sdk/core/a$3;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/blm/sdk/c/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blm/sdk/core/a;->b(Landroid/content/Context;Lcom/blm/sdk/a/c/b;)V
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
    .line 140
    iput-object p1, p0, Lcom/blm/sdk/core/a$3;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;I)V
    .locals 2

    .prologue
    .line 144
    invoke-static {p1}, Lcom/blm/sdk/d/f;->a(Ljava/lang/String;)Lcom/blm/sdk/a/c/d;

    move-result-object v0

    .line 146
    iget-object v1, p0, Lcom/blm/sdk/core/a$3;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/blm/sdk/core/a;->a(Landroid/content/Context;Lcom/blm/sdk/a/c/d;)V

    .line 147
    return-void
.end method

.method public b(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 152
    return-void
.end method
