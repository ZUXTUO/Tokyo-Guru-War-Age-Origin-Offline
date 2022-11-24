.class Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blm/sdk/async/http/SimpleMultipartEntity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "FilePart"
.end annotation


# instance fields
.field public file:Ljava/io/File;

.field public header:[B

.field final synthetic this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;


# direct methods
.method public constructor <init>(Lcom/blm/sdk/async/http/SimpleMultipartEntity;Ljava/lang/String;Ljava/io/File;Ljava/lang/String;)V
    .locals 1
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "file"    # Ljava/io/File;
    .param p4, "type"    # Ljava/lang/String;

    .prologue
    .line 172
    iput-object p1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 173
    invoke-virtual {p3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p2, v0, p4}, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->createHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->header:[B

    .line 174
    iput-object p3, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->file:Ljava/io/File;

    .line 175
    return-void
.end method

.method private createHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "filename"    # Ljava/lang/String;
    .param p3, "type"    # Ljava/lang/String;

    .prologue
    .line 178
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 180
    :try_start_0
    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-static {v1}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$000(Lcom/blm/sdk/async/http/SimpleMultipartEntity;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 183
    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-static {v1, p1, p2}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$100(Lcom/blm/sdk/async/http/SimpleMultipartEntity;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 184
    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-static {v1, p3}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$200(Lcom/blm/sdk/async/http/SimpleMultipartEntity;Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 185
    invoke-static {}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$300()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 186
    invoke-static {}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$400()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 193
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0

    .line 187
    :catch_0
    move-exception v1

    .line 189
    sget-boolean v1, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    if-eqz v1, :cond_0

    goto :goto_0
.end method


# virtual methods
.method public getTotalLength()J
    .locals 4

    .prologue
    .line 197
    iget-object v0, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    .line 198
    iget-object v2, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->header:[B

    array-length v2, v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 4
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 202
    iget-object v0, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->header:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 203
    iget-object v0, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->header:[B

    array-length v1, v1

    invoke-static {v0, v1}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$500(Lcom/blm/sdk/async/http/SimpleMultipartEntity;I)V

    .line 205
    new-instance v0, Ljava/io/FileInputStream;

    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->file:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 206
    const/16 v1, 0x1000

    new-array v1, v1, [B

    .line 208
    :goto_0
    invoke-virtual {v0, v1}, Ljava/io/FileInputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    .line 209
    const/4 v3, 0x0

    invoke-virtual {p1, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 210
    iget-object v3, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-static {v3, v2}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$500(Lcom/blm/sdk/async/http/SimpleMultipartEntity;I)V

    goto :goto_0

    .line 212
    :cond_0
    invoke-static {}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$400()[B

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/io/OutputStream;->write([B)V

    .line 213
    iget-object v1, p0, Lcom/blm/sdk/async/http/SimpleMultipartEntity$FilePart;->this$0:Lcom/blm/sdk/async/http/SimpleMultipartEntity;

    invoke-static {}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$400()[B

    move-result-object v2

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/blm/sdk/async/http/SimpleMultipartEntity;->access$500(Lcom/blm/sdk/async/http/SimpleMultipartEntity;I)V

    .line 214
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 216
    :try_start_0
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 223
    :cond_1
    :goto_1
    return-void

    .line 217
    :catch_0
    move-exception v0

    .line 219
    sget-boolean v0, Lcom/blm/sdk/async/http/AsyncHttpClient;->isDebug:Z

    if-eqz v0, :cond_1

    goto :goto_1
.end method
