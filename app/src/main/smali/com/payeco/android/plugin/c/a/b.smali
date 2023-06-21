.class public final Lcom/payeco/android/plugin/c/a/b;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/util/List;

.field private d:Ljava/util/List;

.field private e:Ljava/util/Map;

.field private f:Ljava/util/Map;

.field private g:Lcom/payeco/android/plugin/c/a/b;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->c:Ljava/util/List;

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->d:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->e:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->f:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/b;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->e:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/payeco/android/plugin/c/a/b;

    return-object v0
.end method

.method public final a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->a:Ljava/lang/String;

    return-object v0
.end method

.method final a(Lcom/payeco/android/plugin/c/a/b;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/c/a/b;->g:Lcom/payeco/android/plugin/c/a/b;

    return-void
.end method

.method public final b(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/a;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->f:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/payeco/android/plugin/c/a/a;

    return-object v0
.end method

.method public final b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->b:Ljava/lang/String;

    return-object v0
.end method

.method public final c()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->c:Ljava/util/List;

    return-object v0
.end method

.method final c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/c/a/b;->a:Ljava/lang/String;

    return-void
.end method

.method public final d()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->d:Ljava/util/List;

    return-object v0
.end method

.method final d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/c/a/b;->b:Ljava/lang/String;

    return-void
.end method

.method public final e()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->e:Ljava/util/Map;

    return-object v0
.end method

.method public final f()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->f:Ljava/util/Map;

    return-object v0
.end method

.method public final g()Lcom/payeco/android/plugin/c/a/b;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/c/a/b;->g:Lcom/payeco/android/plugin/c/a/b;

    return-object v0
.end method
