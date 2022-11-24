GuildFindLsRe = Class("GuildFindLsRe", UiBaseClass)


-------------------------------------外部调用-------------------------------------


function GuildFindLsRe:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/advfuncnotice/ui_7202_search.assetbundle"
    UiBaseClass.Init(self, data);
end

function GuildFindLsRe:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function GuildFindLsRe:InitData(data)
    self.itemlist = {}
    self.itemcard = {}
    UiBaseClass.InitData(self, data)
    
end

function GuildFindLsRe:DestroyUi()
    
    for k,v in pairs(self.itemcard)do
	for kk,vv in pairs(v)do
	    vv:DestroyUi()
	end
    end   
    
    UiBaseClass.DestroyUi(self);

end

function GuildFindLsRe:RegistFunc()

    UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["setData"] = Utility.bind_callback(self, self.setData)
end


--注册消息分发回调函数
function GuildFindLsRe:MsgRegist()
    PublicFunc.msg_regist(msg_xunzhaolishi.gc_request_report, self.bindfunc["setData"])
    UiBaseClass.MsgRegist(self);
   
end

--注销消息分发回调函数
function GuildFindLsRe:MsgUnRegist()
    PublicFunc.msg_unregist(msg_xunzhaolishi.gc_request_report, self.bindfunc["setData"])
    UiBaseClass.MsgUnRegist(self);
        
end


--初始化UI
function GuildFindLsRe:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('GuildFindLsRe');
    self.closebtn = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_btn_close'])

    self.closebtn1 = ngui.find_button(self.ui,"centre_other/animation/lab/btn_yellow")
    self.closebtn1:set_on_click(self.bindfunc['on_btn_close'])

    self.nojilulab = ngui.find_label(self.ui,"centre_other/animation/lab")
    self.nojilulab:set_active(false)

    --ty_tanchuang4 ty_tanchuang7
    self.bg = ngui.find_sprite(self.ui,"centre_other/animation/content_di_754_458/sp_di")
    
    self.scroll_view = ngui.find_wrap_list(self.ui,"centre_other/animation/scroll_view/panel/wrap_list")
    self.scroll_view:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    --self.scroll_view:set_active(false)
    self.scroll_view:set_min_index(0);
    self.scroll_view:set_max_index(-1);
    self.scroll_view:reset();
    --self.panel_mark = ngui.find_scroll_view(self.ui,"center_other/animation/scroll_view/panel_list")
    msg_xunzhaolishi.cg_request_report()
end

function GuildFindLsRe:init_item_wrap_content(obj,b,real_id)
    --app.log("init_item_wrap_content######"..obj:get_name())
    --app.log("b######"..tostring(b))
    if self.reportlist then 
	local index = b+1
	local griditem = ngui.find_grid(obj,"cont")
	local titletext = ngui.find_label(obj,"sp_title/txt")
	local titletxt = self:setTitle(index)
	titletext:set_text(titletxt)
	self.itemlist[index] = {}
	self.itemcard[index] = {}
	--app.log("index##################"..tostring(index))
	for i=1,9 do
	    self.itemlist[index][i] = obj:get_child_by_name("cont/new_small_card_item"..i)
	    --if self.itemcard[index][i] == nil then
		--self.itemcard[index][i] = UiSmallItem:new({parent = self.itemlist[index][i],cardInfo = nil})
		self.itemlist[index][i]:set_active(false)
	    --end
	end
	
	self:setCardData(index)
	griditem:reposition_now()
    end
end

function GuildFindLsRe:setCardData(index)

   -- app.log("index######"..tostring(index))
    if self.reportlist then
	if self.reportlist[index] then
	    for k,v in pairs(self.reportlist[index].vecItem) do
		--app.log("kkkkkkkkkkkk"..tostring(k))
		if self.itemcard[index][k] then
		    --app.log("111111111111111")
		    local card_prop = CardProp:new({number = v.id})
		    self.itemcard[index][k]:SetData(card_prop)
		    self.itemlist[index][k]:set_active(true)
		    self.itemcard[index][k]:SetEnablePressGoodsTips(true)
		    self.itemcard[index][k]:SetCount(v.count)
		else
		    --self.itemlist[index][k] = obj:get_child_by_name("cont/new_small_card_item"..k)
		    --if self.itemcard[index][i] == nil then
		    self.itemcard[index][k] = UiSmallItem:new({parent = self.itemlist[index][k],cardInfo = nil})
		    local card_prop = CardProp:new({number = v.id})
		    self.itemcard[index][k]:SetData(card_prop)
		    self.itemlist[index][k]:set_active(true)
		    self.itemcard[index][k]:SetEnablePressGoodsTips(true)
		    self.itemcard[index][k]:SetCount(v.count)
		end
	    end
	end
    end
end

function GuildFindLsRe:setTitle(index)
    
    local txt = ""
    
    if index == 1 then
	txt = "第一次参与所得："
    elseif index == 2 then
	txt = "第二次参与所得："
    elseif index == 3 then
	txt = "第三次参与所得："
    elseif index == 4 then
	txt = "第四次参与所得："
    elseif index  == 5 then
	txt = "第五次参与所得："
    elseif index == 6 then
	txt = "第六次参与所得："
    elseif index == 7 then
	txt = "第七次参与所得："   
    elseif index == 8 then
	txt = "第八次参与所得："
    elseif index == 9 then
	txt = "第九次参与所得："
    elseif index == 10 then
	txt = "第十次参与所得："
    end
    
    return txt
end

function GuildFindLsRe:on_btn_close()
    uiManager:PopUi();
end

function GuildFindLsRe:setData(reportlist)
    --app.log("1111111111111111111111111111111")
	--do return end
    self.reportlist = reportlist
    if self.reportlist then--and #self.reportlist > 0 then
		--self.scroll_view:set_active(true)
		local cnt = #self.reportlist;
		--app.log("222222222222222222222"..tostring(cnt))
		self.scroll_view:set_min_index(0);
		self.scroll_view:set_max_index(cnt-1);
		self.scroll_view:reset();
		if cnt == 0 then
			self.nojilulab:set_active(true)
			self.bg:set_sprite_name("ty_tanchuang4")
		else
			self.nojilulab:set_active(false)
			self.bg:set_sprite_name("ty_tanchuang7")
		end
		--self.panel_mark:reset_position();
    else
    	--app.log("3333333333333333333333")
	--self.scroll_view:set_active(false)
		
    end
    
end