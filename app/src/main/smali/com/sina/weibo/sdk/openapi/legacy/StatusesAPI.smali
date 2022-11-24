.class public Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "StatusesAPI.java"


# static fields
.field public static final AUTHOR_FILTER_ALL:I = 0x0

.field public static final AUTHOR_FILTER_ATTENTIONS:I = 0x1

.field public static final AUTHOR_FILTER_STRANGER:I = 0x2

.field public static final COMMENTS_BOTH:I = 0x3

.field public static final COMMENTS_CUR_STATUSES:I = 0x1

.field public static final COMMENTS_NONE:I = 0x0

.field public static final COMMENTS_RIGAL_STATUSES:I = 0x2

.field public static final EMOTION_TYPE_ANI:Ljava/lang/String; = "ani"

.field public static final EMOTION_TYPE_CARTOON:Ljava/lang/String; = "cartoon"

.field public static final EMOTION_TYPE_FACE:Ljava/lang/String; = "face"

.field public static final FEATURE_ALL:I = 0x0

.field public static final FEATURE_MUSICE:I = 0x4

.field public static final FEATURE_ORIGINAL:I = 0x1

.field public static final FEATURE_PICTURE:I = 0x2

.field public static final FEATURE_VIDEO:I = 0x3

.field public static final LANGUAGE_CNNAME:Ljava/lang/String; = "cnname"

.field public static final LANGUAGE_TWNAME:Ljava/lang/String; = "twname"

.field private static final SERVER_URL_PRIX:Ljava/lang/String; = "https://api.weibo.com/2/statuses"

.field public static final SRC_FILTER_ALL:I = 0x0

.field public static final SRC_FILTER_WEIBO:I = 0x1

.field public static final SRC_FILTER_WEIQUN:I = 0x2

.field public static final TYPE_COMMENTS:I = 0x2

.field public static final TYPE_FILTER_ALL:I = 0x0

.field public static final TYPE_FILTER_ORIGAL:I = 0x1

.field public static final TYPE_MESSAGE:I = 0x3

.field public static final TYPE_STATUSES:I = 0x1


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 78
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 79
    return-void
.end method

.method private buildHotParams(IZ)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "count"    # I
    .param p2, "base_app"    # Z

    .prologue
    .line 697
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 698
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "count"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 699
    const-string v2, "base_app"

    if-eqz p2, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 700
    return-object v0

    .line 699
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I

    .prologue
    .line 673
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 674
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "since_id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 675
    const-string v1, "max_id"

    invoke-virtual {v0, v1, p3, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 676
    const-string v1, "count"

    invoke-virtual {v0, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 677
    const-string v1, "page"

    invoke-virtual {v0, v1, p6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 678
    return-object v0
.end method

.method private buildTimeLineWithApp(JJIIZI)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I

    .prologue
    .line 683
    invoke-direct/range {p0 .. p6}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 684
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "feature"

    invoke-virtual {v0, v1, p8}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 685
    const-string v2, "base_app"

    if-eqz p7, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 686
    return-object v0

    .line 685
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 11
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "trim_user"    # Z
    .param p9, "featureType"    # I

    .prologue
    .line 691
    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p9

    invoke-direct/range {v1 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithApp(JJIIZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 692
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v2, "trim_user"

    if-eqz p8, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 693
    return-object v0

    .line 692
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildUpdateParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 2
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "lat"    # Ljava/lang/String;
    .param p3, "lon"    # Ljava/lang/String;

    .prologue
    .line 705
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 706
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "status"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 707
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 708
    const-string v1, "long"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 710
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 711
    const-string v1, "lat"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 713
    :cond_1
    return-object v0
.end method


# virtual methods
.method public bilateralTimeline(JJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I
    .param p9, "trim_user"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 430
    move-object v3, p0

    move-wide v4, p1

    move-wide/from16 v6, p3

    move/from16 v8, p5

    move/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p9

    move/from16 v12, p8

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 432
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "https://api.weibo.com/2/statuses/bilateral_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 433
    return-void
.end method

.method public count([Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 7
    .param p1, "ids"    # [Ljava/lang/String;
    .param p2, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 563
    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v3, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 564
    .local v1, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 565
    .local v2, "strb":Ljava/lang/StringBuilder;
    array-length v4, p1

    const/4 v3, 0x0

    :goto_0
    if-lt v3, v4, :cond_0

    .line 568
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->deleteCharAt(I)Ljava/lang/StringBuilder;

    .line 569
    const-string v3, "ids"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 570
    const-string v3, "https://api.weibo.com/2/statuses/count.json"

    const-string v4, "GET"

    invoke-virtual {p0, v3, v1, v4, p2}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 571
    return-void

    .line 565
    :cond_0
    aget-object v0, p1, v3

    .line 566
    .local v0, "id":Ljava/lang/String;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 565
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method public destroy(JLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "id"    # J
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 600
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 601
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 602
    const-string v1, "https://api.weibo.com/2/statuses/destroy.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 603
    return-void
.end method

.method public emotions(Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "language"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 665
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 666
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "type"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 667
    const-string v1, "language"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 668
    const-string v1, "https://api.weibo.com/2/emotions.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 669
    return-void
.end method

.method public friendsTimeline(JJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I
    .param p9, "trim_user"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 118
    move-object v3, p0

    move-wide v4, p1

    move-wide/from16 v6, p3

    move/from16 v8, p5

    move/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p9

    move/from16 v12, p8

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 119
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "https://api.weibo.com/2/statuses/friends_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 120
    return-void
.end method

.method public friendsTimelineIds(JJIIZILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I
    .param p9, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 140
    invoke-direct/range {p0 .. p8}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithApp(JJIIZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 141
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/friends_timeline/ids.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p9}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 142
    return-void
.end method

.method public homeTimeline(JJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I
    .param p9, "trim_user"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 163
    move-object v3, p0

    move-wide v4, p1

    move-wide/from16 v6, p3

    move/from16 v8, p5

    move/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p9

    move/from16 v12, p8

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 165
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "https://api.weibo.com/2/statuses/home_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 166
    return-void
.end method

.method public hotCommentsDaily(IZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # I
    .param p2, "base_app"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 540
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildHotParams(IZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 541
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/hot/comments_daily.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 542
    return-void
.end method

.method public hotCommentsWeekly(IZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # I
    .param p2, "base_app"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 552
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildHotParams(IZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 553
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/hot/comments_weekly.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 554
    return-void
.end method

.method public hotRepostDaily(IZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # I
    .param p2, "base_app"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 516
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildHotParams(IZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 517
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/hot/repost_daily.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 518
    return-void
.end method

.method public hotRepostWeekly(IZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # I
    .param p2, "base_app"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 528
    invoke-direct {p0, p1, p2}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildHotParams(IZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 529
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/hot/repost_weekly.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 530
    return-void
.end method

.method public mentions(JJIIIIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "authorType"    # I
    .param p8, "sourceType"    # I
    .param p9, "filterType"    # I
    .param p10, "trim_user"    # Z
    .param p11, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 374
    invoke-direct/range {p0 .. p6}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 375
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "filter_by_author"

    invoke-virtual {v0, v1, p7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 376
    const-string v1, "filter_by_source"

    invoke-virtual {v0, v1, p8}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 377
    const-string v1, "filter_by_type"

    invoke-virtual {v0, v1, p9}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 378
    const-string v2, "trim_user"

    if-eqz p10, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 379
    const-string v1, "https://api.weibo.com/2/statuses/mentions.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p11}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 380
    return-void

    .line 378
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public mentionsIds(JJIIIIILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "authorType"    # I
    .param p8, "sourceType"    # I
    .param p9, "filterType"    # I
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 404
    invoke-direct/range {p0 .. p6}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 405
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "filter_by_author"

    invoke-virtual {v0, v1, p7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 406
    const-string v1, "filter_by_source"

    invoke-virtual {v0, v1, p8}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 407
    const-string v1, "filter_by_type"

    invoke-virtual {v0, v1, p9}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 408
    const-string v1, "https://api.weibo.com/2/statuses/mentions/ids.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p10}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 409
    return-void
.end method

.method public publicTimeline(IIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # I
    .param p2, "page"    # I
    .param p3, "base_app"    # Z
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 92
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 93
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "count"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 94
    const-string v1, "page"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 95
    const-string v2, "base_app"

    if-eqz p3, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 96
    const-string v1, "https://api.weibo.com/2/statuses/public_timeline.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 97
    return-void

    .line 95
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public queryID([Ljava/lang/String;IZZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 9
    .param p1, "mids"    # [Ljava/lang/String;
    .param p2, "type"    # I
    .param p3, "inbox"    # Z
    .param p4, "isBase62"    # Z
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 487
    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v3, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v1, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 488
    .local v1, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    if-eqz p1, :cond_0

    .line 489
    array-length v3, p1

    if-ne v4, v3, :cond_1

    .line 490
    const-string v3, "mid"

    aget-object v6, p1, v5

    invoke-virtual {v1, v3, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 502
    :cond_0
    :goto_0
    const-string v3, "type"

    invoke-virtual {v1, v3, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 503
    const-string v6, "inbox"

    if-eqz p3, :cond_3

    move v3, v4

    :goto_1
    invoke-virtual {v1, v6, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 504
    const-string v3, "isBase62"

    if-eqz p4, :cond_4

    :goto_2
    invoke-virtual {v1, v3, v4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 505
    const-string v3, "https://api.weibo.com/2/statuses/queryid.json"

    const-string v4, "GET"

    invoke-virtual {p0, v3, v1, v4, p5}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 506
    return-void

    .line 492
    :cond_1
    const-string v3, "is_batch"

    invoke-virtual {v1, v3, v4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 493
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 494
    .local v2, "strb":Ljava/lang/StringBuilder;
    array-length v6, p1

    move v3, v5

    :goto_3
    if-lt v3, v6, :cond_2

    .line 497
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->deleteCharAt(I)Ljava/lang/StringBuilder;

    .line 498
    const-string v3, "mid"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v3, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 494
    :cond_2
    aget-object v0, p1, v3

    .line 495
    .local v0, "mid":Ljava/lang/String;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ","

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 494
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .end local v0    # "mid":Ljava/lang/String;
    .end local v2    # "strb":Ljava/lang/StringBuilder;
    :cond_3
    move v3, v5

    .line 503
    goto :goto_1

    :cond_4
    move v4, v5

    .line 504
    goto :goto_2
.end method

.method public queryMID([JILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 8
    .param p1, "ids"    # [J
    .param p2, "type"    # I
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    const/4 v6, 0x1

    const/4 v4, 0x0

    .line 458
    new-instance v2, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v5, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v2, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 459
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    array-length v5, p1

    if-ne v6, v5, :cond_0

    .line 460
    const-string v5, "id"

    aget-wide v6, p1, v4

    invoke-virtual {v2, v5, v6, v7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 470
    :goto_0
    const-string v4, "type"

    invoke-virtual {v2, v4, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 471
    const-string v4, "https://api.weibo.com/2/statuses/querymid.json"

    const-string v5, "GET"

    invoke-virtual {p0, v4, v2, v5, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 472
    return-void

    .line 462
    :cond_0
    const-string v5, "is_batch"

    invoke-virtual {v2, v5, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 463
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 464
    .local v3, "strb":Ljava/lang/StringBuilder;
    array-length v5, p1

    :goto_1
    if-lt v4, v5, :cond_1

    .line 467
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->deleteCharAt(I)Ljava/lang/StringBuilder;

    .line 468
    const-string v4, "id"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v4, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 464
    :cond_1
    aget-wide v0, p1, v4

    .line 465
    .local v0, "id":J
    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ","

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 464
    add-int/lit8 v4, v4, 0x1

    goto :goto_1
.end method

.method public repost(JLjava/lang/String;ILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "id"    # J
    .param p3, "status"    # Ljava/lang/String;
    .param p4, "commentType"    # I
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 586
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 587
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 588
    const-string v1, "status"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 589
    const-string v1, "is_comment"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 590
    const-string v1, "https://api.weibo.com/2/statuses/repost.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 591
    return-void
.end method

.method public repostByMe(JJIILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 347
    invoke-direct/range {p0 .. p6}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 348
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/repost_by_me.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p7}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 349
    return-void
.end method

.method public repostTimeline(JJJIIILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 11
    .param p1, "id"    # J
    .param p3, "since_id"    # J
    .param p5, "max_id"    # J
    .param p7, "count"    # I
    .param p8, "page"    # I
    .param p9, "authorType"    # I
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 309
    move-object v3, p0

    move-wide v4, p3

    move-wide/from16 v6, p5

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v3 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 310
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "id"

    invoke-virtual {v2, v3, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 311
    const-string v3, "filter_by_author"

    move/from16 v0, p9

    invoke-virtual {v2, v3, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 312
    const-string v3, "https://api.weibo.com/2/statuses/repost_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 313
    return-void
.end method

.method public repostTimelineIds(JJJIIILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 11
    .param p1, "id"    # J
    .param p3, "since_id"    # J
    .param p5, "max_id"    # J
    .param p7, "count"    # I
    .param p8, "page"    # I
    .param p9, "authorType"    # I
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 331
    move-object v3, p0

    move-wide v4, p3

    move-wide/from16 v6, p5

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v3 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 332
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "id"

    invoke-virtual {v2, v3, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 333
    const-string v3, "filter_by_author"

    move/from16 v0, p9

    invoke-virtual {v2, v3, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 334
    const-string v3, "https://api.weibo.com/2/statuses/repost_timeline/ids.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 335
    return-void
.end method

.method public show(JLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "id"    # J
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 442
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 443
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 444
    const-string v1, "https://api.weibo.com/2/statuses/show.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 445
    return-void
.end method

.method public update(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "lat"    # Ljava/lang/String;
    .param p3, "lon"    # Ljava/lang/String;
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 614
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildUpdateParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 615
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/statuses/update.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 616
    return-void
.end method

.method public upload(Ljava/lang/String;Landroid/graphics/Bitmap;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "bitmap"    # Landroid/graphics/Bitmap;
    .param p3, "lat"    # Ljava/lang/String;
    .param p4, "lon"    # Ljava/lang/String;
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 629
    invoke-direct {p0, p1, p3, p4}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildUpdateParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 630
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "pic"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 631
    const-string v1, "https://api.weibo.com/2/statuses/upload.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 632
    return-void
.end method

.method public uploadUrlText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "status"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Ljava/lang/String;
    .param p3, "pic_id"    # Ljava/lang/String;
    .param p4, "lat"    # Ljava/lang/String;
    .param p5, "lon"    # Ljava/lang/String;
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 646
    invoke-direct {p0, p1, p4, p5}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildUpdateParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 647
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "url"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 648
    const-string v1, "pic_id"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 649
    const-string v1, "https://api.weibo.com/2/statuses/upload_url_text.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 650
    return-void
.end method

.method public userTimeline(JJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "base_app"    # Z
    .param p8, "featureType"    # I
    .param p9, "trim_user"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 240
    move-object v3, p0

    move-wide v4, p1

    move-wide/from16 v6, p3

    move/from16 v8, p5

    move/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p9

    move/from16 v12, p8

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 242
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "https://api.weibo.com/2/statuses/user_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 243
    return-void
.end method

.method public userTimeline(JJJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "uid"    # J
    .param p3, "since_id"    # J
    .param p5, "max_id"    # J
    .param p7, "count"    # I
    .param p8, "page"    # I
    .param p9, "base_app"    # Z
    .param p10, "featureType"    # I
    .param p11, "trim_user"    # Z
    .param p12, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 188
    move-object v3, p0

    move-wide/from16 v4, p3

    move-wide/from16 v6, p5

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    move/from16 v11, p11

    move/from16 v12, p10

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 190
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "uid"

    invoke-virtual {v2, v3, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 191
    const-string v3, "https://api.weibo.com/2/statuses/user_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p12

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 192
    return-void
.end method

.method public userTimeline(Ljava/lang/String;JJIIZIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 14
    .param p1, "screen_name"    # Ljava/lang/String;
    .param p2, "since_id"    # J
    .param p4, "max_id"    # J
    .param p6, "count"    # I
    .param p7, "page"    # I
    .param p8, "base_app"    # Z
    .param p9, "featureType"    # I
    .param p10, "trim_user"    # Z
    .param p11, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 214
    move-object v3, p0

    move-wide/from16 v4, p2

    move-wide/from16 v6, p4

    move/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p10

    move/from16 v12, p9

    invoke-direct/range {v3 .. v12}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithAppTrim(JJIIZZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 216
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "screen_name"

    invoke-virtual {v2, v3, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 217
    const-string v3, "https://api.weibo.com/2/statuses/user_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p11

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 218
    return-void
.end method

.method public userTimelineIds(JJJIIZILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 13
    .param p1, "uid"    # J
    .param p3, "since_id"    # J
    .param p5, "max_id"    # J
    .param p7, "count"    # I
    .param p8, "page"    # I
    .param p9, "base_app"    # Z
    .param p10, "featureType"    # I
    .param p11, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 264
    move-object v3, p0

    move-wide/from16 v4, p3

    move-wide/from16 v6, p5

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    move/from16 v11, p10

    invoke-direct/range {v3 .. v11}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithApp(JJIIZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 265
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "uid"

    invoke-virtual {v2, v3, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 266
    const-string v3, "https://api.weibo.com/2/statuses/user_timeline/ids.json"

    const-string v4, "GET"

    move-object/from16 v0, p11

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 267
    return-void
.end method

.method public userTimelineIds(Ljava/lang/String;JJIIZILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 12
    .param p1, "screen_name"    # Ljava/lang/String;
    .param p2, "since_id"    # J
    .param p4, "max_id"    # J
    .param p6, "count"    # I
    .param p7, "page"    # I
    .param p8, "base_app"    # Z
    .param p9, "featureType"    # I
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 288
    move-object v3, p0

    move-wide v4, p2

    move-wide/from16 v6, p4

    move/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    invoke-direct/range {v3 .. v11}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->buildTimeLineWithApp(JJIIZI)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 289
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "screen_name"

    invoke-virtual {v2, v3, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 290
    const-string v3, "https://api.weibo.com/2/statuses/user_timeline/ids.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/StatusesAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 291
    return-void
.end method
