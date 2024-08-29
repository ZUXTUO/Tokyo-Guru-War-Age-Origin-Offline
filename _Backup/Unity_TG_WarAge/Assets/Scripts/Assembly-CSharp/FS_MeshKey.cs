using UnityEngine;

public class FS_MeshKey
{
	public bool isStatic;

	public Material mat;

	public FS_MeshKey(Material m, bool s)
	{
		isStatic = s;
		mat = m;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is FS_MeshKey))
		{
			return false;
		}
		FS_MeshKey fS_MeshKey = (FS_MeshKey)obj;
		if (fS_MeshKey.isStatic == isStatic && fS_MeshKey.mat == mat)
		{
			return true;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return isStatic.GetHashCode() ^ mat.GetHashCode();
	}
}
