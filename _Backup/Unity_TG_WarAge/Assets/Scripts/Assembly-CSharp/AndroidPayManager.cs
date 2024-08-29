public class AndroidPayManager : AndroidBehaviour
{
	public static void Init(string user_sign)
	{
		//AndroidBehaviour.instance.CallStatic("com.digitalsky.unityplugin.GoogleBillingManager", "init", user_sign);
	}

	public static bool IsPlayServiceAvaliable()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.unityplugin.GoogleBillingManager", "is_play_service_avaliable", new object[0]);
		return true;
	}

	public static bool IsExistStore()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.unityplugin.GoogleBillingManager", "is_exist_store", new object[0]);
		return true;
	}

	public static void GetPurchased(string user_sign)
	{
		//AndroidBehaviour.instance.CallStatic("com.digitalsky.unityplugin.GoogleBillingManager", "getPurchased", user_sign);
	}

	public static void BuyProduct(string product_id, string user_defined_data, string user_sign)
	{
		//AndroidBehaviour.instance.CallStatic("com.digitalsky.unityplugin.GoogleBillingManager", "buy_product", product_id, user_defined_data, user_sign);
	}

	public static void ConsumeProduct(string token)
	{
		//AndroidBehaviour.instance.CallStatic("com.digitalsky.unityplugin.GoogleBillingManager", "consume_product", token);
	}
}
