--说明：剧情对话界面
--调用方法：ScreenPlayChat:new(data)
--param: data:

EDramaSide = 
{
	Left = 1,
	Right = 2,
	Center = 3,
}

ScreenPlayChat = Class('ScreenPlayChat', UiBaseClass);

-------------------------------------------------------------------------------
-------------------------外部接口----------------------------------------------
--显示对话ui
--data：例子：ScreenPlayChat.ShowTalk({side=EDramaSide.Left, icon_path=1, dlg="对话内容", name = "名字", audio_id = audio_id})
function ScreenPlayChat.ShowTalk(data)
	if ScreenPlayChat.showTalkUi == nil then
		ScreenPlayChat.showTalkUi = ScreenPlayChat:new(data);
	else
		ScreenPlayChat.showTalkUi:SetAndShow(data);
	end
end

function ScreenPlayChat.DestroyTalk()
	if ScreenPlayChat.showTalkUi then
		ScreenPlayChat.showTalkUi:DestroyUi();
		ScreenPlayChat.showTalkUi = nil;
	end
end

-- 打断对话,清除状态
function ScreenPlayChat.BreakTalk()
	ScreenPlayChat.DestroyTalk() --解决动画重复播放的bug
	-- if ScreenPlayChat.showTalkUi then
	-- 	ScreenPlayChat.showTalkUi:ResetStatus()
	-- end
end

-------------------------------------------------------------------------------
-------------------------内部调用----------------------------------------------
function ScreenPlayChat:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/drama/ui_701_drama.assetbundle"
	UiBaseClass.Init(self, data);
end

function ScreenPlayChat:InitData(data)
    UiBaseClass.InitData(self, data);
	self:LoadData(data)
end

function ScreenPlayChat:LoadData(data)
	self.side = data.side;
	self.icon_path = data.icon_path;
	self.dlg = data.dlg;
	self.name = data.name;
	self.audio_id = data.audio_id;
	self.is_last_audio = data.is_last_audio;
	-- self.enable_auto = data.enable_auto;	-- 暂不需要此功能
	self.enable_auto = false;
	self.enable_skip = data.enable_skip;
	self.enable_black = data.enable_black;
	self.enable_pause = data.enable_pause;
end

--释放界面
function ScreenPlayChat:DestroyUi()
	self.audio_id = nil;
	self.curaudio = nil;
	if self.textureLeftIcon then
		self.textureLeftIcon:Destroy();
		self.textureLeftIcon = nil;
	end

	if self.textureRightIcon then
		self.textureRightIcon:Destroy();
		self.textureRightIcon = nil;
	end
	UiBaseClass.DestroyUi(self);
end

--显示ui
function ScreenPlayChat:Show()
	if UiBaseClass.Show(self) then
	end
end

--隐藏ui
function ScreenPlayChat:Hide()
	if UiBaseClass.Hide(self) then
		-- 恢复
		PublicFunc.UnityResume();
		-- 还原默认值
		self.enable_auto = false;
		self.enable_skip = false;
	end
end

--注册方法
function ScreenPlayChat:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_next"] = Utility.bind_callback(self, self.on_next)
	self.bindfunc["on_skip"] = Utility.bind_callback(self, self.on_skip)
	self.bindfunc["do_skip"] = Utility.bind_callback(self, self.do_skip)
end 

function ScreenPlayChat:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("screenplay_chat");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	
	---------图片----------
	self.textureLeftIcon = ngui.find_texture(self.ui,"texture_left");
	self.textureRightIcon = ngui.find_texture(self.ui,"texture_right");
	self.spTitle = ngui.find_sprite(self.ui, "sp_title");
	self.labName1 = ngui.find_label(self.ui, "sp_title/lab_name1");
	self.labName2 = ngui.find_label(self.ui, "sp_title/lab_name2");
	self.labDlg = ngui.find_label(self.ui, "lab_describe");

	--跳过按钮
	-- self.btnSkip = ngui.find_button(self.ui,"btn");
	-- self.btnSkip:set_on_click(self.bindfunc["on_skip"]);

	--点击屏幕，进入下一段对话
	self.spNext = ngui.find_sprite(self.ui,"sp_mark");
	self.spNext:set_on_ngui_click(self.bindfunc["on_next"]);

	local btn = ngui.find_button(self.ui, "btn_cancel");
	btn:set_active(false);
	btn = ngui.find_button(self.ui, "btn_sure");
	btn:set_active(false);

	self.aniObj = self.ui:get_child_by_name("animation")
	-- if self.initPos1 == nil then
	-- 	local x, y, z = self.textureLeftIcon:get_position()
	-- 	self.initPos1 = {x, y, z}
	-- end
	-- if self.initPos2 == nil then
	-- 	local x, y, z = self.textureRightIcon:get_position()
	-- 	self.initPos2 = {x, y, z}
	-- end

	self:Show();
	self:UpdateUi();
end

-- 重置状态
function ScreenPlayChat:ResetStatus()
	self.is_playing_ani = nil
	self.last_name = nil

	self.textureLeftIcon:clear_texture()
	self.textureRightIcon:clear_texture()
end

-- 下一句
function ScreenPlayChat:on_next()
	if not self.is_playing_ani and self.enable_auto == false then
		self:DestroyAudio()
    	self:Hide();
    	ScreenPlay.TalkOver()
	end
end

-- 跳过该剧情
function ScreenPlayChat:on_skip()
	if self.enable_skip == true then
		HintUI.SetAndShow(EHintUiType.two, "是否跳过剧情展示？", {str = "是",func = self.bindfunc["do_skip"]},{str = "否"})
	end
end

-- 执行跳过
function ScreenPlayChat:do_skip()
	if not self.is_playing_ani then
		self:DestroyAudio()
		self:Hide();
		ScreenPlay.SkipChat()
	end
end

-- 停止声音播放
function ScreenPlayChat:DestroyAudio()
	if self.is_last_audio then
		return;
	end
	if self.cur_audio_id and self.cur_audio_numAdObj then
		local curaudio = AudioManager.GetAudio3dObject(self.cur_audio_id,self.cur_audio_numAdObj);
			if curaudio then
			AudioManager.Stop3dAudio(curaudio,self.cur_audio_id, self.cur_audio_numAdObj, false);
		end
		self.cur_audio_id = nil;
		self.cur_audio_numAdObj = nil;
	end
end

function ScreenPlayChat:UpdateUi()
	if self.ui == nil then return end

	AudioManager.PlayUiAudio(ENUM.EUiAudioType.DlgOut);
	if self.audio_id and self.audio_id ~= 0 then
		self.cur_audio_id,self.cur_audio_numAdObj = AudioManager.Play3dAudio(self.audio_id, AudioManager.GetUiAudioSourceNode(), true, true)
	end

	local textureIcon = nil;
	if self.side == EDramaSide.Left then
		textureIcon = self.textureLeftIcon;
	elseif self.side == EDramaSide.Right then
		textureIcon = self.textureRightIcon;
	elseif(self.side == EDramaSide.Center)then
		
	else
		app.log("对话选边为nil");
	end
	if textureIcon and self.icon_path and self.icon_path ~= 0 then
		local texture = ResourceManager.GetRes(self.icon_path)
		if(texture)then
			textureIcon:set_texture(self.icon_path);
		else
			app.log("未进行预加载剧情对话texture  path=="..self.icon_path);
		end
	end

	if self.name == " " then
		self.spTitle:set_active(false);
	else
		self.spTitle:set_active(true);
		PublicFunc.SetSinkText(self.name, self.labName1, self.labName2)
	end
	
	self.labDlg:set_text(self.dlg);

	if self.enable_black then
		self.spNext:set_sprite_name("bt50")
	else
		self.spNext:set_sprite_name("kongbai")
	end

	-- 显示跳过按钮
	-- self.btnSkip:set_active(self.enable_skip)

	if self.enable_pause then
		PublicFunc.UnityPause();
    end

	if self.last_name ~= self.name then
		self.last_name = self.name

		-- self.textureLeftIcon:set_position(self.initPos1[1], self.initPos1[2], self.initPos1[3])
		-- self.textureRightIcon:set_position(self.initPos2[1], self.initPos2[2], self.initPos2[3])
		self.aniObj:animator_play("ui_701_drama_duihua_diban")

		self.is_playing_ani = true
	else
		self.is_playing_ani = false
	end
end

--显示UI
function ScreenPlayChat:SetAndShow(data)
	if self.ui == nil then
		return
	end
	
	self:LoadData(data);
	self:Show();
	self:UpdateUi();
end

function ScreenPlayChatAnimatorBack(obj, value)
	local self = ScreenPlayChat.showTalkUi
	if self and self.aniObj then
		if value == "1" then
			if self.side == EDramaSide.Left then
				self.aniObj:animator_play("ui_701_drama_duihua_left")
			elseif self.side == EDramaSide.Right then
				self.aniObj:animator_play("ui_701_drama_duihua_right")
			end
		else
			self.is_playing_ani = false
		end
	end

	--传送提示框
	self = ScreenPlayTranslate.GetInstance()
	if self and self.aniObj then
		self:OnAnimCallback(obj, value)
	end
end
