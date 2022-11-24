.class public interface abstract Lcom/digitalsky/sdk/user/IUser;
.super Ljava/lang/Object;
.source "IUser.java"


# virtual methods
.method public abstract add_info(Ljava/lang/String;Ljava/lang/String;)Z
.end method

.method public abstract enterPlatform(I)Z
.end method

.method public abstract exit()Z
.end method

.method public abstract hideToolBar()Z
.end method

.method public abstract login(Ljava/lang/String;)Z
.end method

.method public abstract loginCallback(Lcom/digitalsky/sdk/user/FreeSdkVerifyResponse;)V
.end method

.method public abstract logout()Z
.end method

.method public abstract setUserListener(Lcom/digitalsky/sdk/user/UserListener$OnUserCallback;)V
.end method

.method public abstract showToolBar()Z
.end method

.method public abstract submitInfo(Lcom/digitalsky/sdk/user/SubmitData;)Z
.end method

.method public abstract switchAccount()Z
.end method
