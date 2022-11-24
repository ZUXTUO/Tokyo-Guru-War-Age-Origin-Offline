.class public Lcom/digitalsky/ghoul/cn/wxapi/WXPayEntryActivity;
.super Landroid/app/Activity;
.source "WXPayEntryActivity.java"

# interfaces
.implements Lcom/tencent/mm/opensdk/openapi/IWXAPIEventHandler;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 17
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 18
    invoke-static {p0, p0}, Lcom/digital/wechat/WechatSdk;->onCreate(Landroid/app/Activity;Lcom/tencent/mm/opensdk/openapi/IWXAPIEventHandler;)V

    .line 19
    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 0
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 23
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    .line 24
    invoke-static {p1, p0}, Lcom/digital/wechat/WechatSdk;->onNewIntent(Landroid/content/Intent;Lcom/tencent/mm/opensdk/openapi/IWXAPIEventHandler;)V

    .line 25
    return-void
.end method

.method public onReq(Lcom/tencent/mm/opensdk/modelbase/BaseReq;)V
    .locals 0
    .param p1, "arg0"    # Lcom/tencent/mm/opensdk/modelbase/BaseReq;

    .prologue
    .line 29
    invoke-static {p1}, Lcom/digital/wechat/WechatSdk;->onReq(Lcom/tencent/mm/opensdk/modelbase/BaseReq;)V

    .line 30
    return-void
.end method

.method public onResp(Lcom/tencent/mm/opensdk/modelbase/BaseResp;)V
    .locals 0
    .param p1, "arg0"    # Lcom/tencent/mm/opensdk/modelbase/BaseResp;

    .prologue
    .line 34
    invoke-static {p1}, Lcom/digital/wechat/WechatSdk;->onResp(Lcom/tencent/mm/opensdk/modelbase/BaseResp;)V

    .line 35
    return-void
.end method
