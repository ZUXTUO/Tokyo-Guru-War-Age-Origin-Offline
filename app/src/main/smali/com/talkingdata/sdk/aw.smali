.class public Lcom/talkingdata/sdk/aw;
.super Lcom/talkingdata/sdk/az;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lcom/talkingdata/sdk/az;-><init>()V

    const-string v0, "domain"

    invoke-virtual {p0, v0, p1}, Lcom/talkingdata/sdk/aw;->a(Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "name"

    invoke-virtual {p0, v0, p2}, Lcom/talkingdata/sdk/aw;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/util/Map;)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    const-string v1, "data"

    invoke-virtual {p0, v1, v0}, Lcom/talkingdata/sdk/aw;->a(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
