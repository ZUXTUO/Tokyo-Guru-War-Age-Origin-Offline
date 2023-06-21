.class Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;
.super Ljava/lang/Object;
.source "AutoLoginPage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->Finished(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;

.field private final synthetic val$res:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;

    iput-object p2, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;->val$res:Ljava/lang/String;

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 63
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;->val$res:Ljava/lang/String;

    invoke-direct {v2, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 64
    .local v2, "root":Lorg/json/JSONObject;
    const-string v4, "result"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 65
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 66
    const-string v4, "state"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    .line 67
    .local v3, "state":I
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    const/4 v5, 0x1

    invoke-static {v4, v5}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$1(Lcom/digital/cloud/usercenter/page/AutoLoginPage;Z)V

    .line 68
    iget-object v4, p0, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1$1;->this$1:Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;

    invoke-static {v4}, Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;->access$0(Lcom/digital/cloud/usercenter/page/AutoLoginPage$1;)Lcom/digital/cloud/usercenter/page/AutoLoginPage;

    move-result-object v4

    invoke-static {v4, v3}, Lcom/digital/cloud/usercenter/page/AutoLoginPage;->access$2(Lcom/digital/cloud/usercenter/page/AutoLoginPage;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 73
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    .end local v3    # "state":I
    :cond_0
    :goto_0
    return-void

    .line 70
    :catch_0
    move-exception v0

    .line 71
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
