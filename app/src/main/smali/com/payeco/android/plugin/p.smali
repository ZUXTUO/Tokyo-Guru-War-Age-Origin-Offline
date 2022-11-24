.class final Lcom/payeco/android/plugin/p;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/d/z;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/m;

.field private final synthetic b:Ljava/lang/String;

.field private final synthetic c:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/p;->a:Lcom/payeco/android/plugin/m;

    iput-object p2, p0, Lcom/payeco/android/plugin/p;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/payeco/android/plugin/p;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/String;)V
    .locals 9

    const/4 v3, 0x4

    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xa

    if-ge v0, v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "0"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/p;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PinPKey"

    invoke-static {v1}, Lcom/payeco/android/plugin/b/h;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/payeco/android/plugin/a/f;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-array v2, v6, [Ljava/lang/String;

    aput-object v1, v2, v5

    invoke-static {v2}, Lcom/payeco/android/plugin/c/f;->a([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v1, p0, Lcom/payeco/android/plugin/p;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v1}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v1

    iget-object v2, p0, Lcom/payeco/android/plugin/p;->c:Ljava/lang/String;

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    const-string v4, "\u5bc6\u7801\u52a0\u5bc6\u51fa\u9519"

    aput-object v4, v3, v6

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v3, v7

    const-string v0, ""

    aput-object v0, v3, v8

    invoke-virtual {v1, v2, v3}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_1
    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/payeco/android/plugin/p;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    iget-object v2, p0, Lcom/payeco/android/plugin/p;->c:Ljava/lang/String;

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    const-string v4, ""

    aput-object v4, v3, v6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v7

    aput-object v1, v3, v8

    invoke-virtual {v0, v2, v3}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/p;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->a(Lcom/payeco/android/plugin/m;)V

    goto :goto_1
.end method
