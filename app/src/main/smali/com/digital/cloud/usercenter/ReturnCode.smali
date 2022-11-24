.class public Lcom/digital/cloud/usercenter/ReturnCode;
.super Ljava/lang/Object;
.source "ReturnCode.java"


# static fields
.field public static FAIL:I

.field public static SUCCESS:I

.field public static USER_CANCEL:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 6
    const/4 v0, 0x0

    sput v0, Lcom/digital/cloud/usercenter/ReturnCode;->SUCCESS:I

    .line 9
    const/4 v0, -0x1

    sput v0, Lcom/digital/cloud/usercenter/ReturnCode;->FAIL:I

    .line 12
    const/4 v0, -0x2

    sput v0, Lcom/digital/cloud/usercenter/ReturnCode;->USER_CANCEL:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
