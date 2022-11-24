.class final enum Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;
.super Ljava/lang/Enum;
.source "ResetPasswordPage.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/page/ResetPasswordPage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "Page"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

.field public static final enum Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

.field public static final enum Null:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

.field public static final enum Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 56
    new-instance v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    const-string v1, "Telphone"

    invoke-direct {v0, v1, v2}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    new-instance v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    const-string v1, "Email"

    invoke-direct {v0, v1, v3}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    new-instance v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    const-string v1, "Null"

    invoke-direct {v0, v1, v4}, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Null:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    .line 55
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Telphone:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    aput-object v1, v0, v2

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Email:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    aput-object v1, v0, v3

    sget-object v1, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->Null:Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    aput-object v1, v0, v4

    sput-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 55
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    return-object v0
.end method

.method public static values()[Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    array-length v1, v0

    new-array v2, v1, [Lcom/digital/cloud/usercenter/page/ResetPasswordPage$Page;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
