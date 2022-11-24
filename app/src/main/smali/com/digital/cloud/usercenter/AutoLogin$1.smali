.class Lcom/digital/cloud/usercenter/AutoLogin$1;
.super Ljava/lang/Object;
.source "AutoLogin.java"

# interfaces
.implements Lcom/digital/cloud/usercenter/NormalLogin$loginListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digital/cloud/usercenter/AutoLogin;->login(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$listener:Lcom/digital/cloud/usercenter/AutoLogin$loginListener;


# direct methods
.method constructor <init>(Lcom/digital/cloud/usercenter/AutoLogin$loginListener;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digital/cloud/usercenter/AutoLogin$1;->val$listener:Lcom/digital/cloud/usercenter/AutoLogin$loginListener;

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public finish(Ljava/lang/String;)V
    .locals 1
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 65
    iget-object v0, p0, Lcom/digital/cloud/usercenter/AutoLogin$1;->val$listener:Lcom/digital/cloud/usercenter/AutoLogin$loginListener;

    invoke-interface {v0, p1}, Lcom/digital/cloud/usercenter/AutoLogin$loginListener;->Finished(Ljava/lang/String;)V

    .line 66
    return-void
.end method
