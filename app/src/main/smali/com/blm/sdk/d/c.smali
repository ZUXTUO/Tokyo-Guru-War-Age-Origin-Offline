.class public final Lcom/blm/sdk/d/c;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:[C

.field private static final b:[B


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/16 v7, 0x2f

    const/16 v6, 0x2b

    const/16 v0, 0x1a

    const/16 v5, 0x3e

    const/4 v1, 0x0

    .line 22
    const/16 v2, 0x40

    new-array v2, v2, [C

    sput-object v2, Lcom/blm/sdk/d/c;->a:[C

    .line 23
    const/16 v2, 0x100

    new-array v2, v2, [B

    sput-object v2, Lcom/blm/sdk/d/c;->b:[B

    move v2, v1

    .line 28
    :goto_0
    if-ge v2, v0, :cond_0

    .line 29
    sget-object v3, Lcom/blm/sdk/d/c;->a:[C

    add-int/lit8 v4, v2, 0x41

    int-to-char v4, v4

    aput-char v4, v3, v2

    .line 28
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v0

    move v0, v1

    .line 32
    :goto_1
    const/16 v3, 0x34

    if-ge v2, v3, :cond_1

    .line 33
    sget-object v3, Lcom/blm/sdk/d/c;->a:[C

    add-int/lit8 v4, v0, 0x61

    int-to-char v4, v4

    aput-char v4, v3, v2

    .line 32
    add-int/lit8 v2, v2, 0x1

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 36
    :cond_1
    const/16 v0, 0x34

    move v2, v0

    move v0, v1

    :goto_2
    if-ge v2, v5, :cond_2

    .line 37
    sget-object v3, Lcom/blm/sdk/d/c;->a:[C

    add-int/lit8 v4, v0, 0x30

    int-to-char v4, v4

    aput-char v4, v3, v2

    .line 36
    add-int/lit8 v2, v2, 0x1

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 40
    :cond_2
    sget-object v0, Lcom/blm/sdk/d/c;->a:[C

    aput-char v6, v0, v5

    .line 41
    sget-object v0, Lcom/blm/sdk/d/c;->a:[C

    const/16 v2, 0x3f

    aput-char v7, v0, v2

    move v0, v1

    .line 45
    :goto_3
    const/16 v2, 0x100

    if-ge v0, v2, :cond_3

    .line 46
    sget-object v2, Lcom/blm/sdk/d/c;->b:[B

    const/4 v3, -0x1

    aput-byte v3, v2, v0

    .line 45
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 49
    :cond_3
    const/16 v0, 0x5a

    :goto_4
    const/16 v2, 0x41

    if-lt v0, v2, :cond_4

    .line 50
    sget-object v2, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v3, v0, -0x41

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    .line 49
    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    .line 53
    :cond_4
    const/16 v0, 0x7a

    :goto_5
    const/16 v2, 0x61

    if-lt v0, v2, :cond_5

    .line 54
    sget-object v2, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v3, v0, -0x61

    add-int/lit8 v3, v3, 0x1a

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    .line 53
    add-int/lit8 v0, v0, -0x1

    goto :goto_5

    .line 57
    :cond_5
    const/16 v0, 0x39

    :goto_6
    const/16 v2, 0x30

    if-lt v0, v2, :cond_6

    .line 58
    sget-object v2, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v3, v0, -0x30

    add-int/lit8 v3, v3, 0x34

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    .line 57
    add-int/lit8 v0, v0, -0x1

    goto :goto_6

    .line 61
    :cond_6
    sget-object v0, Lcom/blm/sdk/d/c;->b:[B

    aput-byte v5, v0, v6

    .line 62
    sget-object v0, Lcom/blm/sdk/d/c;->b:[B

    const/16 v2, 0x3f

    aput-byte v2, v0, v7

    .line 63
    sget-object v0, Lcom/blm/sdk/d/c;->b:[B

    const/16 v2, 0x3d

    aput-byte v1, v0, v2

    .line 64
    return-void
.end method

.method public static a([B)Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v6, 0x3d

    .line 79
    new-instance v1, Ljava/lang/StringBuilder;

    array-length v0, p0

    add-int/lit8 v0, v0, 0x2

    div-int/lit8 v0, v0, 0x3

    mul-int/lit8 v0, v0, 0x4

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 82
    const/4 v0, 0x0

    .line 83
    array-length v2, p0

    add-int/lit8 v2, v2, -0x2

    :goto_0
    if-ge v0, v2, :cond_0

    .line 84
    add-int/lit8 v3, v0, 0x1

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x10

    add-int/lit8 v4, v3, 0x1

    aget-byte v3, p0, v3

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v3, v0

    add-int/lit8 v0, v4, 0x1

    aget-byte v4, p0, v4

    and-int/lit16 v4, v4, 0xff

    or-int/2addr v3, v4

    .line 87
    sget-object v4, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v5, v3, 0x12

    aget-char v4, v4, v5

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 88
    sget-object v4, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v5, v3, 0xc

    and-int/lit8 v5, v5, 0x3f

    aget-char v4, v4, v5

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 89
    sget-object v4, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v5, v3, 0x6

    and-int/lit8 v5, v5, 0x3f

    aget-char v4, v4, v5

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 90
    sget-object v4, Lcom/blm/sdk/d/c;->a:[C

    and-int/lit8 v3, v3, 0x3f

    aget-char v3, v4, v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 94
    :cond_0
    array-length v2, p0

    .line 95
    if-ge v0, v2, :cond_1

    .line 96
    add-int/lit8 v3, v0, 0x1

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x10

    .line 97
    sget-object v4, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v5, v0, 0x12

    aget-char v4, v4, v5

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 98
    if-ge v3, v2, :cond_2

    .line 99
    aget-byte v2, p0, v3

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v0, v2

    .line 100
    sget-object v2, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v3, v0, 0xc

    and-int/lit8 v3, v3, 0x3f

    aget-char v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 101
    sget-object v2, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v0, v0, 0x6

    and-int/lit8 v0, v0, 0x3f

    aget-char v0, v2, v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 106
    :goto_1
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 108
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 103
    :cond_2
    sget-object v2, Lcom/blm/sdk/d/c;->a:[C

    shr-int/lit8 v0, v0, 0xc

    and-int/lit8 v0, v0, 0x3f

    aget-char v0, v2, v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 104
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1
.end method

.method public static a(Ljava/lang/String;)[B
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 117
    .line 119
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v2

    :goto_0
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x3d

    if-ne v3, v4, :cond_0

    .line 120
    add-int/lit8 v1, v1, 0x1

    .line 119
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 123
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    mul-int/lit8 v0, v0, 0x6

    div-int/lit8 v0, v0, 0x8

    sub-int v4, v0, v1

    .line 124
    new-array v5, v4, [B

    .line 126
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v6

    move v1, v2

    move v3, v2

    :goto_1
    if-ge v3, v6, :cond_2

    .line 127
    sget-object v0, Lcom/blm/sdk/d/c;->b:[B

    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v7

    aget-byte v0, v0, v7

    shl-int/lit8 v0, v0, 0x12

    .line 128
    sget-object v7, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v8, v3, 0x1

    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    aget-byte v7, v7, v8

    shl-int/lit8 v7, v7, 0xc

    add-int/2addr v0, v7

    .line 129
    sget-object v7, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v8, v3, 0x2

    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    aget-byte v7, v7, v8

    shl-int/lit8 v7, v7, 0x6

    add-int/2addr v0, v7

    .line 130
    sget-object v7, Lcom/blm/sdk/d/c;->b:[B

    add-int/lit8 v8, v3, 0x3

    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    aget-byte v7, v7, v8

    add-int/2addr v7, v0

    move v0, v2

    .line 132
    :goto_2
    const/4 v8, 0x3

    if-ge v0, v8, :cond_1

    add-int v8, v1, v0

    if-ge v8, v4, :cond_1

    .line 133
    add-int v8, v1, v0

    rsub-int/lit8 v9, v0, 0x2

    mul-int/lit8 v9, v9, 0x8

    shr-int v9, v7, v9

    int-to-byte v9, v9

    aput-byte v9, v5, v8

    .line 132
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 136
    :cond_1
    add-int/lit8 v0, v1, 0x3

    .line 126
    add-int/lit8 v1, v3, 0x4

    move v3, v1

    move v1, v0

    goto :goto_1

    .line 139
    :cond_2
    return-object v5
.end method
