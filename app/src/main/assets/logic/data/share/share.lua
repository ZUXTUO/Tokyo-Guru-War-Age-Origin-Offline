--编号	类型（1：文字，2：图片）	标题	描述	图片存储文件名	网址
g_Config.t_share_key_ = {
	id=1,
	type=2,
	title=3,
	des=4,
	png=5,
	web=6,
}
g_Config.t_share = {
	[1] = "{1,2,'gs_share_info.jjc_title','gs_share_info.jjc_des','jjc.png','http://djzj.ppgame.com/yy/index.html',}",
	[2] = "{2,2,'gs_share_info.danganguan_title','gs_share_info.danganguan_des','ddanganguan.png','http://djzj.ppgame.com/yy/index.html',}",
	[3] = "{3,2,'gs_share_info.huodong_dengji_title','gs_share_info.huodong_dengji_des','huodong_dengji.png','http://djzj.ppgame.com/yy/index.html',}",
	[4] = "{4,2,'gs_share_info.huodong_zhanli_title','gs_share_info.huodong_zhanli_des','huodong_zhanli.png','http://djzj.ppgame.com/yy/index.html',}",
	[5] = "{5,2,'gs_share_info.huodong_juese_title','gs_share_info.huodong_juese_des','huodong_juese.png','http://djzj.ppgame.com/yy/index.html',}",
	[6] = "{6,2,'gs_share_info.jixiantiaozhan_title','gs_share_info.jixiantiaozhan_des','jixiantiaozhan.png','http://djzj.ppgame.com/yy/index.html',}",
	[7] = "{7,2,'gs_share_info.yuanzhengshilian_title','gs_share_info.yuanzhengshilian_des','yuanzhengshilian.png','http://djzj.ppgame.com/yy/index.html',}",
	[8] = "{8,2,'gs_share_info.zhenrong_title','gs_share_info.zhenrong_des','zhenrong.png','http://djzj.ppgame.com/yy/index.html',}",
}
return {key = g_Config.t_share_key_, data = g_Config.t_share } 
 -- 