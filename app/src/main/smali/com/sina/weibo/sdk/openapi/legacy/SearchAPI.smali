.class public Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "SearchAPI.java"


# static fields
.field public static final FRIEND_TYPE_ATTENTIONS:I = 0x0

.field public static final FRIEND_TYPE_FELLOWS:I = 0x1

.field public static final RANGE_ALL:I = 0x2

.field public static final RANGE_ATTENTIONS:I = 0x0

.field public static final RANGE_ATTENTION_TAGS:I = 0x1

.field public static final SCHOOL_TYPE_COLLEGE:I = 0x1

.field public static final SCHOOL_TYPE_JUNIOR:I = 0x4

.field public static final SCHOOL_TYPE_PRIMARY:I = 0x5

.field public static final SCHOOL_TYPE_SENIOR:I = 0x2

.field public static final SCHOOL_TYPE_TECHNICAL:I = 0x3

.field private static final SERVER_URL_PRIX:Ljava/lang/String; = "https://api.weibo.com/2/search"


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 51
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 52
    return-void
.end method

.method private buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 2
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I

    .prologue
    .line 147
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 148
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "q"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 149
    const-string v1, "count"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 150
    return-object v0
.end method


# virtual methods
.method public apps(Ljava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 119
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 120
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/search/suggestions/apps.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 121
    return-void
.end method

.method public atUsers(Ljava/lang/String;IIILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "type"    # I
    .param p4, "range"    # I
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 138
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 139
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "q"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 140
    const-string v1, "count"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 141
    const-string v1, "type"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 142
    const-string v1, "range"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 143
    const-string v1, "https://api.weibo.com/2/search/suggestions/at_users.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 144
    return-void
.end method

.method public companies(Ljava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 107
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 108
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/search/suggestions/companies.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 109
    return-void
.end method

.method public schools(Ljava/lang/String;IILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "schoolType"    # I
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 94
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 95
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "type"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 96
    const-string v1, "https://api.weibo.com/2/search/suggestions/schools.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 97
    return-void
.end method

.method public statuses(Ljava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 76
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 77
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/search/suggestions/statuses.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 78
    return-void
.end method

.method public users(Ljava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "q"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 64
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->buildBaseParams(Ljava/lang/String;I)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 65
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/search/suggestions/users.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/SearchAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 66
    return-void
.end method
