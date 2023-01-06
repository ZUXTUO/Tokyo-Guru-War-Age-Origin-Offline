# 项目
战纪

# 进度(Progress)
2022/7/15       前篇、序章1、序章2<br>
2022/11/27      进入主界面<br>
2023/1/5        解除帧数限制<br>

# BUG
2022/11/27      抽卡，egg_hero_ui.lua的631行，超时相应。<br>
2023/1/5        闯关，ui_701_level.lua的285行，sectionConfig为空。<br>

# 关键点
entershow.lua       EnterShow.Start函数牵连初始进入场景信息。<br>
notice_manager.lua  传入的通知可跳过新手引导，但也会让新手引导卡住。<br>
ui_701_level.lua    闯关相关函数。<br>
egg_hero_ui.lua     EggHeroUi:on_buy_1抽卡（单抽），EggHeroUi:on_buy_10抽卡（十连）。<br>


# -----------------------------------------------------

# Project
Tokyo Guru War Age Origin Source Code

# Progress
2022/7/15       Preface 1, Preface 2<br>
2022/11/27      Enter the main interface<br>
2023/1/5		Remove Frame Limit<br>

# BUG
2022/11/27      Gacha<br>
2023/1/5		Customs clearance Function, ui_701_level.lua: lines of 285, and 'sectionConfig' is empty.<br>

# Key points
entershow.lua       The "EnterShow.Start" function involves the initial entering scene information.<br>
notice_manager.lua  The incoming notification can skip the novice guide, but it will also cause the novice guide to get stuck.<br>
ui_701_level.lua    Customs clearance Function.<br>
egg_hero_ui.lua     EggHeroUi:on_buy_1 Gacha (Single)，EggHeroUi:on_buy_10 Gacha (Ten).<br>