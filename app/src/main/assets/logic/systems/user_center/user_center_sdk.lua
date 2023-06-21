--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/11/22
-- Time: 12:26
-- To change this template use File | Settings | File Templates.
--

user_center_sdk = {

};

--[[仅调用一次]]
function user_center_sdk.init()
	--在使用user_center功能前，有且只调用一次init。第2个参数目前固定
	user_center.init(AppConfig.get_app_id(), AppConfig.get_user_center_key());
end