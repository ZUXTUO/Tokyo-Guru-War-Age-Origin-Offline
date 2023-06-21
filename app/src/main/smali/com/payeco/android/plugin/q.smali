.class final Lcom/payeco/android/plugin/q;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/payeco/android/plugin/d/s;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/m;

.field private final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/payeco/android/plugin/m;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/q;->a:Lcom/payeco/android/plugin/m;

    iput-object p2, p0, Lcom/payeco/android/plugin/q;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/String;)V
    .locals 5

    const/4 v4, 0x0

    iget-object v0, p0, Lcom/payeco/android/plugin/q;->a:Lcom/payeco/android/plugin/m;

    invoke-static {v0}, Lcom/payeco/android/plugin/m;->b(Lcom/payeco/android/plugin/m;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->g(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)Lcom/payeco/android/plugin/js/JsBridge;

    move-result-object v0

    iget-object v1, p0, Lcom/payeco/android/plugin/q;->b:Ljava/lang/String;

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    const/4 v3, 0x1

    const-string v4, ""

    aput-object v4, v2, v3

    const/4 v3, 0x2

    aput-object p1, v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/payeco/android/plugin/js/JsBridge;->execJsMethodFromFuncs(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
