.class Lcom/sina/weibo/sdk/widget/LoginoutButton$1;
.super Ljava/lang/Object;
.source "LoginoutButton.java"

# interfaces
.implements Lcom/sina/weibo/sdk/auth/WeiboAuthListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sina/weibo/sdk/widget/LoginoutButton;->login()V
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
    iput-object p1, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    .line 251
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel()V
    .locals 1

    .prologue
    .line 268
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 269
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onCancel()V

    .line 271
    :cond_0
    return-void
.end method

.method public onComplete(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "values"    # Landroid/os/Bundle;

    .prologue
    .line 256
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {p1}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->parseAccessToken(Landroid/os/Bundle;)Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$0(Lcom/sina/weibo/sdk/widget/LoginoutButton;Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;)V

    .line 257
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$1(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sina/weibo/sdk/auth/Oauth2AccessToken;->isSessionValid()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 258
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    sget v1, Lcom/sina/weibo/sdk/R$string;->com_sina_weibo_sdk_logout:I

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->setText(I)V

    .line 261
    :cond_0
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 262
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onComplete(Landroid/os/Bundle;)V

    .line 264
    :cond_1
    return-void
.end method

.method public onWeiboException(Lcom/sina/weibo/sdk/exception/WeiboException;)V
    .locals 1
    .param p1, "e"    # Lcom/sina/weibo/sdk/exception/WeiboException;

    .prologue
    .line 275
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 276
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginoutButton$1;->this$0:Lcom/sina/weibo/sdk/widget/LoginoutButton;

    invoke-static {v0}, Lcom/sina/weibo/sdk/widget/LoginoutButton;->access$2(Lcom/sina/weibo/sdk/widget/LoginoutButton;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/sina/weibo/sdk/auth/WeiboAuthListener;->onWeiboException(Lcom/sina/weibo/sdk/exception/WeiboException;)V

    .line 278
    :cond_0
    return-void
.end method
