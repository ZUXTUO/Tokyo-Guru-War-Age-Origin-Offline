.class public Lcom/digital/cloud/usercenter/UserCenterConfig;
.super Ljava/lang/Object;
.source "UserCenterConfig.java"


# static fields
.field public static APPIdentifying:Ljava/lang/String;

.field public static AppId:Ljava/lang/String;

.field public static AppKey:[B

.field public static ChannelID:Ljava/lang/String;

.field public static Orientation:I

.field public static PlatformType:Ljava/lang/String;

.field public static TAG:Ljava/lang/String;

.field public static ToolBarInfoUrl:Ljava/lang/String;

.field public static ToolBarKefuUrl:Ljava/lang/String;

.field public static ToolBarMallUrl:Ljava/lang/String;

.field public static ToolBarRaidersUrl:Ljava/lang/String;

.field public static ToolBarShowItemsUrl:Ljava/lang/String;

.field public static ToolClauseUrl:Ljava/lang/String;

.field private static UserCenter:Ljava/lang/String;

.field public static isHideGuest:Z

.field private static mArea:Ljava/lang/String;

.field public static sLanguage:Ljava/lang/String;

.field public static sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

.field public static tool_bar_auto_show:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 4
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->mArea:Ljava/lang/String;

    .line 32
    const-string v0, "http://l.ucenter.ppgame.com"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    .line 87
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppId:Ljava/lang/String;

    .line 88
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->AppKey:[B

    .line 89
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->PlatformType:Ljava/lang/String;

    .line 90
    sput-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->ChannelID:Ljava/lang/String;

    .line 92
    new-instance v0, Lcom/digital/cloud/usercenter/UserInfo;

    invoke-direct {v0}, Lcom/digital/cloud/usercenter/UserInfo;-><init>()V

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->sUserInfo:Lcom/digital/cloud/usercenter/UserInfo;

    .line 94
    sput v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->Orientation:I

    .line 96
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->sLanguage:Ljava/lang/String;

    .line 100
    const-string v0, "http://res.ppgame.com/xy/usercenter_tool_bar_config_20150521001"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarShowItemsUrl:Ljava/lang/String;

    .line 102
    const-string v0, "http://new.ucsystem.ppgame.com/user"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarInfoUrl:Ljava/lang/String;

    .line 104
    const-string v0, "http://new.ucsystem.ppgame.com/kefu"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarKefuUrl:Ljava/lang/String;

    .line 106
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarRaidersUrl:Ljava/lang/String;

    .line 108
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarMallUrl:Ljava/lang/String;

    .line 110
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolClauseUrl:Ljava/lang/String;

    .line 112
    const-string v0, "NDK_INFO_USERCENTER"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->TAG:Ljava/lang/String;

    .line 115
    const-string v0, ""

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->APPIdentifying:Ljava/lang/String;

    .line 118
    sput-boolean v2, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    .line 119
    const/4 v0, 0x1

    sput-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->tool_bar_auto_show:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static UserCenterAuthUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 52
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/auth"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterDevIdLoginUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 40
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/devid_login"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterEmailBindUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/email_bind"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterEmailRegisterUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 76
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/email_register"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterEmailResetUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 80
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/req_send_pwd_reset_email"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterGetDevIdUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 36
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/gen_devid"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterIdentifyExistUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/identify_exist"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterNormalLoginUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 48
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/normal_login"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterTelphoneBindUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/telphone_bind"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterTelphonePwdResetisterUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 68
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/telphone_pwd_reset"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterTelphoneRegisterUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 64
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/telphone_register"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterTelphoneVcodeUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 60
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/req_telphone_vcode"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static UserCenterUsernameRegisterUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 44
    new-instance v0, Ljava/lang/StringBuilder;

    sget-object v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "/username_register"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static handleConfig(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 123
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 167
    :cond_0
    :goto_0
    return v0

    .line 125
    :cond_1
    const-string v2, "enable_tehphone_tab"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 126
    const-string v2, "true"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 127
    invoke-static {v0, v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->QuickRegisterPageConfig(ZZ)V

    goto :goto_0

    .line 129
    :cond_2
    invoke-static {v1, v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->QuickRegisterPageConfig(ZZ)V

    goto :goto_0

    .line 132
    :cond_3
    const-string v2, "enable_email_tab"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 133
    const-string v2, "true"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 134
    invoke-static {v0, v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->QuickRegisterPageConfig(ZZ)V

    goto :goto_0

    .line 136
    :cond_4
    invoke-static {v0, v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->QuickRegisterPageConfig(ZZ)V

    goto :goto_0

    .line 139
    :cond_5
    const-string v2, "enable_clause"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 140
    const-string v2, "true"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 141
    invoke-static {v0}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setClause(Z)V

    goto :goto_0

    .line 143
    :cond_6
    invoke-static {v1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setClause(Z)V

    goto :goto_0

    .line 146
    :cond_7
    const-string v2, "set_clause_url"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 147
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolClauseUrl:Ljava/lang/String;

    goto :goto_0

    .line 150
    :cond_8
    const-string v2, "hide_guest"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 151
    const-string v2, "true"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 152
    sput-boolean v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    goto :goto_0

    .line 154
    :cond_9
    sput-boolean v1, Lcom/digital/cloud/usercenter/UserCenterConfig;->isHideGuest:Z

    goto :goto_0

    .line 156
    :cond_a
    const-string v2, "set_language"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 157
    invoke-static {p1}, Lcom/digital/cloud/usercenter/UserCenterActivity;->setLanguage(Ljava/lang/String;)V

    goto :goto_0

    .line 159
    :cond_b
    const-string v2, "set_login_url"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 160
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    goto :goto_0

    .line 162
    :cond_c
    const-string v2, "set_kefu_url"

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_d

    .line 163
    sput-object p1, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarKefuUrl:Ljava/lang/String;

    goto/16 :goto_0

    :cond_d
    move v0, v1

    .line 167
    goto/16 :goto_0
.end method

.method public static setArea(Ljava/lang/String;)V
    .locals 2
    .param p0, "area"    # Ljava/lang/String;

    .prologue
    .line 7
    sput-object p0, Lcom/digital/cloud/usercenter/UserCenterConfig;->mArea:Ljava/lang/String;

    .line 8
    sget-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->mArea:Ljava/lang/String;

    const-string v1, "oversea"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 16
    const-string v0, "https://plat-all-oversea-all-login-0001.ppgame.com"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    .line 17
    const-string v0, "https://plat-all-oversea-all-res-0001.ppgame.com/get_fs/usercenter_tool_bar_config_20150521001"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarShowItemsUrl:Ljava/lang/String;

    .line 19
    const-string v0, "https://plat-all-oversea-all-ucsystem-0001.ppgame.com/user"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarInfoUrl:Ljava/lang/String;

    .line 20
    const-string v0, "https://plat-all-oversea-all-ucsystem-0001.ppgame.com/kefu"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->ToolBarKefuUrl:Ljava/lang/String;

    .line 22
    :cond_0
    return-void
.end method

.method public static setUserCenter(Ljava/lang/String;)V
    .locals 1
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    .line 26
    const-string v0, "gf"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 27
    const-string v0, "http://gf.ucenter.ppgame.com"

    sput-object v0, Lcom/digital/cloud/usercenter/UserCenterConfig;->UserCenter:Ljava/lang/String;

    .line 29
    :cond_0
    return-void
.end method
