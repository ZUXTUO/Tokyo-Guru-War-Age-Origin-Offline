.class public Lcom/blm/sdk/connection/BlmLib;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final BLMJAVA_LIB:Ljava/lang/String; = "YvImSdk"


# instance fields
.field private m_blmState:Lcom/blm/sdk/connection/CPtr;

.field private stateId:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 96
    const-string v0, "YvImSdk"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 97
    return-void
.end method

.method protected constructor <init>(I)V
    .locals 1
    .param p1, "stateId"    # I

    .prologue
    .line 108
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 109
    invoke-direct {p0}, Lcom/blm/sdk/connection/BlmLib;->_open()Lcom/blm/sdk/connection/CPtr;

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    .line 110
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->Blm_open(Lcom/blm/sdk/connection/CPtr;I)V

    .line 111
    iput p1, p0, Lcom/blm/sdk/connection/BlmLib;->stateId:I

    .line 112
    return-void
.end method

.method protected constructor <init>(Lcom/blm/sdk/connection/CPtr;)V
    .locals 1
    .param p1, "blmState"    # Lcom/blm/sdk/connection/CPtr;

    .prologue
    .line 119
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 120
    iput-object p1, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    .line 121
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->insertBlmState(Lcom/blm/sdk/connection/BlmLib;)I

    move-result v0

    iput v0, p0, Lcom/blm/sdk/connection/BlmLib;->stateId:I

    .line 122
    iget v0, p0, Lcom/blm/sdk/connection/BlmLib;->stateId:I

    invoke-direct {p0, p1, v0}, Lcom/blm/sdk/connection/BlmLib;->Blm_open(Lcom/blm/sdk/connection/CPtr;I)V

    .line 123
    return-void
.end method

.method private synchronized native declared-synchronized Blm_open(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _LargError(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LcallMeta(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LcheckAny(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _LcheckInteger(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _LcheckNumber(Lcom/blm/sdk/connection/CPtr;I)D
.end method

.method private synchronized native declared-synchronized _LcheckStack(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _LcheckString(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _LcheckType(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _LdoFile(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LdoString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LfindTable(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;I)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _LgetMetaField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LgetMetatable(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _LgetN(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _Lgsub(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _LloadBuffer(Lcom/blm/sdk/connection/CPtr;[BJLjava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LloadFile(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LloadString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LnewMetatable(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LoptInteger(Lcom/blm/sdk/connection/CPtr;II)I
.end method

.method private synchronized native declared-synchronized _LoptNumber(Lcom/blm/sdk/connection/CPtr;ID)D
.end method

.method private synchronized native declared-synchronized _LoptString(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _Lref(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _LsetN(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _Ltyperror(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I
.end method

.method private synchronized native declared-synchronized _LunRef(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _Lwhere(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _call(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _checkStack(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _close(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _concat(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _createTable(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _equal(Lcom/blm/sdk/connection/CPtr;II)I
.end method

.method private synchronized native declared-synchronized _error(Lcom/blm/sdk/connection/CPtr;)I
.end method

.method private synchronized native declared-synchronized _gc(Lcom/blm/sdk/connection/CPtr;II)I
.end method

.method private synchronized native declared-synchronized _getFEnv(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _getField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _getGcCount(Lcom/blm/sdk/connection/CPtr;)I
.end method

.method private synchronized native declared-synchronized _getGlobal(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _getMetaTable(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _getObjectFromUserdata(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation
.end method

.method private synchronized native declared-synchronized _getTable(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _getTop(Lcom/blm/sdk/connection/CPtr;)I
.end method

.method private synchronized native declared-synchronized _insert(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _isBoolean(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isCFunction(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isFunction(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isJavaFunction(Lcom/blm/sdk/connection/CPtr;I)Z
.end method

.method private synchronized native declared-synchronized _isNil(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isNone(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isNoneOrNil(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isNumber(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isObject(Lcom/blm/sdk/connection/CPtr;I)Z
.end method

.method private synchronized native declared-synchronized _isString(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isTable(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isThread(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _isUserdata(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _lessthan(Lcom/blm/sdk/connection/CPtr;II)I
.end method

.method private synchronized native declared-synchronized _newTable(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _newthread(Lcom/blm/sdk/connection/CPtr;)Lcom/blm/sdk/connection/CPtr;
.end method

.method private synchronized native declared-synchronized _next(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _objlen(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _open()Lcom/blm/sdk/connection/CPtr;
.end method

.method private synchronized native declared-synchronized _openBase(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openDebug(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openIo(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openLibs(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openMath(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openOs(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openPackage(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openString(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _openTable(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _pcall(Lcom/blm/sdk/connection/CPtr;III)I
.end method

.method private synchronized native declared-synchronized _pop(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _pushBoolean(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _pushInteger(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _pushJavaFunction(Lcom/blm/sdk/connection/CPtr;Lcom/blm/sdk/connection/JavaFunction;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation
.end method

.method private synchronized native declared-synchronized _pushJavaObject(Lcom/blm/sdk/connection/CPtr;Ljava/lang/Object;)V
.end method

.method private synchronized native declared-synchronized _pushNil(Lcom/blm/sdk/connection/CPtr;)V
.end method

.method private synchronized native declared-synchronized _pushNumber(Lcom/blm/sdk/connection/CPtr;D)V
.end method

.method private synchronized native declared-synchronized _pushString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _pushString(Lcom/blm/sdk/connection/CPtr;[BI)V
.end method

.method private synchronized native declared-synchronized _pushValue(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _rawGet(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _rawGetI(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _rawSet(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _rawSetI(Lcom/blm/sdk/connection/CPtr;II)V
.end method

.method private synchronized native declared-synchronized _rawequal(Lcom/blm/sdk/connection/CPtr;II)I
.end method

.method private synchronized native declared-synchronized _remove(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _replace(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _resume(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _setFEnv(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _setField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _setGlobal(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
.end method

.method private synchronized native declared-synchronized _setMetaTable(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _setTable(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _setTop(Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _status(Lcom/blm/sdk/connection/CPtr;)I
.end method

.method private synchronized native declared-synchronized _strlen(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _toBoolean(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _toInteger(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _toNumber(Lcom/blm/sdk/connection/CPtr;I)D
.end method

.method private synchronized native declared-synchronized _toString(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _toThread(Lcom/blm/sdk/connection/CPtr;I)Lcom/blm/sdk/connection/CPtr;
.end method

.method private synchronized native declared-synchronized _type(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method private synchronized native declared-synchronized _typeName(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;
.end method

.method private synchronized native declared-synchronized _xmove(Lcom/blm/sdk/connection/CPtr;Lcom/blm/sdk/connection/CPtr;I)V
.end method

.method private synchronized native declared-synchronized _yield(Lcom/blm/sdk/connection/CPtr;I)I
.end method

.method public static convertBlmNumber(Ljava/lang/Double;Ljava/lang/Class;)Ljava/lang/Number;
    .locals 4
    .param p0, "db"    # Ljava/lang/Double;
    .param p1, "retType"    # Ljava/lang/Class;

    .prologue
    .line 1119
    invoke-virtual {p1}, Ljava/lang/Class;->isPrimitive()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1121
    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_1

    .line 1123
    new-instance v0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Double;->intValue()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    move-object p0, v0

    .line 1176
    .end local p0    # "db":Ljava/lang/Double;
    :cond_0
    :goto_0
    return-object p0

    .line 1125
    .restart local p0    # "db":Ljava/lang/Double;
    :cond_1
    sget-object v0, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_2

    .line 1127
    new-instance v0, Ljava/lang/Long;

    invoke-virtual {p0}, Ljava/lang/Double;->longValue()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/lang/Long;-><init>(J)V

    move-object p0, v0

    goto :goto_0

    .line 1129
    :cond_2
    sget-object v0, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_3

    .line 1131
    new-instance v0, Ljava/lang/Float;

    invoke-virtual {p0}, Ljava/lang/Double;->floatValue()F

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Float;-><init>(F)V

    move-object p0, v0

    goto :goto_0

    .line 1133
    :cond_3
    sget-object v0, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    if-eq p1, v0, :cond_0

    .line 1137
    sget-object v0, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_4

    .line 1139
    new-instance v0, Ljava/lang/Byte;

    invoke-virtual {p0}, Ljava/lang/Double;->byteValue()B

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Byte;-><init>(B)V

    move-object p0, v0

    goto :goto_0

    .line 1141
    :cond_4
    sget-object v0, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_a

    .line 1143
    new-instance v0, Ljava/lang/Short;

    invoke-virtual {p0}, Ljava/lang/Double;->shortValue()S

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Short;-><init>(S)V

    move-object p0, v0

    goto :goto_0

    .line 1146
    :cond_5
    const-class v0, Ljava/lang/Number;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 1149
    const-class v0, Ljava/lang/Integer;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1151
    new-instance v0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Double;->intValue()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    move-object p0, v0

    goto :goto_0

    .line 1153
    :cond_6
    const-class v0, Ljava/lang/Long;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 1155
    new-instance v0, Ljava/lang/Long;

    invoke-virtual {p0}, Ljava/lang/Double;->longValue()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/lang/Long;-><init>(J)V

    move-object p0, v0

    goto :goto_0

    .line 1157
    :cond_7
    const-class v0, Ljava/lang/Float;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 1159
    new-instance v0, Ljava/lang/Float;

    invoke-virtual {p0}, Ljava/lang/Double;->floatValue()F

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Float;-><init>(F)V

    move-object p0, v0

    goto/16 :goto_0

    .line 1161
    :cond_8
    const-class v0, Ljava/lang/Double;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1165
    const-class v0, Ljava/lang/Byte;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 1167
    new-instance v0, Ljava/lang/Byte;

    invoke-virtual {p0}, Ljava/lang/Double;->byteValue()B

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Byte;-><init>(B)V

    move-object p0, v0

    goto/16 :goto_0

    .line 1169
    :cond_9
    const-class v0, Ljava/lang/Short;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 1171
    new-instance v0, Ljava/lang/Short;

    invoke-virtual {p0}, Ljava/lang/Double;->shortValue()S

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Short;-><init>(S)V

    move-object p0, v0

    goto/16 :goto_0

    .line 1176
    :cond_a
    const/4 p0, 0x0

    goto/16 :goto_0
.end method


# virtual methods
.method public LargError(ILjava/lang/String;)I
    .locals 1
    .param p1, "numArg"    # I
    .param p2, "extraMsg"    # Ljava/lang/String;

    .prologue
    .line 674
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LargError(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LcallMeta(ILjava/lang/String;)I
    .locals 1
    .param p1, "obj"    # I
    .param p2, "e"    # Ljava/lang/String;

    .prologue
    .line 664
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LcallMeta(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LcheckAny(I)V
    .locals 1
    .param p1, "nArg"    # I

    .prologue
    .line 719
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LcheckAny(Lcom/blm/sdk/connection/CPtr;I)V

    .line 720
    return-void
.end method

.method public LcheckInteger(I)I
    .locals 1
    .param p1, "numArg"    # I

    .prologue
    .line 699
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LcheckInteger(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public LcheckNumber(I)D
    .locals 2
    .param p1, "numArg"    # I

    .prologue
    .line 689
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LcheckNumber(Lcom/blm/sdk/connection/CPtr;I)D

    move-result-wide v0

    return-wide v0
.end method

.method public LcheckStack(ILjava/lang/String;)V
    .locals 1
    .param p1, "sz"    # I
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 709
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LcheckStack(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V

    .line 710
    return-void
.end method

.method public LcheckString(I)Ljava/lang/String;
    .locals 1
    .param p1, "numArg"    # I

    .prologue
    .line 679
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LcheckString(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public LcheckType(II)V
    .locals 1
    .param p1, "nArg"    # I
    .param p2, "t"    # I

    .prologue
    .line 714
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LcheckType(Lcom/blm/sdk/connection/CPtr;II)V

    .line 715
    return-void
.end method

.method public LdoFile(Ljava/lang/String;)I
    .locals 1
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    .line 648
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LdoFile(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LdoString(Ljava/lang/String;)I
    .locals 1
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    .line 654
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LdoString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LfindTable(ILjava/lang/String;I)Ljava/lang/String;
    .locals 1
    .param p1, "idx"    # I
    .param p2, "fname"    # Ljava/lang/String;
    .param p3, "szhint"    # I

    .prologue
    .line 779
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/blm/sdk/connection/BlmLib;->_LfindTable(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public LgetMetaField(ILjava/lang/String;)I
    .locals 1
    .param p1, "obj"    # I
    .param p2, "e"    # Ljava/lang/String;

    .prologue
    .line 659
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LgetMetaField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LgetMetatable(Ljava/lang/String;)V
    .locals 1
    .param p1, "tName"    # Ljava/lang/String;

    .prologue
    .line 729
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LgetMetatable(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V

    .line 730
    return-void
.end method

.method public LgetN(I)I
    .locals 1
    .param p1, "t"    # I

    .prologue
    .line 749
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LgetN(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public Lgsub(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "p"    # Ljava/lang/String;
    .param p3, "r"    # Ljava/lang/String;

    .prologue
    .line 774
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/blm/sdk/connection/BlmLib;->_Lgsub(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public LloadBuffer([BLjava/lang/String;)I
    .locals 7
    .param p1, "buff"    # [B
    .param p2, "name"    # Ljava/lang/String;

    .prologue
    .line 769
    iget-object v2, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    array-length v0, p1

    int-to-long v4, v0

    move-object v1, p0

    move-object v3, p1

    move-object v6, p2

    invoke-direct/range {v1 .. v6}, Lcom/blm/sdk/connection/BlmLib;->_LloadBuffer(Lcom/blm/sdk/connection/CPtr;[BJLjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LloadFile(Ljava/lang/String;)I
    .locals 1
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    .line 759
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LloadFile(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LloadString(Ljava/lang/String;)I
    .locals 1
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 764
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LloadString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LnewMetatable(Ljava/lang/String;)I
    .locals 1
    .param p1, "tName"    # Ljava/lang/String;

    .prologue
    .line 724
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_LnewMetatable(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LoptInteger(II)I
    .locals 1
    .param p1, "numArg"    # I
    .param p2, "def"    # I

    .prologue
    .line 704
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LoptInteger(Lcom/blm/sdk/connection/CPtr;II)I

    move-result v0

    return v0
.end method

.method public LoptNumber(ID)D
    .locals 2
    .param p1, "numArg"    # I
    .param p2, "def"    # D

    .prologue
    .line 694
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/blm/sdk/connection/BlmLib;->_LoptNumber(Lcom/blm/sdk/connection/CPtr;ID)D

    move-result-wide v0

    return-wide v0
.end method

.method public LoptString(ILjava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "numArg"    # I
    .param p2, "def"    # Ljava/lang/String;

    .prologue
    .line 684
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LoptString(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public Lref(I)I
    .locals 1
    .param p1, "t"    # I

    .prologue
    .line 739
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_Lref(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public LsetN(II)V
    .locals 1
    .param p1, "t"    # I
    .param p2, "n"    # I

    .prologue
    .line 754
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LsetN(Lcom/blm/sdk/connection/CPtr;II)V

    .line 755
    return-void
.end method

.method public Ltyperror(ILjava/lang/String;)I
    .locals 1
    .param p1, "nArg"    # I
    .param p2, "tName"    # Ljava/lang/String;

    .prologue
    .line 669
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_Ltyperror(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public LunRef(II)V
    .locals 1
    .param p1, "t"    # I
    .param p2, "ref"    # I

    .prologue
    .line 744
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_LunRef(Lcom/blm/sdk/connection/CPtr;II)V

    .line 745
    return-void
.end method

.method public Lwhere(I)V
    .locals 1
    .param p1, "lvl"    # I

    .prologue
    .line 734
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_Lwhere(Lcom/blm/sdk/connection/CPtr;I)V

    .line 735
    return-void
.end method

.method public call(II)V
    .locals 1
    .param p1, "nArgs"    # I
    .param p2, "nResults"    # I

    .prologue
    .line 594
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_call(Lcom/blm/sdk/connection/CPtr;II)V

    .line 595
    return-void
.end method

.method public checkStack(I)I
    .locals 1
    .param p1, "sz"    # I

    .prologue
    .line 352
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_checkStack(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public declared-synchronized close()V
    .locals 1

    .prologue
    .line 130
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/blm/sdk/connection/BlmLib;->stateId:I

    invoke-static {v0}, Lcom/blm/sdk/connection/BlmStateFactory;->removeBlmState(I)V

    .line 131
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_close(Lcom/blm/sdk/connection/CPtr;)V

    .line 132
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 133
    monitor-exit p0

    return-void

    .line 130
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public concat(I)V
    .locals 1
    .param p1, "n"    # I

    .prologue
    .line 640
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_concat(Lcom/blm/sdk/connection/CPtr;I)V

    .line 641
    return-void
.end method

.method public createTable(II)V
    .locals 1
    .param p1, "narr"    # I
    .param p2, "nrec"    # I

    .prologue
    .line 539
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_createTable(Lcom/blm/sdk/connection/CPtr;II)V

    .line 540
    return-void
.end method

.method public dumpStack()Ljava/lang/String;
    .locals 6

    .prologue
    .line 1180
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v1

    .line 1181
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 1182
    const/4 v0, 0x1

    :goto_0
    if-gt v0, v1, :cond_2

    .line 1183
    invoke-virtual {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v3

    .line 1184
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ": "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0, v3}, Lcom/blm/sdk/connection/BlmLib;->typeName(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1186
    const/4 v4, 0x3

    if-ne v3, v4, :cond_1

    .line 1187
    const-string v3, " = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->toNumber(I)D

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    .line 1191
    :cond_0
    :goto_1
    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1182
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1189
    :cond_1
    const/4 v4, 0x4

    if-ne v3, v4, :cond_0

    .line 1190
    const-string v3, " = \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 1193
    :cond_2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public equal(II)I
    .locals 1
    .param p1, "idx1"    # I
    .param p2, "idx2"    # I

    .prologue
    .line 429
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_equal(Lcom/blm/sdk/connection/CPtr;II)I

    move-result v0

    return v0
.end method

.method public error()I
    .locals 1

    .prologue
    .line 635
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_error(Lcom/blm/sdk/connection/CPtr;)I

    move-result v0

    return v0
.end method

.method public gc(II)I
    .locals 1
    .param p1, "what"    # I
    .param p2, "data"    # I

    .prologue
    .line 620
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_gc(Lcom/blm/sdk/connection/CPtr;II)I

    move-result v0

    return v0
.end method

.method public getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 1104
    new-instance v0, Lcom/blm/sdk/connection/BlmObject;

    invoke-direct {v0, p0, p1}, Lcom/blm/sdk/connection/BlmObject;-><init>(Lcom/blm/sdk/connection/BlmLib;I)V

    return-object v0
.end method

.method public getBlmObject(Lcom/blm/sdk/connection/BlmObject;Lcom/blm/sdk/connection/BlmObject;)Lcom/blm/sdk/connection/BlmObject;
    .locals 4
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Lcom/blm/sdk/connection/BlmObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 1089
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v0

    iget-object v2, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-virtual {v2}, Lcom/blm/sdk/connection/CPtr;->getPeer()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    .line 1090
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v0

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v0

    invoke-virtual {p2}, Lcom/blm/sdk/connection/BlmObject;->getBlmState()Lcom/blm/sdk/connection/BlmLib;

    move-result-object v2

    invoke-virtual {v2}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    .line 1091
    :cond_0
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Object must have the same BlmState as the parent!"

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1093
    :cond_1
    new-instance v0, Lcom/blm/sdk/connection/BlmObject;

    invoke-direct {v0, p1, p2}, Lcom/blm/sdk/connection/BlmObject;-><init>(Lcom/blm/sdk/connection/BlmObject;Lcom/blm/sdk/connection/BlmObject;)V

    return-object v0
.end method

.method public getBlmObject(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/Number;)Lcom/blm/sdk/connection/BlmObject;
    .locals 4
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Ljava/lang/Number;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 1073
    iget-object v0, p1, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v0

    iget-object v2, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-virtual {v2}, Lcom/blm/sdk/connection/CPtr;->getPeer()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 1074
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Object must have the same BlmState as the parent!"

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1076
    :cond_0
    new-instance v0, Lcom/blm/sdk/connection/BlmObject;

    invoke-direct {v0, p1, p2}, Lcom/blm/sdk/connection/BlmObject;-><init>(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/Number;)V

    return-object v0
.end method

.method public getBlmObject(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/String;)Lcom/blm/sdk/connection/BlmObject;
    .locals 4
    .param p1, "parent"    # Lcom/blm/sdk/connection/BlmObject;
    .param p2, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 1057
    iget-object v0, p1, Lcom/blm/sdk/connection/BlmObject;->L:Lcom/blm/sdk/connection/BlmLib;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/BlmLib;->getCPtrPeer()J

    move-result-wide v0

    iget-object v2, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-virtual {v2}, Lcom/blm/sdk/connection/CPtr;->getPeer()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 1058
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Object must have the same BlmState as the parent!"

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1060
    :cond_0
    new-instance v0, Lcom/blm/sdk/connection/BlmObject;

    invoke-direct {v0, p1, p2}, Lcom/blm/sdk/connection/BlmObject;-><init>(Lcom/blm/sdk/connection/BlmObject;Ljava/lang/String;)V

    return-object v0
.end method

.method public getBlmObject(Ljava/lang/String;)Lcom/blm/sdk/connection/BlmObject;
    .locals 1
    .param p1, "globalName"    # Ljava/lang/String;

    .prologue
    .line 1044
    new-instance v0, Lcom/blm/sdk/connection/BlmObject;

    invoke-direct {v0, p0, p1}, Lcom/blm/sdk/connection/BlmObject;-><init>(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/String;)V

    return-object v0
.end method

.method public getCPtrPeer()J
    .locals 2

    .prologue
    .line 149
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-virtual {v0}, Lcom/blm/sdk/connection/CPtr;->getPeer()J

    move-result-wide v0

    :goto_0
    return-wide v0

    :cond_0
    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method public getFEnv(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 555
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_getFEnv(Lcom/blm/sdk/connection/CPtr;I)V

    .line 556
    return-void
.end method

.method public getField(ILjava/lang/String;)V
    .locals 1
    .param p1, "idx"    # I
    .param p2, "k"    # Ljava/lang/String;

    .prologue
    .line 524
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_getField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V

    .line 525
    return-void
.end method

.method public getGcCount()I
    .locals 1

    .prologue
    .line 625
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_getGcCount(Lcom/blm/sdk/connection/CPtr;)I

    move-result v0

    return v0
.end method

.method public declared-synchronized getGlobal(Ljava/lang/String;)V
    .locals 1
    .param p1, "global"    # Ljava/lang/String;

    .prologue
    .line 794
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_getGlobal(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 795
    monitor-exit p0

    return-void

    .line 794
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getMetaTable(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 550
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_getMetaTable(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public getObjectFromUserdata(I)Ljava/lang/Object;
    .locals 1
    .param p1, "idx"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 898
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_getObjectFromUserdata(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getTable(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 519
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_getTable(Lcom/blm/sdk/connection/CPtr;I)V

    .line 520
    return-void
.end method

.method public getTop()I
    .locals 1

    .prologue
    .line 322
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_getTop(Lcom/blm/sdk/connection/CPtr;)I

    move-result v0

    return v0
.end method

.method public insert(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 342
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_insert(Lcom/blm/sdk/connection/CPtr;I)V

    .line 343
    return-void
.end method

.method public isBoolean(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 394
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isBoolean(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isCFunction(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 379
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isCFunction(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public declared-synchronized isClosed()Z
    .locals 1

    .prologue
    .line 140
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public isFunction(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 374
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isFunction(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isJavaFunction(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 938
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isJavaFunction(Lcom/blm/sdk/connection/CPtr;I)Z

    move-result v0

    return v0
.end method

.method public isNil(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 399
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isNil(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isNone(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 409
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isNone(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isNoneOrNil(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 414
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isNoneOrNil(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isNumber(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 364
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isNumber(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isObject(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 908
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isObject(Lcom/blm/sdk/connection/CPtr;I)Z

    move-result v0

    return v0
.end method

.method public isString(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 369
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isString(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isTable(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 389
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isTable(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isThread(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 404
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isThread(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isUserdata(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 384
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_isUserdata(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public lessthan(II)I
    .locals 1
    .param p1, "idx1"    # I
    .param p2, "idx2"    # I

    .prologue
    .line 439
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_lessthan(Lcom/blm/sdk/connection/CPtr;II)I

    move-result v0

    return v0
.end method

.method public newTable()V
    .locals 1

    .prologue
    .line 544
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_newTable(Lcom/blm/sdk/connection/CPtr;)V

    .line 545
    return-void
.end method

.method public newThread()Lcom/blm/sdk/connection/BlmLib;
    .locals 2

    .prologue
    .line 313
    new-instance v0, Lcom/blm/sdk/connection/BlmLib;

    iget-object v1, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v1}, Lcom/blm/sdk/connection/BlmLib;->_newthread(Lcom/blm/sdk/connection/CPtr;)Lcom/blm/sdk/connection/CPtr;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmLib;-><init>(Lcom/blm/sdk/connection/CPtr;)V

    .line 314
    invoke-static {v0}, Lcom/blm/sdk/connection/BlmStateFactory;->insertBlmState(Lcom/blm/sdk/connection/BlmLib;)I

    .line 315
    return-object v0
.end method

.method public next(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 630
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_next(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public objLen(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 469
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_objlen(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public openBase()V
    .locals 1

    .prologue
    .line 808
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openBase(Lcom/blm/sdk/connection/CPtr;)V

    .line 809
    return-void
.end method

.method public openDebug()V
    .locals 1

    .prologue
    .line 832
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openDebug(Lcom/blm/sdk/connection/CPtr;)V

    .line 833
    return-void
.end method

.method public openIo()V
    .locals 1

    .prologue
    .line 816
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openIo(Lcom/blm/sdk/connection/CPtr;)V

    .line 817
    return-void
.end method

.method public openLibs()V
    .locals 1

    .prologue
    .line 840
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openLibs(Lcom/blm/sdk/connection/CPtr;)V

    .line 841
    return-void
.end method

.method public openMath()V
    .locals 1

    .prologue
    .line 828
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openMath(Lcom/blm/sdk/connection/CPtr;)V

    .line 829
    return-void
.end method

.method public openOs()V
    .locals 1

    .prologue
    .line 820
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openOs(Lcom/blm/sdk/connection/CPtr;)V

    .line 821
    return-void
.end method

.method public openPackage()V
    .locals 1

    .prologue
    .line 836
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openPackage(Lcom/blm/sdk/connection/CPtr;)V

    .line 837
    return-void
.end method

.method public openString()V
    .locals 1

    .prologue
    .line 824
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openString(Lcom/blm/sdk/connection/CPtr;)V

    .line 825
    return-void
.end method

.method public openTable()V
    .locals 1

    .prologue
    .line 812
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_openTable(Lcom/blm/sdk/connection/CPtr;)V

    .line 813
    return-void
.end method

.method public pcall(III)I
    .locals 1
    .param p1, "nArgs"    # I
    .param p2, "nResults"    # I
    .param p3, "errFunc"    # I

    .prologue
    .line 600
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/blm/sdk/connection/BlmLib;->_pcall(Lcom/blm/sdk/connection/CPtr;III)I

    move-result v0

    return v0
.end method

.method public pop(I)V
    .locals 1
    .param p1, "n"    # I

    .prologue
    .line 787
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pop(Lcom/blm/sdk/connection/CPtr;I)V

    .line 788
    return-void
.end method

.method public pushBoolean(Z)V
    .locals 2
    .param p1, "bool"    # Z

    .prologue
    .line 512
    iget-object v1, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-direct {p0, v1, v0}, Lcom/blm/sdk/connection/BlmLib;->_pushBoolean(Lcom/blm/sdk/connection/CPtr;I)V

    .line 513
    return-void

    .line 512
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public pushInteger(I)V
    .locals 1
    .param p1, "integer"    # I

    .prologue
    .line 491
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pushInteger(Lcom/blm/sdk/connection/CPtr;I)V

    .line 492
    return-void
.end method

.method public pushJavaFunction(Lcom/blm/sdk/connection/JavaFunction;)V
    .locals 1
    .param p1, "func"    # Lcom/blm/sdk/connection/JavaFunction;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 928
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pushJavaFunction(Lcom/blm/sdk/connection/CPtr;Lcom/blm/sdk/connection/JavaFunction;)V

    .line 929
    return-void
.end method

.method public pushJavaObject(Ljava/lang/Object;)V
    .locals 1
    .param p1, "obj"    # Ljava/lang/Object;

    .prologue
    .line 919
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pushJavaObject(Lcom/blm/sdk/connection/CPtr;Ljava/lang/Object;)V

    .line 920
    return-void
.end method

.method public pushNil()V
    .locals 1

    .prologue
    .line 481
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_pushNil(Lcom/blm/sdk/connection/CPtr;)V

    .line 482
    return-void
.end method

.method public pushNumber(D)V
    .locals 1
    .param p1, "db"    # D

    .prologue
    .line 486
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_pushNumber(Lcom/blm/sdk/connection/CPtr;D)V

    .line 487
    return-void
.end method

.method public pushObjectValue(Ljava/lang/Object;)V
    .locals 2
    .param p1, "obj"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 949
    if-nez p1, :cond_0

    .line 951
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmLib;->pushNil()V

    .line 984
    .end local p1    # "obj":Ljava/lang/Object;
    :goto_0
    return-void

    .line 953
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_0
    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_1

    .line 955
    check-cast p1, Ljava/lang/Boolean;

    .line 956
    .end local p1    # "obj":Ljava/lang/Object;
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->pushBoolean(Z)V

    goto :goto_0

    .line 958
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_1
    instance-of v0, p1, Ljava/lang/Number;

    if-eqz v0, :cond_2

    .line 960
    check-cast p1, Ljava/lang/Number;

    .end local p1    # "obj":Ljava/lang/Object;
    invoke-virtual {p1}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/blm/sdk/connection/BlmLib;->pushNumber(D)V

    goto :goto_0

    .line 962
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_2
    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 964
    check-cast p1, Ljava/lang/String;

    .end local p1    # "obj":Ljava/lang/Object;
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->pushString(Ljava/lang/String;)V

    goto :goto_0

    .line 966
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_3
    instance-of v0, p1, Lcom/blm/sdk/connection/JavaFunction;

    if-eqz v0, :cond_4

    .line 968
    check-cast p1, Lcom/blm/sdk/connection/JavaFunction;

    .line 969
    .end local p1    # "obj":Ljava/lang/Object;
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->pushJavaFunction(Lcom/blm/sdk/connection/JavaFunction;)V

    goto :goto_0

    .line 971
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_4
    instance-of v0, p1, Lcom/blm/sdk/connection/BlmObject;

    if-eqz v0, :cond_5

    .line 973
    check-cast p1, Lcom/blm/sdk/connection/BlmObject;

    .line 974
    .end local p1    # "obj":Ljava/lang/Object;
    invoke-virtual {p1}, Lcom/blm/sdk/connection/BlmObject;->push()V

    goto :goto_0

    .line 976
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_5
    instance-of v0, p1, [B

    if-eqz v0, :cond_6

    .line 978
    check-cast p1, [B

    .end local p1    # "obj":Ljava/lang/Object;
    check-cast p1, [B

    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->pushString([B)V

    goto :goto_0

    .line 982
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_6
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->pushJavaObject(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public pushString(Ljava/lang/String;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    .line 496
    if-nez p1, :cond_0

    .line 497
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_pushNil(Lcom/blm/sdk/connection/CPtr;)V

    .line 500
    :goto_0
    return-void

    .line 499
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pushString(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public pushString([B)V
    .locals 2
    .param p1, "bytes"    # [B

    .prologue
    .line 504
    if-nez p1, :cond_0

    .line 505
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_pushNil(Lcom/blm/sdk/connection/CPtr;)V

    .line 508
    :goto_0
    return-void

    .line 507
    :cond_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    array-length v1, p1

    invoke-direct {p0, v0, p1, v1}, Lcom/blm/sdk/connection/BlmLib;->_pushString(Lcom/blm/sdk/connection/CPtr;[BI)V

    goto :goto_0
.end method

.method public pushValue(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 332
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_pushValue(Lcom/blm/sdk/connection/CPtr;I)V

    .line 333
    return-void
.end method

.method public rawGet(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 529
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_rawGet(Lcom/blm/sdk/connection/CPtr;I)V

    .line 530
    return-void
.end method

.method public rawGetI(II)V
    .locals 1
    .param p1, "idx"    # I
    .param p2, "n"    # I

    .prologue
    .line 534
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_rawGetI(Lcom/blm/sdk/connection/CPtr;II)V

    .line 535
    return-void
.end method

.method public rawSet(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 572
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_rawSet(Lcom/blm/sdk/connection/CPtr;I)V

    .line 573
    return-void
.end method

.method public rawSetI(II)V
    .locals 1
    .param p1, "idx"    # I
    .param p2, "n"    # I

    .prologue
    .line 577
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_rawSetI(Lcom/blm/sdk/connection/CPtr;II)V

    .line 578
    return-void
.end method

.method public rawequal(II)I
    .locals 1
    .param p1, "idx1"    # I
    .param p2, "idx2"    # I

    .prologue
    .line 434
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_rawequal(Lcom/blm/sdk/connection/CPtr;II)I

    move-result v0

    return v0
.end method

.method public remove(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 337
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_remove(Lcom/blm/sdk/connection/CPtr;I)V

    .line 338
    return-void
.end method

.method public replace(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 347
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_replace(Lcom/blm/sdk/connection/CPtr;I)V

    .line 348
    return-void
.end method

.method public resume(I)I
    .locals 1
    .param p1, "nArgs"    # I

    .prologue
    .line 610
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_resume(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public setFEnv(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 589
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_setFEnv(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public setField(ILjava/lang/String;)V
    .locals 1
    .param p1, "idx"    # I
    .param p2, "k"    # Ljava/lang/String;

    .prologue
    .line 567
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1, p2}, Lcom/blm/sdk/connection/BlmLib;->_setField(Lcom/blm/sdk/connection/CPtr;ILjava/lang/String;)V

    .line 568
    return-void
.end method

.method public declared-synchronized setGlobal(Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 802
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_setGlobal(Lcom/blm/sdk/connection/CPtr;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 803
    monitor-exit p0

    return-void

    .line 802
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public setMetaTable(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 583
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_setMetaTable(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public setTable(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 562
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_setTable(Lcom/blm/sdk/connection/CPtr;I)V

    .line 563
    return-void
.end method

.method public setTop(I)V
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 327
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_setTop(Lcom/blm/sdk/connection/CPtr;I)V

    .line 328
    return-void
.end method

.method public status()I
    .locals 1

    .prologue
    .line 615
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0}, Lcom/blm/sdk/connection/BlmLib;->_status(Lcom/blm/sdk/connection/CPtr;)I

    move-result v0

    return v0
.end method

.method public strLen(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 464
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_strlen(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public toBoolean(I)Z
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 454
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_toBoolean(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public toInteger(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 449
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_toInteger(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public declared-synchronized toJavaObject(I)Ljava/lang/Object;
    .locals 4
    .param p1, "idx"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 994
    monitor-enter p0

    .line 996
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isBoolean(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 998
    new-instance v0, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->toBoolean(I)Z

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Boolean;-><init>(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1034
    :cond_0
    :goto_0
    monitor-exit p0

    return-object v0

    .line 1001
    :cond_1
    :try_start_1
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v1

    const/4 v2, 0x4

    if-ne v1, v2, :cond_2

    .line 1003
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1005
    :cond_2
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isFunction(I)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1007
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    goto :goto_0

    .line 1009
    :cond_3
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isTable(I)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1011
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    goto :goto_0

    .line 1014
    :cond_4
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_5

    .line 1016
    new-instance v0, Ljava/lang/Double;

    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->toNumber(I)D

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/lang/Double;-><init>(D)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 994
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1018
    :cond_5
    :try_start_2
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isUserdata(I)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 1020
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isObject(I)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1022
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->getObjectFromUserdata(I)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 1026
    :cond_6
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    goto :goto_0

    .line 1029
    :cond_7
    invoke-virtual {p0, p1}, Lcom/blm/sdk/connection/BlmLib;->isNil(I)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0
.end method

.method public toNumber(I)D
    .locals 2
    .param p1, "idx"    # I

    .prologue
    .line 444
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_toNumber(Lcom/blm/sdk/connection/CPtr;I)D

    move-result-wide v0

    return-wide v0
.end method

.method public toString(I)Ljava/lang/String;
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 459
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_toString(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public toThread(I)Lcom/blm/sdk/connection/BlmLib;
    .locals 2
    .param p1, "idx"    # I

    .prologue
    .line 474
    new-instance v0, Lcom/blm/sdk/connection/BlmLib;

    iget-object v1, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v1, p1}, Lcom/blm/sdk/connection/BlmLib;->_toThread(Lcom/blm/sdk/connection/CPtr;I)Lcom/blm/sdk/connection/CPtr;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmLib;-><init>(Lcom/blm/sdk/connection/CPtr;)V

    return-object v0
.end method

.method public type(I)I
    .locals 1
    .param p1, "idx"    # I

    .prologue
    .line 419
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_type(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method

.method public typeName(I)Ljava/lang/String;
    .locals 1
    .param p1, "tp"    # I

    .prologue
    .line 424
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_typeName(Lcom/blm/sdk/connection/CPtr;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public xmove(Lcom/blm/sdk/connection/BlmLib;I)V
    .locals 2
    .param p1, "to"    # Lcom/blm/sdk/connection/BlmLib;
    .param p2, "n"    # I

    .prologue
    .line 357
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    iget-object v1, p1, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, v1, p2}, Lcom/blm/sdk/connection/BlmLib;->_xmove(Lcom/blm/sdk/connection/CPtr;Lcom/blm/sdk/connection/CPtr;I)V

    .line 358
    return-void
.end method

.method public yield(I)I
    .locals 1
    .param p1, "nResults"    # I

    .prologue
    .line 605
    iget-object v0, p0, Lcom/blm/sdk/connection/BlmLib;->m_blmState:Lcom/blm/sdk/connection/CPtr;

    invoke-direct {p0, v0, p1}, Lcom/blm/sdk/connection/BlmLib;->_yield(Lcom/blm/sdk/connection/CPtr;I)I

    move-result v0

    return v0
.end method
