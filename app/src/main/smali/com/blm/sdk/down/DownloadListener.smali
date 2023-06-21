.class public interface abstract Lcom/blm/sdk/down/DownloadListener;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final CODE_FILENOTFOUND_EXCEPTION:I = 0x65

.field public static final CODE_FILEPATH_ERROR_EXCEPTION:I = 0x6a

.field public static final CODE_FILEPATH_NULL_EXCEPTION:I = 0x69

.field public static final CODE_FILE_LENGTH_EXCEPTION:I = 0x67

.field public static final CODE_MD5_ERROR_EXCEPTION:I = 0x6b

.field public static final CODE_SETLENGTH_EXCEPTION:I = 0x66

.field public static final CODE_URL_PARSED_EXCEPTION:I = 0x68


# virtual methods
.method public abstract onDownloadFail(ILjava/lang/String;)V
.end method

.method public abstract onDownloadFinish(Ljava/lang/String;I)V
.end method

.method public abstract onDownloadProgress(I)V
.end method

.method public abstract onDownloadStart()V
.end method
