.class Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9$1;
.super Ljava/lang/Object;
.source "QuickRegisterPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;->asyncHttpRequestFinished(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;

.field private final synthetic val$res:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9$1;->this$1:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9$1;->val$res:Ljava/lang/String;

    .line 270
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 275
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9$1;->val$res:Ljava/lang/String;

    invoke-direct {v3, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 276
    .local v3, "root":Lorg/json/JSONObject;
    const-string v4, "result"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    .line 277
    .local v2, "result":I
    const-string v4, "msg"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 278
    .local v1, "msg":Ljava/lang/String;
    sparse-switch v2, :sswitch_data_0

    .line 292
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "ErrorCode:"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " Msg:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 298
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "result":I
    .end local v3    # "root":Lorg/json/JSONObject;
    :goto_0
    :sswitch_0
    return-void

    .line 282
    .restart local v1    # "msg":Ljava/lang/String;
    .restart local v2    # "result":I
    .restart local v3    # "root":Lorg/json/JSONObject;
    :sswitch_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    .line 283
    const-string v5, "string"

    const-string v6, "c_sjhgsbd"

    invoke-static {v5, v6}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v5

    .line 282
    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 284
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9$1;->this$1:Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;->access$0(Lcom/digital/cloud/usercenter/page/QuickRegisterPage$9;)Lcom/digital/cloud/usercenter/page/QuickRegisterPage;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/QuickRegisterPage;->access$7(Lcom/digital/cloud/usercenter/page/QuickRegisterPage;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 295
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "result":I
    .end local v3    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 296
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 288
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "msg":Ljava/lang/String;
    .restart local v2    # "result":I
    .restart local v3    # "root":Lorg/json/JSONObject;
    :sswitch_2
    :try_start_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    .line 289
    const-string v5, "string"

    const-string v6, "c_scfsdyzmbd"

    invoke-static {v5, v6}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v5

    .line 288
    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 278
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xede6 -> :sswitch_1
        0xede7 -> :sswitch_2
        0xede8 -> :sswitch_2
    .end sparse-switch
.end method
