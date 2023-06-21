--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/4/29
-- Time: 18:10
-- To change this template use File | Settings | File Templates.
--
--[[清理除系统外的自定义文件或目录]]
del_file = {};

function del_file.clear()
	file.delete("playerEnterTimesSaveFile.data");--[[小红点提示]]
	file.delete("setting.data");--[[系统设置-特效等级]]
end