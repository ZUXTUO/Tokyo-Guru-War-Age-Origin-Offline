.class public Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;
.super Landroid/app/Activity;
.source "SelectCountryActivity.java"

# interfaces
.implements Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar$OnIndexChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;,
        Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;
    }
.end annotation


# static fields
.field private static final CHINA_CN:Ljava/lang/String; = "\u4e2d\u56fd"

.field private static final CHINA_EN:Ljava/lang/String; = "China"

.field private static final CHINA_TW:Ljava/lang/String; = "\u4e2d\u570b"

.field public static final EXTRA_COUNTRY_CODE:Ljava/lang/String; = "code"

.field public static final EXTRA_COUNTRY_NAME:Ljava/lang/String; = "name"

.field private static final INFO_CN:Ljava/lang/String; = "\u5e38\u7528"

.field private static final INFO_EN:Ljava/lang/String; = "Common"

.field private static final INFO_TW:Ljava/lang/String; = "\u5e38\u7528"

.field private static final SELECT_COUNTRY_EN:Ljava/lang/String; = "Region"

.field private static final SELECT_COUNTRY_ZH_CN:Ljava/lang/String; = "\u9009\u62e9\u56fd\u5bb6"

.field private static final SELECT_COUNTRY_ZH_TW:Ljava/lang/String; = "\u9078\u64c7\u570b\u5bb6"


# instance fields
.field private arrSubCountry:[Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/Country;",
            ">;"
        }
    .end annotation
.end field

.field countryStr:Ljava/lang/String;

.field private indexCountries:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;",
            ">;"
        }
    .end annotation
.end field

.field private mAdapter:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

.field private mCountries:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/Country;",
            ">;"
        }
    .end annotation
.end field

.field private mFrameLayout:Landroid/widget/FrameLayout;

.field private mLetterIndexBar:Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

.field private mListView:Landroid/widget/ListView;

.field private mMainLayout:Landroid/widget/RelativeLayout;

.field private result:Lcom/sina/weibo/sdk/register/mobile/CountryList;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 35
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 64
    const-string v0, ""

    iput-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->countryStr:Ljava/lang/String;

    .line 69
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->indexCountries:Ljava/util/List;

    .line 35
    return-void
.end method

.method static synthetic access$0(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)Ljava/util/List;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->indexCountries:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)[Ljava/util/List;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$2(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;
    .locals 1

    .prologue
    .line 72
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mAdapter:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

    return-object v0
.end method

.method private compose([Ljava/util/List;)Ljava/util/List;
    .locals 6
    .param p1, "arrSubCountry"    # [Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/Country;",
            ">;)",
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 257
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 258
    .local v1, "indexFollows":Ljava/util/List;, "Ljava/util/List<Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;>;"
    if-eqz p1, :cond_0

    .line 259
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v4, p1

    if-lt v0, v4, :cond_1

    .line 271
    .end local v0    # "i":I
    :cond_0
    return-object v1

    .line 260
    .restart local v0    # "i":I
    :cond_1
    aget-object v3, p1, v0

    .line 261
    .local v3, "list":Ljava/util/List;, "Ljava/util/List<Lcom/sina/weibo/sdk/register/mobile/Country;>;"
    if-eqz v3, :cond_2

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_2

    .line 262
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_1
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    if-lt v2, v4, :cond_3

    .line 259
    .end local v2    # "j":I
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 263
    .restart local v2    # "j":I
    :cond_3
    if-nez v2, :cond_4

    .line 264
    new-instance v4, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;

    const/4 v5, -0x1

    invoke-direct {v4, p0, v0, v5}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;II)V

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 266
    :cond_4
    new-instance v4, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;

    invoke-direct {v4, p0, v0, v2}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;II)V

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 262
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method

.method private initView()V
    .locals 12

    .prologue
    const/4 v11, 0x1

    const/4 v10, 0x0

    const/4 v9, -0x1

    .line 88
    new-instance v6, Landroid/widget/RelativeLayout;

    invoke-direct {v6, p0}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mMainLayout:Landroid/widget/RelativeLayout;

    .line 89
    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v4, v9, v9}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 91
    .local v4, "mMainLayoutLp":Landroid/widget/RelativeLayout$LayoutParams;
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mMainLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v6, v4}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 95
    new-instance v5, Lcom/sina/weibo/sdk/component/view/TitleBar;

    invoke-direct {v5, p0}, Lcom/sina/weibo/sdk/component/view/TitleBar;-><init>(Landroid/content/Context;)V

    .line 96
    .local v5, "titleBar":Lcom/sina/weibo/sdk/component/view/TitleBar;
    invoke-virtual {v5, v11}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setId(I)V

    .line 98
    const-string v6, "weibosdk_navigationbar_back.png"

    const-string v7, "weibosdk_navigationbar_back_highlighted.png"

    .line 97
    invoke-static {p0, v6, v7}, Lcom/sina/weibo/sdk/utils/ResourceManager;->createStateListDrawable(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/graphics/drawable/StateListDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setLeftBtnBg(Landroid/graphics/drawable/Drawable;)V

    .line 99
    const-string v6, "Region"

    .line 100
    const-string v7, "\u9009\u62e9\u56fd\u5bb6"

    const-string v8, "\u9078\u64c7\u570b\u5bb6"

    .line 99
    invoke-static {p0, v6, v7, v8}, Lcom/sina/weibo/sdk/utils/ResourceManager;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setTitleBarText(Ljava/lang/String;)V

    .line 101
    new-instance v6, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;

    invoke-direct {v6, p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)V

    invoke-virtual {v5, v6}, Lcom/sina/weibo/sdk/component/view/TitleBar;->setTitleBarClickListener(Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;)V

    .line 110
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mMainLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v6, v5}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 112
    new-instance v6, Landroid/widget/FrameLayout;

    invoke-direct {v6, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mFrameLayout:Landroid/widget/FrameLayout;

    .line 113
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v1, v9, v9}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 115
    .local v1, "mFrameLp":Landroid/widget/RelativeLayout$LayoutParams;
    const/4 v6, 0x3

    invoke-virtual {v5}, Lcom/sina/weibo/sdk/component/view/TitleBar;->getId()I

    move-result v7

    invoke-virtual {v1, v6, v7}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 116
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mFrameLayout:Landroid/widget/FrameLayout;

    invoke-virtual {v6, v1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 117
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mMainLayout:Landroid/widget/RelativeLayout;

    iget-object v7, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mFrameLayout:Landroid/widget/FrameLayout;

    invoke-virtual {v6, v7}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 119
    new-instance v6, Landroid/widget/ListView;

    invoke-direct {v6, p0}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    .line 120
    new-instance v3, Landroid/widget/AbsListView$LayoutParams;

    invoke-direct {v3, v9, v9}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    .line 122
    .local v3, "mListViewLp":Landroid/widget/AbsListView$LayoutParams;
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v3}, Landroid/widget/ListView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 123
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setFadingEdgeLength(I)V

    .line 124
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    new-instance v7, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v7, v10}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v6, v7}, Landroid/widget/ListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    .line 125
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-static {p0, v11}, Lcom/sina/weibo/sdk/utils/ResourceManager;->dp2px(Landroid/content/Context;I)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/widget/ListView;->setDividerHeight(I)V

    .line 126
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setCacheColorHint(I)V

    .line 127
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setDrawSelectorOnTop(Z)V

    .line 128
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setScrollingCacheEnabled(Z)V

    .line 129
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setScrollbarFadingEnabled(Z)V

    .line 130
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v10}, Landroid/widget/ListView;->setVerticalScrollBarEnabled(Z)V

    .line 131
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    new-instance v7, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$2;

    invoke-direct {v7, p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$2;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)V

    invoke-virtual {v6, v7}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 149
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mFrameLayout:Landroid/widget/FrameLayout;

    iget-object v7, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v6, v7}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 151
    new-instance v6, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

    const/4 v7, 0x0

    invoke-direct {v6, p0, v7}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mAdapter:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

    .line 152
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    iget-object v7, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mAdapter:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

    invoke-virtual {v6, v7}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 154
    new-instance v6, Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

    invoke-direct {v6, p0}, Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;-><init>(Landroid/content/Context;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mLetterIndexBar:Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

    .line 155
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mLetterIndexBar:Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

    invoke-virtual {v6, p0}, Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;->setIndexChangeListener(Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar$OnIndexChangeListener;)V

    .line 156
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    .line 157
    const/4 v6, -0x2

    .line 156
    invoke-direct {v2, v6, v9}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 158
    .local v2, "mLetterIndexBarLp":Landroid/widget/FrameLayout$LayoutParams;
    const/4 v6, 0x5

    iput v6, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 159
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mLetterIndexBar:Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

    invoke-virtual {v6, v2}, Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 160
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mFrameLayout:Landroid/widget/FrameLayout;

    iget-object v7, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mLetterIndexBar:Lcom/sina/weibo/sdk/register/mobile/LetterIndexBar;

    invoke-virtual {v6, v7}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 163
    invoke-static {p0}, Lcom/sina/weibo/sdk/register/mobile/PinyinUtils;->getInstance(Landroid/content/Context;)Lcom/sina/weibo/sdk/register/mobile/PinyinUtils;

    .line 164
    invoke-static {}, Lcom/sina/weibo/sdk/utils/ResourceManager;->getLanguage()Ljava/util/Locale;

    move-result-object v0

    .line 165
    .local v0, "locale":Ljava/util/Locale;
    sget-object v6, Ljava/util/Locale;->SIMPLIFIED_CHINESE:Ljava/util/Locale;

    invoke-virtual {v6, v0}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 166
    const-string v6, "countryCode.txt"

    invoke-static {p0, v6}, Lcom/sina/weibo/sdk/utils/ResourceManager;->readCountryFromAsset(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->countryStr:Ljava/lang/String;

    .line 172
    :goto_0
    new-instance v6, Lcom/sina/weibo/sdk/register/mobile/CountryList;

    iget-object v7, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->countryStr:Ljava/lang/String;

    invoke-direct {v6, v7}, Lcom/sina/weibo/sdk/register/mobile/CountryList;-><init>(Ljava/lang/String;)V

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->result:Lcom/sina/weibo/sdk/register/mobile/CountryList;

    .line 175
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->result:Lcom/sina/weibo/sdk/register/mobile/CountryList;

    iget-object v6, v6, Lcom/sina/weibo/sdk/register/mobile/CountryList;->countries:Ljava/util/List;

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mCountries:Ljava/util/List;

    .line 176
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mCountries:Ljava/util/List;

    invoke-direct {p0, v6}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->subCountries(Ljava/util/List;)[Ljava/util/List;

    move-result-object v6

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    .line 177
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    invoke-direct {p0, v6}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->compose([Ljava/util/List;)Ljava/util/List;

    move-result-object v6

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->indexCountries:Ljava/util/List;

    .line 178
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mAdapter:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;

    invoke-virtual {v6}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$CountryAdapter;->notifyDataSetChanged()V

    .line 180
    iget-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mMainLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {p0, v6}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->setContentView(Landroid/view/View;)V

    .line 181
    return-void

    .line 167
    :cond_0
    sget-object v6, Ljava/util/Locale;->TRADITIONAL_CHINESE:Ljava/util/Locale;

    invoke-virtual {v6, v0}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 168
    const-string v6, "countryCodeTw.txt"

    invoke-static {p0, v6}, Lcom/sina/weibo/sdk/utils/ResourceManager;->readCountryFromAsset(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->countryStr:Ljava/lang/String;

    goto :goto_0

    .line 170
    :cond_1
    const-string v6, "countryCodeEn.txt"

    invoke-static {p0, v6}, Lcom/sina/weibo/sdk/utils/ResourceManager;->readCountryFromAsset(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->countryStr:Ljava/lang/String;

    goto :goto_0
.end method

.method private subCountries(Ljava/util/List;)[Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/Country;",
            ">;)[",
            "Ljava/util/List",
            "<",
            "Lcom/sina/weibo/sdk/register/mobile/Country;",
            ">;"
        }
    .end annotation

    .prologue
    .local p1, "countries":Ljava/util/List;, "Ljava/util/List<Lcom/sina/weibo/sdk/register/mobile/Country;>;"
    const/4 v8, 0x0

    .line 225
    const/16 v5, 0x1b

    new-array v0, v5, [Ljava/util/ArrayList;

    .line 227
    .local v0, "arr":[Ljava/util/List;
    new-instance v1, Lcom/sina/weibo/sdk/register/mobile/Country;

    invoke-direct {v1}, Lcom/sina/weibo/sdk/register/mobile/Country;-><init>()V

    .line 228
    .local v1, "commonCountry":Lcom/sina/weibo/sdk/register/mobile/Country;
    const-string v5, "0086"

    invoke-virtual {v1, v5}, Lcom/sina/weibo/sdk/register/mobile/Country;->setCode(Ljava/lang/String;)V

    .line 229
    const-string v5, "China"

    const-string v6, "\u4e2d\u56fd"

    const-string v7, "\u4e2d\u570b"

    invoke-static {p0, v5, v6, v7}, Lcom/sina/weibo/sdk/utils/ResourceManager;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Lcom/sina/weibo/sdk/register/mobile/Country;->setName(Ljava/lang/String;)V

    .line 230
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    aput-object v5, v0, v8

    .line 231
    aget-object v5, v0, v8

    invoke-interface {v5, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 233
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v5

    if-lt v3, v5, :cond_0

    .line 249
    return-object v0

    .line 234
    :cond_0
    invoke-interface {p1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/sina/weibo/sdk/register/mobile/Country;

    .line 235
    .local v2, "country":Lcom/sina/weibo/sdk/register/mobile/Country;
    invoke-virtual {v2}, Lcom/sina/weibo/sdk/register/mobile/Country;->getCode()Ljava/lang/String;

    move-result-object v5

    const-string v6, "00852"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v2}, Lcom/sina/weibo/sdk/register/mobile/Country;->getCode()Ljava/lang/String;

    move-result-object v5

    const-string v6, "00853"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 236
    invoke-virtual {v2}, Lcom/sina/weibo/sdk/register/mobile/Country;->getCode()Ljava/lang/String;

    move-result-object v5

    const-string v6, "00886"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 237
    :cond_1
    aget-object v5, v0, v8

    invoke-interface {v5, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 233
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 242
    :cond_2
    invoke-virtual {v2}, Lcom/sina/weibo/sdk/register/mobile/Country;->getPinyin()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/String;->charAt(I)C

    move-result v5

    add-int/lit8 v5, v5, -0x61

    add-int/lit8 v4, v5, 0x1

    .line 244
    .local v4, "index":I
    aget-object v5, v0, v4

    if-nez v5, :cond_3

    .line 245
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    aput-object v5, v0, v4

    .line 247
    :cond_3
    aget-object v5, v0, v4

    invoke-interface {v5, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 80
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 82
    invoke-direct {p0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->initView()V

    .line 83
    return-void
.end method

.method protected onDestroy()V
    .locals 0

    .prologue
    .line 361
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 362
    return-void
.end method

.method public onIndexChange(I)V
    .locals 4
    .param p1, "index"    # I

    .prologue
    .line 191
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->arrSubCountry:[Ljava/util/List;

    aget-object v0, v0, p1

    if-eqz v0, :cond_0

    .line 192
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->mListView:Landroid/widget/ListView;

    iget-object v1, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->indexCountries:Ljava/util/List;

    new-instance v2, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;

    const/4 v3, -0x1

    invoke-direct {v2, p0, p1, v3}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$IndexCountry;-><init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;II)V

    invoke-interface {v1, v2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelection(I)V

    .line 195
    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 186
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 187
    return-void
.end method
