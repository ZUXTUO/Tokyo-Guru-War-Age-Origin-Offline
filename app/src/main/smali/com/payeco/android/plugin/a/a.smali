.class public Lcom/payeco/android/plugin/a/a;
.super Ljava/lang/Object;


# static fields
.field static final synthetic a:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/payeco/android/plugin/a/a;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/payeco/android/plugin/a/a;->a:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a([B)Ljava/lang/String;
    .locals 6

    new-instance v2, Ljava/lang/String;

    array-length v3, p0

    new-instance v4, Lcom/payeco/android/plugin/a/d;

    invoke-direct {v4}, Lcom/payeco/android/plugin/a/d;-><init>()V

    div-int/lit8 v0, v3, 0x3

    mul-int/lit8 v0, v0, 0x4

    iget-boolean v1, v4, Lcom/payeco/android/plugin/a/d;->d:Z

    if-eqz v1, :cond_2

    rem-int/lit8 v1, v3, 0x3

    if-lez v1, :cond_0

    add-int/lit8 v0, v0, 0x4

    :cond_0
    :goto_0
    :pswitch_0
    iget-boolean v1, v4, Lcom/payeco/android/plugin/a/d;->e:Z

    if-eqz v1, :cond_1

    if-lez v3, :cond_1

    add-int/lit8 v1, v3, -0x1

    div-int/lit8 v1, v1, 0x39

    add-int/lit8 v5, v1, 0x1

    iget-boolean v1, v4, Lcom/payeco/android/plugin/a/d;->f:Z

    if-eqz v1, :cond_3

    const/4 v1, 0x2

    :goto_1
    mul-int/2addr v1, v5

    add-int/2addr v0, v1

    :cond_1
    new-array v1, v0, [B

    iput-object v1, v4, Lcom/payeco/android/plugin/a/d;->a:[B

    invoke-virtual {v4, p0, v3}, Lcom/payeco/android/plugin/a/d;->a([BI)Z

    sget-boolean v1, Lcom/payeco/android/plugin/a/a;->a:Z

    if-nez v1, :cond_4

    iget v1, v4, Lcom/payeco/android/plugin/a/d;->b:I

    if-eq v1, v0, :cond_4

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :cond_2
    rem-int/lit8 v1, v3, 0x3

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    :pswitch_1
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    :pswitch_2
    add-int/lit8 v0, v0, 0x3

    goto :goto_0

    :cond_3
    const/4 v1, 0x1

    goto :goto_1

    :cond_4
    iget-object v0, v4, Lcom/payeco/android/plugin/a/d;->a:[B

    invoke-direct {v2, v0}, Ljava/lang/String;-><init>([B)V

    return-object v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public static a(Ljava/lang/String;)[B
    .locals 5

    const/4 v4, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    array-length v1, v0

    new-instance v2, Lcom/payeco/android/plugin/a/c;

    mul-int/lit8 v3, v1, 0x3

    div-int/lit8 v3, v3, 0x4

    new-array v3, v3, [B

    invoke-direct {v2, v3}, Lcom/payeco/android/plugin/a/c;-><init>([B)V

    invoke-virtual {v2, v0, v1}, Lcom/payeco/android/plugin/a/c;->a([BI)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "bad base-64"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget v0, v2, Lcom/payeco/android/plugin/a/c;->b:I

    iget-object v1, v2, Lcom/payeco/android/plugin/a/c;->a:[B

    array-length v1, v1

    if-ne v0, v1, :cond_1

    iget-object v0, v2, Lcom/payeco/android/plugin/a/c;->a:[B

    :goto_0
    return-object v0

    :cond_1
    iget v0, v2, Lcom/payeco/android/plugin/a/c;->b:I

    new-array v0, v0, [B

    iget-object v1, v2, Lcom/payeco/android/plugin/a/c;->a:[B

    iget v2, v2, Lcom/payeco/android/plugin/a/c;->b:I

    invoke-static {v1, v4, v0, v4, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0
.end method
