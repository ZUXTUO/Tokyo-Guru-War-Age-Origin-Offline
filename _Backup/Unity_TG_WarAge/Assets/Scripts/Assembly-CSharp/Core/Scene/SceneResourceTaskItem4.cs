using System.Collections.Generic;

namespace Core.Scene
{
	public class SceneResourceTaskItem4
	{
		public List<string> unfinishPaths;

		public string[] sourcePaths;

		public SceneAssetBundle[] finishBundles;

		public SceneResourceRequest4 req;

		public SceneResourceCallback4 callbackObj;

		public SceneResourceCallbackData4 data;

		public SceneResourceTaskItem4(SceneResourceRequest4 request, SceneResourceCallback4 callb, SceneResourceCallbackData4 data)
		{
			req = request;
			callbackObj = callb;
			this.data = data;
			if (callb != null && request != null && request.relPaths != null)
			{
				int num = request.relPaths.Length;
				unfinishPaths = new List<string>(num);
				sourcePaths = new string[num];
				finishBundles = new SceneAssetBundle[num];
				for (int i = 0; i < num; i++)
				{
					unfinishPaths.Add(request.relPaths[i]);
					sourcePaths[i] = request.relPaths[i];
					finishBundles[i] = null;
				}
			}
		}

		public void SetFinishBundles(int findIdx, SceneAssetBundle assetBundle)
		{
			if (finishBundles != null)
			{
				if (assetBundle != null)
				{
					assetBundle.Retain();
				}
				if (finishBundles[findIdx] != null)
				{
					finishBundles[findIdx].Release();
				}
				finishBundles[findIdx] = assetBundle;
			}
		}

		public void Clear()
		{
			if (finishBundles == null)
			{
				return;
			}
			int i = 0;
			for (int num = finishBundles.Length; i < num; i++)
			{
				if (finishBundles[i] != null)
				{
					finishBundles[i].Release();
				}
			}
		}
	}
}
