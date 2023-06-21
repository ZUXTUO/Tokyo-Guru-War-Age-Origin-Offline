.class final Lcom/payeco/android/plugin/k;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/baidu/location/BDLocationListener;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/k;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onReceiveLocation(Lcom/baidu/location/BDLocation;)V
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lcom/baidu/location/BDLocation;->getLongitude()D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/baidu/location/BDLocation;->getLatitude()D

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/h;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/b/b;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/k;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v0, v0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    invoke-virtual {v0, p0}, Lcom/baidu/location/LocationClient;->unRegisterLocationListener(Lcom/baidu/location/BDLocationListener;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/k;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iget-object v0, v0, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->c:Lcom/baidu/location/LocationClient;

    invoke-virtual {v0}, Lcom/baidu/location/LocationClient;->stop()V

    return-void
.end method
