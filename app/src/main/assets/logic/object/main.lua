-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/18
-- Time: 10:13
-- To change this template use File | Settings | File Templates.
--

--加载游戏进入
script.run("logic/object/entershow.lua");
--分层状态机相关
script.run("logic/object/fsm/main.lua") 
--加载人物卡牌模块
script.run("logic/object/card_human.lua");
--加载武器卡牌模块
script.run("logic/object/card_weapon.lua");
--加载装备卡牌模块
script.run("logic/object/card_equipment.lua");
--加载道具卡牌模块
script.run("logic/object/card_prop.lua");
--加载卡牌显示模块
script.run("logic/object/cardbase.lua");
--加载checkbox模块
script.run("logic/object/checkbox.lua");
--加载背包模块
script.run("logic/object/package.lua");
--加载玩家模块
script.run("logic/object/player.lua");
--加载战斗信息模块
script.run("logic/object/fight_info.lua");
--加载其他玩家数据模块
script.run("logic/object/other_players.lua");
--加载场景模块
script.run("logic/object/scene.lua");
--加载列表模块
script.run("logic/object/scrollview.lua");
--加载好友模块
script.run("logic/object/friend.lua");
--加载扭蛋模块
script.run("logic/object/egg.lua");
--加载活动模块 包括签到
script.run("logic/object/activity.lua");
--加载签到模块
script.run("logic/object/checkin.lua");
--加载触发器模块
script.run("logic/object/trigger/trigger.lua");
script.run("logic/object/trigger/trigger_collider.lua");
script.run("logic/object/trigger/trigger_hurdle.lua");
script.run("logic/object/trigger/trigger_func.lua");


--剧情
-- script.run("logic/object/trigger/trigger_story.lua");

--加载排行榜模块
script.run("logic/object/rank.lua");
--加载活动模块
script.run("logic/object/activity/main.lua")
--加载跑马灯模块
script.run("logic/object/marquee.lua")
--gm测试
script.run("logic/object/gm_cheat.lua")
--二级商店
script.run("logic/object/shop_info.lua")

--加载活动标记模块
script.run("logic/object/flag/main.lua");
--动画控制器
script.run('logic/object/ani_ctrler.lua')

script.run('logic/object/animation_config_geter.lua')

script.run 'logic/object/fsm.lua'

-- 场景对象
script.run("logic/object/compt_timer.lua");
script.run("logic/object/compt_grenade.lua");
script.run("logic/object/compt_grenade_area.lua");
script.run("logic/object/compt_item.lua");

script.run("logic/object/scene_entity.lua");
script.run("logic/object/scene_entity_ai_extend.lua");
script.run("logic/object/scene_entity_fight_extend.lua");


-- 对象状态机
--script.run("logic/object/entity_state.lua");
-- 操作及AI状态机
--script.run("logic/object/handle_state.lua");
--加载技能模块
script.run("logic/object/skill/main.lua");
--加载聊天数据
script.run("logic/object/chat_data.lua");

--加载邮件模块
script.run("logic/object/mail/main.lua");
-- 关卡模块
script.run("logic/object/hurdle/hurdle.lua")
script.run("logic/object/hurdle/hurdle_local.lua")
--加载徽章数据模块
script.run("logic/object/badges_data.lua");
--加载商城数据模块
script.run("logic/object/store/main.lua")

--加载玩法数据模块
script.run("logic/object/play_method/main.lua")

--加载公会数据模块
script.run("logic/object/guild/main.lua")

script.run("logic/object/building/main.lua")

--日常任务数据模块
script.run("logic/object/daily_task.lua");

--系统进入方法模块
script.run("logic/object/system_enter_func.lua");
--script.run("logic/object/develop_guide_enter.lua");

--世界boss模块
script.run("logic/object/world_boss_data.lua");
--优化asset_game_object;
script.run("logic/object/my_asset_game_object.lua");
--我的按钮
script.run("logic/object/my_button.lua");
--我的texture
script.run("logic/object/my_texture.lua");

--设置数据中心
script.run("logic/object/setting.lua");
script.run("logic/object/play_method_info.lua");

script.run("logic/object/institute.lua");

script.run("logic/object/clonebattle.lua");

script.run("logic/object/trainning.lua");

script.run("logic/object/church_bot.lua");

script.run("logic/object/time_flag.lua");

--推荐系统
script.run("logic/object/recommend/main.lua");
--自动寻路
script.run("logic/object/auto_pathfinding.lua")

--任务模块
script.run("logic/object/mmo_task/main.lua");

--boss列表
script.run("logic/object/boss_list.lua");

--天赋系统
script.run("logic/object/talent_system.lua");

-- 七天乐
script.run("logic/object/signin.lua");
--邀请
script.run("logic/object/invite_info.lua");
-- 远征试炼
script.run("logic/object/expedition_trial_data.lua");
-- 区域系统
script.run("logic/object/area.lua");
-- 活动关卡
script.run("logic/object/level_activity_data.lua");
-- 守护之心
script.run("logic/object/guard_heart_data.lua");

script.run("logic/object/maskitem.lua");

--加载数据中心(最后)
script.run("logic/object/data_center.lua")


