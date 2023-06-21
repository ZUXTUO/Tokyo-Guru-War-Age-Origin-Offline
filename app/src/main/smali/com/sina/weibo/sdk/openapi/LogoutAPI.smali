.class public Lcom/sina/weibo/sdk/openapi/LogoutAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "LogoutAPI.java"


# static fields
.field private static final REVOKE_OAUTH_URL:Ljava/lang/String; = "https://api.weibo.com/oauth2/revokeoauth2"


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 41
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 42
    return-void
.end method


# virtual methods
.method public logout(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 50
    const-string v0, "https://api.weibo.com/oauth2/revokeoauth2"

    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v2, p0, Lcom/sina/weibo/sdk/openapi/LogoutAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    const-string v2, "POST"

    invoke-virtual {p0, v0, v1, v2, p1}, Lcom/sina/weibo/sdk/openapi/LogoutAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 51
    return-void
.end method
