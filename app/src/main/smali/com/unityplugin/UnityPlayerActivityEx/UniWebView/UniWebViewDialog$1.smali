.class Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;
.super Ljava/lang/Object;
.source "UniWebViewDialog.java"

# interfaces
.implements Landroid/view/View$OnSystemUiVisibilityChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;->HideSystemUI()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

.field private final synthetic val$decorView:Landroid/view/View;

.field private final synthetic val$finalUiOptions:I


# direct methods
.method constructor <init>(Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;Landroid/view/View;I)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;->this$0:Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog;

    iput-object p2, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;->val$decorView:Landroid/view/View;

    iput p3, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;->val$finalUiOptions:I

    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSystemUiVisibilityChange(I)V
    .locals 2
    .param p1, "i"    # I

    .prologue
    .line 149
    iget-object v0, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;->val$decorView:Landroid/view/View;

    iget v1, p0, Lcom/unityplugin/UnityPlayerActivityEx/UniWebView/UniWebViewDialog$1;->val$finalUiOptions:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 150
    return-void
.end method
