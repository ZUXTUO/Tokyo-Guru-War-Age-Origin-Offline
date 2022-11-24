.class public final enum Lcom/digitalsky/sdk/user/SubmitData$TYPE;
.super Ljava/lang/Enum;
.source "SubmitData.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digitalsky/sdk/user/SubmitData;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "TYPE"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/digitalsky/sdk/user/SubmitData$TYPE;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum ADD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum CREATE_ROLE:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum ENTER_GAME:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field private static final synthetic ENUM$VALUES:[Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum LEVEL_UP:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum LOGOUT:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum PAY:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum REGISTER:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

.field public static final enum UPLOAD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 15
    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "ADD_INFO"

    const-string v2, "addInfo"

    invoke-direct {v0, v1, v4, v2}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ADD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "ENTER_GAME"

    const-string v2, "enterGame"

    invoke-direct {v0, v1, v5, v2}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ENTER_GAME:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "LEVEL_UP"

    const-string v2, "levelUp"

    invoke-direct {v0, v1, v6, v2}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->LEVEL_UP:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "CREATE_ROLE"

    const-string v2, "createRole"

    invoke-direct {v0, v1, v7, v2}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->CREATE_ROLE:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "UPLOAD_INFO"

    .line 16
    const-string v2, "uploadInfo"

    invoke-direct {v0, v1, v8, v2}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->UPLOAD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "PAY"

    const/4 v2, 0x5

    const-string v3, "pay"

    invoke-direct {v0, v1, v2, v3}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->PAY:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "LOGOUT"

    const/4 v2, 0x6

    const-string v3, "logout"

    invoke-direct {v0, v1, v2, v3}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->LOGOUT:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    new-instance v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    const-string v1, "REGISTER"

    const/4 v2, 0x7

    const-string v3, "register"

    invoke-direct {v0, v1, v2, v3}, Lcom/digitalsky/sdk/user/SubmitData$TYPE;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->REGISTER:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    .line 14
    const/16 v0, 0x8

    new-array v0, v0, [Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ADD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v1, v0, v4

    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ENTER_GAME:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v1, v0, v5

    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->LEVEL_UP:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v1, v0, v6

    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->CREATE_ROLE:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v1, v0, v7

    sget-object v1, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->UPLOAD_INFO:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v1, v0, v8

    const/4 v1, 0x5

    sget-object v2, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->PAY:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->LOGOUT:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->REGISTER:Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    aput-object v2, v0, v1

    sput-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ENUM$VALUES:[Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "v"    # Ljava/lang/String;

    .prologue
    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 21
    iput-object p3, p0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->value:Ljava/lang/String;

    .line 22
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/digitalsky/sdk/user/SubmitData$TYPE;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    return-object v0
.end method

.method public static values()[Lcom/digitalsky/sdk/user/SubmitData$TYPE;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->ENUM$VALUES:[Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    array-length v1, v0

    new-array v2, v1, [Lcom/digitalsky/sdk/user/SubmitData$TYPE;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public value()Ljava/lang/String;
    .locals 1

    .prologue
    .line 25
    iget-object v0, p0, Lcom/digitalsky/sdk/user/SubmitData$TYPE;->value:Ljava/lang/String;

    return-object v0
.end method
