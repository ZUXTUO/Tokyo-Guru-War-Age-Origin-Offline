.class public Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;
.super Ljava/lang/Object;
.source "WeiboAppManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/sina/weibo/sdk/WeiboAppManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "WeiboInfo"
.end annotation


# instance fields
.field private mPackageName:Ljava/lang/String;

.field private mSupportApi:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 42
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->setPackageName(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1(Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;I)V
    .locals 0

    .prologue
    .line 48
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->setSupportApi(I)V

    return-void
.end method

.method private setPackageName(Ljava/lang/String;)V
    .locals 0
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 43
    iput-object p1, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mPackageName:Ljava/lang/String;

    .line 44
    return-void
.end method

.method private setSupportApi(I)V
    .locals 0
    .param p1, "supportApi"    # I

    .prologue
    .line 49
    iput p1, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mSupportApi:I

    .line 50
    return-void
.end method


# virtual methods
.method public getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 46
    iget-object v0, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mPackageName:Ljava/lang/String;

    return-object v0
.end method

.method public getSupportApi()I
    .locals 1

    .prologue
    .line 52
    iget v0, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mSupportApi:I

    return v0
.end method

.method public isLegal()Z
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mPackageName:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget v0, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mSupportApi:I

    if-lez v0, :cond_0

    .line 57
    const/4 v0, 0x1

    .line 59
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 65
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "WeiboInfo: PackageName = "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mPackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", supportApi = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;->mSupportApi:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
