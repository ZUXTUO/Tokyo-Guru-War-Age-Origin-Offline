
InstallerReturnCode = 
{
    RC_INSTALLING				        = 1;	--正在安装
    RC_PATH_ERROR				        = 2;	--路径错误
    RC_FILE_NOT_EXIST   			    = 3;	--文件不存在
    RC_READ_MY_INFO_FAILED          	= 4;	--读取自己包信息错误
    RC_READ_APK_INFO_FAILED         	= 5;	--读取apk包信息错误
    RC_PACKAGE_NAME_NOT_EQUAL       	= 6;	--包名不一致
    RC_APK_VERSION_TOO_LOW	            = 7;	--apk版本号过低
    RC_VERSION_EQUAL			        = 8;	--版本号相同
    RC_SIGNATURE_DIFFER		            = 9;	--签名不相同
    RC_INSTALL_FAILED			        = 10;	--安装失败
}

InstallerReturnCode2Str = 
{
    [InstallerReturnCode.RC_INSTALLING]             = '正在安装',
    [InstallerReturnCode.RC_PATH_ERROR]             = '路径错误',
    [InstallerReturnCode.RC_FILE_NOT_EXIST]         = '文件不存在',
    [InstallerReturnCode.RC_READ_MY_INFO_FAILED]    = '读取自己包信息错误',
    [InstallerReturnCode.RC_READ_APK_INFO_FAILED]   = '读取apk包信息错误',
    [InstallerReturnCode.RC_PACKAGE_NAME_NOT_EQUAL] = '包名不一致',
    [InstallerReturnCode.RC_APK_VERSION_TOO_LOW]    = 'apk版本号过低',
    [InstallerReturnCode.RC_VERSION_EQUAL]          = '版本号相同',
    [InstallerReturnCode.RC_SIGNATURE_DIFFER]       = '签名不相同',
    [InstallerReturnCode.RC_INSTALL_FAILED]         = '安装失败',
}

DownloadReturnCode = 
{
    EDR_FAILED = -1,
    EDR_SUCCESS = 0,
    EDR_DOWNLOADING = 1,
    EDR_Down = 2, 
    EDR_TIMEOUT = 3,
    EDR_SPACENOTENOUGH = 4,
    EDR_CREATEREQUESTEXCEPTION = 5,
}

DownloadReturnCode2Str =
{
    [DownloadReturnCode.EDR_FAILED] = '下载失败:-1',
    [DownloadReturnCode.EDR_SUCCESS] = '下载成功',
    [DownloadReturnCode.EDR_DOWNLOADING] = '正在下载',
    [DownloadReturnCode.EDR_Down] = '下载失败:2',
    [DownloadReturnCode.EDR_TIMEOUT] = '下载超时',
    [DownloadReturnCode.EDR_SPACENOTENOUGH] = '手机空间不足',
    [DownloadReturnCode.EDR_CREATEREQUESTEXCEPTION] = '下载失败:5',
}