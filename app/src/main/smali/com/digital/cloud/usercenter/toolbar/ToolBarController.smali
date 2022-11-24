.class public Lcom/digital/cloud/usercenter/toolbar/ToolBarController;
.super Ljava/lang/Object;
.source "ToolBarController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;
    }
.end annotation


# instance fields
.field private mActivity:Landroid/app/Activity;

.field private final mDefaultItemsShow:Ljava/lang/String;

.field private mIsGuest:Z

.field private mIsInit:Z

.field private mMaxItemsShow:I

.field private mShowItems:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;",
            ">;"
        }
    .end annotation
.end field

.field private mShowItemsTmp:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;",
            ">;"
        }
    .end annotation
.end field

.field private mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mActivity:Landroid/app/Activity;

    .line 15
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    .line 16
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    .line 17
    const/16 v0, 0x8

    iput v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mMaxItemsShow:I

    .line 18
    iput-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsGuest:Z

    .line 19
    const-string v0, "011_021_051"

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mDefaultItemsShow:Ljava/lang/String;

    .line 20
    iput-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 21
    iput-boolean v2, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    .line 12
    return-void
.end method

.method static synthetic access$0(Lcom/digital/cloud/usercenter/toolbar/ToolBarController;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0, p1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->setShowItems(Ljava/lang/String;)V

    return-void
.end method

.method private getToolBarConfig()V
    .locals 3

    .prologue
    .line 81
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarShowItemsUrl:Ljava/lang/String;

    const/4 v1, 0x0

    new-instance v2, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$1;

    invoke-direct {v2, p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$1;-><init>(Lcom/digital/cloud/usercenter/toolbar/ToolBarController;)V

    invoke-static {v0, v1, v2}, Lcom/digital/cloud/usercenter/MyHttpClient;->asyncHttpRequest(Ljava/lang/String;[BLcom/digital/cloud/usercenter/MyHttpClient$asyncHttpRequestListener;)V

    .line 89
    return-void
.end method

.method private setShowItems(Ljava/lang/String;)V
    .locals 11
    .param p1, "itemsConfig"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x3

    const/4 v3, 0x0

    .line 50
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v4, v10, :cond_1

    .line 51
    :cond_0
    sget-object v3, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v4, "Items config error"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 78
    :goto_0
    return-void

    .line 54
    :cond_1
    iget-object v4, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    monitor-enter v4

    .line 55
    :try_start_0
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    iput-object v5, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    .line 56
    iget-boolean v5, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsGuest:Z

    if-eqz v5, :cond_2

    .line 57
    iget-object v5, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    sget-object v6, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_BIND:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 60
    :cond_2
    const-string v5, "_"

    invoke-virtual {p1, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 61
    .local v2, "items":[Ljava/lang/String;
    array-length v5, v2

    :goto_1
    if-lt v3, v5, :cond_4

    .line 74
    iget-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_3

    .line 75
    iget-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    iput-object v3, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    .line 54
    :cond_3
    monitor-exit v4

    goto :goto_0

    .end local v2    # "items":[Ljava/lang/String;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    .line 61
    .restart local v2    # "items":[Ljava/lang/String;
    :cond_4
    :try_start_1
    aget-object v1, v2, v3

    .line 62
    .local v1, "item":Ljava/lang/String;
    iget-object v6, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    iget v7, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mMaxItemsShow:I

    if-ge v6, v7, :cond_5

    .line 63
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    if-ne v6, v10, :cond_5

    const/4 v6, 0x2

    invoke-virtual {v1, v6}, Ljava/lang/String;->charAt(I)C
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v6

    const/16 v7, 0x31

    if-ne v6, v7, :cond_5

    .line 65
    :try_start_2
    iget-object v6, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItemsTmp:Ljava/util/ArrayList;

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v9, 0x2

    invoke-virtual {v1, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    add-int/lit8 v8, v8, -0x1

    aget-object v7, v7, v8

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 61
    :cond_5
    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 66
    :catch_0
    move-exception v0

    .line 67
    .local v0, "e":Ljava/lang/Exception;
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 68
    sget-object v6, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v7, "Items config format error"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_2
.end method


# virtual methods
.method public addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "openid"    # Ljava/lang/String;
    .param p2, "accessToken"    # Ljava/lang/String;
    .param p3, "account"    # Ljava/lang/String;

    .prologue
    .line 34
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController addAccountInfo"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 35
    invoke-static {p1, p2, p3}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->addAccountInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    return-void
.end method

.method public getToolBarPageUrl(I)Ljava/lang/String;
    .locals 3
    .param p1, "index"    # I

    .prologue
    .line 126
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController getToolBarPageUrl"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    if-nez v0, :cond_0

    .line 128
    const-string v0, ""

    .line 139
    :goto_0
    return-object v0

    .line 129
    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v0

    array-length v0, v0

    if-le p1, v0, :cond_2

    .line 130
    :cond_1
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "getToolBarPageUrl index error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 131
    const-string v0, ""

    goto :goto_0

    .line 133
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->ordinal()I

    move-result v0

    if-ne v0, p1, :cond_3

    .line 134
    const-string v0, ""

    goto :goto_0

    .line 135
    :cond_3
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v1

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 136
    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v0

    aget-object v0, v0, p1

    invoke-static {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->getUrl(Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 138
    :cond_4
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "getToolBarPageUrl index:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " not in showItems"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 139
    const-string v0, ""

    goto :goto_0
.end method

.method public hideToolBar()V
    .locals 2

    .prologue
    .line 101
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    if-nez v0, :cond_0

    .line 105
    :goto_0
    return-void

    .line 103
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController hideToolBar"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 104
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->hide()V

    goto :goto_0
.end method

.method public init(Landroid/app/Activity;Z)V
    .locals 2
    .param p1, "ctx"    # Landroid/app/Activity;
    .param p2, "isGuest"    # Z

    .prologue
    .line 39
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController init"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    iput-object p1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mActivity:Landroid/app/Activity;

    .line 42
    const-string v0, "011_021_051"

    invoke-direct {p0, v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->setShowItems(Ljava/lang/String;)V

    .line 43
    invoke-direct {p0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->getToolBarConfig()V

    .line 45
    new-instance v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mActivity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    .line 46
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    .line 47
    return-void
.end method

.method public showToolBar()V
    .locals 2

    .prologue
    .line 92
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    if-nez v0, :cond_0

    .line 98
    :goto_0
    return-void

    .line 95
    :cond_0
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController showToolBar"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 96
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    iget-object v1, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->addItems(Ljava/util/ArrayList;)V

    .line 97
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mToolBarView:Lcom/digital/cloud/usercenter/toolbar/ToolBarView;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarView;->show()V

    goto :goto_0
.end method

.method public showToolBarPage(I)V
    .locals 3
    .param p1, "index"    # I

    .prologue
    .line 108
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "ToolBarController showToolBarPage"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 109
    iget-boolean v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mIsInit:Z

    if-nez v0, :cond_1

    .line 123
    :cond_0
    :goto_0
    return-void

    .line 111
    :cond_1
    if-ltz p1, :cond_2

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v0

    array-length v0, v0

    if-le p1, v0, :cond_3

    .line 112
    :cond_2
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    const-string v1, "showToolBarPage index error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 115
    :cond_3
    sget-object v0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->TB_ITEM_EXIT:Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    invoke-virtual {v0}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->ordinal()I

    move-result v0

    if-eq v0, p1, :cond_0

    .line 117
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mShowItems:Ljava/util/ArrayList;

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v1

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 118
    iget-object v0, p0, Lcom/digital/cloud/usercenter/toolbar/ToolBarController;->mActivity:Landroid/app/Activity;

    invoke-static {}, Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;->values()[Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;

    move-result-object v1

    aget-object v1, v1, p1

    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/toolbar/ToolBarMainPage;->show(Landroid/app/Activity;Lcom/digital/cloud/usercenter/toolbar/ToolBarController$ITEMS;)V

    goto :goto_0

    .line 120
    :cond_4
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "showToolBarPage index:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " not in showItems"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
