.class public final Lcom/payeco/android/plugin/d/t;
.super Landroid/widget/PopupWindow;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ViewConstructor"
    }
.end annotation


# static fields
.field private static a:Lcom/payeco/android/plugin/d/t;


# instance fields
.field private b:Landroid/content/Context;

.field private c:Landroid/view/View;

.field private d:I

.field private e:I

.field private f:Z

.field private g:I

.field private h:Lcom/payeco/android/plugin/d/z;


# direct methods
.method private constructor <init>(Landroid/view/View;Landroid/content/Context;III)V
    .locals 2

    const/4 v1, -0x1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v1, v1, v0}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    iput v0, p0, Lcom/payeco/android/plugin/d/t;->d:I

    iput v0, p0, Lcom/payeco/android/plugin/d/t;->e:I

    iput-object p2, p0, Lcom/payeco/android/plugin/d/t;->b:Landroid/content/Context;

    iput-object p1, p0, Lcom/payeco/android/plugin/d/t;->c:Landroid/view/View;

    iput p4, p0, Lcom/payeco/android/plugin/d/t;->d:I

    iput p3, p0, Lcom/payeco/android/plugin/d/t;->e:I

    iput p5, p0, Lcom/payeco/android/plugin/d/t;->g:I

    invoke-direct {p0}, Lcom/payeco/android/plugin/d/t;->a()V

    return-void
.end method

.method private a(Ljava/lang/String;)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/t;->c:Landroid/view/View;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/t;->b:Landroid/content/Context;

    invoke-static {v0, v1, p1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public static a(Landroid/content/Context;Landroid/view/View;IIILcom/payeco/android/plugin/d/z;)Lcom/payeco/android/plugin/d/t;
    .locals 7

    const/4 v6, 0x0

    const/4 v0, 0x1

    if-ne p4, v0, :cond_1

    const-string v0, "payeco_plugin_keyboard"

    invoke-static {p0, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    :goto_0
    sget-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    if-nez v0, :cond_0

    new-instance v0, Lcom/payeco/android/plugin/d/t;

    move-object v2, p0

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/payeco/android/plugin/d/t;-><init>(Landroid/view/View;Landroid/content/Context;III)V

    sput-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/BitmapDrawable;-><init>()V

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/d/t;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/t;->update()V

    sget-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    const/16 v1, 0x50

    invoke-virtual {v0, p1, v1, v6, v6}, Lcom/payeco/android/plugin/d/t;->showAtLocation(Landroid/view/View;III)V

    sget-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    iput-object p5, v0, Lcom/payeco/android/plugin/d/t;->h:Lcom/payeco/android/plugin/d/z;

    :cond_0
    sget-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    return-object v0

    :cond_1
    const-string v0, "payeco_plugin_keyboard_land"

    invoke-static {p0, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    goto :goto_0
.end method

.method private a()V
    .locals 9

    const/4 v1, 0x0

    const/16 v8, 0xa

    const-string v0, "payeco_digitBodyLayout"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const-string v0, "payeco_keyboard_password"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    const/high16 v2, -0x1000000

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setTextColor(I)V

    new-instance v2, Lcom/payeco/android/plugin/d/u;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/u;-><init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-array v3, v8, [I

    new-array v4, v8, [I

    move v2, v1

    :goto_0
    if-lt v2, v8, :cond_0

    new-instance v5, Ljava/util/Random;

    invoke-direct {v5}, Ljava/util/Random;-><init>()V

    move v2, v1

    :goto_1
    if-lt v2, v8, :cond_1

    move v2, v1

    :goto_2
    if-lt v2, v8, :cond_2

    const-string v1, "payeco_digit_clear"

    invoke-direct {p0, v1}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    new-instance v2, Lcom/payeco/android/plugin/d/w;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/w;-><init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v1, "payeco_keyborad_cancel"

    invoke-direct {p0, v1}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    new-instance v2, Lcom/payeco/android/plugin/d/x;

    invoke-direct {v2, p0}, Lcom/payeco/android/plugin/d/x;-><init>(Lcom/payeco/android/plugin/d/t;)V

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v1, "payeco_confirm_keyboard"

    invoke-direct {p0, v1}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    new-instance v2, Lcom/payeco/android/plugin/d/y;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/y;-><init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_0
    aput v2, v4, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    rsub-int/lit8 v6, v2, 0xa

    invoke-virtual {v5, v6}, Ljava/util/Random;->nextInt(I)I

    move-result v6

    aget v7, v4, v6

    aput v7, v3, v2

    rsub-int/lit8 v7, v2, 0x9

    aget v7, v4, v7

    aput v7, v4, v6

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v4, "payeco_digit_"

    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/payeco/android/plugin/d/t;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    aget v4, v3, v2

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    new-instance v4, Lcom/payeco/android/plugin/d/v;

    invoke-direct {v4, p0, v0}, Lcom/payeco/android/plugin/d/v;-><init>(Lcom/payeco/android/plugin/d/t;Landroid/widget/EditText;)V

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_2
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/t;Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/payeco/android/plugin/d/t;->f:Z

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/t;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/t;->f:Z

    return v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/t;)Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/t;->b:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic c(Lcom/payeco/android/plugin/d/t;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/t;->d:I

    return v0
.end method

.method static synthetic d(Lcom/payeco/android/plugin/d/t;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/t;->e:I

    return v0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/d/t;)Lcom/payeco/android/plugin/d/z;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/t;->h:Lcom/payeco/android/plugin/d/z;

    return-object v0
.end method


# virtual methods
.method public final dismiss()V
    .locals 1

    invoke-super {p0}, Landroid/widget/PopupWindow;->dismiss()V

    const/4 v0, 0x0

    sput-object v0, Lcom/payeco/android/plugin/d/t;->a:Lcom/payeco/android/plugin/d/t;

    return-void
.end method
