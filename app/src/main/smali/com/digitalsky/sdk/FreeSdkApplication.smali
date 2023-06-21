.class public Lcom/digitalsky/sdk/FreeSdkApplication;
.super Lcom/digitalsky/sdk/InvalidApplication;
.source "FreeSdkApplication.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Lcom/digitalsky/sdk/InvalidApplication;-><init>()V

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "base"    # Landroid/content/Context;

    .prologue
    .line 9
    invoke-super {p0, p1}, Lcom/digitalsky/sdk/InvalidApplication;->attachBaseContext(Landroid/content/Context;)V

    .line 10
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/sdk/FreeSdk;->onAppAttachBaseContext(Landroid/content/Context;)V

    .line 11
    return-void
.end method

.method public onCreate()V
    .locals 1

    .prologue
    .line 16
    invoke-super {p0}, Lcom/digitalsky/sdk/InvalidApplication;->onCreate()V

    .line 17
    invoke-static {}, Lcom/digitalsky/sdk/FreeSdk;->getInstance()Lcom/digitalsky/sdk/FreeSdk;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/digitalsky/sdk/FreeSdk;->onAppCreate(Landroid/app/Application;)V

    .line 18
    return-void
.end method
