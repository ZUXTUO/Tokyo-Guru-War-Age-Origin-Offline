.class Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;
.super Ljava/lang/Object;
.source "SelectCountryActivity.java"

# interfaces
.implements Lcom/sina/weibo/sdk/component/view/TitleBar$ListenerOnTitleBtnClicked;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->initView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;


# direct methods
.method constructor <init>(Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;->this$0:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;

    .line 101
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLeftBtnClicked()V
    .locals 2

    .prologue
    .line 105
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;->this$0:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->setResult(I)V

    .line 106
    iget-object v0, p0, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity$1;->this$0:Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;

    invoke-virtual {v0}, Lcom/sina/weibo/sdk/register/mobile/SelectCountryActivity;->finish()V

    .line 107
    return-void
.end method
