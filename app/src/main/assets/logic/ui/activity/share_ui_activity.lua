ShareUIActivity = Class("ShareUIActivity", UiBaseClass)

function ShareUIActivity:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_8003_share.assetbundle";
    UiBaseClass.Init(self, data);
end

function ShareUIActivity:Restart(data)

	self.sharetype = data   -- 1 jjc  2 战力 3等级 4角色

    if UiBaseClass.Restart( self, data ) then
    end
end

function ShareUIActivity:InitData(data)
    UiBaseClass.InitData(self, data);
    
end

function ShareUIActivity:DestroyUi()

    UiBaseClass.DestroyUi(self);
end

function ShareUIActivity:RegistFunc()
	UiBaseClass.RegistFunc(self);
end

function ShareUIActivity:MsgRegist()
	
end

function ShareUIActivity:MsgUnRegist()

end

function ShareUIActivity:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ShareUIActivity");

	self.cont_jjc = self.ui:get_child_by_name("centre_other/animation/cont_jjc")  --JJC
	self.jjc_fight_lab = ngui.find_label(self.ui,"centre_other/animation/cont_jjc/lab_fight")
	self.jjc_rank_lab = ngui.find_label(self.ui,"centre_other/animation/cont_jjc/lab_ranking")


	self.cont_fight = self.ui:get_child_by_name("centre_other/animation/cont_fight") -- 战力
	self.fight_rank_lab = ngui.find_label(self.ui,"centre_other/animation/cont_fight/lab_ranking")

	self.cont_level = self.ui:get_child_by_name("centre_other/animation/cont_level") --等级
	self.level_rank_lab = ngui.find_label(self.ui,"centre_other/animation/cont_level/lab_ranking")

	self.Texture_small = ngui.find_texture(self.ui,"centre_other/animation/Texture_small")   --JJC 战力 等级
	self.Texture_bg = ngui.find_texture(self.ui,"centre_other/animation/Texture_big")        --角色炫耀

	self.cont_role = self.ui:get_child_by_name("centre_other/animation/cont_role_num")    --拥有角色
	self.role_numb = ngui.find_label(self.ui,"centre_other/animation/cont_role_num/lab_ranking")


	self.cont_jjc:set_active(false)
	self.cont_fight:set_active(false)
	self.cont_level:set_active(false)
	self.cont_role:set_active(false)

	self:SetData()

end

function ShareUIActivity:SetData()

	if self.sharetype == 4 then
		self.cont_jjc:set_active(true)
		self.Texture_small:set_active(true)
		self.Texture_bg:set_active(false)
		self.Texture_small:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dengji_jjc.assetbundle")
		
		local rank = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena]:GetShowRank()
		local fightvalue = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena]:GetShowTeamFightValue()

		self.jjc_rank_lab:set_text(tostring(rank))
		self.jjc_fight_lab:set_text(tostring(fightvalue))
		--JJC 战力 jjc 等级
		share_ui_button.Start(1,1)
	elseif self.sharetype == 1 then
		self.cont_fight:set_active(true)
		self.Texture_small:set_active(true)
		self.Texture_bg:set_active(false)
		self.Texture_small:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dengji_zl.assetbundle")

		local fightvalue = g_dataCenter.player:GetFightValue()
		self.fight_rank_lab:set_text(tostring(fightvalue))
		share_ui_button.Start(1,4)
	elseif self.sharetype == 2 then
		self.cont_level:set_active(true)
		self.Texture_small:set_active(true)
		self.Texture_bg:set_active(false)
		self.Texture_small:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dj.assetbundle")		
		local lvl = g_dataCenter.player.level
		self.level_rank_lab:set_text(tostring(lvl))
		share_ui_button.Start(1,3)
	elseif self.sharetype == 3 then
		self.cont_role:set_active(true)
		self.Texture_bg:set_active(true)
		self.Texture_small:set_active(false)
		self.Texture_bg:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_yongyoujuese.assetbundle")
		local haverole = #g_dataCenter.package:get_hero_card_table()
		self.role_numb:set_text(tostring(haverole))
		share_ui_button.Start(1,5)
	end

	
end