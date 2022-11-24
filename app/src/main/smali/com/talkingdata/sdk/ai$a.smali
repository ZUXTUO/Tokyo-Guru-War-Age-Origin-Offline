.class public final enum Lcom/talkingdata/sdk/ai$a;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/talkingdata/sdk/ai;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation


# static fields
.field public static final enum a:Lcom/talkingdata/sdk/ai$a;

.field public static final enum b:Lcom/talkingdata/sdk/ai$a;

.field public static final enum c:Lcom/talkingdata/sdk/ai$a;

.field public static final enum d:Lcom/talkingdata/sdk/ai$a;

.field private static final synthetic e:[Lcom/talkingdata/sdk/ai$a;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    new-instance v0, Lcom/talkingdata/sdk/ai$a;

    const-string v1, "DOMOB"

    invoke-direct {v0, v1, v2}, Lcom/talkingdata/sdk/ai$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/talkingdata/sdk/ai$a;->a:Lcom/talkingdata/sdk/ai$a;

    new-instance v0, Lcom/talkingdata/sdk/ai$a;

    const-string v1, "LIMEI"

    invoke-direct {v0, v1, v3}, Lcom/talkingdata/sdk/ai$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/talkingdata/sdk/ai$a;->b:Lcom/talkingdata/sdk/ai$a;

    new-instance v0, Lcom/talkingdata/sdk/ai$a;

    const-string v1, "YOUMI"

    invoke-direct {v0, v1, v4}, Lcom/talkingdata/sdk/ai$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/talkingdata/sdk/ai$a;->c:Lcom/talkingdata/sdk/ai$a;

    new-instance v0, Lcom/talkingdata/sdk/ai$a;

    const-string v1, "DIANRU"

    invoke-direct {v0, v1, v5}, Lcom/talkingdata/sdk/ai$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/talkingdata/sdk/ai$a;->d:Lcom/talkingdata/sdk/ai$a;

    const/4 v0, 0x4

    new-array v0, v0, [Lcom/talkingdata/sdk/ai$a;

    sget-object v1, Lcom/talkingdata/sdk/ai$a;->a:Lcom/talkingdata/sdk/ai$a;

    aput-object v1, v0, v2

    sget-object v1, Lcom/talkingdata/sdk/ai$a;->b:Lcom/talkingdata/sdk/ai$a;

    aput-object v1, v0, v3

    sget-object v1, Lcom/talkingdata/sdk/ai$a;->c:Lcom/talkingdata/sdk/ai$a;

    aput-object v1, v0, v4

    sget-object v1, Lcom/talkingdata/sdk/ai$a;->d:Lcom/talkingdata/sdk/ai$a;

    aput-object v1, v0, v5

    sput-object v0, Lcom/talkingdata/sdk/ai$a;->e:[Lcom/talkingdata/sdk/ai$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/talkingdata/sdk/ai$a;
    .locals 1

    const-class v0, Lcom/talkingdata/sdk/ai$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/ai$a;

    return-object v0
.end method

.method public static values()[Lcom/talkingdata/sdk/ai$a;
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/ai$a;->e:[Lcom/talkingdata/sdk/ai$a;

    invoke-virtual {v0}, [Lcom/talkingdata/sdk/ai$a;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/talkingdata/sdk/ai$a;

    return-object v0
.end method
