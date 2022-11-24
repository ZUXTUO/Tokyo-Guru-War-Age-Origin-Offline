.class public Lcom/payeco/android/plugin/http/biz/UploadFile;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpEntity;


# instance fields
.field private fileParams:Ljava/util/Map;

.field private http:Lcom/payeco/android/plugin/http/comm/Http;

.field private httpParams:Ljava/util/List;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/payeco/android/plugin/http/comm/Http;

    invoke-direct {v0}, Lcom/payeco/android/plugin/http/comm/Http;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    invoke-virtual {v0, p1}, Lcom/payeco/android/plugin/http/comm/Http;->setUrl(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    const-string v1, "upload"

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/Http;->setType(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/Http;->setConnectTimeout(I)V

    invoke-static {}, Lcom/payeco/android/plugin/b/g;->c()Lorg/json/JSONObject;

    move-result-object v1

    const/16 v0, 0x3c

    const-string v2, "ClientTradeOutTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    :try_start_0
    const-string v2, "ClientTradeOutTime"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    invoke-virtual {v1, v0}, Lcom/payeco/android/plugin/http/comm/Http;->setSoTimeout(I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->httpParams:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->fileParams:Ljava/util/Map;

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->httpParams:Ljava/util/List;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/Http;->setHttpParams(Ljava/util/List;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->fileParams:Ljava/util/Map;

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/http/comm/Http;->setFileParams(Ljava/util/Map;)V

    return-void

    :catch_0
    move-exception v1

    goto :goto_0
.end method


# virtual methods
.method public addFile(Ljava/lang/String;Ljava/io/File;)V
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->fileParams:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public addParams(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->httpParams:Ljava/util/List;

    new-instance v1, Lorg/apache/http/message/BasicNameValuePair;

    invoke-direct {v1, p1, p2}, Lorg/apache/http/message/BasicNameValuePair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public getHttp()Lcom/payeco/android/plugin/http/comm/Http;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/biz/UploadFile;->http:Lcom/payeco/android/plugin/http/comm/Http;

    return-object v0
.end method
