.class public final enum Lcom/digital/cloud/usercenter/page/PageManager$PageType;
.super Ljava/lang/Enum;
.source "PageManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/page/PageManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "PageType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/digital/cloud/usercenter/page/PageManager$PageType;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

.field public static final enum AutoLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

.field private static final synthetic ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/PageManager$PageType;

.field public static final enum FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

.field public static final enum QuickRegisterPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

.field public static final enum ResetPasswordPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 27
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    const-string v1, "AutoLoginPage"

    invoke-direct {v0, v1, v2}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AutoLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .line 28
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    const-string v1, "FirstLoginPage"

    invoke-direct {v0, v1, v3}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .line 29
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    const-string v1, "AccountLoginPage"

    invoke-direct {v0, v1, v4}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .line 30
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    const-string v1, "QuickRegisterPage"

    invoke-direct {v0, v1, v5}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->QuickRegisterPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .line 31
    new-instance v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    const-string v1, "ResetPasswordPage"

    invoke-direct {v0, v1, v6}, Lcom/digital/cloud/usercenter/page/PageManager$PageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ResetPasswordPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    .line 26
    const/4 v0, 0x5

    new-array v0, v0, [Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AutoLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    aput-object v1, v0, v4

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->QuickRegisterPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    aput-object v1, v0, v5

    sget-object v1, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ResetPasswordPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    aput-object v1, v0, v6

    sput-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/digital/cloud/usercenter/page/PageManager$PageType;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    return-object v0
.end method

.method public static values()[Lcom/digital/cloud/usercenter/page/PageManager$PageType;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    array-length v1, v0

    new-array v2, v1, [Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
