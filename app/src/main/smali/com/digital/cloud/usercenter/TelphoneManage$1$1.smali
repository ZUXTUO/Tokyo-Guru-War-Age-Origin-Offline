.class Lcom/digital/cloud/usercenter/TelphoneManage$1$1;
.super Ljava/lang/Object;
.source "TelphoneManage.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/TelphoneManage$1;->asyncHttpRequestFinished(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/digital/cloud/usercenter/TelphoneManage$1;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/TelphoneManage$1;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/TelphoneManage$1$1;->this$1:Lcom/digital/cloud/usercenter/TelphoneManage$1;

    .line 136
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 140
    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->access$2()Ljava/util/Map;

    move-result-object v0

    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->access$3()Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    move-result-object v1

    iget-object v1, v1, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;

    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->access$3()Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    invoke-static {}, Lcom/digital/cloud/usercenter/TelphoneManage;->access$4()V

    .line 142
    return-void
.end method
