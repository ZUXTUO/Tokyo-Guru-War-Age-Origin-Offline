.class public Lcom/digital/cloud/usercenter/ResID;
.super Ljava/lang/Object;
.source "ResID.java"


# static fields
.field private static mPkgName:Ljava/lang/String;

.field private static mResources:Landroid/content/res/Resources;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 8
    sput-object v0, Lcom/digital/cloud/usercenter/ResID;->mResources:Landroid/content/res/Resources;

    .line 9
    sput-object v0, Lcom/digital/cloud/usercenter/ResID;->mPkgName:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static get(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4
    .param p0, "type"    # Ljava/lang/String;
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 17
    sget-object v1, Lcom/digital/cloud/usercenter/ResID;->mResources:Landroid/content/res/Resources;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/digital/cloud/usercenter/ResID;->mPkgName:Ljava/lang/String;

    if-eqz v1, :cond_1

    .line 18
    sget-object v1, Lcom/digital/cloud/usercenter/ResID;->mResources:Landroid/content/res/Resources;

    sget-object v2, Lcom/digital/cloud/usercenter/ResID;->mPkgName:Ljava/lang/String;

    invoke-virtual {v1, p1, p0, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 19
    .local v0, "ret":I
    if-nez v0, :cond_0

    .line 20
    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Resource "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "(type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", pkg="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/digital/cloud/usercenter/ResID;->mPkgName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ") is not found"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 25
    .end local v0    # "ret":I
    :cond_0
    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public static getColor(Ljava/lang/String;)I
    .locals 2
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 29
    const-string v1, "color"

    invoke-static {v1, p0}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 30
    .local v0, "id":I
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 31
    sget-object v1, Lcom/digital/cloud/usercenter/ResID;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    .line 34
    :goto_0
    return v1

    :cond_0
    const/high16 v1, -0x1000000

    goto :goto_0
.end method

.method public static init(Landroid/content/res/Resources;Ljava/lang/String;)V
    .locals 0
    .param p0, "r"    # Landroid/content/res/Resources;
    .param p1, "pkgName"    # Ljava/lang/String;

    .prologue
    .line 12
    sput-object p0, Lcom/digital/cloud/usercenter/ResID;->mResources:Landroid/content/res/Resources;

    .line 13
    sput-object p1, Lcom/digital/cloud/usercenter/ResID;->mPkgName:Ljava/lang/String;

    .line 14
    return-void
.end method
