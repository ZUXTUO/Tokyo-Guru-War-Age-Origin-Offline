PropertyListShow = Class("PropertyListShow")
--[[
    data = {
        pros = {},--需要显示的属性列表 table
        pro_item = nil,--被克隆行      userdata
        pro_grid = nil,--Grid组件,刷新排版      userdata        
    }
]]


function PropertyListShow:Init(data)
    -- 需要展示的属性
    self.pros = data.pros or CardHuman.GetDefaultSHowPropertyNames()
    -- {
    --     "max_hp",-- 当前生命值
    --     "atk_power",-- 攻击力
    --     "normal_attack_1",-- 普工1
    --     "normal_attack_2",-- 普工2
    --     "normal_attack_3",-- 普工3
    --     "crit_rate",-- 暴击率
    --     "def_power",-- 防御力
    --     "anti_crite",-- 免爆率
    --     "crit_hurt",-- 暴击伤害加成
    --     "broken_rate",-- 破击率
    --     "parry_rate",-- 格挡率
    --     "parry_plus",-- 格挡伤害加成
    --     "move_speed",-- 移动速度
    -- }
    self.props_info = data.info or nil
    -- 被克隆的行对象
    self.pro_item = data.pro_item;
    -- 用于刷新排版
    self.pro_grid = data.pro_grid or nil
    --
    self.format_type = data.format_type or 0
    -- 每生成一个回调
    self.per_func = data.per_func or nil
    -- 所有的生成完的回调
    self.all_func = data.all_func or nil
    --
    self.temp_gos = { }

    self:InitProRows()
end


function PropertyListShow.Value2ShowForamt(id,value)
    local eValueType = ENUM.EAttributeValueType[id]
    local str = tostring(value)
    if  eValueType then
        if eValueType == 1 then
            str = tostring(PublicFunc.AttrInteger(value))
        elseif eValueType == 2 then
            str = tostring(PublicFunc.Round(value,2))
        elseif eValueType == 3 then
            str = tostring(PublicFunc.Round(value,2)).."%"
        end    
    end
    return str
end

function PropertyListShow:GetFormatTypeStr(number_value)
    if not number_value  then
        return ""
    end

    local tformat_funcs = { 
        [1] = function()
            return string.format("[00ff84]+%s[-]",string.format("%.0f",number_value))
        end
    }
    --app.log(string.format("format_type=%s,fomat_value=%s",tostring(self.format_type),string.format("%.0f",number_value)))
    local func = tformat_funcs[self.format_type]
    if func then        
        return func()
    else
         return tostring(number_value)
    end    
   
end

-- 默认生成需要的行数
function PropertyListShow:InitProRows(pros)
    if pros then
        self.pros = pros
    end
    if not self.pro_item then
         app.log("not found pro_item")
         return
    end

    if self.pros and self.pro_item and #self.temp_gos < #self.pros then
        self.pro_item:set_active(false)
        for k, v in spairs(self.pros) do
            --app.log("#dddd#  "..tostring(k).."  "..tostring(v))
            local new_item = self.temp_gos[v]
            if nil == new_item then
                new_item = self.pro_item:clone();
                if new_item then
                    self.temp_gos[v] = new_item
                    new_item:set_name(v)
                end
            end
            if new_item then
                local _p_number = ENUM.EHeroAttribute[v]          
                local t = { p_name = v, p_number = _p_number, p_type = ENUM.EAttributeValueType[_p_number], p_str_name = gs_string_property_name[_p_number] }
                if self.per_func then                             
                    self.per_func(new_item, t)
                else   
                    local tpro =  t
                    if tpro then
                        local lbl_p_name = ngui.find_label(new_item, "txt")
                        local lbl_p_value = ngui.find_label(new_item, "lab")
                        local p_name = nil
                        local p_value = nil
                        --app.log("xxxxxxxxxx:" .. table.tostring(tpro))
                        if tpro.p_name == "normal_attack_1" then
                            -- 特殊处理三段普通攻击
                            if self.props_info["normal_attack_1"] and self.props_info["normal_attack_2"] and self.props_info["normal_attack_3"] and self.props_info["normal_attack_4"] and self.props_info["normal_attack_5"] then
                                p_value = self.props_info["normal_attack_1"] .. "/" .. self.props_info["normal_attack_2"] .. "/" .. self.props_info["normal_attack_3"].. "/" .. self.props_info["normal_attack_4"].. "/" .. self.props_info["normal_attack_5"]
                                p_name = "普通攻击5段"
                            end
                        end

                        if tpro.p_name ~= "normal_attack_1" and tpro.p_name ~= "normal_attack_2" and tpro.p_name ~= "normal_attack_3" and tpro.p_name ~= "normal_attack_4" and tpro.p_name ~= "normal_attack_5" then
                            p_name = tpro.p_str_name
                            p_value = self.props_info[tpro.p_name]
                        end
                        if p_name and p_value then
                            lbl_p_name:set_text(p_name)
                            lbl_p_value:set_text(self:GetFormatTypeStr(PropertyListShow.Value2ShowForamt(_p_number,p_value)))
                            new_item:set_active(true)
                            --app.log("set value name="..tostring(p_name).." p_value="..tostring(p_value))
                        else
                            new_item:set_active(false)
                        end
                    end
                end
            end
        end
    end
    if self.pro_grid then
        self.pro_grid:reposition_now()
    end
	if self.all_func then
		self.all_func()
	end
end

function PropertyListShow:UpdateUi(props)
   self.props_info = props
   --app.log("PropertyListShow:UpdateUi:"..table.tostring(self.props_info))
   self:InitProRows()
end


function PropertyListShow:Destroy()
    self.pro_item = nil
    -- 用于刷新排
    self.pro_grid = nil
  
    self.temp_gos = {}
    PublicFunc.ClearUserDataRef(self,2)
end