.class public Lcom/sina/weibo/sdk/widget/LoginButton;
.super Landroid/widget/Button;
.source "LoginButton.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field public static final LOGIN_INCON_STYLE_1:I = 0x1

.field public static final LOGIN_INCON_STYLE_2:I = 0x2

.field public static final LOGIN_INCON_STYLE_3:I = 0x3

.field private static final TAG:Ljava/lang/String; = "LoginButton"


# instance fields
.field private mAuthInfo:Lcom/sina/weibo/sdk/auth/AuthInfo;

.field private mAuthListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

.field private mContext:Landroid/content/Context;

.field private mExternalOnClickListener:Landroid/view/View$OnClickListener;

.field private mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 67
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/sina/weibo/sdk/widget/LoginButton;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 68
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 76
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/sina/weibo/sdk/widget/LoginButton;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 77
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    .line 85
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/Button;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 86
    invoke-direct {p0, p1}, Lcom/sina/weibo/sdk/widget/LoginButton;->initialize(Landroid/content/Context;)V

    .line 87
    return-void
.end method

.method private initialize(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 206
    iput-object p1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mContext:Landroid/content/Context;

    .line 207
    invoke-virtual {p0, p0}, Lcom/sina/weibo/sdk/widget/LoginButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 208
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/sina/weibo/sdk/widget/LoginButton;->setStyle(I)V

    .line 209
    return-void
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 195
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    if-eqz v0, :cond_0

    .line 196
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    invoke-virtual {v0, p1, p2, p3}, Lcom/sina/weibo/sdk/auth/sso/SsoHandler;->authorizeCallBack(IILandroid/content/Intent;)V

    .line 198
    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 161
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mExternalOnClickListener:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_0

    .line 162
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mExternalOnClickListener:Landroid/view/View$OnClickListener;

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    .line 165
    :cond_0
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthInfo:Lcom/sina/weibo/sdk/auth/AuthInfo;

    if-eqz v0, :cond_1

    .line 166
    new-instance v1, Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mContext:Landroid/content/Context;

    check-cast v0, Landroid/app/Activity;

    iget-object v2, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthInfo:Lcom/sina/weibo/sdk/auth/AuthInfo;

    invoke-direct {v1, v0, v2}, Lcom/sina/weibo/sdk/auth/sso/SsoHandler;-><init>(Landroid/app/Activity;Lcom/sina/weibo/sdk/auth/AuthInfo;)V

    iput-object v1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    .line 169
    :cond_1
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    if-eqz v0, :cond_2

    .line 170
    iget-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mSsoHandler:Lcom/sina/weibo/sdk/auth/sso/SsoHandler;

    iget-object v1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/auth/sso/SsoHandler;->authorize(Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V

    .line 174
    :goto_0
    return-void

    .line 172
    :cond_2
    const-string v0, "LoginButton"

    const-string v1, "Please setWeiboAuthInfo(...) for first"

    invoke-static {v0, v1}, Lcom/sina/weibo/sdk/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public setExternalOnClickListener(Landroid/view/View$OnClickListener;)V
    .locals 0
    .param p1, "listener"    # Landroid/view/View$OnClickListener;

    .prologue
    .line 152
    iput-object p1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mExternalOnClickListener:Landroid/view/View$OnClickListener;

    .line 153
    return-void
.end method

.method public setStyle(I)V
    .locals 1
    .param p1, "style"    # I

    .prologue
    .line 122
    sget v0, Lcom/sina/weibo/sdk/R$drawable;->com_sina_weibo_sdk_login_button_with_account_text:I

    .line 123
    .local v0, "iconResId":I
    packed-switch p1, :pswitch_data_0

    .line 140
    :goto_0
    invoke-virtual {p0, v0}, Lcom/sina/weibo/sdk/widget/LoginButton;->setBackgroundResource(I)V

    .line 141
    return-void

    .line 125
    :pswitch_0
    sget v0, Lcom/sina/weibo/sdk/R$drawable;->com_sina_weibo_sdk_login_button_with_account_text:I

    .line 126
    goto :goto_0

    .line 129
    :pswitch_1
    sget v0, Lcom/sina/weibo/sdk/R$drawable;->com_sina_weibo_sdk_login_button_with_frame_logo:I

    .line 130
    goto :goto_0

    .line 133
    :pswitch_2
    sget v0, Lcom/sina/weibo/sdk/R$drawable;->com_sina_weibo_sdk_login_button_with_original_logo:I

    .line 134
    goto :goto_0

    .line 123
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public setWeiboAuthInfo(Lcom/sina/weibo/sdk/auth/AuthInfo;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V
    .locals 0
    .param p1, "authInfo"    # Lcom/sina/weibo/sdk/auth/AuthInfo;
    .param p2, "authListener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .prologue
    .line 96
    iput-object p1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthInfo:Lcom/sina/weibo/sdk/auth/AuthInfo;

    .line 97
    iput-object p2, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 98
    return-void
.end method

.method public setWeiboAuthInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/sina/weibo/sdk/auth/WeiboAuthListener;)V
    .locals 2
    .param p1, "appKey"    # Ljava/lang/String;
    .param p2, "redirectUrl"    # Ljava/lang/String;
    .param p3, "scope"    # Ljava/lang/String;
    .param p4, "authListener"    # Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .prologue
    .line 109
    new-instance v0, Lcom/sina/weibo/sdk/auth/AuthInfo;

    iget-object v1, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, p1, p2, p3}, Lcom/sina/weibo/sdk/auth/AuthInfo;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthInfo:Lcom/sina/weibo/sdk/auth/AuthInfo;

    .line 110
    iput-object p4, p0, Lcom/sina/weibo/sdk/widget/LoginButton;->mAuthListener:Lcom/sina/weibo/sdk/auth/WeiboAuthListener;

    .line 111
    return-void
.end method
