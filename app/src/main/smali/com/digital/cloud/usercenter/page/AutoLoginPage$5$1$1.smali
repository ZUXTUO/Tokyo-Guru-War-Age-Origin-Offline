.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->Finished(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

.field private final synthetic val$res:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->val$res:Ljava/lang/String;

    .line 153
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    .line 157
    invoke-static {}, Lcom/digital/cloud/usercenter/UserCenterActivity;->hideLoading()V

    .line 158
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$10(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 185
    :goto_0
    return-void

    .line 161
    :cond_0
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->val$res:Ljava/lang/String;

    invoke-direct {v2, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 162
    .local v2, "root":Lorg/json/JSONObject;
    const-string v4, "result"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 163
    .local v1, "result":I
    if-nez v1, :cond_1

    .line 164
    const-string v4, "state"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    .line 165
    .local v3, "state":I
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    const/4 v5, 0x1

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/AutoLoginPage;Z)V

    .line 166
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    const/4 v5, 0x1

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$11(Lcom/digital/cloud/usercenter/page/AutoLoginPage;Z)V

    .line 167
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    move-result-object v4

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    invoke-static {v4, v3}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$2(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V

    .line 169
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    iget-object v5, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1$1;->this$2:Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;

    invoke-static {v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;

    move-result-object v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$5;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$7(Lcom/digital/cloud/usercenter/page/AutoLoginPage;)I

    move-result v5

    const/4 v6, 0x1

    invoke-virtual {v4, v5, v6}, Lcom/digital/cloud/usercenter/page/PageManager;->setAccountState(IZ)V

    .line 170
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "string"

    const-string v7, "c_hyhl"

    invoke-static {v6, v7}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->getUserName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showWelcome(Ljava/lang/String;)V

    .line 171
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->notifyResult()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 181
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    .end local v3    # "state":I
    :catch_0
    move-exception v0

    .line 182
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 183
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    const-string v5, "string"

    const-string v6, "c_wkywl"

    invoke-static {v5, v6}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 173
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "result":I
    .restart local v2    # "root":Lorg/json/JSONObject;
    :cond_1
    :try_start_1
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    const-string v5, "string"

    const-string v6, "c_sqgq"

    invoke-static {v5, v6}, Lcom/digital/cloud/usercenter/ResID;->get(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Lcom/digital/cloud/usercenter/UserCenterActivity;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->showErrorPage(Ljava/lang/String;)V

    .line 174
    invoke-static {}, Lcom/digital/cloud/usercenter/AutoLogin;->isGuestLogin()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 175
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    sget-object v5, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->FirstLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v4

    invoke-interface {v4}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V

    goto/16 :goto_0

    .line 177
    :cond_2
    invoke-static {}, Lcom/digital/cloud/usercenter/page/PageManager;->getInstance()Lcom/digital/cloud/usercenter/page/PageManager;

    move-result-object v4

    sget-object v5, Lcom/digital/cloud/usercenter/page/PageManager$PageType;->AccountLoginPage:Lcom/digital/cloud/usercenter/page/PageManager$PageType;

    invoke-virtual {v4, v5}, Lcom/digital/cloud/usercenter/page/PageManager;->GetPage(Lcom/digital/cloud/usercenter/page/PageManager$PageType;)Lcom/digital/cloud/usercenter/ShowPageListener;

    move-result-object v4

    invoke-interface {v4}, Lcom/digital/cloud/usercenter/ShowPageListener;->show()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method
