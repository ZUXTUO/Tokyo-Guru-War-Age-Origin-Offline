.class public Lcom/talkingdata/sdk/util/TDLog;
.super Ljava/lang/Object;


# static fields
.field public static a:Ljava/lang/String;

.field public static b:Z

.field public static final c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "TDLOG"

    sput-object v0, Lcom/talkingdata/sdk/util/TDLog;->a:Ljava/lang/String;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/talkingdata/sdk/util/TDLog;->b:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static d(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/util/TDLog;->a:Ljava/lang/String;

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static e(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/talkingdata/sdk/util/TDLog;->b:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/talkingdata/sdk/util/TDLog;->a:Ljava/lang/String;

    invoke-static {v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public static i(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/talkingdata/sdk/util/TDLog;->b:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/talkingdata/sdk/util/TDLog;->a:Ljava/lang/String;

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method
