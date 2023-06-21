

PackageDownload = 
{
    
}

function PackageDownload.Start()
    PackageDownload.memberVars = {}
    PackageDownload._asset_loader = systems_func.loader_create("PackageDownload_loader")
    PackageDownload._asset_loader:set_callback("PackageDownload.AssetLoaded");
    PackageDownload._asset_loader:load("assetbundles/prefabs/ui/loading/resourceload.assetbundle");
    PackageDownload._asset_loader = nil;
end

function PackageDownload.End()
    PackageDownload.memberVars = {}
end

function PackageDownload.AssetLoaded(pid, fpath, asset_obj, error_info)
    PackageDownload.memberVars.ui = asset_game_object.create(asset_obj)
    Root.SetRootUI(PackageDownload.memberVars.ui)

    PackageDownload.memberVars.ui:set_name('packge_download')

    PackageDownload.memberVars.ui:set_parent(Root.get_root_ui_2d());
    PackageDownload.memberVars.progressBar = ngui.find_progress_bar(PackageDownload.memberVars.ui,"progress_bar")
    PackageDownload.memberVars.progressText = ngui.find_label(PackageDownload.memberVars.ui,"progress_font_label")
    
    PackageDownload.SetProgress(1)
    PackageDownload.memberVars.progressText:set_text("")
end

function PackageDownload.SetProgress(value)

    if PackageDownload.memberVars.progressBar == nil then
        return
    end

    if value < 0 then
        value = 0
    elseif value > 1 then
        value = 1
    end
    PackageDownload.memberVars.progressBar:set_value(value)
end

function PackageDownload.ToShowUnit(value, deci)
    local speedUnit = 'B'
    local unitScale = 1024
    if value > unitScale then
        speedUnit = 'KB'
        value = value / unitScale
    end
    if value > unitScale then
        speedUnit = 'M'
        value = value / unitScale
    end
    --return tostring(value) .. speedUnit
    local retStr
    if deci == true then
        retStr = string.format("%.2f%s", value, speedUnit)
    else
        retStr = string.format("%d%s", value, speedUnit)
    end
    return retStr
end

function PackageDownload.SetTipInfo(downloadSize, totalSize, speed)

    if PackageDownload.memberVars.progressText == nil then
        return
    end

    local hasDown = PackageDownload.ToShowUnit(downloadSize, true)
    local totalDown = PackageDownload.ToShowUnit(totalSize, true)
    --local sp = PackageDownload.ToShowUnit(speed)
    --app.log(' ' .. value .. ' ' .. speedUnit)
    PackageDownload.memberVars.progressText:set_text(string.format("正在下载安装包 %s/%s", hasDown, totalDown))
end