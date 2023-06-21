.class public Lcom/blm/sdk/b/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static b:Ljava/lang/String;

.field private static c:Lcom/blm/sdk/b/a;


# instance fields
.field private a:Lcom/blm/sdk/b/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 12
    const-class v0, Lcom/blm/sdk/b/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/blm/sdk/b/a;->b:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Lcom/blm/sdk/b/b;

    invoke-direct {v0, p1}, Lcom/blm/sdk/b/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/blm/sdk/b/a;->a:Lcom/blm/sdk/b/b;

    .line 15
    return-void
.end method

.method public static declared-synchronized a(Landroid/content/Context;)Lcom/blm/sdk/b/a;
    .locals 2

    .prologue
    .line 19
    const-class v1, Lcom/blm/sdk/b/a;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/blm/sdk/b/a;->c:Lcom/blm/sdk/b/a;

    if-nez v0, :cond_0

    .line 21
    new-instance v0, Lcom/blm/sdk/b/a;

    invoke-direct {v0, p0}, Lcom/blm/sdk/b/a;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/blm/sdk/b/a;->c:Lcom/blm/sdk/b/a;

    .line 23
    :cond_0
    sget-object v0, Lcom/blm/sdk/b/a;->c:Lcom/blm/sdk/b/a;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 19
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public a(I)V
    .locals 4

    .prologue
    .line 31
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 32
    iget-object v0, p0, Lcom/blm/sdk/b/a;->a:Lcom/blm/sdk/b/b;

    invoke-virtual {v0}, Lcom/blm/sdk/b/b;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    .line 33
    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    .line 34
    const-string v2, "helloid"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 36
    const-string v2, "table_name"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J

    .line 37
    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->close()V

    .line 38
    return-void
.end method

.method public b(I)Z
    .locals 6

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 46
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    .line 48
    iget-object v3, p0, Lcom/blm/sdk/b/a;->a:Lcom/blm/sdk/b/b;

    invoke-virtual {v3}, Lcom/blm/sdk/b/b;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v3

    .line 49
    const-string v4, "select helloid from table_name where helloid =?"

    .line 50
    new-array v5, v0, [Ljava/lang/String;

    aput-object v2, v5, v1

    invoke-virtual {v3, v4, v5}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v2

    .line 51
    invoke-interface {v2}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 58
    :goto_0
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 59
    invoke-virtual {v3}, Landroid/database/sqlite/SQLiteDatabase;->close()V

    .line 60
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method
