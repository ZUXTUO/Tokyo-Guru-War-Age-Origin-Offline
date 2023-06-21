.class public Lcom/talkingdata/sdk/ay;
.super Lcom/talkingdata/sdk/az;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    return-void
.end method


# virtual methods
.method public a_()Ljava/lang/Object;
    .locals 1

    sget-object v0, Lcom/talkingdata/sdk/as;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/talkingdata/sdk/s;->c(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method
