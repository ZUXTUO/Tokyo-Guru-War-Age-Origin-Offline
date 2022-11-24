.class public Lcom/digitalsky/sdk/data/DefaultData;
.super Ljava/lang/Object;
.source "DefaultData.java"

# interfaces
.implements Lcom/digitalsky/sdk/data/IData;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public submit(Ljava/lang/String;)Z
    .locals 2
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    .line 9
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "call submit "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/digitalsky/sdk/common/Utils;->showToast(Ljava/lang/String;)V

    .line 10
    const/4 v0, 0x1

    return v0
.end method
