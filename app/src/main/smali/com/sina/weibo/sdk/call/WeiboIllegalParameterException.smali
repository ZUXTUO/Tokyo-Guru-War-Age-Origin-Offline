.class Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;
.super Ljava/lang/RuntimeException;
.source "WeiboIllegalParameterException.java"


# static fields
.field private static final serialVersionUID:J = 0x6e8bfdf5c8b4cbd3L


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 37
    invoke-direct {p0}, Ljava/lang/RuntimeException;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 45
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 46
    return-void
.end method
