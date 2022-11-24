.class public Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "AccountAPI.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI$CAPITAL;
    }
.end annotation


# static fields
.field public static final SCHOOL_TYPE_COLLEGE:I = 0x1

.field public static final SCHOOL_TYPE_JUNIOR:I = 0x4

.field public static final SCHOOL_TYPE_PRIMARY:I = 0x5

.field public static final SCHOOL_TYPE_SENIOR:I = 0x2

.field public static final SCHOOL_TYPE_TECHNICAL:I = 0x3

.field private static final SERVER_URL_PRIX:Ljava/lang/String; = "https://api.weibo.com/2/account"


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 49
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 50
    return-void
.end method


# virtual methods
.method public endSession(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 119
    const-string v0, "https://api.weibo.com/2/account/end_session.json"

    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v2, p0, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    const-string v2, "POST"

    invoke-virtual {p0, v0, v1, v2, p1}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 120
    return-void
.end method

.method public getPrivacy(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 58
    const-string v0, "https://api.weibo.com/2/account/get_privacy.json"

    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v2, p0, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    const-string v2, "GET"

    invoke-virtual {p0, v0, v1, v2, p1}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 59
    return-void
.end method

.method public getUid(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 110
    const-string v0, "https://api.weibo.com/2/account/get_uid.json"

    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v2, p0, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    const-string v2, "GET"

    invoke-virtual {p0, v0, v1, v2, p1}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 111
    return-void
.end method

.method public rateLimitStatus(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 101
    const-string v0, "https://api.weibo.com/2/account/rate_limit_status.json"

    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v2, p0, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    const-string v2, "GET"

    invoke-virtual {p0, v0, v1, v2, p1}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 102
    return-void
.end method

.method public schoolList(IIIILcom/sina/weibo/sdk/openapi/legacy/AccountAPI$CAPITAL;Ljava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "province"    # I
    .param p2, "city"    # I
    .param p3, "area"    # I
    .param p4, "schoolType"    # I
    .param p5, "capital"    # Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI$CAPITAL;
    .param p6, "keyword"    # Ljava/lang/String;
    .param p7, "count"    # I
    .param p8, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 81
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 82
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "province"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 83
    const-string v1, "city"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 84
    const-string v1, "area"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 85
    const-string v1, "type"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 86
    invoke-virtual {p5}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI$CAPITAL;->name()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 87
    const-string v1, "capital"

    invoke-virtual {p5}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI$CAPITAL;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 91
    :cond_0
    :goto_0
    const-string v1, "count"

    invoke-virtual {v0, v1, p7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 92
    const-string v1, "https://api.weibo.com/2/account/profile/school_list.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p8}, Lcom/sina/weibo/sdk/openapi/legacy/AccountAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 93
    return-void

    .line 88
    :cond_1
    invoke-static {p6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 89
    const-string v1, "keyword"

    invoke-virtual {v0, v1, p6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
