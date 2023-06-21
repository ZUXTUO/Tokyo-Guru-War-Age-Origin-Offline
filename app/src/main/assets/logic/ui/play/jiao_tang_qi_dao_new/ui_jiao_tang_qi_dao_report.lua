UiJiaoTangQiDaoReport = Class('UiJiaoTangQiDaoReport', UiBaseClass);
--初始化
function UiJiaoTangQiDaoReport:Init()
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1605_church_guaji.assetbundle';
    UiBaseClass.Init(self)
end

--重新开始
function UiJiaoTangQiDaoReport:Restart()
    UiBaseClass.Restart(self)
end

--初始化数据
function UiJiaoTangQiDaoReport:InitData()
    UiBaseClass.InitData(self)
    self.lab_time = {};
    self.lab_describe = {};
end

--析构函数
function UiJiaoTangQiDaoReport:DestroyUi()
    UiBaseClass.DestroyUi(self)
    self.show_report_info = nil;
    self.lab_time = {};
    self.lab_describe = {};
end

--显示ui
function UiJiaoTangQiDaoReport:Show()
    UiBaseClass.Show(self)
end

--隐藏ui
function UiJiaoTangQiDaoReport:Hide()
    UiBaseClass.Hide(self)
end

--注册回调函数
function UiJiaoTangQiDaoReport:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['UpdateFightReport'] = Utility.bind_callback(self, self.UpdateFightReport);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close);
end

function UiJiaoTangQiDaoReport:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_update_church_fight_record,self.bindfunc['UpdateFightReport']);
end

function UiJiaoTangQiDaoReport:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_update_church_fight_record,self.bindfunc['UpdateFightReport']);
end

--初始化UI
function UiJiaoTangQiDaoReport:LoadUI()
    UiBaseClass.LoadUI(self);
end

--寻找ngui对象
function UiJiaoTangQiDaoReport:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(1,1,1);
    self.ui:set_name('ui_jiao_tang_qi_dao_report');

    --do return end
    -----------------
    self.scroll_view = ngui.find_scroll_view(self.ui, "centre_other/animation/scroll_view/panel_list");
    self.wrap_content = ngui.find_wrap_content(self.ui, "centre_other/animation/scroll_view/panel_list/wrap_content");
    self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
    self.btn_close = ngui.find_button(self.ui, "centre_other/animation/sp_di/btn_cha");
    self.btn_close:set_on_click(self.bindfunc['on_btn_close']);
    
    self:UpdateUi();
end

function UiJiaoTangQiDaoReport:UpdateUi()
    UiBaseClass.UpdateUi(self);
    if not self.ui then
        return
    end

    local fight_report_info = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetFightReport();
    local cnt = 0;
    self.show_report_info = {};
    self.item_count = {};  --道具个数
    for k,v in pairs(fight_report_info) do
        local item_cnt = 0;
        for item_k,item_id in pairs(v.itemID) do
            item_cnt = item_cnt + 1;
        end
        if item_cnt ~= 0 then
            cnt = cnt + 1;
            --self.item_count[cnt] = item_cnt;
            self.show_report_info[cnt] = {};
            self.show_report_info[cnt].info = v;
            self.show_report_info[cnt].num = item_cnt;   --该次奖励一共有几个道具
            --self.show_report_info[cnt] = v;
        end
    end

    table.sort(self.show_report_info,function(a,b) return tonumber(a.g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].happenTime) > tonumber(b.g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].happenTime) end);
    self.cnt = cnt;
    self.wrap_content:set_min_index(-cnt + 1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

function UiJiaoTangQiDaoReport:UpdateFightReport(ntype, FightRecordData)
    self:UpdateUi();
end

function UiJiaoTangQiDaoReport:init_item_wrap_content(obj,b,real_id)
    local index = math.abs(real_id)+1;
    if not self.show_report_info then
        return
    end
    --app.log("index=="..index);
    -- if index > self.cnt then
    --     obj:set_active(false);
    --     return
    -- end
    if not self.lab_time[b] then
        self.lab_time[b] = ngui.find_label(obj, "lab_time");
    end
    if not self.lab_describe[b] then
        self.lab_describe[b] = ngui.find_label(obj, "lab_wrod");
    end

    local player_name = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].szEnemyPlayerName;  --玩家名字
    local rewardType = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].rewardType;          --奖励类型0时间到了1被打下来2自己领取
    local bBoss = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].bBoss;                    --是否是主教位置
    local churchStar = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].churchStar;          --教堂星级
    local time = tonumber(self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].happenTime);                --战斗发生的时间
    local itemID = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].itemID;                  --奖励物品
    local itemCnt = self.show_report_info[index].g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].itemCnt;                --奖励个数

    local item_id = {};
    local cnt = 0;
    local str_item = "";
    for k,v in pairs(itemID) do
        cnt = cnt + 1;
        item_id[cnt] = v;
        local item_name = ConfigManager.Get(EConfigIndex.t_item,v).name;
        local item_cnt = itemCnt[k];
        if cnt == self.show_report_info[index].num then
            str_item = str_item.."[00FF00]"..item_name.."x"..item_cnt.."[-]";
        else
            str_item = str_item.."[00FF00]"..item_name.."x"..item_cnt.."[-]、";
        end
    end

    local year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(tonumber(time));
    self.lab_time[b]:set_text(tostring(year).."-"..tostring(month).."-"..tostring(day));

    if rewardType == 1 then
        -- app.log("tonumber(churchStar), str_item, tostring(player_name)==="..table.tostring({tonumber(churchStar), str_item, tostring(player_name)}));
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_19"), tonumber(churchStar), str_item, tostring(player_name), tonumber(churchStar));
        self.lab_describe[b]:set_text(strs);
    else
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_20"), tonumber(churchStar), str_item);
        self.lab_describe[b]:set_text(strs);
    end
    
end

function UiJiaoTangQiDaoReport:on_btn_close()
    uiManager:PopUi();
end
