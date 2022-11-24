.class public Lcom/digitalsky/ghoul/installer/ReturnCode;
.super Ljava/lang/Object;
.source "ReturnCode.java"


# static fields
.field public static RC_APK_VERSION_TOO_LOW:I

.field public static RC_FILE_NOT_EXIST:I

.field public static RC_INSTALLING:I

.field public static RC_INSTALL_FAILED:I

.field public static RC_PACKAGE_NAME_NOT_EQUAL:I

.field public static RC_PATH_ERROR:I

.field public static RC_READ_APK_INFO_FAILED:I

.field public static RC_READ_MY_INFO_FAILED:I

.field public static RC_SIGNATURE_DIFFER:I

.field public static RC_VERSION_EQUAL:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 4
    const/4 v0, 0x1

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_INSTALLING:I

    .line 5
    const/4 v0, 0x2

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_PATH_ERROR:I

    .line 6
    const/4 v0, 0x3

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_FILE_NOT_EXIST:I

    .line 7
    const/4 v0, 0x4

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_READ_MY_INFO_FAILED:I

    .line 8
    const/4 v0, 0x5

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_READ_APK_INFO_FAILED:I

    .line 9
    const/4 v0, 0x6

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_PACKAGE_NAME_NOT_EQUAL:I

    .line 10
    const/4 v0, 0x7

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_APK_VERSION_TOO_LOW:I

    .line 11
    const/16 v0, 0x8

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_VERSION_EQUAL:I

    .line 12
    const/16 v0, 0x9

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_SIGNATURE_DIFFER:I

    .line 13
    const/16 v0, 0xa

    sput v0, Lcom/digitalsky/ghoul/installer/ReturnCode;->RC_INSTALL_FAILED:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
