.class public Lcom/digitalsky/alipay/Rsa;
.super Ljava/lang/Object;
.source "Rsa.java"


# static fields
.field private static final ALGORITHM:Ljava/lang/String; = "RSA"

.field public static final SIGN_ALGORITHMS:Ljava/lang/String; = "SHA1WithRSA"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static doCheck(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9
    .param p0, "content"    # Ljava/lang/String;
    .param p1, "sign"    # Ljava/lang/String;
    .param p2, "publicKey"    # Ljava/lang/String;

    .prologue
    .line 110
    :try_start_0
    const-string v6, "RSA"

    invoke-static {v6}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v3

    .line 111
    .local v3, "keyFactory":Ljava/security/KeyFactory;
    invoke-static {p2}, Lcom/digitalsky/alipay/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v2

    .line 113
    .local v2, "encodedKey":[B
    new-instance v6, Ljava/security/spec/X509EncodedKeySpec;

    invoke-direct {v6, v2}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    invoke-virtual {v3, v6}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v4

    .line 116
    .local v4, "pubKey":Ljava/security/PublicKey;
    const-string v6, "SHA1WithRSA"

    invoke-static {v6}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v5

    .line 118
    .local v5, "signature":Ljava/security/Signature;
    invoke-virtual {v5, v4}, Ljava/security/Signature;->initVerify(Ljava/security/PublicKey;)V

    .line 119
    const-string v6, "utf-8"

    invoke-virtual {p0, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/security/Signature;->update([B)V

    .line 120
    const-string v6, "Result"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "content :   "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    const-string v6, "Result"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "sign:   "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    invoke-static {p1}, Lcom/digitalsky/alipay/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/security/Signature;->verify([B)Z

    move-result v0

    .line 123
    .local v0, "bverify":Z
    const-string v6, "Result"

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "bverify = "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 129
    .end local v0    # "bverify":Z
    .end local v2    # "encodedKey":[B
    .end local v3    # "keyFactory":Ljava/security/KeyFactory;
    .end local v4    # "pubKey":Ljava/security/PublicKey;
    .end local v5    # "signature":Ljava/security/Signature;
    :goto_0
    return v0

    .line 125
    :catch_0
    move-exception v1

    .line 126
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 129
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static encrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p0, "content"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 42
    :try_start_0
    const-string v6, "RSA"

    invoke-static {v6, p1}, Lcom/digitalsky/alipay/Rsa;->getPublicKeyFromX509(Ljava/lang/String;Ljava/lang/String;)Ljava/security/PublicKey;

    move-result-object v4

    .line 44
    .local v4, "pubkey":Ljava/security/PublicKey;
    const-string v6, "RSA/ECB/PKCS1Padding"

    invoke-static {v6}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 45
    .local v0, "cipher":Ljavax/crypto/Cipher;
    const/4 v6, 0x1

    invoke-virtual {v0, v6, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 47
    const-string v6, "UTF-8"

    invoke-virtual {p0, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    .line 48
    .local v3, "plaintext":[B
    invoke-virtual {v0, v3}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v2

    .line 50
    .local v2, "output":[B
    new-instance v5, Ljava/lang/String;

    invoke-static {v2}, Lcom/digitalsky/alipay/Base64;->encode([B)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    .end local v0    # "cipher":Ljavax/crypto/Cipher;
    .end local v2    # "output":[B
    .end local v3    # "plaintext":[B
    .end local v4    # "pubkey":Ljava/security/PublicKey;
    :goto_0
    return-object v5

    .line 54
    :catch_0
    move-exception v1

    .line 55
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 56
    const/4 v5, 0x0

    goto :goto_0
.end method

.method public static getMD5(Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p0, "content"    # Ljava/lang/String;

    .prologue
    const/16 v12, 0x10

    .line 86
    const/4 v7, 0x0

    .line 87
    .local v7, "s":Ljava/lang/String;
    new-array v2, v12, [C

    fill-array-data v2, :array_0

    .line 91
    .local v2, "hexDigits":[C
    :try_start_0
    const-string v11, "MD5"

    invoke-static {v11}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v6

    .line 92
    .local v6, "md":Ljava/security/MessageDigest;
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v11

    invoke-virtual {v6, v11}, Ljava/security/MessageDigest;->update([B)V

    .line 93
    invoke-virtual {v6}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v10

    .line 94
    .local v10, "tmp":[B
    const/16 v11, 0x20

    new-array v9, v11, [C

    .line 95
    .local v9, "str":[C
    const/4 v4, 0x0

    .line 96
    .local v4, "k":I
    const/4 v3, 0x0

    .local v3, "i":I
    move v5, v4

    .end local v4    # "k":I
    .local v5, "k":I
    :goto_0
    if-lt v3, v12, :cond_0

    .line 101
    new-instance v8, Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/lang/String;-><init>([C)V

    .end local v7    # "s":Ljava/lang/String;
    .local v8, "s":Ljava/lang/String;
    move-object v7, v8

    .line 106
    .end local v3    # "i":I
    .end local v5    # "k":I
    .end local v6    # "md":Ljava/security/MessageDigest;
    .end local v8    # "s":Ljava/lang/String;
    .end local v9    # "str":[C
    .end local v10    # "tmp":[B
    .restart local v7    # "s":Ljava/lang/String;
    :goto_1
    return-object v7

    .line 97
    .restart local v3    # "i":I
    .restart local v5    # "k":I
    .restart local v6    # "md":Ljava/security/MessageDigest;
    .restart local v9    # "str":[C
    .restart local v10    # "tmp":[B
    :cond_0
    aget-byte v0, v10, v3

    .line 98
    .local v0, "byte0":B
    add-int/lit8 v4, v5, 0x1

    .end local v5    # "k":I
    .restart local v4    # "k":I
    ushr-int/lit8 v11, v0, 0x4

    and-int/lit8 v11, v11, 0xf

    aget-char v11, v2, v11

    aput-char v11, v9, v5

    .line 99
    add-int/lit8 v5, v4, 0x1

    .end local v4    # "k":I
    .restart local v5    # "k":I
    and-int/lit8 v11, v0, 0xf

    aget-char v11, v2, v11

    aput-char v11, v9, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 96
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 103
    .end local v0    # "byte0":B
    .end local v3    # "i":I
    .end local v5    # "k":I
    .end local v6    # "md":Ljava/security/MessageDigest;
    .end local v9    # "str":[C
    .end local v10    # "tmp":[B
    :catch_0
    move-exception v1

    .line 104
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 87
    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method private static getPublicKeyFromX509(Ljava/lang/String;Ljava/lang/String;)Ljava/security/PublicKey;
    .locals 4
    .param p0, "algorithm"    # Ljava/lang/String;
    .param p1, "bysKey"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 33
    invoke-static {p1}, Lcom/digitalsky/alipay/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v0

    .line 34
    .local v0, "decodedKey":[B
    new-instance v2, Ljava/security/spec/X509EncodedKeySpec;

    invoke-direct {v2, v0}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    .line 36
    .local v2, "x509":Ljava/security/spec/X509EncodedKeySpec;
    invoke-static {p0}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v1

    .line 37
    .local v1, "keyFactory":Ljava/security/KeyFactory;
    invoke-virtual {v1, v2}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v3

    return-object v3
.end method

.method public static sign(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "content"    # Ljava/lang/String;
    .param p1, "privateKey"    # Ljava/lang/String;

    .prologue
    .line 63
    const-string v0, "UTF-8"

    .line 65
    .local v0, "charset":Ljava/lang/String;
    :try_start_0
    new-instance v4, Ljava/security/spec/PKCS8EncodedKeySpec;

    .line 66
    invoke-static {p1}, Lcom/digitalsky/alipay/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v7

    .line 65
    invoke-direct {v4, v7}, Ljava/security/spec/PKCS8EncodedKeySpec;-><init>([B)V

    .line 67
    .local v4, "priPKCS8":Ljava/security/spec/PKCS8EncodedKeySpec;
    const-string v7, "RSA"

    invoke-static {v7}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v2

    .line 68
    .local v2, "keyf":Ljava/security/KeyFactory;
    invoke-virtual {v2, v4}, Ljava/security/KeyFactory;->generatePrivate(Ljava/security/spec/KeySpec;)Ljava/security/PrivateKey;

    move-result-object v3

    .line 71
    .local v3, "priKey":Ljava/security/PrivateKey;
    const-string v7, "SHA1WithRSA"

    invoke-static {v7}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v5

    .line 73
    .local v5, "signature":Ljava/security/Signature;
    invoke-virtual {v5, v3}, Ljava/security/Signature;->initSign(Ljava/security/PrivateKey;)V

    .line 74
    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/security/Signature;->update([B)V

    .line 76
    invoke-virtual {v5}, Ljava/security/Signature;->sign()[B

    move-result-object v6

    .line 78
    .local v6, "signed":[B
    invoke-static {v6}, Lcom/digitalsky/alipay/Base64;->encode([B)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 83
    .end local v2    # "keyf":Ljava/security/KeyFactory;
    .end local v3    # "priKey":Ljava/security/PrivateKey;
    .end local v4    # "priPKCS8":Ljava/security/spec/PKCS8EncodedKeySpec;
    .end local v5    # "signature":Ljava/security/Signature;
    .end local v6    # "signed":[B
    :goto_0
    return-object v7

    .line 79
    :catch_0
    move-exception v1

    .line 80
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 83
    const/4 v7, 0x0

    goto :goto_0
.end method
