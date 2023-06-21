.class Lcom/sina/weibo/sdk/widget/LoginoutButton$2;
.super Ljava/lang/Object;
.source "LoginoutButton.java"

# interfaces
.implements Lcom/sina/weibo/sdk/net/RequestListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sina/weibo/sdk/widget/LoginoutButton;->logout()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;


# direct methods
.method constructor <init>(Lcom/sina/weibo/sdk/widget/LoginoutButton;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    .line 292
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onComplete(Ljava/lang/String;)V
    .locals 6
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 295
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 297
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 298
    .local v2, "obj":Lorg/json/JSONObject;
    const-string v4, "error"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->isNull(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 299
    const-string v4, "result"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 302
    .local v3, "value":Ljava/lang/String;
    const-string v4, "true"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 306
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    const/4 v5, 0x0

    invoke-static {v4, v5}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$0(Lcom/sina/weibo/sdk/widget/LoginoutButton;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 308
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    sget v5, Lcom/sina/weibo/sdk/R$string;->com_sina_weibo_sdk_login_with_weibo_account:I

    invoke-virtual {v4, v5}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->setText(I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 322
    .end local v2    # "obj":Lorg/json/JSONObject;
    .end local v3    # "value":Ljava/lang/String;
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v4}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$3(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/net/RequestListener;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 323
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v4}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$3(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/net/RequestListener;

    move-result-object v4

    invoke-interface {v4, p1}, Lcom/sina/weibo/sdk/net/RequestListener;->onComplete(Ljava/lang/String;)V

    .line 325
    :cond_1
    return-void

    .line 311
    .restart local v2    # "obj":Lorg/json/JSONObject;
    :cond_2
    :try_start_1
    const-string v4, "error_code"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 312
    .local v1, "error_code":Ljava/lang/String;
    const-string v4, "21317"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 313
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    const/4 v5, 0x0

    invoke-static {v4, v5}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$0(Lcom/sina/weibo/sdk/widget/LoginoutButton;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 314
    iget-object v4, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    sget v5, Lcom/sina/weibo/sdk/R$string;->com_sina_weibo_sdk_login_with_weibo_account:I

    invoke-virtual {v4, v5}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->setText(I)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 317
    .end local v1    # "error_code":Ljava/lang/String;
    .end local v2    # "obj":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 318
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public onWeiboException(Lcom/sina/weibo/sdk/exception/WeiboException;)V
    .locals 3
    .param p1, "e"    # Lcom/sina/weibo/sdk/exception/WeiboException;

    .prologue
    .line 329
    const-string v0, "LoginButton"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "WeiboException\uff1a "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/sina/weibo/sdk/exception/WeiboException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/sina/weibo/sdk/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 331
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    sget v1, Lcom/sina/weibo/sdk/R$string;->com_sina_weibo_sdk_logout:I

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->setText(I)V

    .line 332
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$3(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/net/RequestListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 333
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$2;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$3(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/net/RequestListener;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/sina/weibo/sdk/net/RequestListener;->onWeiboException(Lcom/sina/weibo/sdk/exception/WeiboException;)V

    .line 335
    :cond_0
    return-void
.end method
