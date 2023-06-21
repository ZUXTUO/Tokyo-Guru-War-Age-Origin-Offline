FightShowRole = Class("FightShowRole");
------------------------外部接口-----------------------------
---new的时候传入
--{
--  obj=xxx         显示根窗口
--  info=xxx        显示数据 可以不传后面设置
--  isLeader=false   是否显示队长 可以不传 默认不显示
--  isBottom=false   是否显示突破以及内丹相关  可以不传 默认不显示
--  txtLock = ""      锁的内容
--  isPicture=false  是否为图片模式仅显示一张背景图 可以不传 默认不显示
--  isChange=false  是否有更换按钮 默认没有
--}


local showRoleBk = 
{
    "assetbundles/prefabs/ui/image/icon/head_pic/300_120/waikuang_dd_d1.assetbundle",
    "assetbundles/prefabs/ui/image/icon/head_pic/300_120/waikuang_dd_d2.assetbundle",
    "assetbundles/prefabs/ui/image/icon/head_pic/300_120/waikuang_dd_d3.assetbundle",
    "assetbundles/prefabs/ui/image/icon/head_pic/300_120/waikuang_dd_d4.assetbundle",
    "assetbundles/prefabs/ui/image/icon/head_pic/300_120/waikuang_dd_d5.assetbundle",
}

--锁定窗口显示以及文字
function FightShowRole:SetLock(isShow, text)
    self.control.objLock:set_active(isShow);
    self.control.labLock:set_active(tostring(text));
end
--升级的动画
function FightShowRole:SetLevelUpAnimation(isShow)
    local list = self.control.listShow;
    list.objAnimLevelUp:set_active(isShow);
end
--设置数据并刷新
function FightShowRole:SetInfo(info, notRef)
    self.info = info;
    if notRef == nil then
        self:UpdateUi();
    end
end

function FightShowRole:GetInfo()
    return self.info
end
--设置点击添加按钮的回调
function FightShowRole:SetOnClickAddButton(callback)
    if callback == nil or type(_G[callback]) ~= 'function' then 
        return
    end
    self._addBtnCallback = callback
end
--设置点击更换按钮的回调
function FightShowRole:SetOnClickChangeButton(callback)
    if callback == nil or type(_G[callback]) ~= 'function' then 
        return
    end
    self._changeBtnCallback = callback
end
--设置点击人物的回调
function FightShowRole:SetOnClickButton(callback)
    if callback == nil or type(_G[callback]) ~= 'function' then 
        return
    end
    self._clickBtnCallback = callback
end
--设置参数
function FightShowRole:SetParam(param)
    self._param = param
end
--是否显示更换按钮
function FightShowRole:SetChangeBtnShow(isShow)
    if self.control.btnChange then
        self.control.btnChange:set_active(isShow);
    end
end


--------------------------内部接口--------------------------------
--传入obj 以及 cardhuman
function FightShowRole:Init(data)
    self:InitData(data);
    self:InitUi();
end

function FightShowRole:InitData(data)
    self.obj = data.obj;
    self.info = data.info;
    self.isLeader = data.isLeader;
    self.isBottom = data.isBottom;
    self.isPicture = data.isPicture;
    self.txtLock = data.txtLock;
    self.isChange = data.isChange;
    self.bindfunc = {}

    self:registFunc()
end

function FightShowRole:registFunc()
    self.bindfunc["OnClickAddBtn"] = Utility.bind_callback(self, FightShowRole.OnClickAddBtn)
    self.bindfunc["OnClickChangeBtn"] = Utility.bind_callback(self, FightShowRole.OnClickChangeBtn)
    self.bindfunc["on_click"] = Utility.bind_callback(self, FightShowRole.on_click)
end

function FightShowRole:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end


function FightShowRole:InitUi()

    if self.obj == nil then
        return
    end

    self.control = {};
    self.control.spLeader = ngui.find_sprite(self.obj, "sp_leader");
    --显示
    self.control.objShow = self.obj:get_child_by_name("sp_bk1");
    self.control.btnShow = ngui.find_button(self.obj, "sp_bk1");
    self.control.btnShow:set_on_click(self.bindfunc["on_click"]);
    self.control.textShow = ngui.find_texture(self.obj, "sp_bk1");
    self.control.spAptitude = ngui.find_sprite(self.obj, "sp_grade");
    self.control.listShow = {};
    local list = self.control.listShow;
    list.spHuman = ngui.find_texture(self.obj, "text_human");
    --list.spRestraintBk = ngui.find_sprite(self.control.objShow, "sp_nature");
    --list.spRestraint = ngui.find_sprite(self.control.objShow, "sp_nature/sp");
    list.labName = ngui.find_label(self.control.objShow, "lab_name");
    list.spMark = ngui.find_sprite(self.control.objShow, "sp_mark")
    list.labLevel = ngui.find_label(self.control.objShow, "lab_level");
    local num = ngui.find_label(self.control.objShow,"txt");
    num:set_text("战力");
    list.labHp = ngui.find_label(self.control.objShow, "lab_num");
    --升级动画
    local obj = self.control.objShow:get_child_by_name("animation");
    list.objAnimLevelUp = ngui.find_sprite(obj,"sp");
    if list.objAnimLevelUp then
        list.objAnimLevelUp:set_active(false);
    end
    list.spStar = {};
    for i = 1, 5 do
        list.spStar[i] = ngui.find_sprite(self.control.objShow, "star_di"..i.."/sp_star");
    end
    --内丹、突破界限
    -- list.objBottom = self.obj:get_child_by_name("sp_bk3");
    -- list.objNeidan = list.objBottom:get_child_by_name("content2");
    -- list.objBreakthrough = list.objBottom:get_child_by_name("content1");
    -- list.labNeidan = ngui.find_label(list.objNeidan, "lab_num");
    -- list.labBreakthrough = ngui.find_label(list.objBreakthrough, "txt_num");
    
    
    --添加
    self.control.objAdd = self.obj:get_child_by_name("sp_bk2");
    self.control.btnAdd = ngui.find_button(self.control.objAdd, self.control.objAdd:get_name());
    self.control.btnAdd:set_on_click(self.bindfunc["OnClickAddBtn"]);
    self.control.btnChange = ngui.find_button(self.obj, 'btn_change');
    if self.control.btnChange ~= nil then
        self.control.btnChange:set_on_click(self.bindfunc["OnClickChangeBtn"])    
    end
    --锁定
    self.control.objLock = self.obj:get_child_by_name("sp_lock");
    self.control.labLock = ngui.find_label(self.control.objLock, "lab");
    --更新
    self:UpdateUi();
end

function FightShowRole:OnClickAddBtn(param)
    if self._addBtnCallback ~= nil and type(_G[self._addBtnCallback]) == 'function' then 
        _G[self._addBtnCallback](self._param)
    end
end

function FightShowRole:OnClickChangeBtn(param)
    if self._changeBtnCallback ~= nil and type(_G[self._changeBtnCallback]) == 'function' then 
        _G[self._changeBtnCallback](self._param)
    end
end

function FightShowRole:on_click(param)
    if self._clickBtnCallback ~= nil and type(_G[self._clickBtnCallback]) == 'function' then 
        _G[self._clickBtnCallback](self._param);
    end
end

function FightShowRole:UpdateUi()
    local list = self.control.listShow;
    if self.obj == nil or self.info == nil then
        self.control.spLeader:set_active(false);
        self.control.objShow:set_active(false);
        self.control.objAdd:set_active(false);
        --list.objBottom:set_active(false);
        self.control.objLock:set_active(false);
        return;
    end
    self.control.objShow:set_active(true);
    self.control.objAdd:set_active(false);
    self.control.objShow:set_active(true);
    --显示背景
    if showRoleBk[self.info.rarity] then
        self.control.textShow:set_texture(showRoleBk[self.info.rarity]);
    end
    PublicFunc.SetAptitudeSprite(self.control.spAptitude,self.info.config.aptitude);
    --图片
    list.spHuman:set_texture( self.info.config.icon300);
    if self.isPicture then
        self.control.spLeader:set_active(false);
        --list.objBottom:set_active(false);
        self.control.objLock:set_active(false);
        --list.spRestraintBk:set_active(false);
        list.labName:set_text("");
        list.spMark:set_active(false);
        if self.control.btnChange then
            self.control.btnChange:set_active(false);
        end
    else
        --list.spRestraintBk:set_active(true);
        list.spMark:set_active(true);
        --队长
        if self.isLeader then
            self.control.spLeader:set_active(true);
        else
            self.control.spLeader:set_active(false);
        end
        --克制属性
        --PublicFunc.SetRestraintSprite(list.spRestraint, self.info.restraint);
        --PublicFunc.SetRestraintSpriteBk(list.spRestraintBk, self.info.restraint);
        --名字、等级、生命、星数
        list.labName:set_text(tostring(self.info.name));
        list.labLevel:set_text(tostring(self.info.level));
        list.labHp:set_text(tostring(self.info:GetFightValue()));
        for i = 1, 5 do
            if i <= self.info.rarity then
                list.spStar[i]:set_active(true);
            else
                list.spStar[i]:set_active(false);
            end
        end
        -- --内丹、突破界限
        -- if self.isBottom then
        --     list.objBottom:set_active(true);
        --     list.labNeidan:set_text("Lv."..tostring(self.info.neidan_level));
        -- else
        --     list.objBottom:set_active(false);
        -- end
        --是否加锁
        if self.txtLock then
            self.control.objLock:set_active(true);
        else
            self.control.objLock:set_active(false);
        end
        --更换按钮
        if self.control.btnChange then
            if self.isChange then
                self.control.btnChange:set_active(true);
            else
                self.control.btnChange:set_active(false);
            end
        end
    end
end

function FightShowRole:Destroy()
    self.obj = nil;
    self.info = nil;
    self.isLeader = nil;
    if self.control.listShow.spHuman then
        self.control.listShow.spHuman:Destroy();
        self.control.listShow.spHuman = nil;
    end
    if self.control.textShow then
        self.control.textShow:Destroy();
        self.control.textShow = nil;
    end
    self.control = nil;

    self:unregistFunc()
    self.bindfunc = {}
end
