namespace Core.Scene
{
	public class SceneResourceRequest4
	{
		public string[] relPaths;

		public SceneResourceRequest4(string[] parmRelPaths)
		{
			int num = 0;
			if (parmRelPaths != null)
			{
				num = parmRelPaths.Length;
				relPaths = new string[num];
				for (int i = 0; i < num; i++)
				{
					relPaths[i] = ((parmRelPaths[i] == null) ? string.Empty : parmRelPaths[i]);
				}
			}
			else
			{
				relPaths = new string[num];
			}
		}
	}
}
