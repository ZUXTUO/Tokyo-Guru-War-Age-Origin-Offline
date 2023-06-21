.class public Lcom/blm/sdk/core/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/lang/String;

.field private static b:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const-class v0, Lcom/blm/sdk/core/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/core/b;->a:Ljava/lang/String;

    .line 41
    new-instance v0, Lcom/blm/sdk/core/b$1;

    invoke-direct {v0}, Lcom/blm/sdk/core/b$1;-><init>()V

    sput-object v0, Lcom/blm/sdk/core/b;->b:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 18
    sget-object v0, Lcom/blm/sdk/core/b;->b:Landroid/os/Handler;

    return-object v0
.end method

.method public static a(ILandroid/content/Context;Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 4

    .prologue
    .line 27
    new-instance v0, Lcom/blm/sdk/a/b/f;

    invoke-direct {v0}, Lcom/blm/sdk/a/b/f;-><init>()V

    .line 28
    invoke-virtual {v0, p3}, Lcom/blm/sdk/a/b/f;->a(Ljava/lang/Integer;)V

    .line 29
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blm/sdk/a/b/f;->b(Ljava/lang/Integer;)V

    .line 30
    invoke-virtual {v0, p2}, Lcom/blm/sdk/a/b/f;->a(Ljava/lang/String;)V

    .line 32
    new-instance v1, Landroid/os/Message;

    invoke-direct {v1}, Landroid/os/Message;-><init>()V

    .line 33
    iput-object v0, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 34
    const/16 v0, 0x2712

    iput v0, v1, Landroid/os/Message;->what:I

    .line 36
    sget-object v0, Lcom/blm/sdk/core/b;->b:Landroid/os/Handler;

    const-wide/16 v2, 0x3a98

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 37
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 112
    sget-object v0, Lcom/blm/sdk/constants/Constants;->GLOABLE_CONTEXT:Landroid/content/Context;

    .line 113
    if-nez v0, :cond_0

    .line 143
    :goto_0
    return-void

    .line 121
    :cond_0
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/blm/sdk/core/b$2;

    invoke-direct {v2, v0, p0, p1, p2}, Lcom/blm/sdk/core/b$2;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 142
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method
