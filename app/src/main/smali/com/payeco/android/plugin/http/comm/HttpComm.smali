.class public Lcom/payeco/android/plugin/http/comm/HttpComm;
.super Ljava/lang/Object;


# instance fields
.field private httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

.field private httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

.field private httpExecute:Lcom/payeco/android/plugin/http/itf/IHttpExecute;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getHttpCallBack()Lcom/payeco/android/plugin/http/itf/IHttpCallBack;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    return-object v0
.end method

.method public getHttpEntity()Lcom/payeco/android/plugin/http/itf/IHttpEntity;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

    return-object v0
.end method

.method public getHttpExecute()Lcom/payeco/android/plugin/http/itf/IHttpExecute;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpExecute:Lcom/payeco/android/plugin/http/itf/IHttpExecute;

    return-object v0
.end method

.method public request()V
    .locals 3

    iget-object v0, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpExecute:Lcom/payeco/android/plugin/http/itf/IHttpExecute;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

    iget-object v2, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    invoke-interface {v0, v1, v2}, Lcom/payeco/android/plugin/http/itf/IHttpExecute;->exec(Lcom/payeco/android/plugin/http/itf/IHttpEntity;Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V

    return-void
.end method

.method public setHttpCallBack(Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    return-void
.end method

.method public setHttpEntity(Lcom/payeco/android/plugin/http/itf/IHttpEntity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

    return-void
.end method

.method public setHttpExecute(Lcom/payeco/android/plugin/http/itf/IHttpExecute;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/http/comm/HttpComm;->httpExecute:Lcom/payeco/android/plugin/http/itf/IHttpExecute;

    return-void
.end method
