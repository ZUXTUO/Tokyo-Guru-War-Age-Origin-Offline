.class public Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;
.super Landroid/os/AsyncTask;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpExecute;


# instance fields
.field private exception:Ljava/lang/Exception;

.field private httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

.field private httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge varargs synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->doInBackground([Ljava/lang/Void;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

    invoke-interface {v0}, Lcom/payeco/android/plugin/http/itf/IHttpEntity;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v0

    :try_start_0
    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/comm/Http;->send()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    iput-object v0, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->exception:Ljava/lang/Exception;

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public exec(Lcom/payeco/android/plugin/http/itf/IHttpEntity;Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V
    .locals 1

    iput-object p1, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->httpEntity:Lcom/payeco/android/plugin/http/itf/IHttpEntity;

    iput-object p2, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Void;

    invoke-virtual {p0, v0}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/String;)V
    .locals 2

    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    iget-object v1, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->exception:Ljava/lang/Exception;

    invoke-interface {v0, v1}, Lcom/payeco/android/plugin/http/itf/IHttpCallBack;->fail(Ljava/lang/Exception;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/http/itf/impl/AsyncExecute;->httpCallBack:Lcom/payeco/android/plugin/http/itf/IHttpCallBack;

    invoke-interface {v0, p1}, Lcom/payeco/android/plugin/http/itf/IHttpCallBack;->success(Ljava/lang/String;)V

    goto :goto_0
.end method
