--说明：剧情对话界面
--调用方法：ScreenPlayChatMMO:new(data)
--param: data:

ScreenPlayChatMMO = Class('ScreenPlayChatMMO', UiBaseClass);

-------------------------------------------------------------------------------
-------------------------外部接口----------------------------------------------
--显示对话ui
--data：例子：ScreenPlayChatMMO.ShowTalk({side=EDramaSide.Left, icon_path=1, dlg="对话内容", name = "名字", audio_id = audio_id})
function ScreenPlayChatMMO.ShowTalk(data)
    app.log_warning("ScreenPlayChatMMO  ShowTalk "..table.tostring(data))
	if ScreenPlayChatMMO.showTalkUi == nil then
		ScreenPlayChatMMO.showTalkUi = ScreenPlayChatMMO:new(data);
	else
		ScreenPlayChatMMO.showTalkUi:SetAndShow(data);
	end
end

function ScreenPlayChatMMO.DestroyTalk()
	if(ScreenPlayChatMMO.showTalkUi)then
		ScreenPlayChatMMO.showTalkUi:DestroyUi();
		ScreenPlayChatMMO.showTalkUi = nil;
	end
end
-------------------------------------------------------------------------------
-------------------------内部调用----------------------------------------------
function ScreenPlayChatMMO:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mmo_task/ui_3303_task.assetbundle"
	UiBaseClass.Init(self, data);
end

function ScreenPlayChatMMO:InitData(data)
    UiBaseClass.InitData(self, data);
	self:LoadData(data)
end

function ScreenPlayChatMMO:LoadData(data)
	self.side = data.side;
	self.icon_path = data.icon_path;
	app.log_warning("LoadData  data.dlg "..tostring(data.dlg))
    app.log_warning("LoadData  data.name "..data.name)
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
function ScreenPlayChatMMO:DestroyUi()
	UiBaseClass.DestroyUi(self);
	self.audio_id = nil;
	self.curaudio = nil;
	if self.spIcon then
		self.spIcon:Destroy();
		self.spIcon = nil;
	end

end

--显示ui
function ScreenPlayChatMMO:Show()
	if UiBaseClass.Show(self) then
	end
end

--隐藏ui
function ScreenPlayChatMMO:Hide()
	if UiBaseClass.Hide(self) then
		-- 恢复
		PublicFunc.UnityResume();
		-- 还原默认值
		self.enable_auto = false;
		self.enable_skip = false;
	end
end

--注册方法
function ScreenPlayChatMMO:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_next"] = Utility.bind_callback(self, self.on_next)
	self.bindfunc["on_skip"] = Utility.bind_callback(self, self.on_skip)
	self.bindfunc["do_skip"] = Utility.bind_callback(self, self.do_skip)
end 

function ScreenPlayChatMMO:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("screenplay_chat_mmo");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	
	---------图片----------
	--左侧人物头像sp
	self.spIcon = ngui.find_texture(self.ui,"animation/content/Texture");
	--人物名字lab
	self.labName = ngui.find_label(self.ui,"animation/content/lab_name");
	--对话内容
	self.labDlg = ngui.find_label(self.ui,"animation/content/lab_describe");

    local spTaskName = ngui.find_label(self.ui,"animation/content/txt1");
    spTaskName:set_active(false);

	
	---------------------按钮及回调事件绑定------------------------
	--点击屏幕，进入下一段对话
	self.spNext = ngui.find_sprite(self.ui,"sp_mark");
	self.spNext:set_on_ngui_click(self.bindfunc["on_next"]);
	
	self:UpdateUi();
	self:Show();
end

-- 下一句
function ScreenPlayChatMMO:on_next()
	if self.enable_auto == false then
		self:DestroyAudio()
    	self:Hide();
    	ScreenPlay.TalkOver()
	end
end

-- 跳过该剧情
function ScreenPlayChatMMO:on_skip()
	if self.enable_skip == true then
		HintUI.SetAndShow(EHintUiType.two, "是否跳过剧情展示？", {str = "是",func = self.bindfunc["do_skip"]},{str = "否"})
	end
end

-- 执行跳过
function ScreenPlayChatMMO:do_skip()
	self:DestroyAudio()
	self:Hide();
	ScreenPlay.Skip()
end

-- 停止声音播放
function ScreenPlayChatMMO:DestroyAudio()
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

function ScreenPlayChatMMO:UpdateUi()
	if self.ui == nil then return end
	app.log_warning("self.name="..self.name.."icon_path="..self.icon_path)

	AudioManager.PlayUiAudio(ENUM.EUiAudioType.DlgOut);
	if self.audio_id and self.audio_id ~= 0 then
		self.cur_audio_id,self.cur_audio_numAdObj = AudioManager.Play3dAudio(self.audio_id, AudioManager.GetUiAudioSourceNode(), true, true)
	end
	self.spIcon:set_active(false);
	if self.icon_path and self.icon_path ~= 0 then
		app.log_warning("1")
		self.spIcon:set_texture(self.icon_path);
		app.log_warning("2")
       	self.spIcon:set_active(true);
       	app.log_warning("3")
    end

    
	self.labName:set_text(self.name);
	self.labDlg:set_text(self.dlg);

	if self.enable_black then
		self.spNext:set_sprite_name("bt100")
	else
		self.spNext:set_sprite_name("bantou55")
	end

	if self.enable_pause then
        -- 暂停
		PublicFunc.UnityPause();
    end
end

--显示UI
function ScreenPlayChatMMO:SetAndShow(data)
	if self.ui == nil then
		return
	end
	
	self:LoadData(data);
	self:UpdateUi();
	self:Show();
end

-- 打断对话,清除状态
function ScreenPlayChatMMO.BreakTalk()
	ScreenPlayChatMMO.DestroyTalk() --解决动画重复播放的bug
end
