public class NcDontActive : NcEffectBehaviour
{
	private void Awake()
	{
		base.gameObject.active = false;
	}

	private void OnEnable()
	{
		base.gameObject.active = false;
	}
}
