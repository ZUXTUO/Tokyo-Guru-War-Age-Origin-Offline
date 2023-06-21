.class public final Lcom/payeco/android/plugin/d/a;
.super Landroid/widget/PopupWindow;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ViewConstructor"
    }
.end annotation


# static fields
.field private static a:Lcom/payeco/android/plugin/d/a;


# instance fields
.field private b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

.field private c:Landroid/view/View;

.field private d:Lcom/payeco/android/plugin/d/l;

.field private e:Lcom/payeco/android/plugin/d/m;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/Button;

.field private h:Landroid/widget/LinearLayout;

.field private i:Landroid/widget/LinearLayout;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/LinearLayout;

.field private l:Ljava/util/List;

.field private m:Ljava/util/List;

.field private n:Ljava/util/List;

.field private o:Z

.field private p:I

.field private q:I

.field private r:I

.field private s:Ljava/util/Calendar;

.field private t:Ljava/lang/String;

.field private u:Ljava/lang/String;

.field private v:Landroid/view/View$OnClickListener;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/view/View;IIILcom/payeco/android/plugin/d/l;)V
    .locals 2

    const/4 v0, -0x1

    const/4 v1, 0x0

    invoke-direct {p0, p2, v0, v0, v1}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->l:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->m:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->n:Ljava/util/List;

    iput v1, p0, Lcom/payeco/android/plugin/d/a;->p:I

    iput v1, p0, Lcom/payeco/android/plugin/d/a;->q:I

    new-instance v0, Lcom/payeco/android/plugin/d/b;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/d/b;-><init>(Lcom/payeco/android/plugin/d/a;)V

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->v:Landroid/view/View$OnClickListener;

    iput-object p1, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    iput-object p2, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iput p5, p0, Lcom/payeco/android/plugin/d/a;->r:I

    iput p4, p0, Lcom/payeco/android/plugin/d/a;->p:I

    iput p3, p0, Lcom/payeco/android/plugin/d/a;->q:I

    iput-object p6, p0, Lcom/payeco/android/plugin/d/a;->d:Lcom/payeco/android/plugin/d/l;

    invoke-direct {p0}, Lcom/payeco/android/plugin/d/a;->a()V

    return-void
.end method

.method private a(Ljava/lang/String;)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-static {v0, v1, p1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/view/View;Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public static a(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/view/View;IIILcom/payeco/android/plugin/d/l;)Lcom/payeco/android/plugin/d/a;
    .locals 8

    const/4 v7, 0x0

    const/4 v0, 0x1

    if-ne p4, v0, :cond_1

    const-string v0, "payeco_plugin_credit_keyboard"

    invoke-static {p0, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    :goto_0
    sget-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    if-nez v0, :cond_0

    new-instance v0, Lcom/payeco/android/plugin/d/a;

    move-object v1, p0

    move v3, p2

    move v4, p3

    move v5, p4

    move-object v6, p5

    invoke-direct/range {v0 .. v6}, Lcom/payeco/android/plugin/d/a;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Landroid/view/View;IIILcom/payeco/android/plugin/d/l;)V

    sput-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/BitmapDrawable;-><init>()V

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/d/a;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    invoke-virtual {v0}, Lcom/payeco/android/plugin/d/a;->update()V

    sget-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    const/16 v1, 0x50

    invoke-virtual {v0, p1, v1, v7, v7}, Lcom/payeco/android/plugin/d/a;->showAtLocation(Landroid/view/View;III)V

    sget-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    iput-object p5, v0, Lcom/payeco/android/plugin/d/a;->d:Lcom/payeco/android/plugin/d/l;

    :cond_0
    sget-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    return-object v0

    :cond_1
    const-string v0, "payeco_plugin_credit_keyboard_land"

    invoke-static {p0, v0}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    goto :goto_0
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->f:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private a()V
    .locals 11

    const/16 v10, 0x9

    const/4 v9, 0x2

    const/16 v8, 0x8

    const/4 v2, 0x1

    const/4 v1, 0x0

    const-string v0, "payeco_digit_clear"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/a;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    new-instance v3, Lcom/payeco/android/plugin/d/k;

    invoke-direct {v3, p0}, Lcom/payeco/android/plugin/d/k;-><init>(Lcom/payeco/android/plugin/d/a;)V

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/16 v0, 0xa

    new-array v4, v0, [I

    const/16 v0, 0xa

    new-array v3, v0, [I

    aput v2, v3, v2

    aput v9, v3, v9

    const/4 v0, 0x3

    const/4 v5, 0x3

    aput v5, v3, v0

    const/4 v0, 0x4

    const/4 v5, 0x4

    aput v5, v3, v0

    const/4 v0, 0x5

    const/4 v5, 0x5

    aput v5, v3, v0

    const/4 v0, 0x6

    const/4 v5, 0x6

    aput v5, v3, v0

    const/4 v0, 0x7

    const/4 v5, 0x7

    aput v5, v3, v0

    aput v8, v3, v8

    aput v10, v3, v10

    new-instance v5, Ljava/util/Random;

    invoke-direct {v5}, Ljava/util/Random;-><init>()V

    move v0, v1

    :goto_0
    array-length v6, v3

    if-lt v0, v6, :cond_1

    move v3, v1

    :goto_1
    if-le v3, v10, :cond_2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "payeco_keyboard_editText"

    const-string v4, "id"

    invoke-static {v0, v3, v4}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v4, "payeco_ckb_vailbg"

    const-string v5, "id"

    invoke-static {v3, v4, v5}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    iget-object v4, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->h:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->i:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "payeco_keyborad_cancel"

    const-string v4, "id"

    invoke-static {v0, v3, v4}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    invoke-virtual {v3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v3, Lcom/payeco/android/plugin/d/c;

    invoke-direct {v3, p0}, Lcom/payeco/android/plugin/d/c;-><init>(Lcom/payeco/android/plugin/d/a;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v4, "payeco_plugin_ckb_spinnerlayout"

    const-string v5, "id"

    invoke-static {v3, v4, v5}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->k:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v4, "payeco_ckb_vail"

    const-string v5, "id"

    invoke-static {v3, v4, v5}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->j:Landroid/widget/TextView;

    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v3, 0xb

    if-ge v0, v3, :cond_6

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->k:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->j:Landroid/widget/TextView;

    invoke-virtual {v0, v8}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v3, "payeco_cqpAuth_month_edit"

    const-string v4, "id"

    invoke-static {v1, v3, v4}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->c:Landroid/view/View;

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v4, "payeco_cqpAuth_year_edit"

    const-string v5, "id"

    invoke-static {v3, v4, v5}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Spinner;

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v3

    iput-object v3, p0, Lcom/payeco/android/plugin/d/a;->s:Ljava/util/Calendar;

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->s:Ljava/util/Calendar;

    invoke-virtual {v3, v9}, Ljava/util/Calendar;->get(I)I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    iget-object v4, p0, Lcom/payeco/android/plugin/d/a;->s:Ljava/util/Calendar;

    invoke-virtual {v4, v2}, Ljava/util/Calendar;->get(I)I

    move-result v5

    move v4, v5

    :goto_2
    add-int/lit8 v6, v5, 0x14

    if-le v4, v6, :cond_3

    :goto_3
    const/16 v4, 0xc

    if-le v3, v4, :cond_4

    :goto_4
    const/16 v3, 0xc

    if-le v2, v3, :cond_5

    new-instance v2, Landroid/widget/ArrayAdapter;

    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const v4, 0x1090008

    iget-object v5, p0, Lcom/payeco/android/plugin/d/a;->l:Ljava/util/List;

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    const v3, 0x1090009

    invoke-virtual {v2, v3}, Landroid/widget/ArrayAdapter;->setDropDownViewResource(I)V

    invoke-virtual {v1, v2}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    new-instance v3, Lcom/payeco/android/plugin/d/d;

    invoke-direct {v3, p0, v2, v0}, Lcom/payeco/android/plugin/d/d;-><init>(Lcom/payeco/android/plugin/d/a;Landroid/widget/ArrayAdapter;Landroid/widget/Spinner;)V

    invoke-virtual {v1, v3}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    :goto_5
    const-string v0, "payeco_keyboard_password"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/a;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->f:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->f:Landroid/widget/EditText;

    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->f:Landroid/widget/EditText;

    new-instance v1, Lcom/payeco/android/plugin/d/i;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/i;-><init>(Lcom/payeco/android/plugin/d/a;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v0, "payeco_confirm_keyboard"

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/a;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/payeco/android/plugin/d/a;->g:Landroid/widget/Button;

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->g:Landroid/widget/Button;

    new-instance v1, Lcom/payeco/android/plugin/d/j;

    invoke-direct {v1, p0}, Lcom/payeco/android/plugin/d/j;-><init>(Lcom/payeco/android/plugin/d/a;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_1
    array-length v6, v3

    sub-int/2addr v6, v0

    invoke-virtual {v5, v6}, Ljava/util/Random;->nextInt(I)I

    move-result v6

    aget v7, v3, v6

    aput v7, v4, v0

    array-length v7, v3

    add-int/lit8 v7, v7, -0x1

    sub-int/2addr v7, v0

    aget v7, v3, v7

    aput v7, v3, v6

    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v5, "payeco_digit_"

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/payeco/android/plugin/d/a;->a(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iget-object v5, p0, Lcom/payeco/android/plugin/d/a;->v:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v5}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    aget v5, v4, v3

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto/16 :goto_1

    :cond_3
    iget-object v6, p0, Lcom/payeco/android/plugin/d/a;->l:Ljava/util/List;

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, " "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\u5e74"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    :cond_4
    iget-object v4, p0, Lcom/payeco/android/plugin/d/a;->n:Ljava/util/List;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\u6708"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_3

    :cond_5
    iget-object v3, p0, Lcom/payeco/android/plugin/d/a;->m:Ljava/util/List;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\u6708"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_4

    :cond_6
    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->k:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->j:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    new-instance v0, Lcom/payeco/android/plugin/d/g;

    invoke-direct {v0, p0}, Lcom/payeco/android/plugin/d/g;-><init>(Lcom/payeco/android/plugin/d/a;)V

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->j:Landroid/widget/TextView;

    new-instance v2, Lcom/payeco/android/plugin/d/h;

    invoke-direct {v2, p0, v0}, Lcom/payeco/android/plugin/d/h;-><init>(Lcom/payeco/android/plugin/d/a;Landroid/app/DatePickerDialog$OnDateSetListener;)V

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto/16 :goto_5
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;Lcom/payeco/android/plugin/d/m;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/a;->e:Lcom/payeco/android/plugin/d/m;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/a;->u:Ljava/lang/String;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;Ljava/util/Calendar;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/a;->s:Ljava/util/Calendar;

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/payeco/android/plugin/d/a;->o:Z

    return-void
.end method

.method static synthetic a(Lcom/payeco/android/plugin/d/a;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/payeco/android/plugin/d/a;->o:Z

    return v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    return-object v0
.end method

.method static synthetic b(Lcom/payeco/android/plugin/d/a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/d/a;->t:Ljava/lang/String;

    return-void
.end method

.method static synthetic c(Lcom/payeco/android/plugin/d/a;)Landroid/widget/LinearLayout;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->h:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic d(Lcom/payeco/android/plugin/d/a;)Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->f:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic e(Lcom/payeco/android/plugin/d/a;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/a;->p:I

    return v0
.end method

.method static synthetic f(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->u:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic g(Lcom/payeco/android/plugin/d/a;)Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->n:Ljava/util/List;

    return-object v0
.end method

.method static synthetic h(Lcom/payeco/android/plugin/d/a;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->t:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic i(Lcom/payeco/android/plugin/d/a;)Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->m:Ljava/util/List;

    return-object v0
.end method

.method static synthetic j(Lcom/payeco/android/plugin/d/a;)Ljava/util/Calendar;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->s:Ljava/util/Calendar;

    return-object v0
.end method

.method static synthetic k(Lcom/payeco/android/plugin/d/a;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->j:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic l(Lcom/payeco/android/plugin/d/a;)Landroid/widget/LinearLayout;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->i:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic m(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/d/m;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->e:Lcom/payeco/android/plugin/d/m;

    return-object v0
.end method

.method static synthetic n(Lcom/payeco/android/plugin/d/a;)I
    .locals 1

    iget v0, p0, Lcom/payeco/android/plugin/d/a;->q:I

    return v0
.end method

.method static synthetic o(Lcom/payeco/android/plugin/d/a;)Lcom/payeco/android/plugin/d/l;
    .locals 1

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->d:Lcom/payeco/android/plugin/d/l;

    return-object v0
.end method


# virtual methods
.method public final a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "drawable"

    invoke-static {v0, p2, v1}, Lcom/payeco/android/plugin/c/d;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->h:Landroid/widget/LinearLayout;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/payeco/android/plugin/d/a;->h:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackgroundResource(I)V

    :cond_0
    iget-object v0, p0, Lcom/payeco/android/plugin/d/a;->b:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method public final dismiss()V
    .locals 1

    invoke-super {p0}, Landroid/widget/PopupWindow;->dismiss()V

    const/4 v0, 0x0

    sput-object v0, Lcom/payeco/android/plugin/d/a;->a:Lcom/payeco/android/plugin/d/a;

    return-void
.end method
