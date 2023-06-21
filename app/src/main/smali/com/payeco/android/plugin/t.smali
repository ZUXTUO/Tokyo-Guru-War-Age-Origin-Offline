.class final Lcom/payeco/android/plugin/t;
.super Landroid/content/BroadcastReceiver;


# instance fields
.field final synthetic a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;


# direct methods
.method private constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/payeco/android/plugin/t;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;B)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/payeco/android/plugin/t;-><init>(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;)V

    return-void
.end method


# virtual methods
.method public final onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v2, 0x0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/payeco/android/plugin/t;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    const-string v1, "android.permission.RECEIVE_SMS"

    invoke-virtual {v0, v1}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "android.provider.Telephony.SMS_DELIVER"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    :cond_2
    :try_start_0
    const-string v0, "pdus"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    array-length v1, v0

    new-array v4, v1, [[B

    move v3, v2

    :goto_1
    array-length v1, v0

    if-lt v3, v1, :cond_4

    array-length v0, v4

    new-array v1, v0, [[B

    array-length v3, v1

    new-array v5, v3, [Landroid/telephony/gsm/SmsMessage;

    move v0, v2

    :goto_2
    if-lt v0, v3, :cond_5

    array-length v1, v5

    move v0, v2

    :goto_3
    if-ge v0, v1, :cond_0

    aget-object v2, v5, v0

    const-string v3, "SmsNumber"

    invoke-static {v3}, Lcom/payeco/android/plugin/b/h;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2}, Landroid/telephony/gsm/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {v2}, Landroid/telephony/gsm/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/payeco/android/plugin/t;->a:Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;

    invoke-virtual {v2}, Landroid/telephony/gsm/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    invoke-static {v4, v3}, Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;->d(Lcom/payeco/android/plugin/PayecoPluginLoadingActivity;Ljava/lang/String;)V

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    :cond_4
    aget-object v1, v0, v3

    check-cast v1, [B

    aput-object v1, v4, v3

    add-int/lit8 v1, v3, 0x1

    move v3, v1

    goto :goto_1

    :cond_5
    aget-object v6, v4, v0

    aput-object v6, v1, v0

    aget-object v6, v1, v0

    invoke-static {v6}, Landroid/telephony/gsm/SmsMessage;->createFromPdu([B)Landroid/telephony/gsm/SmsMessage;

    move-result-object v6

    aput-object v6, v5, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :catch_0
    move-exception v0

    const-string v1, "payeco"

    const-string v2, "\u76d1\u542c\u5230\u77ed\u4fe1\uff0c\u5904\u7406\u5931\u8d25\uff01"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method
