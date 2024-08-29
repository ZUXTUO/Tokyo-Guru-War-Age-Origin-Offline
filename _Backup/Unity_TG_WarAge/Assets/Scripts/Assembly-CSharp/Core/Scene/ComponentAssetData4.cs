namespace Core.Scene
{
	public class ComponentAssetData4
	{
		public SceneAsset4[] dependencies;

		public int refCount = 1;

		public ComponentAssetData4(SceneAsset4[] dep)
		{
			dependencies = dep;
		}
	}
}
