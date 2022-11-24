.class final Lcom/pg/im/sdk/lib/d/a$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/pg/im/sdk/lib/d/a;->a(Landroid/content/Context;Landroid/os/Handler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lorg/json/JSONObject;

.field final synthetic c:I

.field final synthetic d:Landroid/content/Context;

.field final synthetic e:Landroid/os/Handler;


# direct methods
.method constructor <init>(Ljava/lang/String;Lorg/json/JSONObject;ILandroid/content/Context;Landroid/os/Handler;)V
    .locals 0

    .prologue
    .line 120
    iput-object p1, p0, Lcom/pg/im/sdk/lib/d/a$1;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/pg/im/sdk/lib/d/a$1;->b:Lorg/json/JSONObject;

    iput p3, p0, Lcom/pg/im/sdk/lib/d/a$1;->c:I

    iput-object p4, p0, Lcom/pg/im/sdk/lib/d/a$1;->d:Landroid/content/Context;

    iput-object p5, p0, Lcom/pg/im/sdk/lib/d/a$1;->e:Landroid/os/Handler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 123
    iget-object v0, p0, Lcom/pg/im/sdk/lib/d/a$1;->a:Ljava/lang/String;

    iget-object v1, p0, Lcom/pg/im/sdk/lib/d/a$1;->b:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/pg/im/sdk/lib/d/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 125
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 126
    new-instance v2, Lcom/pg/im/sdk/lib/a/f;

    invoke-direct {v2}, Lcom/pg/im/sdk/lib/a/f;-><init>()V

    .line 127
    const-string v0, "result"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v2, v0}, Lcom/pg/im/sdk/lib/a/f;->b(I)V

    .line 128
    const-string v0, "note"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v2, v0}, Lcom/pg/im/sdk/lib/a/f;->a(I)V

    .line 129
    const-string v0, "url"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/pg/im/sdk/lib/a/f;->a(Ljava/lang/String;)V

    .line 131
    invoke-virtual {v2}, Lcom/pg/im/sdk/lib/a/f;->b()I

    move-result v0

    if-nez v0, :cond_1

    .line 132
    invoke-virtual {v2}, Lcom/pg/im/sdk/lib/a/f;->a()I

    move-result v0

    iget v1, p0, Lcom/pg/im/sdk/lib/d/a$1;->c:I

    if-le v0, v1, :cond_1

    .line 133
    iget-object v0, p0, Lcom/pg/im/sdk/lib/d/a$1;->d:Landroid/content/Context;

    const-string v1, "blmvoicejar_path"

    const-string v3, ""

    invoke-static {v0, v1, v3}, Lcom/pg/im/sdk/lib/d/d;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 134
    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 135
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/pg/im/sdk/lib/d/a$1;->d:Landroid/content/Context;

    invoke-static {v1}, Lcom/pg/im/sdk/lib/d/a;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "blmvoice_for_assets.jar"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 137
    :cond_0
    invoke-virtual {v2}, Lcom/pg/im/sdk/lib/a/f;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/pg/im/sdk/lib/d/a;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    .line 138
    if-eqz v1, :cond_1

    .line 139
    iget-object v1, p0, Lcom/pg/im/sdk/lib/d/a$1;->d:Landroid/content/Context;

    const-string v3, "blmvoicejar_version"

    invoke-virtual {v2}, Lcom/pg/im/sdk/lib/a/f;->a()I

    move-result v2

    invoke-static {v1, v3, v2}, Lcom/pg/im/sdk/lib/d/d;->a(Landroid/content/Context;Ljava/lang/String;I)V

    .line 140
    iget-object v1, p0, Lcom/pg/im/sdk/lib/d/a$1;->d:Landroid/content/Context;

    const-string v2, "blmvoicejar_path"

    invoke-static {v1, v2, v0}, Lcom/pg/im/sdk/lib/d/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 145
    :cond_1
    iget-object v0, p0, Lcom/pg/im/sdk/lib/d/a$1;->e:Landroid/os/Handler;

    const/4 v1, 0x0

    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 151
    :goto_0
    return-void

    .line 147
    :catch_0
    move-exception v0

    .line 148
    const-string v1, "DownService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "error:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/pg/im/sdk/lib/d/b;->b(Ljava/lang/String;Ljava/lang/String;)V

    .line 149
    iget-object v0, p0, Lcom/pg/im/sdk/lib/d/a$1;->e:Landroid/os/Handler;

    invoke-virtual {v0, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0
.end method
