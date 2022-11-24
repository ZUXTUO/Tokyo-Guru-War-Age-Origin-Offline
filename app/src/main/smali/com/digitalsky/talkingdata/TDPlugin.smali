.class public Lcom/digitalsky/talkingdata/TDPlugin;
.super Ljava/lang/Object;
.source "TDPlugin.java"

# interfaces
.implements Lcom/digitalsky/sdk/IApplication;
.implements Lcom/digitalsky/sdk/data/IData;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAppAttachBaseContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "arg0"    # Landroid/content/Context;

    .prologue
    .line 23
    return-void
.end method

.method public onAppCreate(Landroid/app/Application;)V
    .locals 1
    .param p1, "arg0"    # Landroid/app/Application;

    .prologue
    .line 28
    invoke-static {}, Lcom/digitalsky/talkingdata/TDSdk;->getInstance()Lcom/digitalsky/talkingdata/TDSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/talkingdata/TDSdk;->onAppCreate(Landroid/content/Context;)V

    .line 29
    return-void
.end method

.method public submit(Ljava/lang/String;)Z
    .locals 1
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    .line 16
    invoke-static {}, Lcom/digitalsky/talkingdata/TDSdk;->getInstance()Lcom/digitalsky/talkingdata/TDSdk;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/digitalsky/talkingdata/TDSdk;->submit(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
