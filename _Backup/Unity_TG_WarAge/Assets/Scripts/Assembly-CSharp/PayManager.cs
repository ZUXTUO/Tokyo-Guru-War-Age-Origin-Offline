using System;
using System.Collections.Generic;
using System.IO;
using Core.Unity;
using Script;
using SimpleJSON;
using UnityEngine;

public class PayManager : MonoBehaviourEx
{
	public delegate void BoolDelegate(bool value);

	public delegate void JsonDelegate(string value);

	public delegate void PaymentsDelegate(List<Payment> values);

	private static string m_name = "_PayManager";

	private static PayManager m_instance;

	private JsonDelegate m_onResponseProduct;

	private BoolDelegate m_onInit;

	private PaymentsDelegate m_onBuy;

	private PaymentsDelegate m_onGetPurchase;

	public string m_onResponseProductStringFunc = string.Empty;

	public string m_onInitStringFunc = string.Empty;

	public string m_onBuyStringFunc = string.Empty;

	public string m_onGetPurchaseStringFunc = string.Empty;

	public static PayManager GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_name);
			m_instance = gameObject.AddComponent<PayManager>();
		}
		return m_instance;
	}

	public void Init()
	{
		AndroidPayManager.Init("_PayManager.OnInitResponse");
	}

	public bool CanPayment()
	{
		bool flag = false;
		return AndroidPayManager.IsExistStore() && AndroidPayManager.IsPlayServiceAvaliable();
	}

	public void RequestProducts(string ids)
	{
		string[] array = ids.Split(new string[1] { "|@|" }, StringSplitOptions.None);
	}

	public void SetOnResponseProducts(JsonDelegate callback)
	{
		m_onResponseProduct = callback;
	}

	public void SetOnResponseProducts(string callback)
	{
		m_onResponseProductStringFunc = callback;
	}

	public SpayProduct[] GetProducts()
	{
		List<SpayProduct> list = new List<SpayProduct>();
		return list.ToArray();
	}

	public int Buy(string id, int quality = 1)
	{
		int result = 0;
		AndroidPayManager.BuyProduct(id, string.Empty, "_PayManager.OnBuyProductResponse");
		return result;
	}

	public void GetPurchase()
	{
		List<SpayTransaction> list = new List<SpayTransaction>();
		AndroidPayManager.GetPurchased("_PayManager.OnGetPurchaseResponse");
	}

	public void Consume(string transactionKey, string transactionId)
	{
	}

	public void Consume(string token)
	{
		AndroidPayManager.ConsumeProduct(token);
	}

	public void SetOnInitResponse(BoolDelegate callback)
	{
		m_onInit = callback;
	}

	public void SetOnInitResponse(string callback)
	{
		m_onInitStringFunc = callback;
	}

	public void SetOnGetPurchaseResponse(PaymentsDelegate callback)
	{
		m_onGetPurchase = callback;
	}

	public void SetOnGetPurchaseResponse(string callback)
	{
		m_onGetPurchaseStringFunc = callback;
	}

	public void SetOnBuyResponse(PaymentsDelegate callback)
	{
		m_onBuy = callback;
	}

	public void SetOnBuyResponse(string callback)
	{
		m_onBuyStringFunc = callback;
	}

	private void OnInitResponse(string result)
	{
		if (m_onInit != null)
		{
			m_onInit(bool.Parse(result));
		}
		if (m_onInitStringFunc != null && !ScriptManager.GetInstance().CallFunction(m_onInitStringFunc, bool.Parse(result)))
		{
			Core.Unity.Debug.LogError(string.Format("[PayManager OnInitResponse] called, lua on_init function failed > " + m_onInitStringFunc.ToString()));
		}
	}

	private void OnGetPurchaseResponse(string result)
	{
		UnityEngine.Debug.Log("OnGetPurchaseResponse called, result: " + result);
		List<Payment> list = new List<Payment>();
		try
		{
			JSONNode jSONNode = JSONNode.Parse(result);
			JSONArray asArray = jSONNode.AsArray;
			for (int i = 0; i < asArray.Count; i++)
			{
				JSONNode jSONNode2 = JSONNode.Parse(asArray[i]);
				string text = jSONNode2["purchase"];
				UnityEngine.Debug.Log(string.Format("OnGetPurchaseResponse called, purchase{0}: {1}", i, text));
				byte[] buffer = System.Convert.FromBase64String(text);
				MemoryStream memoryStream = new MemoryStream(buffer);
				memoryStream.Position = 0L;
				StreamReader streamReader = new StreamReader(memoryStream);
				string text2 = streamReader.ReadToEnd();
				UnityEngine.Debug.Log("OnGetPurchaseResponse called, purchase decode: " + text2);
				Payment payment = new Payment();
				JSONNode jSONNode3 = JSONNode.Parse(text2);
				payment.key = jSONNode3["purchaseToken"];
				payment.id = jSONNode3["orderId"];
				payment.state = jSONNode3["purchaseToken"].AsInt;
				payment.productId = jSONNode3["productId"];
				payment.productQuantity = 1;
				list.Add(payment);
			}
		}
		catch (Exception ex)
		{
			UnityEngine.Debug.Log("OnGetPurchaseResponse Exception: " + ex.ToString());
		}
		if (m_onGetPurchase != null)
		{
			m_onGetPurchase(list);
		}
		if (m_onGetPurchaseStringFunc != null && !ScriptManager.GetInstance().CallFunction(m_onGetPurchaseStringFunc, list))
		{
			Core.Unity.Debug.LogError(string.Format("[PayManager OnGetPurchaseResponse] called, lua on_get_purchase function failed > " + m_onGetPurchaseStringFunc.ToString()));
		}
	}

	private void OnBuyProductResponse(string result)
	{
		UnityEngine.Debug.Log("OnBuyProductResponse called, result: " + result);
		List<Payment> list = new List<Payment>();
		string[] array = result.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (array.Length >= 3)
		{
			string aJSON = array[2];
			string empty = string.Empty;
			try
			{
				JSONNode jSONNode = JSONNode.Parse(aJSON);
				empty = jSONNode["purchase"];
				UnityEngine.Debug.Log("OnBuyProductResponse called, purchase: " + empty);
				byte[] buffer = System.Convert.FromBase64String(empty);
				MemoryStream memoryStream = new MemoryStream(buffer);
				memoryStream.Position = 0L;
				StreamReader streamReader = new StreamReader(memoryStream);
				string text = streamReader.ReadToEnd();
				UnityEngine.Debug.Log("OnBuyProductResponse called, purchase decode: " + text);
				Payment payment = new Payment();
				JSONNode jSONNode2 = JSONNode.Parse(text);
				payment.key = jSONNode2["purchaseToken"];
				payment.id = jSONNode2["orderId"];
				payment.state = jSONNode2["purchaseToken"].AsInt;
				payment.productId = jSONNode2["productId"];
				payment.productQuantity = 1;
				list.Add(payment);
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.Log("OnBuyProductResponse Exception: " + ex.ToString());
			}
			if (m_onBuy != null)
			{
				m_onBuy(list);
			}
			if (m_onBuyStringFunc != null && !ScriptManager.GetInstance().CallFunction(m_onBuyStringFunc, list))
			{
				Core.Unity.Debug.LogError(string.Format("[PayManager OnBuyProductResponse] called, lua on_buy function failed > " + m_onBuyStringFunc.ToString()));
			}
		}
	}

	private void OnUpdateTransaction(string result)
	{
		UnityEngine.Debug.Log("OnUpdateTransaction called, value: " + result);
		JSONNode jSONNode = JSONNode.Parse(result);
		JSONArray asArray = jSONNode["unfinish"].AsArray;
		List<Payment> list = new List<Payment>();
		for (int i = 0; i < asArray.Count; i++)
		{
			Payment payment = new Payment();
			payment.key = asArray[i]["key"];
			payment.id = asArray[i]["identifier"];
			payment.receipt = asArray[i]["receipt"];
			payment.state = asArray[i]["state"].AsInt;
			payment.errorCode = asArray[i]["error_code"].AsInt;
			payment.errorInfo = asArray[i]["error_info"];
			payment.productId = asArray[i]["product_identifier"];
			payment.productQuantity = asArray[i]["product_quantity"].AsInt;
			list.Add(payment);
		}
		if (m_onBuy != null)
		{
			m_onBuy(list);
		}
		if (m_onBuyStringFunc != null && !ScriptManager.GetInstance().CallFunction(m_onBuyStringFunc, list))
		{
			Core.Unity.Debug.LogError(string.Format("[PayManager OnUpdateTransaction] called, lua on_buy function failed >" + m_onBuyStringFunc.ToString()));
		}
	}

	private void OnResponseProducts(string result)
	{
		if (m_onResponseProduct != null)
		{
			m_onResponseProduct(result);
		}
		if (m_onResponseProductStringFunc != null && !ScriptManager.GetInstance().CallFunction(m_onResponseProductStringFunc, result))
		{
			Core.Unity.Debug.LogError(string.Format("[PayManager OnResponseProducts] called, lua on_response_product function failed > " + m_onResponseProductStringFunc.ToString()));
		}
	}
}
