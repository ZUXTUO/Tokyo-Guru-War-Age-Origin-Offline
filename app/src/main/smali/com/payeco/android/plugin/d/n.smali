.class public final Lcom/payeco/android/plugin/d/n;
.super Landroid/widget/PopupWindow;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ViewConstructor"
    }
.end annotation


# static fields
.field private static c:Lcom/payeco/android/plugin/d/n;


# instance fields
.field private a:Landroid/content/Context;

.field private b:Landroid/view/View;

.field private d:Landroid/widget/EditText;

.field private e:Ljava/lang/String;

.field private f:I

.field private g:I

.field private h:Z

.field private i:Z

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/String;

.field private l:Z

.field private m:Lcom/payeco/android/plugin/d/s;


# direct methods
.method private constructor <init>(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;IILjava/lang/String;ZZ)V
    .locals 2

    const/4 v1, -0x1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v1, v1, v0}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    const-string v0, ""

    iput-object v0, p0, Lcom/payeco/android/plugin/d/n;->k:Ljava/lang/String;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    iput-object p1, p0, Lcom/payeco/android/plugin/d/n;->b:Landroid/view/View;

    iput p4, p0, Lcom/payeco/android/plugin/d/n;->f:I

    iput p5, p0, Lcom/payeco/android/plugin/d/n;->g:I

    iput-object p6, p0, Lcom/payeco/android/plugin/d/n;->j:Ljava/lang/String;

    iput-boolean p7, p0, Lcom/payeco/android/plugin/d/n;->i:Z

    iput-boolean p8, p0, Lcom/payeco/android/plugin/d/n;->h:Z

    iput-object p3, p0, Lcom/payeco/android/plugin/d/n;->e:Ljava/lang/String;

    invoke-direct {p0}, Lcom/payeco/android/plugin/d/n;->a()V

    return-void
.end method

.method private a(Ljava/lang/String;)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->b:Landroid/view/View;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    invoke-static {v0, v1, p1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public static a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;IILjava/lang/String;ZZILcom/payeco/android/plugin/d/s;)Lcom/payeco/android/plugin/d/n;
    .locals 10

    const/4 v1, 0x1

    move/from16 v0, p8

    if-ne v0, v1, :cond_1

    const-string v1, "payeco_plugin_hxkeyboard"

    invoke-static {p0, v1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    :goto_0
    sget-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    if-nez v1, :cond_0

    new-instance v1, Lcom/payeco/android/plugin/d/n;

    move-object v3, p0

    move-object v4, p2

    move v5, p3

    move v6, p4

    move-object v7, p5

    move/from16 v8, p6

    move/from16 v9, p7

    invoke-direct/range {v1 .. v9}, Lcom/payeco/android/plugin/d/n;-><init>(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;IILjava/lang/String;ZZ)V

    sput-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    new-instance v2, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v2}, Landroid/graphics/drawable/BitmapDrawable;-><init>()V

    invoke-virtual {v1, v2}, Lcom/payeco/android/plugin/d/n;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    invoke-virtual {v1}, Lcom/payeco/android/plugin/d/n;->update()V

    sget-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    const/16 v2, 0x50

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v1, p1, v2, v3, v4}, Lcom/payeco/android/plugin/d/n;->showAtLocation(Landroid/view/View;III)V

    sget-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    move-object/from16 v0, p9

    iput-object v0, v1, Lcom/payeco/android/plugin/d/n;->m:Lcom/payeco/android/plugin/d/s;

    :cond_0
    sget-object v1, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    return-object v1

    :cond_1
    const-string v1, "payeco_plugin_hxkeyboard_land"

    invoke-static {p0, v1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    goto :goto_0
.end method

.method private a()V
    .locals 5

    const/4 v2, 0x0

    const-string v0, "payeco_keyboard_password_hx"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    invoke-static {}, Landroid/text/method/ScrollingMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->j:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->j:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->j:Ljava/lang/String;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/n;->k:Ljava/lang/String;

    :cond_0
    new-instance v3, Lcom/payeco/android/plugin/d/o;

    invoke-direct {v3, p0}, Lcom/payeco/android/plugin/d/o;-><init>(Lcom/payeco/android/plugin/d/n;)V

    move v1, v2

    :goto_0
    const/16 v0, 0xa

    if-lt v1, v0, :cond_2

    const-string v0, "payeco_digit_x_hx"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    invoke-virtual {v0, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean v1, p0, Lcom/payeco/android/plugin/d/n;->i:Z

    if-eqz v1, :cond_1

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    const-string v2, "payeco_btnenable"

    const-string v3, "drawable"

    invoke-static {v1, v2, v3}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setBackgroundResource(I)V

    :cond_1
    const-string v0, "keyboard_back"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    new-instance v1, Lcom/payeco/android/plugin/d/p;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/p;-><init>(Lcom/payeco/android/plugin/d/n;)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "payeco_digit_ok_hx"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/q;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/q;-><init>(Lcom/payeco/android/plugin/d/n;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "keyboard_invisable"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    new-instance v1, Lcom/payeco/android/plugin/d/r;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/r;-><init>(Lcom/payeco/android/plugin/d/n;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v4, "payeco_digit_"

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "_hx"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/n;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    invoke-virtual {v0, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/n;->k:Ljava/lang/String;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/n;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/n;->l:Z

    return v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/n;)Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/n;Ljava/lang/String;)V
    .locals 4

    const/4 v3, 0x1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    invoke-static {v0, p1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    const-string v1, "payeco_keyboard_red_bg"

    const-string v2, "drawable"

    invoke-static {v0, v1, v2}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/n;->d:Landroid/widget/EditText;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setBackgroundResource(I)V

    :cond_0
    iput-boolean v3, p0, Lcom/payeco/android/plugin/d/n;->l:Z

    return-void
.end method

.method static synthetic c(Lcom/payeco/android/plugin/d/n;)Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->a:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic d(Lcom/payeco/android/plugin/d/n;)V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/payeco/android/plugin/d/n;->l:Z

    return-void
.end method

.method static synthetic e(Lcom/payeco/android/plugin/d/n;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/n;->h:Z

    return v0
.end method

.method static synthetic f(Lcom/payeco/android/plugin/d/n;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->k:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic g(Lcom/payeco/android/plugin/d/n;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/n;->g:I

    return v0
.end method

.method static synthetic h(Lcom/payeco/android/plugin/d/n;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/n;->f:I

    return v0
.end method

.method static synthetic i(Lcom/payeco/android/plugin/d/n;)Lcom/payeco/android/plugin/d/s;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/n;->m:Lcom/payeco/android/plugin/d/s;

    return-object v0
.end method


# virtual methods
.method public final dismiss()V
    .locals 1

    invoke-super {p0}, Landroid/widget/PopupWindow;->dismiss()V

    const/4 v0, 0x0

    sput-object v0, Lcom/payeco/android/plugin/d/n;->c:Lcom/payeco/android/plugin/d/n;

    return-void
.end method
