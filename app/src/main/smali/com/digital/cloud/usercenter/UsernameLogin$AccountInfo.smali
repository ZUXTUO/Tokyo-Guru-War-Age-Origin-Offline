.class Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;
.super Ljava/lang/Object;
.source "UsernameLogin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digital/cloud/usercenter/UsernameLogin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "AccountInfo"
.end annotation


# instance fields
.field public pwdMd5:Ljava/lang/String;

.field public username:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object v0, p0, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->username:Ljava/lang/String;

    .line 31
    iput-object v0, p0, Lcom/digital/cloud/usercenter/UsernameLogin$AccountInfo;->pwdMd5:Ljava/lang/String;

    .line 29
    return-void
.end method
