using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("NGUI/Interaction/EnchanceSVItem")]
internal class EnchanceSVItem : MonoBehaviour
{
	private Dictionary<int, UISprite> spList;

	private Dictionary<int, UITexture> texList;

	private Dictionary<int, UIWidget> wgList;

	private Dictionary<int, UIPanel> panelList;

	private Dictionary<int, UILabel> labelList;

	private Dictionary<int, int> baseDepthList;

	private Dictionary<int, Color> baseTextColorList;

	private Dictionary<int, Color> baseTextEffectColorList;

	public List<GameObject> colorControlList = new List<GameObject>();

	public bool autoFindEnchanceScollView;

	private int _depth = -1;

	private EnchanceScollView scollview;

	private GameObject go;

	private UISprite sp;

	private UITexture tex;

	private UIWidget wg;

	private UILabel lab;

	private UIPanel panel;

	private Color baseColor;

	private Color baseEffectColor;

	private int i;

	private int count;

	private int baseDepth;

	private void Start()
	{
		if (!autoFindEnchanceScollView)
		{
			return;
		}
		scollview = GetComponentInParent<EnchanceScollView>();
		if (scollview != null)
		{
			BoxCollider component = base.transform.GetComponent<BoxCollider>();
			if (component != null)
			{
				UIEventListener.Get(base.gameObject).onDragStart = scollview.onDragStart;
				UIEventListener.Get(base.gameObject).onDrag = scollview.onDrag;
				UIEventListener.Get(base.gameObject).onDragEnd = scollview.onDragEnd;
			}
		}
	}

	public void init()
	{
		spList = new Dictionary<int, UISprite>();
		texList = new Dictionary<int, UITexture>();
		wgList = new Dictionary<int, UIWidget>();
		panelList = new Dictionary<int, UIPanel>();
		labelList = new Dictionary<int, UILabel>();
		baseDepthList = new Dictionary<int, int>();
		baseTextColorList = new Dictionary<int, Color>();
		baseTextEffectColorList = new Dictionary<int, Color>();
		count = colorControlList.Count;
		for (i = 0; i < count; i++)
		{
			go = colorControlList[i];
			sp = go.GetComponent<UISprite>();
			tex = go.GetComponent<UITexture>();
			wg = go.GetComponent<UIWidget>();
			panel = go.GetComponent<UIPanel>();
			lab = go.GetComponent<UILabel>();
			spList[i] = sp;
			texList[i] = tex;
			wgList[i] = wg;
			panelList[i] = panel;
			labelList[i] = lab;
			if (wg != null)
			{
				int depth = wg.depth;
				baseDepthList[i] = depth;
			}
			if (panel != null)
			{
				int depth2 = panel.depth;
				baseDepthList[i] = depth2;
			}
			if (lab != null)
			{
				baseColor = lab.color;
				baseTextColorList[i] = baseColor;
				baseEffectColor = lab.effectColor;
				baseTextEffectColorList[i] = baseEffectColor;
			}
		}
	}

	public void set_color(Color color)
	{
		count = colorControlList.Count;
		for (i = 0; i < count; i++)
		{
			spList.TryGetValue(i, out sp);
			texList.TryGetValue(i, out tex);
			wgList.TryGetValue(i, out wg);
			panelList.TryGetValue(i, out panel);
			labelList.TryGetValue(i, out lab);
			baseTextColorList.TryGetValue(i, out baseColor);
			baseTextEffectColorList.TryGetValue(i, out baseEffectColor);
			baseDepthList.TryGetValue(i, out baseDepth);
			if (sp != null)
			{
				sp.color = color;
			}
			if (tex != null)
			{
				tex.color = color;
			}
			if (lab != null)
			{
				baseColor = new Color(baseColor.r * color.r, baseColor.g * color.g, baseColor.b * color.b, baseColor.a * color.a);
				lab.color = baseColor;
				lab.effectColor = new Color(baseEffectColor.r * color.r, baseEffectColor.g * color.g, baseEffectColor.b * color.b, baseEffectColor.a * color.a);
			}
			if (panel != null)
			{
				panel.alpha = color.a;
			}
		}
	}

	public void set_depth(int depth)
	{
		if (_depth == depth)
		{
			return;
		}
		_depth = depth;
		count = colorControlList.Count;
		for (i = 0; i < count; i++)
		{
			panelList.TryGetValue(i, out panel);
			wgList.TryGetValue(i, out wg);
			baseDepthList.TryGetValue(i, out baseDepth);
			if (wg != null)
			{
				wg.depth = baseDepth + depth;
			}
			if (panel != null)
			{
				panel.depth = baseDepth + depth;
			}
		}
	}
}
