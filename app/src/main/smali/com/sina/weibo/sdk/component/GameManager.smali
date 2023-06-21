.class public Lcom/sina/weibo/sdk/component/GameManager;
.super Ljava/lang/Object;
.source "GameManager.java"


# static fields
.field private static final BOUNDARY:Ljava/lang/String;

.field public static final DEFAULT_CHARSET:Ljava/lang/String; = "UTF-8"

.field private static final HTTP_METHOD_GET:Ljava/lang/String; = "GET"

.field private static final HTTP_METHOD_POST:Ljava/lang/String; = "POST"

.field private static INVITATION_ONE_FRINED_URL:Ljava/lang/String; = null

.field private static INVITATION_URL:Ljava/lang/String; = null

.field private static final MULTIPART_FORM_DATA:Ljava/lang/String; = "multipart/form-data"

.field private static final TAG:Ljava/lang/String; = "GameManager"

.field private static URL:Ljava/lang/StringBuffer;

.field private static URL_ACHIEVEMENT_ADD_UPDATE:Ljava/lang/String;

.field private static URL_ACHIEVEMENT_READ_PLAYER_FRIENDS:Ljava/lang/String;

.field private static URL_ACHIEVEMENT_READ_PLAYER_SCORE:Ljava/lang/String;

.field private static URL_ACHIEVEMENT_RELATION_ADD_UPDATE:Ljava/lang/String;

.field private static URL_ACHIEVEMENT_SCORE_ADD_UPDATE:Ljava/lang/String;

.field private static URL_ACHIEVEMENT_USER_GAIN:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 49
    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "https://api.weibo.com/2/proxy/darwin/graph/game/"

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    .line 55
    invoke-static {}, Lcom/sina/weibo/sdk/net/HttpManager;->getBoundry()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->BOUNDARY:Ljava/lang/String;

    .line 59
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "achievement/add.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_ADD_UPDATE:Ljava/lang/String;

    .line 62
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "achievement/gain/add.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_RELATION_ADD_UPDATE:Ljava/lang/String;

    .line 65
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "score/add.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_SCORE_ADD_UPDATE:Ljava/lang/String;

    .line 68
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "score/read_player.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_READ_PLAYER_SCORE:Ljava/lang/String;

    .line 71
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "score/read_player_friends.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_READ_PLAYER_FRIENDS:Ljava/lang/String;

    .line 74
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/sina/weibo/sdk/component/GameManager;->URL:Ljava/lang/StringBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "achievement/user_gain.json"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_USER_GAIN:Ljava/lang/String;

    .line 77
    const-string v0, "http://widget.weibo.com/invitation/app.php?"

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->INVITATION_URL:Ljava/lang/String;

    .line 80
    const-string v0, "http://widget.weibo.com/invitation/appinfo.php?"

    sput-object v0, Lcom/sina/weibo/sdk/component/GameManager;->INVITATION_ONE_FRINED_URL:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static AddOrUpdateGameAchievement(Landroid/content/Context;Lcom/sina/weibo/sdk/net/WeiboParameters;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "params"    # Lcom/sina/weibo/sdk/net/WeiboParameters;

    .prologue
    .line 100
    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v5, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v2, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 101
    .local v2, "myFmt":Ljava/text/SimpleDateFormat;
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    .line 102
    .local v1, "date":Ljava/util/Date;
    const-string v5, "updated_time"

    invoke-virtual {v2, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v5, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    const-string v5, "create_time"

    invoke-virtual {p1, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 105
    .local v4, "time":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 106
    const-string v5, "create_time"

    invoke-virtual {v2, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v5, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 108
    :cond_0
    sget-object v5, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_ADD_UPDATE:Ljava/lang/String;

    const-string v6, "POST"

    invoke-static {p0, v5, v6, p1}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v3

    .line 109
    .local v3, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v3}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 110
    .local v0, "ans":Ljava/lang/String;
    const-string v5, "GameManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "Response : "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 111
    return-object v0
.end method

.method public static addOrUpdateAchievementScore(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "access_token"    # Ljava/lang/String;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "game_id"    # Ljava/lang/String;
    .param p4, "user_id"    # Ljava/lang/String;
    .param p5, "score"    # Ljava/lang/String;

    .prologue
    .line 152
    new-instance v4, Lcom/sina/weibo/sdk/net/WeiboParameters;

    const-string v6, ""

    invoke-direct {v4, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 154
    .local v4, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 155
    const-string v6, "access_token"

    invoke-virtual {v4, v6, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 158
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 159
    const-string v6, "source"

    invoke-virtual {v4, v6, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 161
    :cond_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_2

    .line 162
    const-string v6, "game_id"

    invoke-virtual {v4, v6, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 165
    :cond_2
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_3

    .line 166
    const-string v6, "uid"

    invoke-virtual {v4, v6, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 169
    :cond_3
    invoke-static {p5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_4

    .line 170
    const-string v6, "score"

    invoke-virtual {v4, v6, p5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 173
    :cond_4
    new-instance v3, Ljava/text/SimpleDateFormat;

    const-string v6, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v3, v6}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 174
    .local v3, "myFmt":Ljava/text/SimpleDateFormat;
    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    .line 175
    .local v2, "date":Ljava/util/Date;
    const-string v6, "updated_time"

    invoke-virtual {v3, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 176
    const-string v6, "create_time"

    invoke-virtual {v4, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 177
    .local v1, "create_time":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 178
    const-string v6, "create_time"

    invoke-virtual {v3, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    :cond_5
    sget-object v6, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_SCORE_ADD_UPDATE:Ljava/lang/String;

    const-string v7, "POST"

    invoke-static {p0, v6, v7, v4}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v5

    .line 182
    .local v5, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v5}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 183
    .local v0, "ans":Ljava/lang/String;
    const-string v6, "GameManager"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "Response : "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 184
    return-object v0
.end method

.method public static addOrUpdateGameAchievementRelation(Landroid/content/Context;Lcom/sina/weibo/sdk/net/WeiboParameters;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "params"    # Lcom/sina/weibo/sdk/net/WeiboParameters;

    .prologue
    .line 129
    new-instance v3, Ljava/text/SimpleDateFormat;

    const-string v5, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v3, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 130
    .local v3, "myFmt":Ljava/text/SimpleDateFormat;
    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    .line 131
    .local v2, "date":Ljava/util/Date;
    const-string v5, "updated_time"

    invoke-virtual {v3, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v5, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    const-string v5, "create_time"

    invoke-virtual {p1, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 134
    .local v1, "create_time":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 135
    const-string v5, "create_time"

    invoke-virtual {v3, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v5, v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 137
    :cond_0
    sget-object v5, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_RELATION_ADD_UPDATE:Ljava/lang/String;

    const-string v6, "POST"

    invoke-static {p0, v5, v6, p1}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v4

    .line 138
    .local v4, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v4}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 139
    .local v0, "ans":Ljava/lang/String;
    const-string v5, "GameManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "Response : "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 140
    return-object v0
.end method

.method public static readPlayerAchievementGain(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "access_token"    # Ljava/lang/String;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "game_id"    # Ljava/lang/String;
    .param p4, "user_id"    # Ljava/lang/String;

    .prologue
    .line 264
    new-instance v3, Lcom/sina/weibo/sdk/net/WeiboParameters;

    const-string v5, ""

    invoke-direct {v3, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 266
    .local v3, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 267
    const-string v5, "access_token"

    invoke-virtual {v3, v5, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 270
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 271
    const-string v5, "source"

    invoke-virtual {v3, v5, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 273
    :cond_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 274
    const-string v5, "game_id"

    invoke-virtual {v3, v5, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    :cond_2
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 277
    const-string v5, "uid"

    invoke-virtual {v3, v5, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 280
    :cond_3
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    .line 281
    .local v1, "date":Ljava/util/Date;
    new-instance v2, Ljava/sql/Timestamp;

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v6

    invoke-direct {v2, v6, v7}, Ljava/sql/Timestamp;-><init>(J)V

    .line 282
    .local v2, "nousedate":Ljava/sql/Timestamp;
    const-string v5, "create_time"

    invoke-virtual {v3, v5, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/Object;)V

    .line 284
    sget-object v5, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_USER_GAIN:Ljava/lang/String;

    const-string v6, "GET"

    invoke-static {p0, v5, v6, v3}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v4

    .line 285
    .local v4, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v4}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 286
    .local v0, "ans":Ljava/lang/String;
    const-string v5, "GameManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "Response : "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 287
    return-object v0
.end method

.method public static readPlayerFriendsScoreInfo(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "access_token"    # Ljava/lang/String;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "game_id"    # Ljava/lang/String;
    .param p4, "user_id"    # Ljava/lang/String;

    .prologue
    .line 229
    new-instance v3, Lcom/sina/weibo/sdk/net/WeiboParameters;

    const-string v5, ""

    invoke-direct {v3, v5}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 231
    .local v3, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 232
    const-string v5, "access_token"

    invoke-virtual {v3, v5, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 234
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 235
    const-string v5, "source"

    invoke-virtual {v3, v5, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 237
    :cond_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 238
    const-string v5, "game_id"

    invoke-virtual {v3, v5, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 240
    :cond_2
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 241
    const-string v5, "uid"

    invoke-virtual {v3, v5, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    :cond_3
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    .line 246
    .local v1, "date":Ljava/util/Date;
    new-instance v2, Ljava/sql/Timestamp;

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v6

    invoke-direct {v2, v6, v7}, Ljava/sql/Timestamp;-><init>(J)V

    .line 247
    .local v2, "nousedate":Ljava/sql/Timestamp;
    const-string v5, "create_time"

    invoke-virtual {v3, v5, v2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/Object;)V

    .line 249
    sget-object v5, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_READ_PLAYER_FRIENDS:Ljava/lang/String;

    const-string v6, "GET"

    invoke-static {p0, v5, v6, v3}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v4

    .line 250
    .local v4, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v4}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 251
    .local v0, "ans":Ljava/lang/String;
    const-string v5, "GameManager"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "Response : "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 252
    return-object v0
.end method

.method public static readPlayerScoreInfo(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "access_token"    # Ljava/lang/String;
    .param p2, "appKey"    # Ljava/lang/String;
    .param p3, "game_id"    # Ljava/lang/String;
    .param p4, "user_id"    # Ljava/lang/String;

    .prologue
    .line 199
    new-instance v1, Lcom/sina/weibo/sdk/net/WeiboParameters;

    const-string v3, ""

    invoke-direct {v1, v3}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 200
    .local v1, "params":Lcom/sina/weibo/sdk/net/WeiboParameters;
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 201
    const-string v3, "access_token"

    invoke-virtual {v1, v3, p1}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 204
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 205
    const-string v3, "source"

    invoke-virtual {v1, v3, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 207
    :cond_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 208
    const-string v3, "game_id"

    invoke-virtual {v1, v3, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 210
    :cond_2
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 211
    const-string v3, "uid"

    invoke-virtual {v1, v3, p4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 214
    :cond_3
    sget-object v3, Lcom/sina/weibo/sdk/component/GameManager;->URL_ACHIEVEMENT_READ_PLAYER_SCORE:Ljava/lang/String;

    const-string v4, "GET"

    invoke-static {p0, v3, v4, v1}, Lcom/sina/weibo/sdk/component/GameManager;->requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;

    move-result-object v2

    .line 215
    .local v2, "response":Lorg/apache/http/HttpResponse;
    invoke-static {v2}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v0

    .line 216
    .local v0, "ans":Ljava/lang/String;
    const-string v3, "GameManager"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Response : "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 217
    return-object v0
.end method

.method private static requestHttpExecute(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/net/WeiboParameters;)Lorg/apache/http/HttpResponse;
    .locals 16
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "method"    # Ljava/lang/String;
    .param p3, "params"    # Lcom/sina/weibo/sdk/net/WeiboParameters;

    .prologue
    .line 378
    const/4 v3, 0x0

    .line 379
    .local v3, "client":Lorg/apache/http/client/HttpClient;
    const/4 v1, 0x0

    .line 380
    .local v1, "baos":Ljava/io/ByteArrayOutputStream;
    const/4 v8, 0x0

    .line 386
    .local v8, "response":Lorg/apache/http/HttpResponse;
    :try_start_0
    invoke-static {}, Lcom/sina/weibo/sdk/net/HttpManager;->getNewHttpClient()Lorg/apache/http/client/HttpClient;

    move-result-object v3

    .line 387
    invoke-interface {v3}, Lorg/apache/http/client/HttpClient;->getParams()Lorg/apache/http/params/HttpParams;

    move-result-object v13

    const-string v14, "http.route.default-proxy"

    invoke-static {}, Lcom/sina/weibo/sdk/net/NetStateManager;->getAPN()Lorg/apache/http/HttpHost;

    move-result-object v15

    invoke-interface {v13, v14, v15}, Lorg/apache/http/params/HttpParams;->setParameter(Ljava/lang/String;Ljava/lang/Object;)Lorg/apache/http/params/HttpParams;

    .line 389
    const/4 v7, 0x0

    .line 396
    .local v7, "request":Lorg/apache/http/client/methods/HttpUriRequest;
    const-string v13, "GET"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    .line 397
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-static/range {p1 .. p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v14, "?"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual/range {p3 .. p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->encodeUrl()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 398
    new-instance v7, Lorg/apache/http/client/methods/HttpGet;

    .end local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    move-object/from16 v0, p1

    invoke-direct {v7, v0}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    .line 399
    .restart local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    const-string v13, "GameManager"

    new-instance v14, Ljava/lang/StringBuilder;

    const-string v15, "requestHttpExecute GET Url : "

    invoke-direct {v14, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, p1

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 431
    :cond_0
    :goto_0
    invoke-interface {v3, v7}, Lorg/apache/http/client/HttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v8

    .line 432
    invoke-interface {v8}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v10

    .line 433
    .local v10, "status":Lorg/apache/http/StatusLine;
    invoke-interface {v10}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v11

    .line 436
    .local v11, "statusCode":I
    const/16 v13, 0xc8

    if-eq v11, v13, :cond_6

    .line 437
    invoke-static {v8}, Lcom/sina/weibo/sdk/net/HttpManager;->readRsponse(Lorg/apache/http/HttpResponse;)Ljava/lang/String;

    move-result-object v9

    .line 438
    .local v9, "result":Ljava/lang/String;
    new-instance v13, Lcom/sina/weibo/sdk/exception/WeiboHttpException;

    invoke-direct {v13, v9, v11}, Lcom/sina/weibo/sdk/exception/WeiboHttpException;-><init>(Ljava/lang/String;I)V

    throw v13
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 440
    .end local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    .end local v9    # "result":Ljava/lang/String;
    .end local v10    # "status":Lorg/apache/http/StatusLine;
    .end local v11    # "statusCode":I
    :catch_0
    move-exception v4

    .line 441
    .local v4, "e":Ljava/io/IOException;
    :goto_1
    :try_start_1
    new-instance v13, Lcom/sina/weibo/sdk/exception/WeiboException;

    invoke-direct {v13, v4}, Lcom/sina/weibo/sdk/exception/WeiboException;-><init>(Ljava/lang/Throwable;)V

    throw v13
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 442
    .end local v4    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v13

    .line 443
    :goto_2
    if-eqz v1, :cond_1

    .line 445
    :try_start_2
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 449
    :cond_1
    :goto_3
    invoke-static {v3}, Lcom/sina/weibo/sdk/net/HttpManager;->shutdownHttpClient(Lorg/apache/http/client/HttpClient;)V

    .line 450
    throw v13

    .line 401
    .restart local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    :cond_2
    :try_start_3
    const-string v13, "POST"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_5

    .line 402
    const-string v13, "GameManager"

    new-instance v14, Ljava/lang/StringBuilder;

    const-string v15, "requestHttpExecute POST Url : "

    invoke-direct {v14, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, p1

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 403
    new-instance v5, Lorg/apache/http/client/methods/HttpPost;

    move-object/from16 v0, p1

    invoke-direct {v5, v0}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    .line 404
    .local v5, "post":Lorg/apache/http/client/methods/HttpPost;
    move-object v7, v5

    .line 406
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 407
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    .local v2, "baos":Ljava/io/ByteArrayOutputStream;
    :try_start_4
    invoke-virtual/range {p3 .. p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->hasBinaryData()Z

    move-result v13

    if-eqz v13, :cond_3

    .line 408
    const-string v13, "Content-Type"

    new-instance v14, Ljava/lang/StringBuilder;

    const-string v15, "multipart/form-data; boundary="

    invoke-direct {v14, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v15, Lcom/sina/weibo/sdk/component/GameManager;->BOUNDARY:Ljava/lang/String;

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v5, v13, v14}, Lorg/apache/http/client/methods/HttpPost;->setHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 409
    move-object/from16 v0, p3

    invoke-static {v2, v0}, Lcom/sina/weibo/sdk/net/HttpManager;->buildParams(Ljava/io/OutputStream;Lcom/sina/weibo/sdk/net/WeiboParameters;)V

    .line 424
    :goto_4
    new-instance v13, Lorg/apache/http/entity/ByteArrayEntity;

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v14

    invoke-direct {v13, v14}, Lorg/apache/http/entity/ByteArrayEntity;-><init>([B)V

    invoke-virtual {v5, v13}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    move-object v1, v2

    .line 426
    .end local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    goto/16 :goto_0

    .line 411
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    :cond_3
    const-string v13, "content-type"

    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Lcom/sina/weibo/sdk/net/WeiboParameters;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    .line 412
    .local v12, "value":Ljava/lang/Object;
    if-eqz v12, :cond_4

    instance-of v13, v12, Ljava/lang/String;

    if-eqz v13, :cond_4

    .line 413
    const-string v13, "content-type"

    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Lcom/sina/weibo/sdk/net/WeiboParameters;->remove(Ljava/lang/String;)V

    .line 414
    const-string v13, "Content-Type"

    check-cast v12, Ljava/lang/String;

    .end local v12    # "value":Ljava/lang/Object;
    invoke-virtual {v5, v13, v12}, Lorg/apache/http/client/methods/HttpPost;->setHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 420
    :goto_5
    invoke-virtual/range {p3 .. p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->encodeUrl()Ljava/lang/String;

    move-result-object v6

    .line 421
    .local v6, "postParam":Ljava/lang/String;
    const-string v13, "GameManager"

    new-instance v14, Ljava/lang/StringBuilder;

    const-string v15, "requestHttpExecute POST postParam : "

    invoke-direct {v14, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v14, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Lcom/sina/weibo/sdk/utils/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 422
    const-string v13, "UTF-8"

    invoke-virtual {v6, v13}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v13

    invoke-virtual {v2, v13}, Ljava/io/ByteArrayOutputStream;->write([B)V

    goto :goto_4

    .line 440
    .end local v6    # "postParam":Ljava/lang/String;
    :catch_1
    move-exception v4

    move-object v1, v2

    .end local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    goto/16 :goto_1

    .line 416
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v12    # "value":Ljava/lang/Object;
    :cond_4
    const-string v13, "Content-Type"

    const-string v14, "application/x-www-form-urlencoded"

    invoke-virtual {v5, v13, v14}, Lorg/apache/http/client/methods/HttpPost;->setHeader(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_5

    .line 442
    .end local v12    # "value":Ljava/lang/Object;
    :catchall_1
    move-exception v13

    move-object v1, v2

    .end local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    goto/16 :goto_2

    .line 426
    .end local v5    # "post":Lorg/apache/http/client/methods/HttpPost;
    :cond_5
    :try_start_5
    const-string v13, "DELETE"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_0

    .line 427
    new-instance v7, Lorg/apache/http/client/methods/HttpDelete;

    .end local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    move-object/from16 v0, p1

    invoke-direct {v7, v0}, Lorg/apache/http/client/methods/HttpDelete;-><init>(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .restart local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    goto/16 :goto_0

    .line 443
    .restart local v10    # "status":Lorg/apache/http/StatusLine;
    .restart local v11    # "statusCode":I
    :cond_6
    if-eqz v1, :cond_7

    .line 445
    :try_start_6
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 449
    :cond_7
    :goto_6
    invoke-static {v3}, Lcom/sina/weibo/sdk/net/HttpManager;->shutdownHttpClient(Lorg/apache/http/client/HttpClient;)V

    .line 452
    return-object v8

    .line 446
    .end local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    .end local v10    # "status":Lorg/apache/http/StatusLine;
    .end local v11    # "statusCode":I
    :catch_2
    move-exception v14

    goto/16 :goto_3

    .restart local v7    # "request":Lorg/apache/http/client/methods/HttpUriRequest;
    .restart local v10    # "status":Lorg/apache/http/StatusLine;
    .restart local v11    # "statusCode":I
    :catch_3
    move-exception v13

    goto :goto_6
.end method


# virtual methods
.method public invatationWeiboFriendsByList(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "access_token"    # Ljava/lang/String;
    .param p3, "appKey"    # Ljava/lang/String;
    .param p4, "title"    # Ljava/lang/String;
    .param p5, "listener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .prologue
    .line 304
    new-instance v4, Lcom/sina/weibo/sdk/net/WeiboParameters;

    invoke-direct {v4, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 305
    .local v4, "requestParams":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v5, "access_token"

    invoke-virtual {v4, v5, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 306
    const-string v5, "source"

    invoke-virtual {v4, v5, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 308
    new-instance v5, Ljava/lang/StringBuilder;

    sget-object v6, Lcom/sina/weibo/sdk/component/GameManager;->INVITATION_URL:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Lcom/sina/weibo/sdk/net/WeiboParameters;->encodeUrl()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 310
    .local v0, "UrlStr":Ljava/lang/String;
    new-instance v3, Lcom/sina/weibo/sdk/component/GameRequestParam;

    invoke-direct {v3, p1}, Lcom/sina/weibo/sdk/component/GameRequestParam;-><init>(Landroid/content/Context;)V

    .line 311
    .local v3, "reqParam":Lcom/sina/weibo/sdk/component/GameRequestParam;
    invoke-virtual {v3, p3}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setAppKey(Ljava/lang/String;)V

    .line 312
    invoke-virtual {v3, p2}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setToken(Ljava/lang/String;)V

    .line 313
    sget-object v5, Lcom/sina/weibo/sdk/component/BrowserLauncher;->GAME:Lcom/sina/weibo/sdk/component/BrowserLauncher;

    invoke-virtual {v3, v5}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setLauncher(Lcom/sina/weibo/sdk/component/BrowserLauncher;)V

    .line 314
    invoke-virtual {v3, v0}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setUrl(Ljava/lang/String;)V

    .line 315
    invoke-virtual {v3, p5}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setAuthListener(Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V

    .line 316
    new-instance v2, Landroid/content/Intent;

    const-class v5, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;

    invoke-direct {v2, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 317
    .local v2, "intent":Landroid/content/Intent;
    invoke-virtual {v3}, Lcom/sina/weibo/sdk/component/GameRequestParam;->createRequestParamBundle()Landroid/os/Bundle;

    move-result-object v1

    .line 318
    .local v1, "data":Landroid/os/Bundle;
    const-string v5, "key_specify_title"

    invoke-virtual {v1, v5, p4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 319
    invoke-virtual {v2, v1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    .line 320
    invoke-virtual {p1, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 321
    return-void
.end method

.method public invatationWeiboFriendsInOnePage(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;Ljava/util/ArrayList;)V
    .locals 11
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "access_token"    # Ljava/lang/String;
    .param p3, "appKey"    # Ljava/lang/String;
    .param p4, "title"    # Ljava/lang/String;
    .param p5, "listener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/sina/weibo/sdk/auth/WeiboAuthListener;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 334
    .local p6, "userIdList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    new-instance v8, Ljava/lang/StringBuffer;

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    .line 335
    .local v8, "userIds":Ljava/lang/StringBuffer;
    if-eqz p6, :cond_0

    .line 336
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual/range {p6 .. p6}, Ljava/util/ArrayList;->size()I

    move-result v9

    if-lt v3, v9, :cond_1

    .line 346
    .end local v3    # "i":I
    :cond_0
    new-instance v6, Lcom/sina/weibo/sdk/net/WeiboParameters;

    invoke-direct {v6, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;-><init>(Ljava/lang/String;)V

    .line 347
    .local v6, "requestParams":Lcom/sina/weibo/sdk/net/WeiboParameters;
    const-string v9, "access_token"

    invoke-virtual {v6, v9, p2}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 348
    const-string v9, "source"

    invoke-virtual {v6, v9, p3}, Lcom/sina/weibo/sdk/net/WeiboParameters;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    new-instance v9, Ljava/lang/StringBuilder;

    sget-object v10, Lcom/sina/weibo/sdk/component/GameManager;->INVITATION_ONE_FRINED_URL:Ljava/lang/String;

    invoke-virtual {v10}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Lcom/sina/weibo/sdk/net/WeiboParameters;->encodeUrl()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "&uids="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v8}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 352
    .local v1, "UrlStr":Ljava/lang/String;
    new-instance v5, Lcom/sina/weibo/sdk/component/GameRequestParam;

    invoke-direct {v5, p1}, Lcom/sina/weibo/sdk/component/GameRequestParam;-><init>(Landroid/content/Context;)V

    .line 353
    .local v5, "reqParam":Lcom/sina/weibo/sdk/component/GameRequestParam;
    invoke-virtual {v5, p3}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setAppKey(Ljava/lang/String;)V

    .line 354
    invoke-virtual {v5, p2}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setToken(Ljava/lang/String;)V

    .line 355
    sget-object v9, Lcom/sina/weibo/sdk/component/BrowserLauncher;->GAME:Lcom/sina/weibo/sdk/component/BrowserLauncher;

    invoke-virtual {v5, v9}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setLauncher(Lcom/sina/weibo/sdk/component/BrowserLauncher;)V

    .line 356
    invoke-virtual {v5, v1}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setUrl(Ljava/lang/String;)V

    .line 357
    move-object/from16 v0, p5

    invoke-virtual {v5, v0}, Lcom/sina/weibo/sdk/component/GameRequestParam;->setAuthListener(Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V

    .line 358
    new-instance v4, Landroid/content/Intent;

    const-class v9, Lcom/sina/weibo/sdk/component/WeiboSdkBrowser;

    invoke-direct {v4, p1, v9}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 359
    .local v4, "intent":Landroid/content/Intent;
    invoke-virtual {v5}, Lcom/sina/weibo/sdk/component/GameRequestParam;->createRequestParamBundle()Landroid/os/Bundle;

    move-result-object v2

    .line 360
    .local v2, "data":Landroid/os/Bundle;
    const-string v9, "key_specify_title"

    invoke-virtual {v2, v9, p4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 361
    invoke-virtual {v4, v2}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    .line 362
    invoke-virtual {p1, v4}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 364
    return-void

    .line 337
    .end local v1    # "UrlStr":Ljava/lang/String;
    .end local v2    # "data":Landroid/os/Bundle;
    .end local v4    # "intent":Landroid/content/Intent;
    .end local v5    # "reqParam":Lcom/sina/weibo/sdk/component/GameRequestParam;
    .end local v6    # "requestParams":Lcom/sina/weibo/sdk/net/WeiboParameters;
    .restart local v3    # "i":I
    :cond_1
    move-object/from16 v0, p6

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 338
    .local v7, "user":Ljava/lang/String;
    if-nez v3, :cond_2

    .line 339
    invoke-virtual {v8, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 336
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 341
    :cond_2
    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, ","

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_1
.end method
