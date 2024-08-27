# 项目
Tokyo Guru War Age Origin Source Code

# 进度(Progress)
2022/7/15-----------前篇、序章1、序章2<br>
2022/11/27----------进入主界面<br>
2023/1/5------------解除帧数限制<br>
2023/5/28-----------可以抽卡<br>
2023/6/5------------可以查看角色<br>
2023/6/10-----------角色图鉴修复，可以换头像<br>
2023/6/20-----------闯关可进入，除极限挑战外，其他均可进入不报错，内置HTML<br>

# BUG
2022/11/27----------[修复]抽卡，egg_hero_ui.lua的631行，超时相应。<br>
2023/1/5------------[有办法调处页面，但不完美]闯关，ui_701_level.lua的285行，sectionConfig为空。<br>
2023/1/5------------[修复]帧数限制<br>
2023/5.28-----------[修复]背包无法储存角色数据egg_hero_ui.lua的751行。有测试函数。<br>
2023/6/20-----------3V3暂时没法正常工作。<br>
2024/8/26-----------[修复]序章读取存在问题<br>

# 关键点
game_begin.lua 的 GameBegin.load_first_res() 函数里有序章和新手教程的加载和跳过功能。<br><br>

entershow.lua------------EnterShow.Start函数牵连初始进入场景信息。<br>
notice_manager.lua-------传入的通知可跳过新手引导，但也会让新手引导卡住。<br>
ui_701_level.lua---------闯关相关函数。<br>
ui\egg\egg_hero_ui.lua----------EggHeroUi:on_buy_1抽卡（单抽），EggHeroUi:on_buy_10抽卡（十连）。<br>
data_center.lua----------用户中心数据<br>
e.lua--------------------用户数据衍生【自定义出来的】<br>
package.lua--------------背包信息<br>
card_human.lua-----------角色信息<br>
common_hero_list_ui.lua--队列信息<br>
scene\fight_scene_management\prologue_battle_fight_manager.lua---第103行有序章判断


# -----------------------------------------------------