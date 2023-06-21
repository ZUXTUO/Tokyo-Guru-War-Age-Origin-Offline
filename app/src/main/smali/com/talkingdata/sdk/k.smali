.class public Lcom/talkingdata/sdk/k;
.super Ljava/lang/Object;


# static fields
.field private static final h:Ljava/lang/String; = "td-cache"

.field private static final i:Ljava/lang/String; = "td-%.zip"

.field private static final j:Ljava/lang/String; = "td.tmp-"

.field private static final k:Ljava/lang/String; = "pref_longtime"

.field private static final l:Ljava/lang/String; = "td.sdk.digest."

.field private static final m:[B

.field private static final n:[I

.field private static final o:[I


# instance fields
.field a:Lcom/talkingdata/sdk/m;

.field b:Landroid/content/Context;

.field c:Ljava/lang/String;

.field d:Ljava/lang/String;

.field e:Ljava/lang/String;

.field f:Ljava/lang/String;

.field volatile g:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/16 v1, 0x14

    const/16 v0, 0x380

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/talkingdata/sdk/k;->m:[B

    new-array v0, v1, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/talkingdata/sdk/k;->n:[I

    new-array v0, v1, [I

    fill-array-data v0, :array_2

    sput-object v0, Lcom/talkingdata/sdk/k;->o:[I

    return-void

    :array_0
    .array-data 1
        -0x1ct
        0x9t
        -0x3at
        0x3t
        -0x1bt
        -0x5t
        0x74t
        0x44t
        -0x5bt
        -0xdt
        -0x36t
        -0x35t
        -0x26t
        -0x33t
        0x65t
        0x1et
        -0x4bt
        -0x43t
        -0x2t
        0x20t
        -0x50t
        -0xdt
        -0x7at
        0x25t
        -0x14t
        -0x3at
        0x49t
        -0x47t
        0x4ct
        0x2t
        0x27t
        0x4et
        0x3t
        -0x77t
        -0x48t
        0x2ft
        0x1et
        -0x2at
        -0x59t
        0x45t
        -0x70t
        0x1et
        -0x32t
        0x75t
        -0x6bt
        0x78t
        0x16t
        0x3t
        -0x67t
        0x27t
        -0x37t
        -0x76t
        0x10t
        -0x5ft
        0x16t
        0x55t
        -0x44t
        0x36t
        0x2dt
        0x27t
        -0x3at
        0x14t
        0x39t
        -0x7at
        -0x40t
        0x2ct
        0xdt
        0x79t
        0x7et
        -0x2dt
        -0x36t
        0x66t
        0x32t
        0x15t
        -0x79t
        0x1et
        0x19t
        -0x46t
        0x1bt
        -0xct
        0x11t
        -0xat
        0x51t
        -0x23t
        -0x1t
        0x62t
        -0x3ct
        -0x6ct
        0x5et
        0x3ct
        0x31t
        -0x69t
        0x52t
        0x17t
        0x52t
        0x76t
        0x56t
        -0x69t
        0xat
        0x6bt
        -0x4at
        -0x2dt
        0x1ft
        0x0t
        -0x76t
        -0x12t
        0xct
        -0x12t
        0x11t
        -0x32t
        0x10t
        -0x3dt
        -0x6ct
        0x68t
        0x6bt
        0x73t
        -0x70t
        0x29t
        0x3dt
        -0x67t
        -0x7ct
        -0x3at
        -0x56t
        -0x59t
        -0x22t
        0x4at
        0x2dt
        -0x14t
        0x5ct
        0x2bt
        0x6dt
        -0x45t
        0x34t
        -0x69t
        -0x3dt
        0x5at
        0x0t
        -0x3ct
        -0x80t
        -0x18t
        -0x7bt
        -0x77t
        -0x61t
        -0x23t
        -0x53t
        0x11t
        -0x18t
        -0x1ct
        0x2et
        -0x14t
        0x7t
        -0xft
        -0x19t
        0x36t
        -0x57t
        0x4et
        -0xat
        -0x6ct
        0x14t
        0x63t
        -0x7at
        -0x42t
        -0x4ct
        -0x3ct
        -0x7t
        0x7ct
        0x72t
        0x1bt
        -0x51t
        0x77t
        -0x2ft
        -0x5bt
        -0x7ft
        -0x5et
        0x77t
        0x52t
        0x6ct
        -0x70t
        0x50t
        -0x6dt
        0x68t
        0x51t
        0x13t
        -0x3t
        -0x3bt
        0x7ft
        -0x6t
        0x5t
        0x43t
        0x1bt
        0x1at
        -0x5et
        0x13t
        0x12t
        0x3t
        0x77t
        -0x5ft
        -0x1at
        0x49t
        0x5ft
        0x61t
        0x35t
        -0x36t
        0x55t
        -0x6at
        -0xat
        -0xft
        0x79t
        0x38t
        0x2et
        -0x76t
        -0x4t
        -0x6t
        0x20t
        0xct
        -0x1at
        0x11t
        -0x28t
        -0x4ct
        -0x62t
        -0x50t
        0x43t
        -0xbt
        0x0t
        -0x74t
        0x3et
        -0x3et
        -0x55t
        -0xft
        0x30t
        -0x6et
        0x3ft
        0x23t
        0x36t
        0x55t
        0xbt
        0x52t
        -0x3at
        0x4at
        -0x41t
        0x44t
        -0x3at
        -0x6at
        -0x2et
        -0x46t
        -0x9t
        -0x4ct
        0x3at
        0x6ft
        -0x5et
        0x7ct
        0x3bt
        0x7ct
        0x4et
        0x5ct
        -0x11t
        0x5t
        -0x6bt
        0x5ft
        -0x42t
        -0x51t
        0x33t
        -0x38t
        -0x62t
        -0x53t
        0x4bt
        0x78t
        0x38t
        0x50t
        0x20t
        -0x27t
        0x6ft
        -0x5bt
        -0x58t
        -0x44t
        -0x1dt
        -0x7bt
        0x5ct
        -0x58t
        -0x47t
        0x79t
        0x37t
        0x31t
        -0x62t
        0x58t
        0x39t
        0x5ft
        0x8t
        0x5ft
        0x3bt
        0x10t
        0x37t
        -0x65t
        0x5at
        -0x1dt
        -0x33t
        0x75t
        -0x2dt
        -0x37t
        0x2dt
        0x25t
        0xct
        -0x31t
        -0x45t
        0x10t
        0x59t
        -0x33t
        0x10t
        -0x61t
        0x55t
        0x78t
        0x6dt
        0x17t
        -0x24t
        0x2dt
        0x20t
        -0x53t
        0x1et
        0x5ft
        -0x9t
        -0x5ct
        0x52t
        0x60t
        -0x1bt
        0x31t
        -0x4bt
        -0x78t
        0x53t
        -0x17t
        0x2t
        0xdt
        -0x53t
        0x43t
        0x14t
        -0x10t
        0x74t
        0x1ct
        -0x21t
        0x3dt
        -0x20t
        0x1ft
        -0x35t
        0x6et
        0x2ft
        -0x38t
        -0x5at
        0x21t
        -0x3et
        -0x6t
        -0x33t
        -0x69t
        -0x5dt
        0x34t
        -0x2ft
        -0x13t
        -0x76t
        -0x72t
        -0x7dt
        0x4bt
        0x9t
        -0x7dt
        0xbt
        -0x5dt
        0x22t
        -0x5t
        -0x7t
        0x8t
        0x4at
        -0x13t
        0x51t
        -0x5bt
        0x27t
        -0x35t
        0x77t
        -0xct
        -0x1et
        -0x1et
        0x3et
        0xdt
        0x7et
        0x13t
        0x35t
        0x78t
        -0xat
        0x29t
        0x50t
        -0xct
        -0x30t
        -0x4t
        0x3bt
        0x7t
        0x1at
        -0x11t
        0x73t
        -0x1ft
        0x1dt
        0x36t
        0x65t
        0x48t
        -0x62t
        -0x27t
        -0x60t
        0x58t
        -0x1bt
        0x39t
        0x9t
        -0x76t
        0x8t
        0x62t
        -0x11t
        0x1at
        -0x54t
        0x0t
        0x42t
        -0x26t
        -0x21t
        0x48t
        -0x78t
        -0x4ft
        0x1at
        -0x6dt
        -0x28t
        0x3dt
        0x3t
        0x54t
        0x13t
        0x4at
        0x57t
        0x2ft
        0x45t
        0x44t
        -0x64t
        0x56t
        -0xbt
        0x5et
        0x25t
        -0x14t
        -0x49t
        0x12t
        0x37t
        -0x19t
        0x2dt
        -0x7dt
        -0x52t
        -0x27t
        0x61t
        -0x58t
        0x32t
        0x52t
        0x79t
        -0xdt
        -0x7ct
        -0x11t
        0x30t
        0x5ft
        0x52t
        0x41t
        0x7dt
        -0x3dt
        0x76t
        -0x19t
        -0x5at
        -0x5t
        -0x39t
        0x52t
        0x15t
        -0x70t
        0x3bt
        0x3ft
        0x6bt
        -0x49t
        0x13t
        0x5dt
        -0x2ct
        0x40t
        -0x16t
        -0x5ct
        0x45t
        -0x5et
        -0x4bt
        0x79t
        -0x4dt
        0x6t
        -0x1ct
        -0x2ft
        0x7ct
        -0xft
        -0xet
        0x22t
        0x71t
        -0x48t
        -0x31t
        -0x77t
        -0xat
        -0x20t
        -0x6at
        -0x1t
        -0x2et
        -0x5at
        -0x1ct
        -0x45t
        -0x30t
        -0x6ct
        -0x5ct
        -0x7at
        0x6et
        0x58t
        -0x17t
        0x44t
        0x44t
        0x73t
        -0x10t
        0x8t
        -0x5ct
        0x39t
        -0x21t
        -0x59t
        0xct
        0x5at
        -0x7bt
        0x29t
        -0x8t
        -0x64t
        -0x75t
        -0x57t
        0x77t
        -0x19t
        0x6t
        0x7ct
        0x4t
        0x3et
        -0x35t
        0x24t
        -0x28t
        0x44t
        0x3ft
        0x3dt
        -0x2at
        0x35t
        0xet
        -0x5t
        -0x17t
        -0x38t
        -0x4t
        -0x12t
        -0x4et
        0x50t
        -0x3t
        0x11t
        0x5at
        0x4at
        0x2et
        0x16t
        0x62t
        0x48t
        0x39t
        0x8t
        -0x55t
        -0x73t
        -0x2ct
        0x24t
        0x4et
        -0x57t
        0x74t
        0x18t
        0x33t
        -0x50t
        0x30t
        -0x62t
        0xet
        0x5t
        0x19t
        0x31t
        -0x64t
        -0x5dt
        -0x6et
        0x6t
        0x49t
        0x2ft
        0x1ct
        0x1at
        -0x10t
        0x76t
        -0x54t
        -0x10t
        -0x31t
        0x3ft
        -0x44t
        -0x62t
        -0x2bt
        -0x33t
        -0x1at
        0x67t
        -0x3at
        -0x71t
        0x41t
        -0x58t
        0xat
        0x59t
        0x17t
        0x27t
        0x5dt
        -0x39t
        -0x5ft
        -0x3dt
        -0x20t
        0x31t
        0x4ft
        0x3dt
        -0x5at
        -0x10t
        -0x77t
        -0x6et
        0x0t
        -0x44t
        -0x7dt
        -0x41t
        -0x73t
        0x6at
        -0x34t
        -0x67t
        -0x1ft
        -0x48t
        0x2et
        0x1ft
        -0x44t
        -0xct
        -0x2dt
        0x1at
        0x13t
        -0x73t
        -0x31t
        0x38t
        0x68t
        0x9t
        -0x27t
        0x40t
        0x71t
        -0x23t
        -0x30t
        0x59t
        0x7ct
        0x6bt
        -0x52t
        -0x3dt
        0x56t
        0x8t
        -0x28t
        0xft
        -0x25t
        -0x57t
        0x71t
        0xft
        -0x16t
        -0x5t
        -0x16t
        0x23t
        -0x3bt
        0x4ft
        0x39t
        0x29t
        0xat
        -0x1t
        0x66t
        0x69t
        -0x7at
        0x66t
        -0x7at
        -0x75t
        0x7ct
        0x5ct
        0x21t
        -0x3ct
        0x42t
        0x5dt
        -0xft
        -0x73t
        -0x49t
        0x60t
        -0x16t
        0x4bt
        -0x34t
        -0x3bt
        -0x48t
        -0x7t
        0x29t
        -0x30t
        -0x6ct
        -0x19t
        0x68t
        0x5dt
        -0x6t
        0x48t
        -0x32t
        -0x7at
        -0x6dt
        0x3t
        0x20t
        -0x1at
        -0x6dt
        -0x2bt
        0x4ft
        -0x3ft
        -0x77t
        0x9t
        -0x32t
        -0x7at
        0x67t
        -0x3et
        0x47t
        0x1dt
        -0x78t
        0x44t
        0x31t
        0x51t
        0x23t
        -0x3et
        0x79t
        0x1at
        -0x19t
        0x31t
        0x54t
        -0x14t
        -0x38t
        -0x4at
        0x45t
        0x46t
        -0x24t
        0x4ct
        0x33t
        -0x59t
        -0x3dt
        0x5bt
        0x5at
        -0x5ft
        0x3ft
        0x2ft
        -0x2dt
        0x1ft
        0x1ft
        0x78t
        -0x7t
        -0x56t
        -0x40t
        0x5et
        -0x4dt
        0x24t
        0x35t
        0x78t
        0x1ft
        -0xft
        -0x7dt
        0x69t
        -0x61t
        0x48t
        0x7at
        0x77t
        0x7bt
        0x24t
        0x17t
        -0x5bt
        -0x7bt
        0x68t
        -0x5bt
        0x2t
        -0x38t
        -0x6dt
        0x2ft
        0x75t
        -0x61t
        0x4at
        0xet
        0x1t
        -0x5t
        -0x37t
        0x11t
        -0xct
        -0x5dt
        0x6ct
        -0x23t
        0x49t
        -0x2et
        -0x50t
        -0x7dt
        -0x2et
        -0x1ct
        0x29t
        0x42t
        0x10t
        0x13t
        -0x58t
        -0x6at
        0x19t
        -0x41t
        0x3bt
        0x30t
        0x36t
        0x63t
        -0x38t
        0x70t
        0x50t
        -0x58t
        -0x2bt
        -0x11t
        0x13t
        -0x31t
        -0x3et
        0x75t
        0x5ct
        0x21t
        -0x76t
        0x74t
        0xdt
        0x70t
        -0x7bt
        0x77t
        -0x73t
        -0x70t
        -0x6dt
        0x62t
        0x15t
        -0x42t
        0x48t
        -0x21t
        -0x66t
        -0x3ft
        0x1t
        0x5ct
        -0x3ft
        -0x22t
        -0x3et
        0x4at
        0x32t
        0x53t
        0x7t
        0x31t
        0x6ft
        0x78t
        -0x4t
        -0x1ft
        0x5et
        -0x9t
        -0x65t
        0x22t
        0x5t
        -0x4ft
        -0x76t
        0x20t
        0x3ft
        -0x1t
        0x1ct
        0x50t
        -0x75t
        0x6et
        0x1et
        0xct
        0x41t
        -0x13t
        0x50t
        -0x6at
        -0x48t
        -0x77t
        0x29t
        0x26t
        0x46t
        -0x70t
        -0x26t
        -0x5ft
        -0x57t
        0x75t
        -0x3et
        0x3ct
        0x4et
        -0x2et
        -0x7ct
        -0x28t
        -0x78t
        0x35t
        -0x53t
        0x47t
        -0x3t
        0x38t
        -0x2dt
        0x74t
        0x1dt
        0x4at
        0x7ct
        -0x78t
        0x51t
        0x5t
        -0xdt
        -0x63t
        0x4ct
        -0x70t
        0x55t
        -0x48t
    .end array-data

    :array_1
    .array-data 4
        0x30
        0xae
        0xb3
        0x39
        0x75
        0x9e
        0x6f
        0x4d
        0x5
        0xbe
        0xb9
        0xf1
        0x39
        0x15
        0xd8
        0xb2
        0x25
        0x2
        0x5f
        0xa6
    .end array-data

    :array_2
    .array-data 4
        0x68
        0xa9
        0x5b
        0x66
        0x42
        0xef
        0x16
        0x14
        0x74
        0x6
        0x5f
        0x8
        0x9
        0x1c
        0xce
        0xa0
        0x7b
        0x98
        0x21
        0x7e
    .end array-data
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/talkingdata/sdk/k;->g:Z

    return-void
.end method

.method static synthetic a(Lcom/talkingdata/sdk/k;Ljava/lang/String;)Lcom/talkingdata/sdk/m;
    .locals 1

    invoke-direct {p0, p1}, Lcom/talkingdata/sdk/k;->a(Ljava/lang/String;)Lcom/talkingdata/sdk/m;

    move-result-object v0

    return-object v0
.end method

.method private a(Ljava/lang/String;)Lcom/talkingdata/sdk/m;
    .locals 6

    const/4 v1, 0x0

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/k;->b:Landroid/content/Context;

    const-string v2, "td-cache"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    new-instance v2, Ljava/io/File;

    iget-object v3, p0, Lcom/talkingdata/sdk/k;->d:Ljava/lang/String;

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {p0, v2}, Lcom/talkingdata/sdk/k;->a(Ljava/io/File;)Z

    move-result v3

    if-eqz v3, :cond_0

    new-instance v3, Ldalvik/system/DexClassLoader;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const/4 v4, 0x0

    const-class v5, Lcom/talkingdata/sdk/k;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-direct {v3, v2, v0, v4, v5}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    invoke-virtual {v3, p1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/m;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    :cond_0
    move-object v0, v1

    goto :goto_0
.end method

.method static synthetic a(Lcom/talkingdata/sdk/k;Lcom/talkingdata/sdk/m;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/talkingdata/sdk/k;->a(Lcom/talkingdata/sdk/m;)V

    return-void
.end method

.method private a(Lcom/talkingdata/sdk/m;)V
    .locals 5

    const/4 v3, 0x0

    const-string v0, ""

    invoke-interface {p1, v0}, Lcom/talkingdata/sdk/m;->a(Ljava/lang/String;)V

    invoke-interface {p1}, Lcom/talkingdata/sdk/m;->d()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/net/URL;

    invoke-direct {v1, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/net/URL;->getHost()Ljava/lang/String;

    invoke-virtual {v1}, Ljava/net/URL;->getPort()I

    move-result v0

    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    invoke-virtual {v1}, Ljava/net/URL;->getDefaultPort()I

    :cond_0
    new-instance v0, Ljava/lang/String;

    sget-object v1, Lcom/talkingdata/sdk/k;->n:[I

    sget-object v2, Lcom/talkingdata/sdk/k;->o:[I

    invoke-static {v1, v2}, Lcom/talkingdata/sdk/t;->a([I[I)[B

    move-result-object v1

    sget-object v2, Lcom/talkingdata/sdk/k;->m:[B

    invoke-static {v1, v2}, Lcom/talkingdata/sdk/t;->a([B[B)[B

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([B)V

    invoke-interface {p1}, Lcom/talkingdata/sdk/m;->d()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0, v3}, Lcom/talkingdata/sdk/b;->a(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/talkingdata/sdk/t;->b(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1}, Lcom/talkingdata/sdk/m;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/talkingdata/sdk/k;->b:Landroid/content/Context;

    const-string v2, "td-cache"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    iget-object v3, p0, Lcom/talkingdata/sdk/k;->e:Ljava/lang/String;

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-interface {p1}, Lcom/talkingdata/sdk/m;->e()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, v2}, Lcom/talkingdata/sdk/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    :try_start_0
    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lcom/talkingdata/sdk/k;->d:Ljava/lang/String;

    invoke-direct {v3, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    invoke-virtual {v2, v3}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    iget-object v1, p0, Lcom/talkingdata/sdk/k;->b:Landroid/content/Context;

    const-string v2, "pref_longtime"

    iget-object v3, p0, Lcom/talkingdata/sdk/k;->f:Ljava/lang/String;

    invoke-static {v1, v2, v3, v0}, Lcom/talkingdata/sdk/n;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {p1}, Lcom/talkingdata/sdk/m;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private a(Ljava/io/File;)Z
    .locals 7

    const/4 v0, 0x0

    const/4 v2, 0x0

    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    const/16 v3, 0x400

    new-array v3, v3, [B

    :goto_0
    invoke-virtual {v1, v3}, Ljava/io/FileInputStream;->read([B)I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_0

    const/4 v5, 0x0

    invoke-virtual {v2, v3, v5, v4}, Ljava/security/MessageDigest;->update([BII)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catch_0
    move-exception v2

    :goto_1
    :try_start_2
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :goto_2
    return v0

    :cond_0
    :try_start_3
    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    invoke-static {v2}, Lcom/talkingdata/sdk/t;->a([B)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/talkingdata/sdk/k;->b:Landroid/content/Context;

    const-string v4, "pref_longtime"

    iget-object v5, p0, Lcom/talkingdata/sdk/k;->f:Ljava/lang/String;

    const-string v6, ""

    invoke-static {v3, v4, v5, v6}, Lcom/talkingdata/sdk/n;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-result v0

    :try_start_4
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    :catch_1
    move-exception v1

    goto :goto_2

    :catchall_0
    move-exception v0

    move-object v1, v2

    :goto_3
    :try_start_5
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    :goto_4
    throw v0

    :catch_2
    move-exception v1

    goto :goto_2

    :catch_3
    move-exception v1

    goto :goto_4

    :catchall_1
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v1

    move-object v1, v2

    goto :goto_1
.end method


# virtual methods
.method public declared-synchronized a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Ljava/lang/String;)Lcom/talkingdata/sdk/m;
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    if-nez v0, :cond_1

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/k;->b:Landroid/content/Context;

    iput-object p3, p0, Lcom/talkingdata/sdk/k;->c:Ljava/lang/String;

    const-string v0, "td-%.zip"

    const-string v1, "%"

    invoke-virtual {v0, v1, p3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/k;->d:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "td.tmp-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/k;->e:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "td.sdk.digest."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/talkingdata/sdk/k;->f:Ljava/lang/String;

    monitor-enter p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/talkingdata/sdk/l;

    invoke-direct {v1, p0, p6}, Lcom/talkingdata/sdk/l;-><init>(Lcom/talkingdata/sdk/k;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const-wide/16 v0, 0x1f4

    invoke-virtual {p0, v0, v1}, Ljava/lang/Object;->wait(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    iget-object v0, p0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/talkingdata/sdk/k;->g:Z

    invoke-virtual {p5}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/talkingdata/sdk/m;

    iput-object v0, p0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    :cond_0
    iget-object v0, p0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;

    invoke-interface {v0, p1, p2}, Lcom/talkingdata/sdk/m;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/talkingdata/sdk/k;->a:Lcom/talkingdata/sdk/m;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    :try_start_4
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
