.class public Lcom/sina/weibo/sdk/api/share/ProvideMessageForWeiboRequest;
.super Lcom/sina/weibo/sdk/api/share/BaseRequest;
.source "ProvideMessageForWeiboRequest.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/sina/weibo/sdk/api/share/BaseRequest;-><init>()V

    .line 35
    return-void
.end method

.method public constructor <init>(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "bundle"    # Landroid/os/Bundle;

    .prologue
    .line 37
    invoke-direct {p0}, Lcom/sina/weibo/sdk/api/share/BaseRequest;-><init>()V

    .line 38
    invoke-virtual {p0, p1}, Lcom/sina/weibo/sdk/api/share/ProvideMessageForWeiboRequest;->fromBundle(Landroid/os/Bundle;)V

    .line 39
    return-void
.end method


# virtual methods
.method final check(Landroid/content/Context;Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;Lcom/sina/weibo/sdk/api/share/VersionCheckHandler;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "weiboInfo"    # Lcom/sina/weibo/sdk/WeiboAppManager$WeiboInfo;
    .param p3, "handler"    # Lcom/sina/weibo/sdk/api/share/VersionCheckHandler;

    .prologue
    .line 48
    const/4 v0, 0x1

    return v0
.end method

.method public getType()I
    .locals 1

    .prologue
    .line 43
    const/4 v0, 0x2

    return v0
.end method
