.class public Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;
.super Ljava/lang/Object;
.source "CommentComponentView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/sina/weibo/sdk/component/view/CommentComponentView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RequestParam"
.end annotation


# instance fields
.field private mAccessToken:Ljava/lang/String;

.field private mAppKey:Ljava/lang/String;

.field private mAuthlistener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

.field private mCategory:Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;

.field private mContent:Ljava/lang/String;

.field private mTopic:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 126
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$0(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 119
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAppKey:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 121
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mTopic:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$2(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 122
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mContent:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$3(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mCategory:Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;

    return-object v0
.end method

.method static synthetic access$4(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Lcom/sina/weibo/sdk/auth/WeiboAuthListener;
    .locals 1

    .prologue
    .line 124
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAuthlistener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    return-object v0
.end method

.method static synthetic access$5(Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 120
    iget-object v0, p0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAccessToken:Ljava/lang/String;

    return-object v0
.end method

.method public static createRequestParam(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;
    .locals 1
    .param p0, "appKey"    # Ljava/lang/String;
    .param p1, "commentTopic"    # Ljava/lang/String;
    .param p2, "commentContent"    # Ljava/lang/String;
    .param p3, "category"    # Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;
    .param p4, "listener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .prologue
    .line 161
    new-instance v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;-><init>()V

    .line 162
    .local v0, "param":Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;
    iput-object p0, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAppKey:Ljava/lang/String;

    .line 163
    iput-object p1, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mTopic:Ljava/lang/String;

    .line 164
    iput-object p2, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mContent:Ljava/lang/String;

    .line 165
    iput-object p3, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mCategory:Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;

    .line 166
    iput-object p4, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAuthlistener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 167
    return-object v0
.end method

.method public static createRequestParam(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;
    .locals 1
    .param p0, "appKey"    # Ljava/lang/String;
    .param p1, "token"    # Ljava/lang/String;
    .param p2, "commentTopic"    # Ljava/lang/String;
    .param p3, "commentContent"    # Ljava/lang/String;
    .param p4, "category"    # Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;
    .param p5, "listener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .prologue
    .line 140
    new-instance v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;

    invoke-direct {v0}, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;-><init>()V

    .line 141
    .local v0, "param":Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;
    iput-object p0, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAppKey:Ljava/lang/String;

    .line 142
    iput-object p1, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAccessToken:Ljava/lang/String;

    .line 143
    iput-object p2, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mTopic:Ljava/lang/String;

    .line 144
    iput-object p3, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mContent:Ljava/lang/String;

    .line 145
    iput-object p4, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mCategory:Lcom/sina/weibo/sdk/component/view/CommentComponentView$Category;

    .line 146
    iput-object p5, v0, Lcom/sina/weibo/sdk/component/view/CommentComponentView$RequestParam;->mAuthlistener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 147
    return-object v0
.end method
