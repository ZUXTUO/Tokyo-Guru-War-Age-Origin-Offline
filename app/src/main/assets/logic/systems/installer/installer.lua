

function OnInstallerAndroidMsg(param)
    SystemHintUI.SetAndShow(ESystemHintUIType.one, '安装失败' ,
    {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'}) -- btn 1
end

SystemHintUI.Instance()

Installer = 
{
    apkName = "game.apk",
    downloadInfo = "game.apk.download",
    updateConfigName = "apkUpdateConfig.json",

    InstallerHasStarted = false,
    retryCount = 0,
}

function Installer.UpdatePackage()

    if Installer.InstallerHasStarted == true then
        return
    end

    Installer.InstallerHasStarted = true
    if app.get_internet_reach_ability() == 0 then -- 没有网络
        SystemHintUI.SetAndShow(ESystemHintUIType.one, '没有网络，请检查网络',
        {func = Utility.create_callback(Installer.CloseGame, Installer), str = '确定'})
    elseif app.get_internet_reach_ability() == 1 then --运营商网络，提示用户
        SystemHintUI.SetAndShow(ESystemHintUIType.two, '当前使用的是运营商网络，会产生流量',
        {func = Utility.create_callback(Installer.CheckUpdateUseHasGetConfig, Installer), str = "继续"}
        , {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'})
    elseif app.get_internet_reach_ability() == 2 then -- wifi
        Installer.CheckUpdateUseHasGetConfig()
    end
end

function Installer.CheckUpdateUseHasGetConfig()
    local list = systems_data.get_new_apk_url_list()

--    for k,v


    Installer.StartCheckAndDownloadApk(pjson.encode(list))
end

function Installer.CloseGame()
    app.log('Installer.CloseGame')
    --[[清理掉开始背景]]
    login_bg.Destroy();

    util.quit()
end

function Installer.IsDownloading()
    return file.exist(Installer.apkName)
end

function Installer.DeleteCacheUpdateFile()
    if file.exist(Installer.apkName) then
        file.delete(Installer.apkName)
    end

    if file.exist(Installer.updateConfigName) then
        file.delete(Installer.updateConfigName)
    end

    if file.exist(Installer.downloadInfo) then
        file.delete(Installer.downloadInfo)
    end
end

function Installer.StartCheckAndDownloadApk( content)
    app.log('update config = ' .. tostring(content));
    --content = '{"md5":"ED380110DE91AA628062867BBF906A3C","url":"http://192.168.81.66:8080/gm_ghoul/apk/game.apk"}'
    local updateConfig =  pjson.decode(content)
    if updateConfig.url[1] ~= nil then
        local myPN = util.get_package_name()
        local mySignHash = util.get_signature_hash_code()
        local versionCode = util.get_version_code()
        -- 关闭packageName和签名的检测
        if (updateConfig.packageName == myPN
            and updateConfig.signatureHashCode == mySignHash) or true
            then
            if file.exist(Installer.updateConfigName) then
                local useLatest = false
                local fileHandler = file.open(Installer.updateConfigName,4);
                if fileHandler then
                    local lastJson = fileHandler:read_string()
                    local latestUpConfig =  pjson.decode(content)
                    if latestUpConfig.md5 == updateConfig.md5 then
                        useLatest = true
                    end
                    fileHandler:close()
                    file.delete(Installer.updateConfigName)
                end

                if not useLatest then
                    Installer.DeleteCacheUpdateFile()
                end
            else
                Installer.DeleteCacheUpdateFile()
            end

            local fileHandler = file.open(Installer.updateConfigName,4);
            if fileHandler then
                fileHandler:write_string(content)
                fileHandler:close()
            else
                app.log('installer write config error')
            end

            Installer.updateConfig = updateConfig
            Installer.StartDownLoadApk(updateConfig.url[1])
        else
            SystemHintUI.SetAndShow(ESystemHintUIType.one, '包名或者签名不一致' ,
            {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'})
        end
    else
        app.log("update apk config eror")
    end
end

function Installer.StartDownLoadApk(url, retry)
    local path = util.get_write_dir(Installer.apkName)
--    local md5
--    if file.exist(Installer.apkName) then
--        md5 = util.get_file_md5(path)
--    end
--    if md5 == Installer.updateConfig.md5 then
--        Installer.DownloadResult(EDOWNLOADRESULT.EDR_SUCCESS, path)
--    else
        app.log('start download apk')
        util.download_file(url, path, "Installer.ProgressCallback", "Installer.DownloadResult")
        Installer.isDowning = true
        if retry ~= true then
            PackageDownload.Start();
        end
--    end
end

function Installer.ProgressCallback(downloadSize, totalSize, speed)
    if totalSize > 0 and downloadSize >= 0 then
        PackageDownload.SetProgress(downloadSize/totalSize)
        PackageDownload.SetTipInfo(downloadSize, totalSize, speed)
    end
    --app.log('xx ' .. tostring(progress))
end

function Installer.DownloadResult(retCode, content)
    Installer.isDowning = false
    app.log('Installer.DownloadResult')
    if retCode == EDOWNLOADRESULT.EDR_SUCCESS then
        local md5 = util.get_file_md5(content)
        app.log("Install MD5="..tostring(md5));
        if md5 == Installer.updateConfig.md5 then
            util.android_log('begin install')
            Root.push_web_info("installer","begin");

            --[[清除动态更新文件]]
            Root.clear_doc();

            local result = util.start_installer(content)
            if result ~= InstallerReturnCode.RC_INSTALLING then
                Root.push_web_info("installer","no");
                SystemHintUI.SetAndShow(ESystemHintUIType.one, '安装失败:' .. tostring(InstallerReturnCode2Str[result]) ,
                {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'})
            else
                Root.push_web_info("installer","yes");
            end
        else
            Root.push_web_info("installer","md5 check failed");
            util.android_log('md5 check failed')
            Installer.DeleteCacheUpdateFile()
            SystemHintUI.SetAndShow(ESystemHintUIType.two,  '安装包校验失败,重新下载' ,
            {func = Utility.create_callback(Installer.CheckUpdateUseHasGetConfig, Installer), str = '重新下载'},
            {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'})
        end
    else
        Root.push_web_info("installer","down failed");
        if Installer.retryCount > 3 then
            Installer.retryCount = 0
            SystemHintUI.SetAndShow(ESystemHintUIType.two, tostring(DownloadReturnCode2Str[retCode]) ,
                {func = Utility.create_callback(Installer.ReTryDownload, Installer), str = '重试'},
                {func = Utility.create_callback(Installer.CloseGame, Installer), str = '退出'})
        else
            Installer.ReTryDownload()
        end
    end
end

function Installer.ReTryDownload()
    if Installer.isDowning == true then
        return
    end
    Installer.retryCount = Installer.retryCount + 1
    Installer.StartDownLoadApk(Installer.updateConfig.url[1], true)
end
