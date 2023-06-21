.class public Lcom/sina/weibo/sdk/openapi/InviteAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "InviteAPI.java"


# static fields
.field public static final KEY_INVITE_LOGO:Ljava/lang/String; = "invite_logo"

.field public static final KEY_TEXT:Ljava/lang/String; = "text"

.field public static final KEY_URL:Ljava/lang/String; = "url"

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private final INVITE_URL:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 38
    const-class v0, Lcom/sina/weibo/sdk/openapi/InviteAPI;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/openapi/InviteAPI;->TAG:Ljava/lang/String;

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 56
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 41
    const-string v0, "https://m.api.weibo.com/2/messages/invite.json"

    iput-object v0, p0, Lcom/sina/weibo/sdk/openapi/InviteAPI;->INVITE_URL:Ljava/lang/String;

    .line 57
    return-void
.end method


# virtual methods
.method public sendInvite(Ljava/lang/String;Lorg/json/JSONObject;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # Ljava/lang/String;
    .param p2, "jsonData"    # Lorg/json/JSONObject;
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 67
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 68
    if-eqz p2, :cond_0

    .line 69
    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 71
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/InviteAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 72
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "uid"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    const-string v1, "data"

    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 74
    const-string v1, "https://m.api.weibo.com/2/messages/invite.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/InviteAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 78
    .end local v0    # "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    :goto_0
    return-void

    .line 76
    :cond_0
    sget-object v1, Lcom/sina/weibo/sdk/openapi/InviteAPI;->TAG:Ljava/lang/String;

    const-string v2, "Invite args error!"

    invoke-static {v1, v2}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
