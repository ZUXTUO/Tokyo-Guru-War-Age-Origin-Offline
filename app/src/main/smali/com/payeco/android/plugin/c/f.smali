.class public final Lcom/payeco/android/plugin/c/f;
.super Ljava/lang/Object;


# direct methods
.method public static varargs a([Ljava/lang/String;)Z
    .locals 6

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    array-length v3, p0

    move v2, v1

    :goto_1
    if-lt v2, v3, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    aget-object v4, p0, v2

    if-eqz v4, :cond_0

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method
