.class public final enum Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
.super Ljava/lang/Enum;
.source "ToolBarController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/toolbar/ToolBarController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ITEMS"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic ENUM$VALUES:[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

.field public static final enum TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 24
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_EXIT"

    invoke-direct {v0, v1, v3}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 25
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_KEFU"

    invoke-direct {v0, v1, v4}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 26
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_SHOP"

    invoke-direct {v0, v1, v5}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 27
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_STRATEGY"

    invoke-direct {v0, v1, v6}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 28
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_INFO"

    invoke-direct {v0, v1, v7}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 29
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    const-string v1, "TB_ITEM_BIND"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    .line 23
    const/4 v0, 0x6

    new-array v0, v0, [Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v1, v0, v3

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_KEFU:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v1, v0, v4

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_SHOP:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v1, v0, v5

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_STRATEGY:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v1, v0, v6

    sget-object v1, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_INFO:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    aput-object v2, v0, v1

    sput-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    .locals 1

    .prologue
    .line 1
    const-class v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    return-object v0
.end method

.method public static values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->ENUM$VALUES:[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    array-length v1, v0

    new-array v2, v1, [Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
