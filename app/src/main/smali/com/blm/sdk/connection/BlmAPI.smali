.class public final Lcom/blm/sdk/connection/BlmAPI;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    return-void
.end method

.method public static checkField(ILjava/lang/Object;Ljava/lang/String;)I
    .locals 4
    .param p0, "luaState"    # I
    .param p1, "obj"    # Ljava/lang/Object;
    .param p2, "fieldName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 365
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v3

    .line 367
    monitor-enter v3

    .line 372
    :try_start_0
    instance-of v1, p1, Ljava/lang/Class;

    if-eqz v1, :cond_0

    .line 374
    move-object v0, p1

    check-cast v0, Ljava/lang/Class;

    move-object v1, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 383
    :goto_0
    :try_start_1
    invoke-virtual {v1, p2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 390
    if-nez v1, :cond_1

    .line 392
    :try_start_2
    monitor-exit v3

    move v1, v2

    .line 412
    :goto_1
    return v1

    .line 378
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    goto :goto_0

    .line 385
    :catch_0
    move-exception v1

    .line 387
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move v1, v2

    goto :goto_1

    .line 398
    :cond_1
    :try_start_3
    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v1

    .line 405
    if-nez p1, :cond_2

    .line 407
    :try_start_4
    monitor-exit v3

    move v1, v2

    goto :goto_1

    .line 400
    :catch_1
    move-exception v1

    .line 402
    monitor-exit v3

    move v1, v2

    goto :goto_1

    .line 410
    :cond_2
    invoke-virtual {v3, v1}, Lcom/blm/sdk/connection/BlmLib;->pushObjectValue(Ljava/lang/Object;)V

    .line 412
    const/4 v1, 0x1

    monitor-exit v3

    goto :goto_1

    .line 413
    :catchall_0
    move-exception v1

    monitor-exit v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v1
.end method

.method public static checkMethod(ILjava/lang/Object;Ljava/lang/String;)I
    .locals 5
    .param p0, "luaState"    # I
    .param p1, "obj"    # Ljava/lang/Object;
    .param p2, "methodName"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 426
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v2

    .line 428
    monitor-enter v2

    .line 432
    :try_start_0
    instance-of v1, p1, Ljava/lang/Class;

    if-eqz v1, :cond_0

    .line 434
    check-cast p1, Ljava/lang/Class;

    .line 441
    .end local p1    # "obj":Ljava/lang/Object;
    :goto_0
    invoke-virtual {p1}, Ljava/lang/Class;->getMethods()[Ljava/lang/reflect/Method;

    move-result-object v3

    move v1, v0

    .line 443
    :goto_1
    array-length v4, v3

    if-ge v1, v4, :cond_2

    .line 445
    aget-object v4, v3, v1

    invoke-virtual {v4}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 446
    const/4 v0, 0x1

    monitor-exit v2

    .line 449
    :goto_2
    return v0

    .line 438
    .restart local p1    # "obj":Ljava/lang/Object;
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    goto :goto_0

    .line 443
    .end local p1    # "obj":Ljava/lang/Object;
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 449
    :cond_2
    monitor-exit v2

    goto :goto_2

    .line 450
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static classIndex(ILjava/lang/Class;Ljava/lang/String;)I
    .locals 2
    .param p0, "luaState"    # I
    .param p1, "clazz"    # Ljava/lang/Class;
    .param p2, "searchName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 166
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    monitor-enter v1

    .line 170
    :try_start_0
    invoke-static {p0, p1, p2}, Lcom/blm/sdk/connection/BlmAPI;->checkField(ILjava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 172
    if-eqz v0, :cond_0

    .line 174
    const/4 v0, 0x1

    monitor-exit v1

    .line 184
    :goto_0
    return v0

    .line 177
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/blm/sdk/connection/BlmAPI;->checkMethod(ILjava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 179
    if-eqz v0, :cond_1

    .line 181
    const/4 v0, 0x2

    monitor-exit v1

    goto :goto_0

    .line 185
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 184
    :cond_1
    const/4 v0, 0x0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method private static compareTypes(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;I)Ljava/lang/Object;
    .locals 6
    .param p0, "L"    # Lcom/blm/sdk/connection/BlmLib;
    .param p1, "parameter"    # Ljava/lang/Class;
    .param p2, "idx"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    .line 491
    const/4 v1, 0x1

    .line 494
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isBoolean(I)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 496
    invoke-virtual {p1}, Ljava/lang/Class;->isPrimitive()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 498
    sget-object v2, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-eq p1, v2, :cond_3

    .line 507
    :cond_0
    :goto_0
    new-instance v2, Ljava/lang/Boolean;

    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->toBoolean(I)Z

    move-result v1

    invoke-direct {v2, v1}, Ljava/lang/Boolean;-><init>(Z)V

    .line 589
    :cond_1
    :goto_1
    if-nez v0, :cond_d

    .line 591
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Invalid Parameter."

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 503
    :cond_2
    const-class v2, Ljava/lang/Boolean;

    invoke-virtual {p1, v2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_3
    move v0, v1

    goto :goto_0

    .line 510
    :cond_4
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v3

    const/4 v4, 0x4

    if-ne v3, v4, :cond_5

    .line 512
    const-class v3, Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 518
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->toString(I)Ljava/lang/String;

    move-result-object v2

    move v0, v1

    goto :goto_1

    .line 521
    :cond_5
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isFunction(I)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 523
    const-class v3, Lcom/blm/sdk/connection/BlmObject;

    invoke-virtual {p1, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 529
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v2

    move v0, v1

    goto :goto_1

    .line 532
    :cond_6
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isTable(I)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 534
    const-class v3, Lcom/blm/sdk/connection/BlmObject;

    invoke-virtual {p1, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 540
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v2

    move v0, v1

    goto :goto_1

    .line 544
    :cond_7
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->type(I)I

    move-result v3

    const/4 v4, 0x3

    if-ne v3, v4, :cond_8

    .line 546
    new-instance v2, Ljava/lang/Double;

    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->toNumber(I)D

    move-result-wide v4

    invoke-direct {v2, v4, v5}, Ljava/lang/Double;-><init>(D)V

    .line 548
    invoke-static {v2, p1}, Lcom/blm/sdk/connection/BlmLib;->convertBlmNumber(Ljava/lang/Double;Ljava/lang/Class;)Ljava/lang/Number;

    move-result-object v2

    .line 549
    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_1

    .line 554
    :cond_8
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isUserdata(I)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 556
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isObject(I)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 558
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->getObjectFromUserdata(I)Ljava/lang/Object;

    move-result-object v3

    .line 559
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {p1, v4}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v4

    if-nez v4, :cond_9

    move v1, v0

    move-object v0, v2

    :goto_2
    move-object v2, v0

    move v0, v1

    .line 567
    goto/16 :goto_1

    :cond_9
    move-object v0, v3

    .line 565
    goto :goto_2

    .line 570
    :cond_a
    const-class v3, Lcom/blm/sdk/connection/BlmObject;

    invoke-virtual {p1, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 576
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v2

    move v0, v1

    goto/16 :goto_1

    .line 580
    :cond_b
    invoke-virtual {p0, p2}, Lcom/blm/sdk/connection/BlmLib;->isNil(I)Z

    move-result v0

    if-eqz v0, :cond_c

    move v0, v1

    .line 582
    goto/16 :goto_1

    .line 586
    :cond_c
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Invalid Parameters."

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 594
    :cond_d
    return-object v2
.end method

.method public static createProxyObject(ILjava/lang/String;)I
    .locals 3
    .param p0, "luaState"    # I
    .param p1, "implem"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 464
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    .line 466
    monitor-enter v1

    .line 470
    const/4 v0, 0x2

    :try_start_0
    invoke-virtual {v1, v0}, Lcom/blm/sdk/connection/BlmLib;->isTable(I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 471
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Parameter is not a table. Can\'t create proxy."

    invoke-direct {v0, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 479
    :catch_0
    move-exception v0

    .line 481
    :try_start_1
    new-instance v2, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v2, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/Exception;)V

    throw v2

    .line 485
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 474
    :cond_0
    const/4 v0, 0x2

    :try_start_2
    invoke-virtual {v1, v0}, Lcom/blm/sdk/connection/BlmLib;->getBlmObject(I)Lcom/blm/sdk/connection/BlmObject;

    move-result-object v0

    .line 476
    invoke-virtual {v0, p1}, Lcom/blm/sdk/connection/BlmObject;->createProxy(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 477
    invoke-virtual {v1, v0}, Lcom/blm/sdk/connection/BlmLib;->pushJavaObject(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 484
    const/4 v0, 0x1

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    return v0
.end method

.method private static getObjInstance(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 11
    .param p0, "L"    # Lcom/blm/sdk/connection/BlmLib;
    .param p1, "clazz"    # Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 290
    monitor-enter p0

    .line 292
    :try_start_0
    invoke-virtual {p0}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v5

    .line 294
    add-int/lit8 v0, v5, -0x1

    new-array v6, v0, [Ljava/lang/Object;

    .line 296
    invoke-virtual {p1}, Ljava/lang/Class;->getConstructors()[Ljava/lang/reflect/Constructor;

    move-result-object v7

    .line 297
    const/4 v0, 0x0

    move v4, v2

    .line 300
    :goto_0
    array-length v1, v7

    if-ge v4, v1, :cond_3

    .line 302
    aget-object v1, v7, v4

    invoke-virtual {v1}, Ljava/lang/reflect/Constructor;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v8

    .line 303
    array-length v1, v8

    add-int/lit8 v3, v5, -0x1

    if-eq v1, v3, :cond_1

    .line 300
    :cond_0
    add-int/lit8 v1, v4, 0x1

    move v4, v1

    goto :goto_0

    .line 306
    :cond_1
    const/4 v1, 0x1

    move v3, v2

    .line 308
    :goto_1
    array-length v9, v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ge v3, v9, :cond_2

    .line 312
    :try_start_1
    aget-object v9, v8, v3

    add-int/lit8 v10, v3, 0x2

    invoke-static {p0, v9, v10}, Lcom/blm/sdk/connection/BlmAPI;->compareTypes(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v9

    aput-object v9, v6, v3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 308
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 314
    :catch_0
    move-exception v1

    move v1, v2

    .line 321
    :cond_2
    if-eqz v1, :cond_0

    .line 323
    :try_start_2
    aget-object v0, v7, v4

    .line 330
    :cond_3
    if-nez v0, :cond_4

    .line 332
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Invalid method call. No such method."

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 351
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 338
    :cond_4
    :try_start_3
    invoke-virtual {v0, v6}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    .line 345
    if-nez v0, :cond_5

    .line 347
    :try_start_4
    new-instance v0, Lcom/blm/sdk/connection/BlmException;

    const-string v1, "Couldn\'t instantiate java Object"

    invoke-direct {v0, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 340
    :catch_1
    move-exception v0

    .line 342
    new-instance v1, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v1, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/Exception;)V

    throw v1

    .line 350
    :cond_5
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    return-object v0
.end method

.method public static javaLoadLib(ILjava/lang/String;Ljava/lang/String;)I
    .locals 6
    .param p0, "luaState"    # I
    .param p1, "className"    # Ljava/lang/String;
    .param p2, "methodName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 254
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v2

    .line 256
    monitor-enter v2

    .line 261
    :try_start_0
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 270
    const/4 v3, 0x1

    :try_start_1
    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Lcom/blm/sdk/connection/BlmLib;

    aput-object v5, v3, v4

    invoke-virtual {v0, p2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 271
    const/4 v3, 0x0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v2, v4, v5

    invoke-virtual {v0, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 273
    if-eqz v0, :cond_0

    instance-of v3, v0, Ljava/lang/Integer;

    if-eqz v3, :cond_0

    .line 275
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    :try_start_2
    monitor-exit v2

    .line 278
    :goto_0
    return v0

    .line 263
    :catch_0
    move-exception v0

    .line 265
    new-instance v1, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v1, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/Exception;)V

    throw v1

    .line 284
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 278
    :cond_0
    :try_start_3
    monitor-exit v2

    move v0, v1

    goto :goto_0

    .line 280
    :catch_1
    move-exception v0

    .line 282
    new-instance v1, Lcom/blm/sdk/connection/BlmException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error on calling method. Library could not be loaded. "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method public static javaNew(ILjava/lang/Class;)I
    .locals 2
    .param p0, "luaState"    # I
    .param p1, "clazz"    # Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 230
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    .line 232
    monitor-enter v1

    .line 234
    :try_start_0
    invoke-static {v1, p1}, Lcom/blm/sdk/connection/BlmAPI;->getObjInstance(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 236
    invoke-virtual {v1, v0}, Lcom/blm/sdk/connection/BlmLib;->pushJavaObject(Ljava/lang/Object;)V

    .line 238
    const/4 v0, 0x1

    monitor-exit v1

    return v0

    .line 239
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static javaNewInstance(ILjava/lang/String;)I
    .locals 3
    .param p0, "luaState"    # I
    .param p1, "className"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    .line 199
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v1

    .line 201
    monitor-enter v1

    .line 206
    :try_start_0
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 212
    :try_start_1
    invoke-static {v1, v0}, Lcom/blm/sdk/connection/BlmAPI;->getObjInstance(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 214
    invoke-virtual {v1, v0}, Lcom/blm/sdk/connection/BlmLib;->pushJavaObject(Ljava/lang/Object;)V

    .line 216
    const/4 v0, 0x1

    monitor-exit v1

    return v0

    .line 208
    :catch_0
    move-exception v0

    .line 210
    new-instance v2, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v2, v0}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/Exception;)V

    throw v2

    .line 217
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public static objectIndex(ILjava/lang/Object;Ljava/lang/String;)I
    .locals 13
    .param p0, "luaState"    # I
    .param p1, "obj"    # Ljava/lang/Object;
    .param p2, "methodName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/blm/sdk/connection/BlmException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 55
    invoke-static {p0}, Lcom/blm/sdk/connection/BlmStateFactory;->getExistingState(I)Lcom/blm/sdk/connection/BlmLib;

    move-result-object v6

    .line 57
    monitor-enter v6

    .line 59
    :try_start_0
    invoke-virtual {v6}, Lcom/blm/sdk/connection/BlmLib;->getTop()I

    move-result v7

    .line 61
    add-int/lit8 v1, v7, -0x1

    new-array v8, v1, [Ljava/lang/Object;

    .line 65
    instance-of v1, p1, Ljava/lang/Class;

    if-eqz v1, :cond_1

    .line 67
    move-object v0, p1

    check-cast v0, Ljava/lang/Class;

    move-object v1, v0

    .line 74
    :goto_0
    invoke-virtual {v1}, Ljava/lang/Class;->getMethods()[Ljava/lang/reflect/Method;

    move-result-object v9

    move v5, v2

    .line 78
    :goto_1
    array-length v1, v9

    if-ge v5, v1, :cond_8

    .line 80
    aget-object v1, v9, v5

    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 78
    :cond_0
    add-int/lit8 v1, v5, 0x1

    move v5, v1

    goto :goto_1

    .line 71
    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    goto :goto_0

    .line 84
    :cond_2
    aget-object v1, v9, v5

    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v10

    .line 85
    array-length v1, v10

    add-int/lit8 v11, v7, -0x1

    if-ne v1, v11, :cond_0

    move v1, v2

    .line 90
    :goto_2
    array-length v11, v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ge v1, v11, :cond_7

    .line 94
    :try_start_1
    aget-object v11, v10, v1

    add-int/lit8 v12, v1, 0x2

    invoke-static {v6, v11, v12}, Lcom/blm/sdk/connection/BlmAPI;->compareTypes(Lcom/blm/sdk/connection/BlmLib;Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v11

    aput-object v11, v8, v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 90
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 96
    :catch_0
    move-exception v1

    move v1, v2

    .line 103
    :goto_3
    if-eqz v1, :cond_0

    .line 105
    :try_start_2
    aget-object v1, v9, v5

    .line 112
    :goto_4
    if-nez v1, :cond_3

    .line 114
    new-instance v1, Lcom/blm/sdk/connection/BlmException;

    const-string v2, "Invalid method call. No such method."

    invoke-direct {v1, v2}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 149
    :catchall_0
    move-exception v1

    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    .line 120
    :cond_3
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v4

    invoke-static {v4}, Ljava/lang/reflect/Modifier;->isPublic(I)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 122
    const/4 v4, 0x1

    invoke-virtual {v1, v4}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 125
    :cond_4
    instance-of v4, p1, Ljava/lang/Class;

    if-eqz v4, :cond_5

    .line 127
    const/4 v4, 0x0

    invoke-virtual {v1, v4, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v1

    .line 140
    :goto_5
    if-nez v1, :cond_6

    .line 142
    :try_start_4
    monitor-exit v6
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move v1, v2

    .line 148
    :goto_6
    return v1

    .line 131
    :cond_5
    :try_start_5
    invoke-virtual {v1, p1, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v1

    goto :goto_5

    .line 134
    :catch_1
    move-exception v1

    .line 136
    :try_start_6
    new-instance v2, Lcom/blm/sdk/connection/BlmException;

    invoke-direct {v2, v1}, Lcom/blm/sdk/connection/BlmException;-><init>(Ljava/lang/Exception;)V

    throw v2

    .line 146
    :cond_6
    invoke-virtual {v6, v1}, Lcom/blm/sdk/connection/BlmLib;->pushObjectValue(Ljava/lang/Object;)V

    .line 148
    monitor-exit v6
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move v1, v3

    goto :goto_6

    :cond_7
    move v1, v3

    goto :goto_3

    :cond_8
    move-object v1, v4

    goto :goto_4
.end method
