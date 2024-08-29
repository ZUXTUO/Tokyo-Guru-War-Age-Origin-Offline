using UnityEngine;

public class SceneItemEditorInfo4 : MonoBehaviour
{
	public static int lightmapPriority = 1000;

	public int priority;

	public void CopyBy(SceneItemEditorInfo4 info)
	{
		priority = info.priority;
	}
}
