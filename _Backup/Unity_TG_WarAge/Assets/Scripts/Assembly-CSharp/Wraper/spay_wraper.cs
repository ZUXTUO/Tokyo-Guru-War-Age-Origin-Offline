using System;
using LuaInterface;

namespace Wraper
{
	public class spay_wraper
	{
		public static string libname = "spay";

		private static luaL_Reg[] libfunc = new luaL_Reg[11]
		{
			new luaL_Reg("init_spay", init_spay),
			new luaL_Reg("can_payment", can_payment),
			new luaL_Reg("set_on_init", set_on_init),
			new luaL_Reg("set_on_get_pruchase", set_on_get_pruchase),
			new luaL_Reg("set_on_buy", set_on_buy),
			new luaL_Reg("get_purchase", get_purchase),
			new luaL_Reg("buy", buy),
			new luaL_Reg("consume", consume),
			new luaL_Reg("set_on_response_products", set_on_response_products),
			new luaL_Reg("request_products", request_products),
			new luaL_Reg("get_products", get_products)
		};

		private static string string_set_on_init = "spay.set_on_init";

		private static string string_set_on_get_pruchase = "spay.set_on_get_pruchase";

		private static string string_set_on_buy = "spay.set_on_buy";

		private static string string_buy = "spay.buy";

		private static string string_consume = "spay.consume";

		private static string string_set_on_response_products = "spay.set_on_response_products";

		private static string string_request_products = "spay.request_products";

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
		private static int init_spay(IntPtr L)
		{
			int num = 0;
			PayManager.GetInstance().Init();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int can_payment(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, PayManager.GetInstance().CanPayment());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_init(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_init))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().SetOnInitResponse(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_get_pruchase(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_get_pruchase))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().SetOnGetPurchaseResponse(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_buy(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_buy))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().SetOnBuyResponse(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_purchase(IntPtr L)
		{
			int num = 0;
			PayManager.GetInstance().GetPurchase();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int buy(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_buy))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().Buy(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int consume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_consume) && WraperUtil.ValidIsString(L, 2, string_consume))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				if (text2 != string.Empty)
				{
					PayManager.GetInstance().Consume(text2, text);
				}
				else
				{
					PayManager.GetInstance().Consume(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_response_products(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_response_products))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().SetOnResponseProducts(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int request_products(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_request_products))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PayManager.GetInstance().RequestProducts(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_products(IntPtr L)
		{
			int num = 0;
			SpayProduct[] products = PayManager.GetInstance().GetProducts();
			WraperUtil.Push(L, products);
			return 1;
		}
	}
}
