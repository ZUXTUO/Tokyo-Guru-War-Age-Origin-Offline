.class public interface abstract Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;
.super Ljava/lang/Object;
.source "UserListener.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/digitalsky/sdk/user/UserListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "OnUserCallback"
.end annotation


# virtual methods
.method public abstract onLoginCallback(ILcom/digitalsky/sdk/user/FreeSdkVerifyRequest;)V
.end method

.method public abstract onLogoutCallback()V
.end method
