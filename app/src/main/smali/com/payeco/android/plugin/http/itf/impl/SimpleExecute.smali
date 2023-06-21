.class public Lcom/payeco/android/plugin/http/itf/impl/SimpleExecute;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/http/itf/IHttpExecute;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public exec(Lcom/payeco/android/plugin/http/itf/IHttpEntity;Lcom/payeco/android/plugin/http/itf/IHttpCallBack;)V
    .locals 1

    :try_start_0
    invoke-interface {p1}, Lcom/payeco/android/plugin/http/itf/IHttpEntity;->getHttp()Lcom/payeco/android/plugin/http/comm/Http;

    move-result-object v0

    invoke-virtual {v0}, Lcom/payeco/android/plugin/http/comm/Http;->send()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-interface {p2, v0}, Lcom/payeco/android/plugin/http/itf/IHttpCallBack;->fail(Ljava/lang/Exception;)V

    :goto_0
    return-void

    :cond_0
    invoke-interface {p2, v0}, Lcom/payeco/android/plugin/http/itf/IHttpCallBack;->success(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    invoke-interface {p2, v0}, Lcom/payeco/android/plugin/http/itf/IHttpCallBack;->fail(Ljava/lang/Exception;)V

    goto :goto_0
.end method
