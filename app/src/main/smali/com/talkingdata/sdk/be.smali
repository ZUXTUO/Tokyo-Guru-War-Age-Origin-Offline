.class public Lcom/talkingdata/sdk/be;
.super Lcom/talkingdata/sdk/az;


# static fields
.field public static final a:Ljava/lang/String; = "type"

.field public static final c:Ljava/lang/String; = "deviceId"

.field public static final d:Ljava/lang/String; = "hardwareConfig"

.field public static final e:Ljava/lang/String; = "softwareConfig"

.field public static final f:Ljava/lang/String; = "tags"


# instance fields
.field g:Lcom/talkingdata/sdk/bf;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    new-instance v0, Lcom/talkingdata/sdk/bf;

    invoke-direct {v0}, Lcom/talkingdata/sdk/bf;-><init>()V

    iput-object v0, p0, Lcom/talkingdata/sdk/be;->g:Lcom/talkingdata/sdk/bf;

    invoke-direct {p0}, Lcom/talkingdata/sdk/be;->c()V

    return-void
.end method

.method private c()V
    .locals 2

    const-string v0, "type"

    const-string v1, "mobile"

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/be;->a(Ljava/lang/String;Ljava/lang/Object;)V

    new-instance v0, Lcom/talkingdata/sdk/bd;

    invoke-direct {v0}, Lcom/talkingdata/sdk/bd;-><init>()V

    const-string v1, "deviceId"

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bd;->a_()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/be;->a(Ljava/lang/String;Ljava/lang/Object;)V

    new-instance v0, Lcom/talkingdata/sdk/bc;

    invoke-direct {v0}, Lcom/talkingdata/sdk/bc;-><init>()V

    const-string v1, "hardwareConfig"

    invoke-virtual {v0}, Lcom/talkingdata/sdk/bc;->a_()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/be;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "softwareConfig"

    iget-object v1, p0, Lcom/talkingdata/sdk/be;->g:Lcom/talkingdata/sdk/bf;

    invoke-virtual {v1}, Lcom/talkingdata/sdk/bf;->a_()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/talkingdata/sdk/be;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public b()Lcom/talkingdata/sdk/bf;
    .locals 1

    iget-object v0, p0, Lcom/talkingdata/sdk/be;->g:Lcom/talkingdata/sdk/bf;

    return-object v0
.end method
