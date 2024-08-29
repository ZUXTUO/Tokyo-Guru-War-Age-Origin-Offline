using System;
using LuaInterface;

namespace Wraper
{
	public class user_center_wraper
	{
		public static string libname = "user_center";

		private static luaL_Reg[] libfunc = new luaL_Reg[23]
		{
			new luaL_Reg("init_user_center", init_user_center),
			new luaL_Reg("login", login),
			new luaL_Reg("logout", logout),
			new luaL_Reg("set_login_listener", set_login_listener),
			new luaL_Reg("set_logout_listener", set_logout_listener),
			new luaL_Reg("set_payment_listener", set_payment_listener),
			new luaL_Reg("open_user_center", open_user_center),
			new luaL_Reg("switch_account", switch_account),
			new luaL_Reg("payment", payment),
			new luaL_Reg("payment_json", payment_json),
			new luaL_Reg("submit_extend_info", submit_extend_info),
			new luaL_Reg("open_kefu_web_page", open_kefu_web_page),
			new luaL_Reg("show_tool_bar", show_tool_bar),
			new luaL_Reg("hide_tool_bar", hide_tool_bar),
			new luaL_Reg("sdk_exit", sdk_exit),
			new luaL_Reg("set_wechatshare_listener", set_wechatshare_listener),
			new luaL_Reg("set_wechatpay_listener", set_wechatpay_listener),
			new luaL_Reg("wechat_check", wechat_check),
			new luaL_Reg("wechat_pay", wechat_pay),
			new luaL_Reg("wechat_share", wechat_share),
			new luaL_Reg("weibo_check", weibo_check),
			new luaL_Reg("set_weiboshare_listener", set_weiboshare_listener),
			new luaL_Reg("weibo_share", weibo_share)
		};

		private static string string_init_user_center = "user_center.init_user_center";

		private static string string_login = "user_center.login";

		private static string string_set_login_listener = "user_center.set_login_listener";

		private static string string_set_logout_listener = "user_center.set_logout_listener";

		private static string string_set_payment_listener = "user_center.set_payment_listener";

		private static string string_set_wechatshare_listener = "user_center.set_wechatshare_listener";

		private static string string_set_wechatpay_listener = "user_center.set_wechatpay_listener";

		private static string string_wechat_check = "user_center.wechat_check";

		private static string string_wechat_pay = "user_center.wechat_pay";

		private static string string_wechat_share = "user_center.wechat_share";

		private static string string_open_user_center = "user_center.open_user_center";

		private static string string_payment = "user_center.payment";

		private static string string_payment_json = "user_center.payment_json";

		private static string string_submit_extend_info = "user_center.submit_extend_info";

		private static string string_add_info = "user_center.add_info";

		private static string string_get_tool_bar_url = "user_center.get_tool_bar_url";

		private static string string_sdk_exit = "user_center.sdk_exit";

		private static string string_weibo_check = "user_center.weibo_check";

		private static string string_set_weiboshare_listener = "user_center.set_weiboshare_listener";

		private static string string_weibo_share = "user_center.weibo_share";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int init_user_center(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_init_user_center) && WraperUtil.ValidIsString(L, 2, string_init_user_center))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				UserCenter.GetInstance().Init(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int login(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_login))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().Login(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int logout(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().Logout());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_login_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_login_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onLoginedScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_logout_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_logout_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onLogoutedScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_payment_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_payment_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onPaymentedScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_wechatshare_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_wechatshare_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onWechatshareScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_wechatpay_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_wechatpay_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onWechatpayScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int wechat_check(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().WechatCheck());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int wechat_pay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_wechat_pay))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().WechatPay(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int wechat_share(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_wechat_share))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().WechatShare(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int weibo_check(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().WeiboCheck());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_weiboshare_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_weiboshare_listener))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().m_onWeiboshareScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int weibo_share(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_weibo_share))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().WeiboShare(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int open_user_center(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_open_user_center))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().OpenUserCenter(num));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int switch_account(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().SwitchAccount());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int payment(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_payment) && WraperUtil.ValidIsString(L, 2, string_payment) && WraperUtil.ValidIsString(L, 3, string_payment) && WraperUtil.ValidIsString(L, 4, string_payment) && WraperUtil.ValidIsString(L, 5, string_payment) && WraperUtil.ValidIsString(L, 6, string_payment) && WraperUtil.ValidIsString(L, 7, string_payment))
			{
				int num = 0;
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				string text5 = null;
				string text6 = null;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				text = LuaDLL.lua_tostring(L, 2);
				text2 = LuaDLL.lua_tostring(L, 3);
				text3 = LuaDLL.lua_tostring(L, 4);
				text4 = LuaDLL.lua_tostring(L, 5);
				text5 = LuaDLL.lua_tostring(L, 6);
				text6 = LuaDLL.lua_tostring(L, 7);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().Payment(num, text, text2, text3, text4, text5, text6));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int payment_json(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_payment_json) && WraperUtil.ValidIsString(L, 2, string_payment_json))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				LuaDLL.lua_pushboolean(L, UserCenter.GetInstance().Payment(text, text2));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int submit_extend_info(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_submit_extend_info))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				UserCenter.GetInstance().SubmitExtendInfo(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_info(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_add_info) && WraperUtil.ValidIsString(L, 2, string_add_info))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				UserCenter.GetInstance().AddInfo(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int open_kefu_web_page(IntPtr L)
		{
			int num = 0;
			UserCenter.GetInstance().OpenCustomServiceWebPage();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int show_tool_bar(IntPtr L)
		{
			int num = 0;
			UserCenter.GetInstance().ShowToolBar();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int hide_tool_bar(IntPtr L)
		{
			int num = 0;
			UserCenter.GetInstance().HideToolBar();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int sdk_exit(IntPtr L)
		{
			int num = 0;
			bool flag = false;
			flag = UserCenter.GetInstance().Sdk_Exit();
			LuaDLL.lua_pushboolean(L, flag);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_tool_bar_url(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_get_tool_bar_url))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				LuaDLL.lua_pushstring(L, UserCenter.GetInstance().GetToolBarUrl(num));
				result = 1;
			}
			return result;
		}
	}
}
