.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->_UniWebViewCleanCookie(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$key:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;->val$key:Ljava/lang/String;

    .line 292
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 295
    const-string v2, "UniWebView"

    const-string v3, "_UniWebViewCleanCookie"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 297
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    .line 298
    .local v0, "cm":Landroid/webkit/CookieManager;
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;->val$key:Ljava/lang/String;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;->val$key:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 299
    :cond_0
    const-string v2, "UniWebView"

    const-string v3, "Cleaning all cookies"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 300
    invoke-virtual {v0}, Landroid/webkit/CookieManager;->removeAllCookie()V

    .line 306
    :goto_0
    invoke-static {}, Landroid/webkit/CookieSyncManager;->getInstance()Landroid/webkit/CookieSyncManager;

    move-result-object v1

    .line 307
    .local v1, "manager":Landroid/webkit/CookieSyncManager;
    if-eqz v1, :cond_1

    .line 308
    invoke-virtual {v1}, Landroid/webkit/CookieSyncManager;->sync()V

    .line 310
    :cond_1
    return-void

    .line 302
    .end local v1    # "manager":Landroid/webkit/CookieSyncManager;
    :cond_2
    const-string v2, "UniWebView"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Setting an empty cookie for: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;->val$key:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 303
    iget-object v2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$12;->val$key:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
