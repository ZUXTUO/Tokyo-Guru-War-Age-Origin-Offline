.class public Lcom/digitalsky/sdk/common/XXTEA;
.super Ljava/lang/Object;
.source "XXTEA.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static decrypt([B[B)[B
    .locals 3
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .prologue
    const/4 v2, 0x0

    .line 27
    array-length v0, p0

    if-nez v0, :cond_0

    .line 30
    .end local p0    # "data":[B
    :goto_0
    return-object p0

    .line 31
    .restart local p0    # "data":[B
    :cond_0
    invoke-static {p0, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toIntArray([BZ)[I

    move-result-object v0

    invoke-static {p1, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toIntArray([BZ)[I

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/XXTEA;->decrypt([I[I)[I

    move-result-object v0

    .line 30
    invoke-static {v0, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toByteArray([IZ)[B

    move-result-object p0

    goto :goto_0
.end method

.method public static decrypt([I[I)[I
    .locals 13
    .param p0, "v"    # [I
    .param p1, "k"    # [I

    .prologue
    const/4 v12, 0x0

    .line 74
    array-length v2, p0

    .line 75
    .local v2, "n":I
    add-int/lit8 v8, v2, -0x1

    aget v7, p0, v8

    .local v7, "z":I
    aget v6, p0, v12

    .local v6, "y":I
    const v0, -0x61c88647

    .line 77
    .local v0, "delta":I
    const/16 v8, 0x34

    div-int/2addr v8, v2

    add-int/lit8 v4, v8, 0x6

    .line 78
    .local v4, "rounds":I
    mul-int v5, v4, v0

    .line 79
    .local v5, "sum":I
    aget v6, p0, v12

    .line 81
    :cond_0
    ushr-int/lit8 v8, v5, 0x2

    and-int/lit8 v1, v8, 0x3

    .line 82
    .local v1, "e":I
    add-int/lit8 v3, v2, -0x1

    .local v3, "p":I
    :goto_0
    if-gtz v3, :cond_1

    .line 87
    add-int/lit8 v8, v2, -0x1

    aget v7, p0, v8

    .line 88
    aget v8, p0, v12

    ushr-int/lit8 v9, v7, 0x5

    shl-int/lit8 v10, v6, 0x2

    xor-int/2addr v9, v10

    ushr-int/lit8 v10, v6, 0x3

    shl-int/lit8 v11, v7, 0x4

    xor-int/2addr v10, v11

    add-int/2addr v9, v10

    xor-int v10, v5, v6

    .line 89
    and-int/lit8 v11, v3, 0x3

    xor-int/2addr v11, v1

    aget v11, p1, v11

    xor-int/2addr v11, v7

    add-int/2addr v10, v11

    xor-int/2addr v9, v10

    .line 88
    sub-int v6, v8, v9

    aput v6, p0, v12

    .line 90
    sub-int/2addr v5, v0

    if-nez v5, :cond_0

    .line 91
    return-object p0

    .line 83
    :cond_1
    add-int/lit8 v8, v3, -0x1

    aget v7, p0, v8

    .line 84
    aget v8, p0, v3

    ushr-int/lit8 v9, v7, 0x5

    shl-int/lit8 v10, v6, 0x2

    xor-int/2addr v9, v10

    ushr-int/lit8 v10, v6, 0x3

    shl-int/lit8 v11, v7, 0x4

    xor-int/2addr v10, v11

    add-int/2addr v9, v10

    xor-int v10, v5, v6

    .line 85
    and-int/lit8 v11, v3, 0x3

    xor-int/2addr v11, v1

    aget v11, p1, v11

    xor-int/2addr v11, v7

    add-int/2addr v10, v11

    xor-int/2addr v9, v10

    .line 84
    sub-int v6, v8, v9

    aput v6, p0, v3

    .line 82
    add-int/lit8 v3, v3, -0x1

    goto :goto_0
.end method

.method public static encrypt([B[B)[B
    .locals 3
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .prologue
    const/4 v2, 0x0

    .line 12
    array-length v0, p0

    if-nez v0, :cond_0

    .line 15
    .end local p0    # "data":[B
    :goto_0
    return-object p0

    .line 16
    .restart local p0    # "data":[B
    :cond_0
    invoke-static {p0, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toIntArray([BZ)[I

    move-result-object v0

    invoke-static {p1, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toIntArray([BZ)[I

    move-result-object v1

    invoke-static {v0, v1}, Lcom/digitalsky/sdk/common/XXTEA;->encrypt([I[I)[I

    move-result-object v0

    .line 15
    invoke-static {v0, v2}, Lcom/digitalsky/sdk/common/XXTEA;->toByteArray([IZ)[B

    move-result-object p0

    goto :goto_0
.end method

.method public static encrypt([I[I)[I
    .locals 13
    .param p0, "v"    # [I
    .param p1, "k"    # [I

    .prologue
    .line 42
    array-length v2, p0

    .line 46
    .local v2, "n":I
    const/16 v8, 0x34

    div-int/2addr v8, v2

    add-int/lit8 v4, v8, 0x6

    .line 47
    .local v4, "rounds":I
    const/4 v5, 0x0

    .line 48
    .local v5, "sum":I
    add-int/lit8 v8, v2, -0x1

    aget v7, p0, v8

    .line 49
    .local v7, "z":I
    const v0, -0x61c88647

    .line 51
    .local v0, "delta":I
    :cond_0
    add-int/2addr v5, v0

    .line 52
    ushr-int/lit8 v8, v5, 0x2

    and-int/lit8 v1, v8, 0x3

    .line 53
    .local v1, "e":I
    const/4 v3, 0x0

    .local v3, "p":I
    :goto_0
    add-int/lit8 v8, v2, -0x1

    if-lt v3, v8, :cond_1

    .line 58
    const/4 v8, 0x0

    aget v6, p0, v8

    .line 59
    .local v6, "y":I
    add-int/lit8 v8, v2, -0x1

    aget v9, p0, v8

    ushr-int/lit8 v10, v7, 0x5

    shl-int/lit8 v11, v6, 0x2

    xor-int/2addr v10, v11

    ushr-int/lit8 v11, v6, 0x3

    shl-int/lit8 v12, v7, 0x4

    xor-int/2addr v11, v12

    add-int/2addr v10, v11

    xor-int v11, v5, v6

    .line 60
    and-int/lit8 v12, v3, 0x3

    xor-int/2addr v12, v1

    aget v12, p1, v12

    xor-int/2addr v12, v7

    add-int/2addr v11, v12

    xor-int/2addr v10, v11

    .line 59
    add-int v7, v9, v10

    aput v7, p0, v8

    .line 61
    add-int/lit8 v4, v4, -0x1

    .line 50
    if-gtz v4, :cond_0

    .line 63
    return-object p0

    .line 54
    .end local v6    # "y":I
    :cond_1
    add-int/lit8 v8, v3, 0x1

    aget v6, p0, v8

    .line 55
    .restart local v6    # "y":I
    aget v8, p0, v3

    ushr-int/lit8 v9, v7, 0x5

    shl-int/lit8 v10, v6, 0x2

    xor-int/2addr v9, v10

    ushr-int/lit8 v10, v6, 0x3

    shl-int/lit8 v11, v7, 0x4

    xor-int/2addr v10, v11

    add-int/2addr v9, v10

    xor-int v10, v5, v6

    .line 56
    and-int/lit8 v11, v3, 0x3

    xor-int/2addr v11, v1

    aget v11, p1, v11

    xor-int/2addr v11, v7

    add-int/2addr v10, v11

    xor-int/2addr v9, v10

    .line 55
    add-int v7, v8, v9

    aput v7, p0, v3

    .line 53
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method private static toByteArray([IZ)[B
    .locals 6
    .param p0, "data"    # [I
    .param p1, "includeLength"    # Z

    .prologue
    .line 127
    array-length v4, p0

    shl-int/lit8 v2, v4, 0x2

    .line 130
    .local v2, "n":I
    if-eqz p1, :cond_2

    .line 131
    array-length v4, p0

    add-int/lit8 v4, v4, -0x1

    aget v1, p0, v4

    .line 133
    .local v1, "m":I
    if-le v1, v2, :cond_1

    .line 134
    const/4 v3, 0x0

    .line 144
    .end local v1    # "m":I
    :cond_0
    return-object v3

    .line 136
    .restart local v1    # "m":I
    :cond_1
    move v2, v1

    .line 139
    .end local v1    # "m":I
    :cond_2
    new-array v3, v2, [B

    .line 141
    .local v3, "result":[B
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    .line 142
    ushr-int/lit8 v4, v0, 0x2

    aget v4, p0, v4

    and-int/lit8 v5, v0, 0x3

    shl-int/lit8 v5, v5, 0x3

    ushr-int/2addr v4, v5

    and-int/lit16 v4, v4, 0xff

    int-to-byte v4, v4

    aput-byte v4, v3, v0

    .line 141
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static toIntArray([BZ)[I
    .locals 7
    .param p0, "data"    # [B
    .param p1, "includeLength"    # Z

    .prologue
    .line 102
    array-length v3, p0

    and-int/lit8 v3, v3, 0x3

    if-nez v3, :cond_0

    array-length v3, p0

    ushr-int/lit8 v1, v3, 0x2

    .line 106
    .local v1, "n":I
    :goto_0
    if-eqz p1, :cond_1

    .line 107
    add-int/lit8 v3, v1, 0x1

    new-array v2, v3, [I

    .line 108
    .local v2, "result":[I
    array-length v3, p0

    aput v3, v2, v1

    .line 112
    :goto_1
    array-length v1, p0

    .line 113
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_2
    if-lt v0, v1, :cond_2

    .line 116
    return-object v2

    .line 103
    .end local v0    # "i":I
    .end local v1    # "n":I
    .end local v2    # "result":[I
    :cond_0
    array-length v3, p0

    ushr-int/lit8 v3, v3, 0x2

    add-int/lit8 v1, v3, 0x1

    goto :goto_0

    .line 110
    .restart local v1    # "n":I
    :cond_1
    new-array v2, v1, [I

    .restart local v2    # "result":[I
    goto :goto_1

    .line 114
    .restart local v0    # "i":I
    :cond_2
    ushr-int/lit8 v3, v0, 0x2

    aget v4, v2, v3

    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xff

    and-int/lit8 v6, v0, 0x3

    shl-int/lit8 v6, v6, 0x3

    shl-int/2addr v5, v6

    or-int/2addr v4, v5

    aput v4, v2, v3

    .line 113
    add-int/lit8 v0, v0, 0x1

    goto :goto_2
.end method
