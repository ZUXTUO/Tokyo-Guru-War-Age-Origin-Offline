.class Lcom/digitalsky/sdk/user/DefaultUser$2;
.super Ljava/lang/Object;
.source "DefaultUser.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/user/DefaultUser;->_devLogin()V
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
    iput-object p1, p0, Lcom/digitalsky/sdk/user/DefaultUser$2;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    .line 222
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 227
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 228
    .local v2, "root":Lorg/json/JSONObject;
    const-string v3, "result"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 229
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 230
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$2;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/digitalsky/sdk/user/DefaultUser;->access$4(Lcom/digitalsky/sdk/user/DefaultUser;Ljava/lang/String;)V

    .line 238
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 233
    .restart local v1    # "result":I
    .restart local v2    # "root":Lorg/json/JSONObject;
    :cond_0
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$2;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    const-string v4, "DevId login fail"

    invoke-static {v3, v1, v4}, Lcom/digitalsky/sdk/user/DefaultUser;->access$3(Lcom/digitalsky/sdk/user/DefaultUser;ILjava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 235
    .end local v1    # "result":I
    .end local v2    # "root":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 236
    .local v0, "e":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/digitalsky/sdk/user/DefaultUser$2;->this$0:Lcom/digitalsky/sdk/user/DefaultUser;

    const/4 v4, -0x1

    const-string v5, "DevId login exception"

    invoke-static {v3, v4, v5}, Lcom/digitalsky/sdk/user/DefaultUser;->access$3(Lcom/digitalsky/sdk/user/DefaultUser;ILjava/lang/String;)V

    goto :goto_0
.end method
