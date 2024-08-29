using System.Collections.Generic;
using Core;
using UnityEngine;

public class NodeQuickLookupHelper : MonoBehaviour, NameCacheInterface<GameObject>
{
	public string m_RootName;

	public NodeInf[] m_NodeArray;

	public Dictionary<string, GameObject> m_nodeDict;

	private bool hasLoadNodeDict;

	public void Start()
	{
		if (!hasLoadNodeDict)
		{
			hasLoadNodeDict = true;
			LoadNodeDict();
		}
	}

	public void LoadNodeDict()
	{
		if (m_NodeArray.Length > 0 && m_nodeDict == null)
		{
			m_nodeDict = new Dictionary<string, GameObject>();
		}
		for (int i = 0; i < m_NodeArray.Length; i++)
		{
			NodeInf nodeInf = m_NodeArray[i];
			if (nodeInf != null && nodeInf.m_Name != null && null != nodeInf.m_GO && !m_nodeDict.ContainsKey(nodeInf.m_Name))
			{
				m_nodeDict.Add(nodeInf.m_Name, nodeInf.m_GO);
			}
		}
	}

	public GameObject GetByName(string name)
	{
		if (!hasLoadNodeDict)
		{
			hasLoadNodeDict = true;
			LoadNodeDict();
		}
		GameObject value;
		if (m_nodeDict.TryGetValue(name, out value))
		{
			return value;
		}
		return null;
	}
}
