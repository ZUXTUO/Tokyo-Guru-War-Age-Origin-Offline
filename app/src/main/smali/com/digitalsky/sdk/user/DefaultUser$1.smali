.class Lcom/digitalsky/sdk/user/DefaultUser$1;
.super Ljava/lang/Object;
.source "DefaultUser.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/user/DefaultUser;->_genDevId()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/user/DefaultUser;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/user/DefaultUser;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    .line 192
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 197
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 198
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 199
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 200
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    const-string v4, "devid"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/user/DefaultUser;->access$0(Lcom/digitalsky/sdk/user/DefaultUser;Ljava/lang/String;)V

    .line 201
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    invoke-static {v3}, Lcom/digitalsky/sdk/user/DefaultUser;->access$1(Lcom/digitalsky/sdk/user/DefaultUser;)V

    .line 202
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    invoke-static {v3}, Lcom/digitalsky/sdk/user/DefaultUser;->access$2(Lcom/digitalsky/sdk/user/DefaultUser;)V

    .line 209
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 204
    .restart local v1    # "result":I
    .restart local v2    # "root":Lorg/json/JSONObject;
    :cond_0
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    const-string v4, "gen DevId fail"

    invoke-static {v3, v1, v4}, Lcom/digitalsky/sdk/user/DefaultUser;->access$3(Lcom/digitalsky/sdk/user/DefaultUser;ILjava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 206
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 207
    .local v0, "e":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$1;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    const/4 v4, -0x1

    const-string v5, "gen DevId exception"

    invoke-static {v3, v4, v5}, Lcom/digitalsky/sdk/user/DefaultUser;->access$3(Lcom/digitalsky/sdk/user/DefaultUser;ILjava/lang/String;)V

    goto :goto_0
.end method
