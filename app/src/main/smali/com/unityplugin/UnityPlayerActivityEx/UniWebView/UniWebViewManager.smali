.class public Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;
.super Ljava/lang/Object;
.source "UniWebViewManager.java"


# static fields
.field private static _instance:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;


# instance fields
.field private _showingWebViewDialogs:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;",
            ">;"
        }
    .end annotation
.end field

.field private _webViewDialogDic:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    const/4 v0, 0x0

    sput-object v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_instance:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    .line 20
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_showingWebViewDialogs:Ljava/util/ArrayList;

    .line 21
    return-void
.end method

.method public static Instance()Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;
    .locals 1

    .prologue
    .line 24
    sget-object v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_instance:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    if-nez v0, :cond_0

    .line 25
    new-instance v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    invoke-direct {v0}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;-><init>()V

    sput-object v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_instance:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    .line 27
    :cond_0
    sget-object v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_instance:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;

    return-object v0
.end method


# virtual methods
.method public addShowingWebViewDialog(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V
    .locals 1
    .param p1, "webViewDialog"    # Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .prologue
    .line 52
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_showingWebViewDialogs:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 53
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_showingWebViewDialogs:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 55
    :cond_0
    return-void
.end method

.method public allDialogs()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection",
            "<",
            "Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;",
            ">;"
        }
    .end annotation

    .prologue
    .line 48
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    return-object v0
.end method

.method public getShowingWebViewDialogs()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;",
            ">;"
        }
    .end annotation

    .prologue
    .line 62
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_showingWebViewDialogs:Ljava/util/ArrayList;

    return-object v0
.end method

.method public getUniWebViewDialog(Ljava/lang/String;)Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 31
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 32
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .line 34
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public removeShowingWebViewDialog(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V
    .locals 1
    .param p1, "webViewDialog"    # Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .prologue
    .line 58
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_showingWebViewDialogs:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 59
    return-void
.end method

.method public removeUniWebView(Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 39
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 41
    :cond_0
    return-void
.end method

.method public setUniWebView(Ljava/lang/String;Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "webViewDialog"    # Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    .prologue
    .line 44
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewManager;->_webViewDialogDic:Ljava/util/HashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 45
    return-void
.end method
