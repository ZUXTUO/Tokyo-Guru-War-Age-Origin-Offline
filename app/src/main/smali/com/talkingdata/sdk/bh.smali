.class public final enum Lcom/talkingdata/sdk/bh;
.super Ljava/lang/Enum;


# static fields
.field public static final enum a:Lcom/talkingdata/sdk/bh;

.field public static final enum b:Lcom/talkingdata/sdk/bh;

.field private static final synthetic d:[Lcom/talkingdata/sdk/bh;


# instance fields
.field private c:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const/4 v4, 0x1

    const/4 v3, 0x0

    new-instance v0, Lcom/talkingdata/sdk/bh;

    const-string v1, "WIFI"

    const-string v2, "wifi"

    invoke-direct {v0, v1, v3, v2}, Lcom/talkingdata/sdk/bh;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/talkingdata/sdk/bh;->a:Lcom/talkingdata/sdk/bh;

    new-instance v0, Lcom/talkingdata/sdk/bh;

    const-string v1, "CELLULAR"

    const-string v2, "cellular"

    invoke-direct {v0, v1, v4, v2}, Lcom/talkingdata/sdk/bh;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/talkingdata/sdk/bh;->b:Lcom/talkingdata/sdk/bh;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/talkingdata/sdk/bh;

    sget-object v1, Lcom/talkingdata/sdk/bh;->a:Lcom/talkingdata/sdk/bh;

    aput-object v1, v0, v3

    sget-object v1, Lcom/talkingdata/sdk/bh;->b:Lcom/talkingdata/sdk/bh;

    aput-object v1, v0, v4

    sput-object v0, Lcom/talkingdata/sdk/bh;->d:[Lcom/talkingdata/sdk/bh;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/talkingdata/sdk/bh;->c:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/talkingdata/sdk/bh;
    .locals 1

    const-class v0, Lcom/talkingdata/sdk/bh;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/bh;

    return-object v0
.end method

.method public static values()[Lcom/talkingdata/sdk/bh;
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/bh;->d:[Lcom/talkingdata/sdk/bh;

    invoke-virtual {v0}, [Lcom/talkingdata/sdk/bh;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/talkingdata/sdk/bh;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/bh;->c:Ljava/lang/String;

    return-object v0
.end method
