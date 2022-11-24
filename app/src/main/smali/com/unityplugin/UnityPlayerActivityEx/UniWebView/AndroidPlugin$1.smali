.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$1;
.super Ljava/lang/Object;
.source "AndroidPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->onResume()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;


# direct methods
.method constructor <init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$1;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 68
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin$1;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/AndroidPlugin;->ShowAllWebViewDialogs(Z)V

    .line 69
    return-void
.end method
