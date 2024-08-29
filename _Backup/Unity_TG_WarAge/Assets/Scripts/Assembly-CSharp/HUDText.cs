using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("NGUI/Examples/HUD Text")]
public class HUDText : MonoBehaviour
{
	public class HudType
	{
		public int fontSize { get; set; }

		public bool applyGradient { get; set; }

		public Color gradientTop { get; set; }

		public Color gradientBottom { get; set; }

		public UILabel.Effect effectStyle { get; set; }

		public Color effectColor { get; set; }

		public override bool Equals(object obj)
		{
			if (obj == null || !(obj is HudType))
			{
				return false;
			}
			HudType hudType = obj as HudType;
			if (hudType.applyGradient != applyGradient || hudType.effectColor != effectColor || hudType.effectStyle != effectStyle || hudType.fontSize != fontSize || hudType.gradientBottom != gradientBottom || hudType.gradientTop != gradientTop)
			{
				return false;
			}
			return true;
		}
	}

	protected class Entry
	{
		public float time;

		public float stay;

		public float offset;

		public float val;

		public UILabel label;

		public float movementStart
		{
			get
			{
				return time + stay;
			}
		}
	}

	private static Dictionary<int, HudType> DicHudTypes = new Dictionary<int, HudType>();

	[HideInInspector]
	[SerializeField]
	private UIFont font;

	private int mTypeId = -1;

	public UIFont bitmapFont;

	public Font trueTypeFont;

	public int fontSize = 20;

	public FontStyle fontStyle;

	public bool applyGradient;

	public Color gradientTop = Color.white;

	public Color gradienBottom = new Color(0.7f, 0.7f, 0.7f);

	public UILabel.Effect effect;

	public Color effectColor = Color.black;

	public AnimationCurve offsetCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(3f, 40f));

	public AnimationCurve alphaCurve = new AnimationCurve(new Keyframe(1f, 1f), new Keyframe(3f, 0f));

	public AnimationCurve scaleCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.25f, 1f));

	private List<Entry> mList = new List<Entry>();

	private List<Entry> mUnused = new List<Entry>();

	private int counter;

	private Keyframe[] mOffsets;

	private Keyframe[] mAlphas;

	private Keyframe[] mScales;

	private bool mUseDynamicFont;

	public int HTypeId
	{
		get
		{
			return mTypeId;
		}
		set
		{
			if ((value <= 0 && value == mTypeId) || !DicHudTypes.ContainsKey(value))
			{
				return;
			}
			mTypeId = value;
			HudType hudType = DicHudTypes[value];
			if (hudType != null)
			{
				fontSize = hudType.fontSize;
				applyGradient = hudType.applyGradient;
				gradientTop = hudType.gradientTop;
				gradienBottom = hudType.gradientBottom;
				effect = hudType.effectStyle;
				effectColor = hudType.effectColor;
				for (int i = 0; i < mUnused.Count; i++)
				{
					Entry entry = mUnused[i];
					entry.label.fontSize = hudType.fontSize;
					entry.label.applyGradient = hudType.applyGradient;
					entry.label.gradientTop = hudType.gradientTop;
					entry.label.gradientBottom = hudType.gradientBottom;
					entry.label.effectStyle = hudType.effectStyle;
					entry.label.effectColor = hudType.effectColor;
				}
			}
		}
	}

	public bool isVisible
	{
		get
		{
			return mList.Count != 0;
		}
	}

	public Object ambigiousFont
	{
		get
		{
			if (trueTypeFont != null)
			{
				return trueTypeFont;
			}
			if (bitmapFont != null)
			{
				return bitmapFont;
			}
			return font;
		}
		set
		{
			if (value is Font)
			{
				trueTypeFont = value as Font;
				bitmapFont = null;
				font = null;
			}
			else if (value is UIFont)
			{
				bitmapFont = value as UIFont;
				trueTypeFont = null;
				font = null;
			}
		}
	}

	public static void RegHudType(int id, HudType hType)
	{
		if (!DicHudTypes.ContainsKey(id) && hType != null)
		{
			DicHudTypes.Add(id, hType);
		}
	}

	private static int Comparison(Entry a, Entry b)
	{
		if (a.movementStart < b.movementStart)
		{
			return -1;
		}
		if (a.movementStart > b.movementStart)
		{
			return 1;
		}
		return 0;
	}

	private Entry Create()
	{
		if (mUnused.Count > 0)
		{
			Entry entry = mUnused[mUnused.Count - 1];
			mUnused.RemoveAt(mUnused.Count - 1);
			entry.time = Time.realtimeSinceStartup;
			entry.label.depth = NGUITools.CalculateNextDepth(base.gameObject);
			NGUITools.SetActive(entry.label.gameObject, true);
			entry.offset = 0f;
			mList.Add(entry);
			return entry;
		}
		Entry entry2 = new Entry();
		entry2.time = Time.realtimeSinceStartup;
		entry2.label = NGUITools.AddWidget<UILabel>(base.gameObject);
		entry2.label.name = counter.ToString();
		entry2.label.ambigiousFont = ambigiousFont;
		entry2.label.fontSize = fontSize;
		entry2.label.fontStyle = fontStyle;
		entry2.label.applyGradient = applyGradient;
		entry2.label.gradientTop = gradientTop;
		entry2.label.gradientBottom = gradienBottom;
		entry2.label.effectStyle = effect;
		entry2.label.effectColor = effectColor;
		entry2.label.overflowMethod = UILabel.Overflow.ResizeFreely;
		entry2.label.cachedTransform.localScale = new Vector3(0.001f, 0.001f, 0.001f);
		mList.Add(entry2);
		counter++;
		return entry2;
	}

	public void ChangeLisEntryProperty()
	{
		for (int i = 0; i < mUnused.Count; i++)
		{
			Entry entry = mUnused[i];
			entry.label.ambigiousFont = ambigiousFont;
			entry.label.fontSize = fontSize;
			entry.label.fontStyle = fontStyle;
			entry.label.applyGradient = applyGradient;
			entry.label.gradientTop = gradientTop;
			entry.label.gradientBottom = gradienBottom;
			entry.label.effectStyle = effect;
			entry.label.effectColor = effectColor;
		}
		for (int j = 0; j < mList.Count; j++)
		{
			Entry entry2 = mList[j];
			entry2.label.ambigiousFont = ambigiousFont;
			entry2.label.fontSize = fontSize;
			entry2.label.fontStyle = fontStyle;
			entry2.label.applyGradient = applyGradient;
			entry2.label.gradientTop = gradientTop;
			entry2.label.gradientBottom = gradienBottom;
			entry2.label.effectStyle = effect;
			entry2.label.effectColor = effectColor;
		}
	}

	private void Delete(Entry ent)
	{
		mList.Remove(ent);
		mUnused.Add(ent);
		NGUITools.SetActive(ent.label.gameObject, false);
	}

	public void AddLocalized(string text, Color c, float stayDuration)
	{
		Add(Localization.Get(text), c, stayDuration);
	}

	public void Add(object obj, Color c, float stayDuration)
	{
		if (!base.enabled)
		{
			return;
		}
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		bool flag = false;
		float num = 0f;
		if (obj is float)
		{
			flag = true;
			num = (float)obj;
		}
		else if (obj is int)
		{
			flag = true;
			num = (int)obj;
		}
		if (flag)
		{
			if (num == 0f)
			{
				return;
			}
			int num2 = mList.Count;
			while (num2 > 0)
			{
				Entry entry = mList[--num2];
				if (!(entry.time + 1f < realtimeSinceStartup) && entry.val != 0f)
				{
					if (entry.val < 0f && num < 0f)
					{
						entry.val += num;
						entry.label.text = Mathf.RoundToInt(entry.val).ToString();
						return;
					}
					if (entry.val > 0f && num > 0f)
					{
						entry.val += num;
						entry.label.text = "+" + Mathf.RoundToInt(entry.val);
						return;
					}
				}
			}
		}
		Entry entry2 = Create();
		entry2.stay = stayDuration;
		entry2.label.color = c;
		entry2.label.alpha = 0f;
		entry2.val = num;
		if (flag)
		{
			entry2.label.text = ((!(num < 0f)) ? ("+" + Mathf.RoundToInt(entry2.val)) : Mathf.RoundToInt(entry2.val).ToString());
		}
		else
		{
			entry2.label.text = obj.ToString();
		}
		mList.Sort(Comparison);
	}

	private void OnEnable()
	{
		if (font != null)
		{
			if (font.isDynamic)
			{
				trueTypeFont = font.dynamicFont;
				fontStyle = font.dynamicFontStyle;
				mUseDynamicFont = true;
			}
			else if (bitmapFont == null)
			{
				bitmapFont = font;
				mUseDynamicFont = false;
			}
			font = null;
		}
	}

	private void OnValidate()
	{
		Font font = trueTypeFont;
		UIFont uIFont = bitmapFont;
		bitmapFont = null;
		trueTypeFont = null;
		if (font != null && (uIFont == null || !mUseDynamicFont))
		{
			bitmapFont = null;
			trueTypeFont = font;
			mUseDynamicFont = true;
		}
		else if (uIFont != null)
		{
			if (uIFont.isDynamic)
			{
				trueTypeFont = uIFont.dynamicFont;
				fontStyle = uIFont.dynamicFontStyle;
				fontSize = uIFont.defaultSize;
				mUseDynamicFont = true;
			}
			else
			{
				bitmapFont = uIFont;
				mUseDynamicFont = false;
			}
		}
		else
		{
			trueTypeFont = font;
			mUseDynamicFont = true;
		}
	}

	private void OnDisable()
	{
		int num = mList.Count;
		while (num > 0)
		{
			Entry entry = mList[--num];
			if (entry.label != null)
			{
				entry.label.enabled = false;
			}
			else
			{
				mList.RemoveAt(num);
			}
		}
	}

	private void Update()
	{
		float time = RealTime.time;
		if (mOffsets == null)
		{
			mOffsets = offsetCurve.keys;
			mAlphas = alphaCurve.keys;
			mScales = scaleCurve.keys;
		}
		float time2 = mOffsets[mOffsets.Length - 1].time;
		float time3 = mAlphas[mAlphas.Length - 1].time;
		float time4 = mScales[mScales.Length - 1].time;
		float num = Mathf.Max(time4, Mathf.Max(time2, time3));
		int num2 = mList.Count;
		while (num2 > 0)
		{
			Entry entry = mList[--num2];
			float num3 = time - entry.movementStart;
			entry.offset = offsetCurve.Evaluate(num3);
			entry.label.alpha = alphaCurve.Evaluate(num3);
			float num4 = scaleCurve.Evaluate(time - entry.time);
			if (num4 < 0.001f)
			{
				num4 = 0.001f;
			}
			entry.label.cachedTransform.localScale = new Vector3(num4, num4, num4);
			if (num3 > num)
			{
				Delete(entry);
			}
			else
			{
				entry.label.enabled = true;
			}
		}
		float a = 0f;
		int num5 = mList.Count;
		while (num5 > 0)
		{
			Entry entry2 = mList[--num5];
			a = Mathf.Max(a, entry2.offset);
			entry2.label.cachedTransform.localPosition = new Vector3(0f, a, 0f);
			a += Mathf.Round(entry2.label.cachedTransform.localScale.y * (float)entry2.label.fontSize);
		}
	}
}
