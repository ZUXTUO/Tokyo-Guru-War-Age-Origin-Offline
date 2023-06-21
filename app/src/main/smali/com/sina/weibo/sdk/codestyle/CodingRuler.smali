.class public Lcom/sina/weibo/sdk/codestyle/CodingRuler;
.super Ljava/lang/Object;
.source "CodingRuler.java"


# static fields
.field public static final ACTION_MAIN:Ljava/lang/String; = "android.intent.action.MAIN"

.field private static final MSG_AUTH_FAILED:I = 0x2

.field private static final MSG_AUTH_NONE:I = 0x0

.field private static final MSG_AUTH_SUCCESS:I = 0x1


# instance fields
.field protected mObject0:Ljava/lang/Object;

.field private mObject1:Ljava/lang/Object;

.field private mObject2:Ljava/lang/Object;

.field private mObject3:Ljava/lang/Object;

.field private mObject4:Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private circulationFun()V
    .locals 7

    .prologue
    .line 220
    const/4 v4, 0x5

    new-array v0, v4, [I

    fill-array-data v0, :array_0

    .line 221
    .local v0, "array":[I
    array-length v5, v0

    const/4 v4, 0x0

    :goto_0
    if-lt v4, v5, :cond_2

    .line 225
    array-length v3, v0

    .line 226
    .local v3, "length":I
    const/4 v2, 0x0

    .local v2, "ix":I
    :goto_1
    if-lt v2, v3, :cond_3

    .line 230
    const/4 v1, 0x1

    .line 231
    .local v1, "condition":Z
    :goto_2
    if-eqz v1, :cond_0

    goto :goto_2

    .line 237
    :cond_0
    :goto_3
    if-eqz v1, :cond_1

    goto :goto_3

    .line 238
    :cond_1
    return-void

    .line 221
    .end local v1    # "condition":Z
    .end local v2    # "ix":I
    .end local v3    # "length":I
    :cond_2
    aget v6, v0, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 226
    .restart local v2    # "ix":I
    .restart local v3    # "length":I
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 220
    :array_0
    .array-data 4
        0x1
        0x2
        0x3
        0x4
        0x5
    .end array-data
.end method

.method private conditionFun()V
    .locals 6

    .prologue
    .line 157
    const/4 v0, 0x1

    .line 158
    .local v0, "condition1":Z
    const/4 v1, 0x0

    .line 159
    .local v1, "condition2":Z
    const/4 v2, 0x0

    .line 160
    .local v2, "condition3":Z
    const/4 v3, 0x0

    .line 161
    .local v3, "condition4":Z
    const/4 v4, 0x0

    .line 162
    .local v4, "condition5":Z
    const/4 v5, 0x0

    .line 177
    .local v5, "condition6":Z
    if-eqz v0, :cond_0

    .line 178
    const/4 v2, 0x1

    .line 180
    :cond_0
    if-eq v0, v1, :cond_1

    .line 181
    if-eq v2, v3, :cond_1

    .line 185
    :cond_1
    return-void
.end method

.method private doSomethingInternal(IF)V
    .locals 0
    .param p1, "param1"    # I
    .param p2, "param2"    # F

    .prologue
    .line 151
    return-void
.end method

.method private exceptionFun()V
    .locals 0

    .prologue
    .line 254
    return-void
.end method

.method private otherFun()V
    .locals 0

    .prologue
    .line 261
    return-void
.end method

.method private switchFun()V
    .locals 1

    .prologue
    .line 195
    const/4 v0, 0x1

    .line 196
    .local v0, "code":I
    packed-switch v0, :pswitch_data_0

    .line 208
    :pswitch_0
    return-void

    .line 196
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected doSomething()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 141
    return-void
.end method

.method public doSomething(IFLjava/lang/String;)V
    .locals 0
    .param p1, "param1"    # I
    .param p2, "param2"    # F
    .param p3, "paramXX"    # Ljava/lang/String;

    .prologue
    .line 133
    return-void
.end method
