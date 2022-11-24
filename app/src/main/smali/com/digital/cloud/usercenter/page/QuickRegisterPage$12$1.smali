.class Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12$1;
.super Ljava/lang/Object;
.source "QuickRegisterPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;->finish(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;

.field private final synthetic val$res:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12$1;->this$1:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12$1;->val$res:Ljava/lang/String;

    .line 428
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    .line 433
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    iget-object v5, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$12$1;->val$res:Ljava/lang/String;

    invoke-direct {v3, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 434
    .local v3, "root":Lorg/json/JSONObject;
    const-string v5, "result"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    .line 435
    .local v2, "result":I
    const-string v5, "msg"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 436
    .local v1, "msg":Ljava/lang/String;
    sparse-switch v2, :sswitch_data_0

    .line 465
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "ErrorCode:"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " Msg:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 471
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "result":I
    .end local v3    # "root":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 438
    .restart local v1    # "msg":Ljava/lang/String;
    .restart local v2    # "result":I
    .restart local v3    # "root":Lorg/json/JSONObject;
    :sswitch_0
    const-string v5, "state"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    .line 439
    .local v4, "state":I
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    const/4 v6, 0x1

    invoke-virtual {v5, v4, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->setAccountState(IZ)V

    .line 440
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    .line 441
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "string"

    const-string v8, "c_hyhl"

    invoke-static {v7, v8}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    invoke-static {v7}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, "  "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 442
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->getUserName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 441
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->showWelcome(Ljava/lang/String;)V

    .line 443
    invoke-static {}, Lcom/digital/cloud/usercenter/NormalLogin;->notifyResult()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 468
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "result":I
    .end local v3    # "root":Lorg/json/JSONObject;
    .end local v4    # "state":I
    :catch_0
    move-exception v0

    .line 469
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 449
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "msg":Ljava/lang/String;
    .restart local v2    # "result":I
    .restart local v3    # "root":Lorg/json/JSONObject;
    :sswitch_1
    :try_start_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    .line 450
    const-string v6, "string"

    const-string v7, "c_mmbd"

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 455
    :sswitch_2
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    .line 456
    const-string v6, "string"

    const-string v7, "c_zhbcz"

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto :goto_0

    .line 461
    :sswitch_3
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v5

    .line 462
    const-string v6, "string"

    const-string v7, "c_zhgsbd"

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 436
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xeac6 -> :sswitch_3
        0xeacc -> :sswitch_3
        0xeacd -> :sswitch_1
        0xeacf -> :sswitch_2
        0xead1 -> :sswitch_1
        0xead3 -> :sswitch_2
        0xead5 -> :sswitch_1
        0xead6 -> :sswitch_2
        0xead8 -> :sswitch_1
        0xead9 -> :sswitch_3
    .end sparse-switch
.end method
