using System;
using System.IO;
using SimpleJSON;
using UnityEngine;

internal class Test_CSharp : MonoBehaviour
{
	private string m_InGameLog = string.Empty;

	private Vector2 m_Position = Vector2.zero;

	private void P(string aText)
	{
		m_InGameLog = m_InGameLog + aText + "\n";
	}

	private void Test()
	{
		JSONNode jSONNode = JSONNode.Parse("{\"name\":\"test\", \"array\":[1,{\"data\":\"value\"}]}");
		jSONNode["array"][1]["Foo"] = "Bar";
		P("'nice formatted' string representation of the JSON tree:");
		P(jSONNode.ToString(string.Empty));
		P(string.Empty);
		P("'normal' string representation of the JSON tree:");
		P(jSONNode.ToString());
		P(string.Empty);
		P("content of member 'name':");
		P(jSONNode["name"]);
		P(string.Empty);
		P("content of member 'array':");
		P(jSONNode["array"].ToString(string.Empty));
		P(string.Empty);
		P("first element of member 'array': " + jSONNode["array"][0]);
		P(string.Empty);
		jSONNode["array"][0].AsInt = 10;
		P("value of the first element set to: " + jSONNode["array"][0]);
		P("The value of the first element as integer: " + jSONNode["array"][0].AsInt);
		P(string.Empty);
		P("N[\"array\"][1][\"data\"] == " + jSONNode["array"][1]["data"]);
		P(string.Empty);
		string text = jSONNode.SaveToBase64();
		jSONNode = null;
		P("Serialized to Base64 string:");
		P(text);
		P("Serialized to Base64 string (compressed):");
		P(string.Empty);
		jSONNode = JSONNode.LoadFromBase64(text);
		P("Deserialized from Base64 string:");
		P(jSONNode.ToString());
		P(string.Empty);
		JSONClass jSONClass = new JSONClass();
		jSONClass["version"].AsInt = 5;
		jSONClass["author"]["name"] = "Bunny83";
		jSONClass["author"]["phone"] = "0123456789";
		jSONClass["data"][-1] = "First item\twith tab";
		jSONClass["data"][-1] = "Second item";
		jSONClass["data"][-1]["value"] = "class item";
		jSONClass["data"].Add("Forth item");
		jSONClass["data"][1] = string.Concat(jSONClass["data"][1], " 'addition to the second item'");
		jSONClass.Add("version", "1.0");
		P("Second example:");
		P(jSONClass.ToString());
		P(string.Empty);
		P("I[\"data\"][0]            : " + jSONClass["data"][0]);
		P("I[\"data\"][0].ToString() : " + jSONClass["data"][0].ToString());
		P("I[\"data\"][0].Value      : " + jSONClass["data"][0].Value);
		P(jSONClass.ToString());
	}

	private void Test1()
	{
		string text = "[{\"signature\":\"\",\"purchase\":\"eyJwYWNrYWdlTmFtZSI6ImNvbS5kaWdpdGFsc2t5LnN0YXJ3YXJzLnNlYSIsIm9yZGVySWQiOiJ0cmFuc2FjdGlvbklkLmFuZHJvaWQudGVzdC5wdXJjaGFzZWQiLCJwcm9kdWN0SWQiOiJhbmRyb2lkLnRlc3QucHVyY2hhc2VkIiwiZGV2ZWxvcGVyUGF5bG9hZCI6IiIsInB1cmNoYXNlVGltZSI6MCwicHVyY2hhc2VTdGF0ZSI6MCwicHVyY2hhc2VUb2tlbiI6ImluYXBwOmNvbS5kaWdpdGFsc2t5LnN0YXJ3YXJzLnNlYTphbmRyb2lkLnRlc3QucHVyY2hhc2VkIn0=\"}]";
		P(text);
		P("\n");
		JSONNode jSONNode = JSONNode.Parse(text);
		P(jSONNode.ToString(string.Empty));
		P("\n");
		string text2 = jSONNode[0]["purchase"];
		P(text2);
		P("\n");
		byte[] buffer = Convert.FromBase64String(text2);
		MemoryStream memoryStream = new MemoryStream(buffer);
		memoryStream.Position = 0L;
		StreamReader streamReader = new StreamReader(memoryStream);
		string aText = streamReader.ReadToEnd();
		P(aText);
	}

	private void Start()
	{
		Test1();
		Debug.Log("Test results:\n" + m_InGameLog);
	}

	private void OnGUI()
	{
		m_Position = GUILayout.BeginScrollView(m_Position);
		GUILayout.Label(m_InGameLog);
		GUILayout.EndScrollView();
	}
}
