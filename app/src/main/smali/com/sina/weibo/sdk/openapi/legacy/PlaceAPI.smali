.class public Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;
.super Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;
.source "PlaceAPI.java"


# static fields
.field public static final GENDER_ALL:I = 0x0

.field public static final GENDER_MAN:I = 0x1

.field public static final GENDER_WOMAM:I = 0x2

.field public static final NEARBY_POIS_SORT_BY_CHECKIN_NUMBER:I = 0x2

.field public static final NEARBY_POIS_SORT_BY_DISTENCE:I = 0x1

.field public static final NEARBY_POIS_SORT_BY_WEIGHT:I = 0x0

.field public static final NEARBY_USER_SORT_BY_DISTANCE:I = 0x1

.field public static final NEARBY_USER_SORT_BY_SOCIAL_SHIP:I = 0x2

.field public static final NEARBY_USER_SORT_BY_TIME:I = 0x0

.field public static final POIS_SORT_BY_HOT:I = 0x1

.field public static final POIS_SORT_BY_TIME:I = 0x0

.field public static final RELATIONSHIP_FILTER_ALL:I = 0x0

.field public static final RELATIONSHIP_FILTER_FOLLOW:I = 0x2

.field public static final RELATIONSHIP_FILTER_STRANGER:I = 0x1

.field private static final SERVER_URL_PRIX:Ljava/lang/String; = "https://api.weibo.com/2/place"

.field public static final SORT_BY_DISTENCE:I = 0x1

.field public static final SORT_BY_TIME:I = 0x0

.field public static final USER_LEVEL_ALL:I = 0x0

.field public static final USER_LEVEL_NORMAL:I = 0x1

.field public static final USER_LEVEL_STAR:I = 0x7

.field public static final USER_LEVEL_VIP:I = 0x2


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "accessToken"    # Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    .prologue
    .line 71
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/AbsOpenAPI;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 72
    return-void
.end method

.method private buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "range"    # I
    .param p4, "count"    # I
    .param p5, "page"    # I
    .param p6, "sortType"    # I
    .param p7, "offset"    # Z

    .prologue
    .line 598
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 599
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "lat"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 600
    const-string v1, "long"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 601
    const-string v1, "range"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 602
    const-string v1, "count"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 603
    const-string v1, "page"

    invoke-virtual {v0, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 604
    const-string v1, "sort"

    invoke-virtual {v0, v1, p6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 605
    const-string v2, "offset"

    if-eqz p7, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 606
    return-object v0

    .line 605
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildPoiis(Ljava/lang/String;Ljava/lang/String;Z)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "status"    # Ljava/lang/String;
    .param p3, "isPublic"    # Z

    .prologue
    .line 610
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 611
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "poiid"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 612
    const-string v1, "status"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 613
    const-string v2, "public"

    if-eqz p3, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 614
    return-object v0

    .line 613
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildPoisParams(Ljava/lang/String;IIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "page"    # I
    .param p4, "base_app"    # Z

    .prologue
    .line 618
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 619
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "poiid"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 620
    const-string v2, "base_app"

    if-eqz p4, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 621
    const-string v1, "count"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 622
    const-string v1, "page"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 623
    return-object v0

    .line 620
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private buildTimeLineParamsBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I

    .prologue
    .line 577
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 578
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "since_id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 579
    const-string v1, "max_id"

    invoke-virtual {v0, v1, p3, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 580
    const-string v1, "count"

    invoke-virtual {v0, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 581
    const-string v1, "page"

    invoke-virtual {v0, v1, p6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 582
    return-object v0
.end method

.method private buildUserParams(JIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;
    .locals 3
    .param p1, "uid"    # J
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "base_app"    # Z

    .prologue
    .line 587
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 588
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "uid"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 589
    const-string v1, "count"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 590
    const-string v1, "page"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 591
    const-string v2, "base_app"

    if-eqz p5, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 592
    return-object v0

    .line 591
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method


# virtual methods
.method public friendsTimeline(JJIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "since_id"    # J
    .param p3, "max_id"    # J
    .param p5, "count"    # I
    .param p6, "page"    # I
    .param p7, "only_attentions"    # Z
    .param p8, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 99
    invoke-direct/range {p0 .. p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildTimeLineParamsBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 100
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v2, "type"

    if-eqz p7, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 101
    const-string v1, "https://api.weibo.com/2/place/friends_timeline.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p8}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 102
    return-void

    .line 100
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public nearbyPhotos(Ljava/lang/String;Ljava/lang/String;IJJIIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 12
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "range"    # I
    .param p4, "starttime"    # J
    .param p6, "endtime"    # J
    .param p8, "sortType"    # I
    .param p9, "count"    # I
    .param p10, "page"    # I
    .param p11, "offset"    # Z
    .param p12, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 415
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move/from16 v6, p9

    move/from16 v7, p10

    move/from16 v8, p8

    move/from16 v9, p11

    invoke-direct/range {v2 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v10

    .line 416
    .local v10, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v2, "starttime"

    move-wide/from16 v0, p4

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 417
    const-string v2, "endtime"

    move-wide/from16 v0, p6

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 418
    const-string v2, "https://api.weibo.com/2/place/nearby/photos.json"

    const-string v3, "GET"

    move-object/from16 v0, p12

    invoke-virtual {p0, v2, v10, v3, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 419
    return-void
.end method

.method public nearbyPois(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 10
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "range"    # I
    .param p4, "q"    # Ljava/lang/String;
    .param p5, "category"    # Ljava/lang/String;
    .param p6, "count"    # I
    .param p7, "page"    # I
    .param p8, "sortType"    # I
    .param p9, "offset"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 367
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move/from16 v5, p6

    move/from16 v6, p7

    move/from16 v7, p8

    move/from16 v8, p9

    invoke-direct/range {v1 .. v8}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v9

    .line 368
    .local v9, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "q"

    invoke-virtual {v9, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 369
    const-string v1, "category"

    invoke-virtual {v9, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 370
    const-string v1, "https://api.weibo.com/2/place/nearby/pois.json"

    const-string v2, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v1, v9, v2, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 371
    return-void
.end method

.method public nearbyTimeline(Ljava/lang/String;Ljava/lang/String;IJJIIIZZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 12
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "range"    # I
    .param p4, "starttime"    # J
    .param p6, "endtime"    # J
    .param p8, "sortType"    # I
    .param p9, "count"    # I
    .param p10, "page"    # I
    .param p11, "base_app"    # Z
    .param p12, "offset"    # Z
    .param p13, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 161
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move/from16 v6, p9

    move/from16 v7, p10

    move/from16 v8, p8

    move/from16 v9, p12

    invoke-direct/range {v2 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v10

    .line 162
    .local v10, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v2, "starttime"

    move-wide/from16 v0, p4

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 163
    const-string v2, "endtime"

    move-wide/from16 v0, p6

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 164
    const-string v3, "base_app"

    if-eqz p11, :cond_0

    const/4 v2, 0x1

    :goto_0
    invoke-virtual {v10, v3, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 165
    const-string v2, "https://api.weibo.com/2/place/nearby_timeline.json"

    const-string v3, "GET"

    move-object/from16 v0, p13

    invoke-virtual {p0, v2, v10, v3, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 166
    return-void

    .line 164
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public nearbyUserList(Ljava/lang/String;Ljava/lang/String;IIIIIIIIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 10
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "range"    # I
    .param p6, "sortType"    # I
    .param p7, "filterType"    # I
    .param p8, "genderType"    # I
    .param p9, "levelType"    # I
    .param p10, "start_birth"    # I
    .param p11, "end_birth"    # I
    .param p12, "offset"    # Z
    .param p13, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 453
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p5

    move v5, p3

    move v6, p4

    move/from16 v7, p6

    move/from16 v8, p12

    invoke-direct/range {v1 .. v8}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v9

    .line 454
    .local v9, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "filter"

    move/from16 v0, p7

    invoke-virtual {v9, v1, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 455
    const-string v1, "gender"

    move/from16 v0, p8

    invoke-virtual {v9, v1, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 456
    const-string v1, "level"

    move/from16 v0, p9

    invoke-virtual {v9, v1, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 457
    const-string v1, "startbirth"

    move/from16 v0, p10

    invoke-virtual {v9, v1, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 458
    const-string v1, "endbirth"

    move/from16 v0, p11

    invoke-virtual {v9, v1, v0}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 459
    const-string v1, "https://api.weibo.com/2/place/nearby_users/list.json"

    const-string v2, "GET"

    move-object/from16 v0, p13

    invoke-virtual {p0, v1, v9, v2, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 460
    return-void
.end method

.method public nearbyUsers(Ljava/lang/String;Ljava/lang/String;IJJIIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 12
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "range"    # I
    .param p4, "starttime"    # J
    .param p6, "endtime"    # J
    .param p8, "sortType"    # I
    .param p9, "count"    # I
    .param p10, "page"    # I
    .param p11, "offset"    # Z
    .param p12, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 391
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move/from16 v6, p9

    move/from16 v7, p10

    move/from16 v8, p8

    move/from16 v9, p11

    invoke-direct/range {v2 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildNearbyParams(Ljava/lang/String;Ljava/lang/String;IIIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v10

    .line 392
    .local v10, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v2, "starttime"

    move-wide/from16 v0, p4

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 393
    const-string v2, "endtime"

    move-wide/from16 v0, p6

    invoke-virtual {v10, v2, v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 394
    const-string v2, "https://api.weibo.com/2/place/nearby/users.json"

    const-string v3, "GET"

    move-object/from16 v0, p12

    invoke-virtual {p0, v2, v10, v3, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 395
    return-void
.end method

.method public nearbyUsersCreate(Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "lat"    # Ljava/lang/String;
    .param p2, "lon"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 559
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 560
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "lat"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 561
    const-string v1, "long"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 562
    const-string v1, "https://api.weibo.com/2/place/nearby_users/create.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 563
    return-void
.end method

.method public nearbyUsersDestroy(Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 571
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 572
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/nearby_users/destory.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p1}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 573
    return-void
.end method

.method public poiTimeline(Ljava/lang/String;JJIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 10
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "since_id"    # J
    .param p4, "max_id"    # J
    .param p6, "count"    # I
    .param p7, "page"    # I
    .param p8, "base_app"    # Z
    .param p9, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 136
    move-object v3, p0

    move-wide v4, p2

    move-wide v6, p4

    move/from16 v8, p6

    move/from16 v9, p7

    invoke-direct/range {v3 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildTimeLineParamsBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 137
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "poiid"

    invoke-virtual {v2, v3, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    const-string v4, "base_app"

    if-eqz p8, :cond_0

    const/4 v3, 0x1

    :goto_0
    invoke-virtual {v2, v4, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 139
    const-string v3, "https://api.weibo.com/2/place/poi_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p9

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 140
    return-void

    .line 138
    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public poisAddCheckin(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "status"    # Ljava/lang/String;
    .param p3, "pic"    # Ljava/lang/String;
    .param p4, "isPublic"    # Z
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 505
    invoke-direct {p0, p1, p2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoiis(Ljava/lang/String;Ljava/lang/String;Z)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 506
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "pic"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 507
    const-string v1, "https://api.weibo.com/2/place/pois/add_checkin.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 508
    return-void
.end method

.method public poisAddPhoto(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "status"    # Ljava/lang/String;
    .param p3, "pic"    # Ljava/lang/String;
    .param p4, "isPublic"    # Z
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 520
    invoke-direct {p0, p1, p2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoiis(Ljava/lang/String;Ljava/lang/String;Z)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 521
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "pic"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 522
    const-string v1, "https://api.weibo.com/2/place/pois/add_photo.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 523
    return-void
.end method

.method public poisAddTip(Ljava/lang/String;Ljava/lang/String;ZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "status"    # Ljava/lang/String;
    .param p3, "isPublic"    # Z
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 534
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoiis(Ljava/lang/String;Ljava/lang/String;Z)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 535
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/pois/add_tip.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 536
    return-void
.end method

.method public poisAddTodo(Ljava/lang/String;Ljava/lang/String;ZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "status"    # Ljava/lang/String;
    .param p3, "isPublic"    # Z
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 547
    invoke-direct {p0, p1, p2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoiis(Ljava/lang/String;Ljava/lang/String;Z)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 548
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/pois/add_todo.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 549
    return-void
.end method

.method public poisCategory(IZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "pid"    # I
    .param p2, "returnALL"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 342
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 343
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "pid"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 344
    const-string v2, "flag"

    if-eqz p2, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 345
    const-string v1, "https://api.weibo.com/2/place/pois/category.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 346
    return-void

    .line 344
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public poisCreate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "category"    # Ljava/lang/String;
    .param p4, "lat"    # Ljava/lang/String;
    .param p5, "lon"    # Ljava/lang/String;
    .param p6, "city"    # Ljava/lang/String;
    .param p7, "province"    # Ljava/lang/String;
    .param p8, "country"    # Ljava/lang/String;
    .param p9, "phone"    # Ljava/lang/String;
    .param p10, "postCode"    # Ljava/lang/String;
    .param p11, "extra"    # Ljava/lang/String;
    .param p12, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 480
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 481
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "title"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 482
    const-string v1, "address"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 483
    const-string v1, "category"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 484
    const-string v1, "lat"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 485
    const-string v1, "long"

    invoke-virtual {v0, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 486
    const-string v1, "city"

    invoke-virtual {v0, v1, p6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 487
    const-string v1, "province"

    invoke-virtual {v0, v1, p7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 488
    const-string v1, "country"

    invoke-virtual {v0, v1, p8}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 489
    const-string v1, "phone"

    invoke-virtual {v0, v1, p9}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 490
    const-string v1, "postcode"

    invoke-virtual {v0, v1, p10}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 491
    const-string v1, "extra"

    invoke-virtual {v0, v1, p11}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 492
    const-string v1, "https://api.weibo.com/2/place/pois/create.json"

    const-string v2, "POST"

    invoke-virtual {p0, v1, v0, v2, p12}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 493
    return-void
.end method

.method public poisPhotos(Ljava/lang/String;IIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "page"    # I
    .param p4, "sortType"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 291
    invoke-direct {p0, p1, p2, p3, p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoisParams(Ljava/lang/String;IIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 292
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "sort"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 293
    const-string v1, "https://api.weibo.com/2/place/pois/photos.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 294
    return-void
.end method

.method public poisSearch(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "keyword"    # Ljava/lang/String;
    .param p2, "city"    # Ljava/lang/String;
    .param p3, "category"    # Ljava/lang/String;
    .param p4, "count"    # I
    .param p5, "page"    # I
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 325
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 326
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "keyword"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 327
    const-string v1, "city"

    invoke-virtual {v0, v1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 328
    const-string v1, "category"

    invoke-virtual {v0, v1, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 329
    const-string v1, "count"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 330
    const-string v1, "page"

    invoke-virtual {v0, v1, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 331
    const-string v1, "https://api.weibo.com/2/place/pois/search.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 332
    return-void
.end method

.method public poisShow(Ljava/lang/String;ZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "base_app"    # Z
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 258
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 259
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "poiid"

    invoke-virtual {v0, v1, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 260
    const-string v2, "base_app"

    if-eqz p2, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 261
    const-string v1, "https://api.weibo.com/2/place/pois/show.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 262
    return-void

    .line 260
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public poisTips(Ljava/lang/String;IIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "page"    # I
    .param p4, "sortType"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 309
    invoke-direct {p0, p1, p2, p3, p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoisParams(Ljava/lang/String;IIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 310
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "sort"

    invoke-virtual {v0, v1, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 311
    const-string v1, "https://api.weibo.com/2/place/pois/tips.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 312
    return-void
.end method

.method public poisUsers(Ljava/lang/String;IIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "poiid"    # Ljava/lang/String;
    .param p2, "count"    # I
    .param p3, "page"    # I
    .param p4, "base_app"    # Z
    .param p5, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 274
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildPoisParams(Ljava/lang/String;IIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 275
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/pois/users.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 276
    return-void
.end method

.method public pulicTimeline(JZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "count"    # J
    .param p3, "base_app"    # Z
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 81
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 82
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "count"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 83
    const-string v2, "base_app"

    if-eqz p3, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 84
    const-string v1, "https://api.weibo.com/2/place/public_timelin.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 85
    return-void

    .line 83
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public statusesShow(JLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "id"    # J
    .param p3, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 175
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 176
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "id"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 177
    const-string v1, "https://api.weibo.com/2/place/statuses/show.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p3}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 178
    return-void
.end method

.method public userTimeline(JJJIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 11
    .param p1, "uid"    # J
    .param p3, "since_id"    # J
    .param p5, "max_id"    # J
    .param p7, "count"    # I
    .param p8, "page"    # I
    .param p9, "base_app"    # Z
    .param p10, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 117
    move-object v3, p0

    move-wide v4, p3

    move-wide/from16 v6, p5

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v3 .. v9}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildTimeLineParamsBase(JJII)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v2

    .line 118
    .local v2, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v3, "uid"

    invoke-virtual {v2, v3, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 119
    const-string v4, "base_app"

    if-eqz p9, :cond_0

    const/4 v3, 0x1

    :goto_0
    invoke-virtual {v2, v4, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 120
    const-string v3, "https://api.weibo.com/2/place/user_timeline.json"

    const-string v4, "GET"

    move-object/from16 v0, p10

    invoke-virtual {p0, v3, v2, v4, v0}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 121
    return-void

    .line 119
    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public usersCheckins(JIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # J
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 204
    invoke-direct/range {p0 .. p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildUserParams(JIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 205
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/users/checkins.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 206
    return-void
.end method

.method public usersPhotos(JIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # J
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 218
    invoke-direct/range {p0 .. p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildUserParams(JIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 219
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/users/photos.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 220
    return-void
.end method

.method public usersShow(JZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # J
    .param p3, "base_app"    # Z
    .param p4, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 188
    new-instance v0, Lcom/sina/weibo/sdk/net/WeiboParameters;

    iget-object v1, p0, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->mAppKey:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 189
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "uid"

    invoke-virtual {v0, v1, p1, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;J)V

    .line 190
    const-string v2, "base_app"

    if-eqz p3, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v2, v1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;I)V

    .line 191
    const-string v1, "https://api.weibo.com/2/place/users/show.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p4}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 192
    return-void

    .line 190
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public usersTips(JIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # J
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 232
    invoke-direct/range {p0 .. p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildUserParams(JIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 233
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/users/tips.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 234
    return-void
.end method

.method public usersTodo(JIIZLcom/sina/weibo/sdk/net/RequestListener;)V
    .locals 3
    .param p1, "uid"    # J
    .param p3, "count"    # I
    .param p4, "page"    # I
    .param p5, "base_app"    # Z
    .param p6, "listener"    # Lcom/sina/weibo/sdk/net/RequestListener;

    .prologue
    .line 246
    invoke-direct/range {p0 .. p5}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->buildUserParams(JIIZ)Lcom/sina/weibo/sdk/net/WeiboParameters;

    move-result-object v0

    .line 247
    .local v0, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v1, "https://api.weibo.com/2/place/users/todos.json"

    const-string v2, "GET"

    invoke-virtual {p0, v1, v0, v2, p6}, Lcom/sina/weibo/sdk/openapi/legacy/PlaceAPI;->requestAsync(Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;Ljava/lang/String;Lcom/sina/weibo/sdk/net/RequestListener;)V

    .line 248
    return-void
.end method
