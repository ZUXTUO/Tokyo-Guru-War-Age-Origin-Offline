.class Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;
.super Ljava/lang/Object;
.source "TelphoneManage.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/TelphoneManage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "AccountInfo"
.end annotation


# instance fields
.field public phoneNumber:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/digital/cloud/usercenter/TelphoneManage$AccountInfo;->phoneNumber:Ljava/lang/String;

    .line 22
    return-void
.end method
