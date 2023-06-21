.class Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;
.super Ljava/lang/Object;
.source "Sanalyze.java"

# interfaces
.implements Lcom/digitalsky/sdk/common/Utils$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/digitalsky/sdk/sanalyze/Sanalyze;->reportStart(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;


# direct methods
.method constructor <init>(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    .line 147
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallback(Ljava/lang/String;)V
    .locals 4
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 152
    if-nez p1, :cond_0

    .line 153
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Http return null"

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->LogE(Ljava/lang/String;Ljava/lang/String;)V

    .line 160
    :goto_0
    return-void

    .line 156
    :cond_0
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$2(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Landroid/app/Activity;

    move-result-object v1

    const-string v2, "sanalyze_info"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 157
    .local v0, "sanalyze_info":Landroid/content/SharedPreferences;
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "key"

    invoke-interface {v1, v2, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 158
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v1, p1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$3(Lcom/digitalsky/sdk/sanalyze/Sanalyze;Ljava/lang/String;)V

    .line 159
    iget-object v1, p0, Lcom/digitalsky/sdk/sanalyze/Sanalyze$2;->this$0:Lcom/digitalsky/sdk/sanalyze/Sanalyze;

    invoke-static {v1}, Lcom/digitalsky/sdk/sanalyze/Sanalyze;->access$1(Lcom/digitalsky/sdk/sanalyze/Sanalyze;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Http return new key"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/digitalsky/sdk/common/LogUtils;->Log(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
