.class public final Lcom/sina/weibo/sdk/call/WeiboPageUtilsV2;
.super Ljava/lang/Object;
.source "WeiboPageUtilsV2.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    return-void
.end method

.method public static displayInWeiboMap(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 723
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 724
    new-instance v5, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v6, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v5, v6}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 727
    :cond_0
    const-string v2, "http://weibo.cn/dpool/ttt/maps.php?xy=%s,%s&amp;size=320x320&amp;offset=%s"

    .line 728
    .local v2, "mapUrl":Ljava/lang/String;
    const-string v1, ""

    .line 729
    .local v1, "lon":Ljava/lang/String;
    const-string v0, ""

    .line 730
    .local v0, "lat":Ljava/lang/String;
    const-string v3, ""

    .line 732
    .local v3, "offset":Ljava/lang/String;
    if-eqz p1, :cond_1

    .line 733
    const-string v5, "longitude"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "lon":Ljava/lang/String;
    check-cast v1, Ljava/lang/String;

    .line 734
    .restart local v1    # "lon":Ljava/lang/String;
    const-string v5, "latitude"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "lat":Ljava/lang/String;
    check-cast v0, Ljava/lang/String;

    .line 735
    .restart local v0    # "lat":Ljava/lang/String;
    const-string v5, "offset"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .end local v3    # "offset":Ljava/lang/String;
    check-cast v3, Ljava/lang/String;

    .line 738
    .restart local v3    # "offset":Ljava/lang/String;
    :cond_1
    const/4 v4, 0x0

    .line 739
    .local v4, "packageName":Ljava/lang/String;
    if-eqz p1, :cond_2

    const-string v5, "packagename"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 740
    const-string v5, "packagename"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .end local v4    # "packageName":Ljava/lang/String;
    check-cast v4, Ljava/lang/String;

    .line 742
    .restart local v4    # "packageName":Ljava/lang/String;
    :cond_2
    if-eqz p1, :cond_3

    .line 743
    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v1, v5, v6

    const/4 v6, 0x1

    aput-object v0, v5, v6

    const/4 v6, 0x2

    aput-object v3, v5, v6

    invoke-static {v2, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "default"

    .line 744
    const-string v5, "extparam"

    invoke-virtual {p1, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 743
    invoke-static {p0, v6, v7, v5, v4}, Lcom/sina/weibo/sdk/call/WeiboPageUtilsV2;->openInWeiboBrowser(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 747
    :cond_3
    return-void
.end method

.method public static openInWeiboBrowser(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "sinainternalbrowser"    # Ljava/lang/String;
    .param p3, "extParam"    # Ljava/lang/String;
    .param p4, "packageName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 667
    if-nez p0, :cond_0

    .line 668
    new-instance v3, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v4, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v3, v4}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 671
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 672
    new-instance v3, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v4, "url\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v3, v4}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 675
    :cond_1
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 676
    const-string v3, "topnav"

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "default"

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 677
    const-string v3, "fullscreen"

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 678
    new-instance v3, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    .line 679
    const-string v4, "sinainternalbrowser\u4e0d\u5408\u6cd5"

    .line 678
    invoke-direct {v3, v4}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 683
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "sinaweibo://browser"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 685
    .local v2, "uri":Ljava/lang/StringBuilder;
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 687
    .local v1, "paramMap":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v3, "url"

    invoke-virtual {v1, v3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 688
    const-string v3, "sinainternalbrowser"

    invoke-virtual {v1, v3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 689
    const-string v3, "extparam"

    invoke-virtual {v1, v3, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 691
    invoke-static {v1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 693
    const/4 v0, 0x0

    .line 694
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 695
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v3, "sinaweibo://browser"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 696
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz v1, :cond_3

    .line 697
    invoke-static {v1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 700
    :cond_3
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v3, v4, p4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 704
    :goto_0
    return-void

    .line 702
    :cond_4
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-static {p0, v3, v4, v5}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static openQrcodeScanner(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 764
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 765
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 767
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://qrcode"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 769
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_1

    .line 770
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 773
    :cond_1
    const/4 v0, 0x0

    .line 774
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 775
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://qrcode"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 776
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_2

    .line 777
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 780
    :cond_2
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 781
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 780
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 785
    :goto_0
    return-void

    .line 783
    :cond_3
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static postNewWeibo(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 67
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 68
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 71
    :cond_0
    const/4 v1, 0x0

    .line 73
    .local v1, "uri":Ljava/lang/StringBuilder;
    new-instance v1, Ljava/lang/StringBuilder;

    .end local v1    # "uri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://sendweibo"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 74
    .restart local v1    # "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_1

    .line 75
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 78
    :cond_1
    const/4 v0, 0x0

    .line 79
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 80
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://sendweibo"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 83
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_2

    .line 84
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 87
    :cond_2
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 88
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 87
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    :goto_0
    return-void

    .line 90
    :cond_3
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewNearbyPeople(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 116
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 117
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 120
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://nearbypeople"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 121
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_1

    .line 122
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 124
    :cond_1
    const/4 v0, 0x0

    .line 125
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 126
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://nearbypeople"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 129
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_2

    .line 130
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 133
    :cond_2
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 134
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 133
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    :goto_0
    return-void

    .line 136
    :cond_3
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewNearbyWeibo(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 162
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 163
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 166
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://nearbyweibo"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 168
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_1

    .line 169
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 172
    :cond_1
    const/4 v0, 0x0

    .line 173
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 174
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://nearbyweibo"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 177
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_2

    .line 178
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 181
    :cond_2
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 182
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 181
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 187
    :goto_0
    return-void

    .line 184
    :cond_3
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewPageDetailInfo(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 613
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 614
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 616
    :cond_0
    if-nez p1, :cond_1

    .line 617
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 620
    :cond_1
    const-string v2, "pageid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 621
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 623
    :cond_2
    const-string v2, "cardid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 624
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "cardId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 627
    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://pagedetailinfo"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 629
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_4

    .line 630
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 633
    :cond_4
    const/4 v0, 0x0

    .line 634
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_6

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_6

    .line 635
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://pagedetailinfo"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 636
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    .line 637
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 640
    :cond_5
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 641
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 640
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 645
    :goto_0
    return-void

    .line 643
    :cond_6
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewPageInfo(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 301
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 302
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 304
    :cond_0
    if-eqz p1, :cond_1

    const-string v2, "pageid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 305
    :cond_1
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 308
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://pageinfo"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 310
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    .line 311
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 314
    :cond_3
    const/4 v0, 0x0

    .line 315
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 316
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://pageinfo"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 317
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_4

    .line 318
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    :cond_4
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 322
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 321
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 326
    :goto_0
    return-void

    .line 324
    :cond_5
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewPagePhotoList(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 550
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 551
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 553
    :cond_0
    if-nez p1, :cond_1

    .line 554
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 557
    :cond_1
    const-string v4, "pageid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 558
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 560
    :cond_2
    const-string v4, "cardid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 561
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "cardId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 563
    :cond_3
    const/4 v0, -0x1

    .line 565
    .local v0, "count":I
    :try_start_0
    const-string v4, "count"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 569
    :goto_0
    if-gez v0, :cond_4

    .line 570
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "count\u4e0d\u80fd\u4e3a\u8d1f\u6570"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 566
    :catch_0
    move-exception v1

    .line 567
    .local v1, "e":Ljava/lang/NumberFormatException;
    const/4 v0, -0x1

    goto :goto_0

    .line 573
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    :cond_4
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "sinaweibo://pagephotolist"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 574
    .local v3, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    .line 575
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 578
    :cond_5
    const/4 v2, 0x0

    .line 579
    .local v2, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_7

    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_7

    .line 580
    new-instance v2, Ljava/lang/StringBuilder;

    .end local v2    # "packageuri":Ljava/lang/StringBuilder;
    const-string v4, "sinaweibo://pagephotolist"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 581
    .restart local v2    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_6

    .line 582
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 585
    :cond_6
    const-string v5, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 586
    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 585
    invoke-static {p0, v5, v6, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 590
    :goto_1
    return-void

    .line 588
    :cond_7
    const-string v4, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {p0, v4, v5, v6}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static viewPageProductList(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 351
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 352
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 355
    :cond_0
    if-nez p1, :cond_1

    .line 356
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 359
    :cond_1
    const-string v4, "pageid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 360
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 362
    :cond_2
    const-string v4, "cardid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 363
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "cardId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 365
    :cond_3
    const/4 v0, -0x1

    .line 367
    .local v0, "count":I
    :try_start_0
    const-string v4, "count"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 371
    :goto_0
    if-gez v0, :cond_4

    .line 372
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "count\u4e0d\u80fd\u4e3a\u8d1f\u6570"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 368
    :catch_0
    move-exception v1

    .line 369
    .local v1, "e":Ljava/lang/NumberFormatException;
    const/4 v0, -0x1

    goto :goto_0

    .line 375
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    :cond_4
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "sinaweibo://pageproductlist"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 377
    .local v3, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    .line 378
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 381
    :cond_5
    const/4 v2, 0x0

    .line 382
    .local v2, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_7

    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_7

    .line 383
    new-instance v2, Ljava/lang/StringBuilder;

    .end local v2    # "packageuri":Ljava/lang/StringBuilder;
    const-string v4, "sinaweibo://pageproductlist"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 384
    .restart local v2    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_6

    .line 385
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 388
    :cond_6
    const-string v5, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 389
    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 388
    invoke-static {p0, v5, v6, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 393
    :goto_1
    return-void

    .line 391
    :cond_7
    const-string v4, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {p0, v4, v5, v6}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static viewPageUserList(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 418
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 419
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 421
    :cond_0
    if-nez p1, :cond_1

    .line 422
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 425
    :cond_1
    const-string v4, "pageid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 426
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 428
    :cond_2
    const-string v4, "cardid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 429
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "cardId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 431
    :cond_3
    const/4 v0, -0x1

    .line 433
    .local v0, "count":I
    :try_start_0
    const-string v4, "count"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 437
    :goto_0
    if-gez v0, :cond_4

    .line 438
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "count\u4e0d\u80fd\u4e3a\u8d1f\u6570"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 434
    :catch_0
    move-exception v1

    .line 435
    .local v1, "e":Ljava/lang/NumberFormatException;
    const/4 v0, -0x1

    goto :goto_0

    .line 441
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    :cond_4
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "sinaweibo://pageuserlist"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 443
    .local v3, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    .line 444
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 447
    :cond_5
    const/4 v2, 0x0

    .line 448
    .local v2, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_7

    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_7

    .line 449
    new-instance v2, Ljava/lang/StringBuilder;

    .end local v2    # "packageuri":Ljava/lang/StringBuilder;
    const-string v4, "sinaweibo://pageuserlist"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 450
    .restart local v2    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_6

    .line 451
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    :cond_6
    const-string v5, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 455
    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 454
    invoke-static {p0, v5, v6, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 459
    :goto_1
    return-void

    .line 457
    :cond_7
    const-string v4, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {p0, v4, v5, v6}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static viewPageWeiboList(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 484
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 485
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 487
    :cond_0
    if-nez p1, :cond_1

    .line 488
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 491
    :cond_1
    const-string v4, "pageid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 492
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "pageId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 494
    :cond_2
    const-string v4, "cardid"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 495
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "cardId\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 497
    :cond_3
    const/4 v0, -0x1

    .line 499
    .local v0, "count":I
    :try_start_0
    const-string v4, "count"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 503
    :goto_0
    if-gez v0, :cond_4

    .line 504
    new-instance v4, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v5, "count\u4e0d\u80fd\u4e3a\u8d1f\u6570"

    invoke-direct {v4, v5}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 500
    :catch_0
    move-exception v1

    .line 501
    .local v1, "e":Ljava/lang/NumberFormatException;
    const/4 v0, -0x1

    goto :goto_0

    .line 507
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    :cond_4
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "sinaweibo://pageweibolist"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 509
    .local v3, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    .line 510
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 513
    :cond_5
    const/4 v2, 0x0

    .line 514
    .local v2, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_7

    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_7

    .line 515
    new-instance v2, Ljava/lang/StringBuilder;

    .end local v2    # "packageuri":Ljava/lang/StringBuilder;
    const-string v4, "sinaweibo://pageweibolist"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 516
    .restart local v2    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_6

    .line 517
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 520
    :cond_6
    const-string v5, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 521
    const-string v4, "packagename"

    invoke-virtual {p1, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 520
    invoke-static {p0, v5, v6, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 525
    :goto_1
    return-void

    .line 523
    :cond_7
    const-string v4, "android.intent.action.VIEW"

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {p0, v4, v5, v6}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static viewUserInfo(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 209
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 210
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 213
    :cond_0
    if-eqz p1, :cond_1

    const-string v2, "uid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 214
    const-string v2, "nick"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 215
    :cond_1
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "uid\u548cnick\u5fc5\u987b\u81f3\u5c11\u6709\u4e00\u4e2a\u4e0d\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 218
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://userinfo"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 220
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    .line 221
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 223
    :cond_3
    const/4 v0, 0x0

    .line 224
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 225
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://userinfo"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 228
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_4

    .line 229
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    :cond_4
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 233
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 232
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 237
    :goto_0
    return-void

    .line 235
    :cond_5
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static viewUsertrends(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 256
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 257
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 259
    :cond_0
    if-eqz p1, :cond_1

    const-string v2, "uid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 260
    :cond_1
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "uid\u548cnick\u5fc5\u987b\u81f3\u5c11\u6709\u4e00\u4e2a\u4e0d\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 263
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://usertrends"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 264
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    .line 265
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 268
    :cond_3
    const/4 v0, 0x0

    .line 269
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 270
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://usertrends"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 271
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_4

    .line 272
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 275
    :cond_4
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 276
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 275
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 280
    :goto_0
    return-void

    .line 278
    :cond_5
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static weiboDetail(Landroid/content/Context;Ljava/util/HashMap;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sina/weibo/sdk/call/WeiboNotInstalledException;
        }
    .end annotation

    .prologue
    .line 804
    .local p1, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p0, :cond_0

    .line 805
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "context\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 807
    :cond_0
    if-nez p1, :cond_1

    .line 808
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "mblogId(\u5fae\u535aid)\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 811
    :cond_1
    const-string v2, "mblogid"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 812
    new-instance v2, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;

    const-string v3, "mblogId(\u5fae\u535aid)\u4e0d\u80fd\u4e3a\u7a7a"

    invoke-direct {v2, v3}, Lcom/sina/weibo/sdk/call/WeiboIllegalParameterException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 815
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sinaweibo://detail"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 817
    .local v1, "uri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_3

    .line 818
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 820
    :cond_3
    const/4 v0, 0x0

    .line 821
    .local v0, "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_5

    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 822
    new-instance v0, Ljava/lang/StringBuilder;

    .end local v0    # "packageuri":Ljava/lang/StringBuilder;
    const-string v2, "sinaweibo://detail"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 823
    .restart local v0    # "packageuri":Ljava/lang/StringBuilder;
    if-eqz p1, :cond_4

    .line 824
    invoke-static {p1}, Lcom/sina/weibo/sdk/call/CommonUtils;->buildUriQuery(Ljava/util/HashMap;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 827
    :cond_4
    const-string v3, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 828
    const-string v2, "packagename"

    invoke-virtual {p1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 827
    invoke-static {p0, v3, v4, v2}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 832
    :goto_0
    return-void

    .line 830
    :cond_5
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v3, v4}, Lcom/sina/weibo/sdk/call/CommonUtils;->openWeiboActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
