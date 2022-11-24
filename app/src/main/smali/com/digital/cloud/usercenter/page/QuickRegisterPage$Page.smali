.class final enum Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;
.super Ljava/lang/Enum;
.source "QuickRegisterPage.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/page/QuickRegisterPage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "Page"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

.field public static final enum Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

.field public static final enum Null:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

.field public static final enum Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 54
    new-instance v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    const-string v1, "Telphone"

    invoke-direct {v0, v1, v2}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    new-instance v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    const-string v1, "Email"

    invoke-direct {v0, v1, v3}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    new-instance v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    const-string v1, "Null"

    invoke-direct {v0, v1, v4}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Null:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    .line 53
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    aput-object v1, v0, v2

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Email:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    aput-object v1, v0, v3

    sget-object v1, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->Null:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    aput-object v1, v0, v4

    sput-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    return-object v0
.end method

.method public static values()[Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    array-length v1, v0

    new-array v2, v1, [Lcom/digital/cloud/usercenter/page/QuickRegisterPage$Page;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
