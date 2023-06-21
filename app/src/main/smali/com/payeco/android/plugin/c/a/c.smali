.class public final Lcom/payeco/android/plugin/c/a/c;
.super Ljava/lang/Object;


# direct methods
.method public static a(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/b;
    .locals 14

    const/4 v3, 0x0

    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v8

    invoke-static {p0}, Lcom/payeco/android/plugin/c/e;->a(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    const-string v1, "utf-8"

    invoke-interface {v8, v0, v1}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    const/4 v4, 0x1

    const/4 v2, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v0

    move v7, v0

    move-object v0, v2

    move v2, v1

    move-object v1, v3

    move v3, v4

    :goto_0
    const/4 v4, 0x1

    if-ne v7, v4, :cond_0

    return-object v1

    :cond_0
    const/4 v4, 0x2

    if-ne v7, v4, :cond_8

    new-instance v2, Lcom/payeco/android/plugin/c/a/b;

    invoke-direct {v2}, Lcom/payeco/android/plugin/c/a/b;-><init>()V

    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v4

    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Lcom/payeco/android/plugin/c/a/b;->c(Ljava/lang/String;)V

    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeCount()I

    move-result v9

    const/4 v6, 0x0

    :goto_1
    if-lt v6, v9, :cond_3

    const/4 v6, 0x1

    if-ne v4, v6, :cond_4

    move-object v1, v2

    :goto_2
    const/4 v4, 0x1

    move-object v5, v2

    move-object v2, v0

    move v0, v4

    move v4, v3

    move-object v3, v1

    :goto_3
    const/4 v1, 0x4

    if-ne v7, v1, :cond_1

    if-eqz v0, :cond_1

    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Lcom/payeco/android/plugin/c/a/b;->d(Ljava/lang/String;)V

    :cond_1
    const/4 v1, 0x3

    if-ne v7, v1, :cond_2

    const/4 v0, 0x0

    :cond_2
    invoke-interface {v8}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    move v7, v1

    move-object v1, v3

    move v3, v4

    move v13, v0

    move-object v0, v2

    move v2, v13

    goto :goto_0

    :cond_3
    new-instance v10, Lcom/payeco/android/plugin/c/a/a;

    invoke-direct {v10}, Lcom/payeco/android/plugin/c/a/a;-><init>()V

    invoke-interface {v8, v6}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeName(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/payeco/android/plugin/c/a/a;->a(Ljava/lang/String;)V

    invoke-interface {v8, v6}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/payeco/android/plugin/c/a/a;->b(Ljava/lang/String;)V

    invoke-virtual {v2}, Lcom/payeco/android/plugin/c/a/b;->d()Ljava/util/List;

    move-result-object v11

    invoke-interface {v11, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2}, Lcom/payeco/android/plugin/c/a/b;->f()Ljava/util/Map;

    move-result-object v11

    invoke-virtual {v10}, Lcom/payeco/android/plugin/c/a/a;->a()Ljava/lang/String;

    move-result-object v12

    invoke-interface {v11, v12, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    :cond_4
    if-le v4, v3, :cond_5

    move-object v0, v5

    :cond_5
    if-ge v4, v3, :cond_6

    invoke-virtual {v0}, Lcom/payeco/android/plugin/c/a/b;->g()Lcom/payeco/android/plugin/c/a/b;

    move-result-object v5

    if-eqz v5, :cond_6

    invoke-virtual {v0}, Lcom/payeco/android/plugin/c/a/b;->g()Lcom/payeco/android/plugin/c/a/b;

    move-result-object v0

    :cond_6
    if-lt v4, v3, :cond_7

    invoke-virtual {v2, v0}, Lcom/payeco/android/plugin/c/a/b;->a(Lcom/payeco/android/plugin/c/a/b;)V

    invoke-virtual {v0}, Lcom/payeco/android/plugin/c/a/b;->c()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0}, Lcom/payeco/android/plugin/c/a/b;->e()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v2}, Lcom/payeco/android/plugin/c/a/b;->a()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v5, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    move v3, v4

    goto :goto_2

    :cond_8
    move v4, v3

    move-object v3, v1

    move-object v13, v0

    move v0, v2

    move-object v2, v13

    goto :goto_3
.end method

.method public static a(Lcom/payeco/android/plugin/c/a/b;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const/4 v3, 0x1

    const/4 v0, 0x0

    :goto_0
    const-string v1, "/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    const-string v1, "/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x0

    const-string v2, "/"

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/payeco/android/plugin/c/a/b;->a(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/b;

    move-result-object p0

    if-nez p0, :cond_2

    :cond_1
    :goto_1
    return-object v0

    :cond_2
    const-string v1, "/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_3
    const-string v1, "@"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/payeco/android/plugin/c/a/b;->b(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/a;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/payeco/android/plugin/c/a/a;->b()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_4
    const-string v1, "text()"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {p0}, Lcom/payeco/android/plugin/c/a/b;->b()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_5
    invoke-virtual {p0, p1}, Lcom/payeco/android/plugin/c/a/b;->a(Ljava/lang/String;)Lcom/payeco/android/plugin/c/a/b;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/payeco/android/plugin/c/a/b;->b()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method
