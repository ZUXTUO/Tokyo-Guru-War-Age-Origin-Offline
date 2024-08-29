using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
[ExecuteInEditMode]
[RequireComponent(typeof(LineRenderer))]
[RequireComponent(typeof(UISprite))]
public class BezierPathSpline : MonoBehaviour
{
	public delegate void TweenEndCallBack(int index);

	public enum LineType
	{
		StraightLine = 0,
		OneCtrlCurv = 1,
		TwoCtrlCurv = 2
	}

	[Serializable]
	public class LineInfo
	{
		public LineType type;

		public Vector3 keyStart;

		public Vector3 keyEnd;

		public Vector3 ctrlStart;

		public Vector3 ctrlEnd;

		public float length;
	}

	public TweenEndCallBack tweenShowEndCall;

	public TweenEndCallBack tweenSwitchEndCall;

	public List<LineInfo> lines;

	public bool usePos;

	public bool updateChange = true;

	public Material lineMaterial;

	public LineRenderer lineRenderer;

	public float lineWidth = 0.02f;

	private int curveCount;

	private int layerOrder;

	public int SEGMENT_COUNT = 20;

	private float showRate;

	private float switchRate;

	private float targetSwitchRate;

	private float targetShowRate;

	private UISprite sprite;

	private float tweenShowRateTimeCount;

	private float targetTweenShowRateTime;

	private float tweenSwitchRateTimeCount;

	private float targetTweenSwitchRateTime;

	private int curShowIndex = 1;

	private int curSwitchIndex = 1;

	private void Start()
	{
		if (!lineRenderer)
		{
			lineRenderer = GetComponent<LineRenderer>();
		}
		lineRenderer.sortingLayerID = layerOrder;
		sprite = GetComponent<UISprite>();
		Renderer component = sprite.GetComponent<Renderer>();
		lineRenderer.sharedMaterial = lineMaterial;
		lineRenderer.numCornerVertices = 8;
		lineRenderer.numCapVertices = 4;
		lineRenderer.startWidth = lineWidth;
		lineRenderer.endWidth = lineWidth;
		if (sprite != null && sprite.drawCall != null)
		{
			lineRenderer.sharedMaterial.renderQueue = sprite.drawCall.finalRenderQueue;
		}
	}

	private void Update()
	{
		if (lineRenderer.sharedMaterial != lineMaterial)
		{
			lineRenderer.sharedMaterial = lineMaterial;
		}
		if (updateChange)
		{
			DrawCurve();
		}
		if (targetTweenShowRateTime > 0f)
		{
			tweenShowRateTimeCount += Time.deltaTime;
			if (tweenShowRateTimeCount >= targetTweenShowRateTime)
			{
				targetTweenShowRateTime = -1f;
				SetShowRate(targetShowRate);
				if (tweenShowEndCall != null)
				{
					tweenShowEndCall(curShowIndex);
				}
			}
			else
			{
				SetShowRate(showRate + (targetShowRate - showRate) * (tweenShowRateTimeCount / targetTweenShowRateTime));
			}
		}
		if (!(targetTweenSwitchRateTime > 0f))
		{
			return;
		}
		tweenSwitchRateTimeCount += Time.deltaTime;
		if (tweenSwitchRateTimeCount >= targetTweenSwitchRateTime)
		{
			targetTweenSwitchRateTime = -1f;
			SetSwitchRate(targetSwitchRate);
			if (tweenSwitchEndCall != null)
			{
				tweenSwitchEndCall(curSwitchIndex);
			}
		}
		else
		{
			SetSwitchRate(switchRate + (targetSwitchRate - switchRate) * (tweenSwitchRateTimeCount / targetTweenSwitchRateTime));
		}
	}

	public void SetSwitchRate(float rate)
	{
		lineRenderer.sharedMaterial.SetFloat("_SwitchRate", rate);
	}

	public void SetShowRate(float rate)
	{
		lineRenderer.sharedMaterial.SetFloat("_ShowRate", rate);
	}

	public void TweenToShowIndex(int index, float time = 1f)
	{
		if (index >= 0 && index <= lines.Count)
		{
			curShowIndex = index;
		}
		tweenShowRateTimeCount = 0f;
		if (index > 0)
		{
			targetShowRate = lines[curShowIndex - 1].length / lines[lines.Count - 1].length;
		}
		else
		{
			targetShowRate = 0f;
		}
		targetTweenShowRateTime = time;
		showRate = lineRenderer.sharedMaterial.GetFloat("_ShowRate");
	}

	public void TweenToSwitchIndex(int index, float time = 1f)
	{
		if (index >= 0 && index <= lines.Count)
		{
			curSwitchIndex = index;
		}
		tweenSwitchRateTimeCount = 0f;
		if (index > 0)
		{
			targetSwitchRate = lines[curSwitchIndex - 1].length / lines[lines.Count - 1].length;
		}
		else
		{
			targetSwitchRate = 0f;
		}
		targetTweenSwitchRateTime = time;
		switchRate = lineRenderer.sharedMaterial.GetFloat("_SwitchRate");
	}

	public void SetShowIndex(int index)
	{
		if (index >= 0 && index <= lines.Count)
		{
			curShowIndex = index;
		}
		if (index > 0)
		{
			targetShowRate = lines[curShowIndex - 1].length / lines[lines.Count - 1].length;
		}
		else
		{
			targetShowRate = 0f;
		}
		SetShowRate(targetShowRate);
	}

	public void SetSwitchIndex(int index)
	{
		if (index >= 0 && index <= lines.Count)
		{
			curSwitchIndex = index;
		}
		if (index > 0)
		{
			targetSwitchRate = lines[curSwitchIndex - 1].length / lines[lines.Count - 1].length;
		}
		else
		{
			targetSwitchRate = 0f;
		}
		SetSwitchRate(targetSwitchRate);
	}

	public void AddKeyPoint(int index = -1)
	{
		if (index > 0 && lines.Count > index)
		{
			LineInfo lineInfo = new LineInfo();
			LineInfo lineInfo2 = lines[index - 1];
			LineInfo lineInfo3 = lines[index];
			lineInfo.keyStart = lineInfo2.keyEnd;
			lineInfo.keyEnd = new Vector3(lineInfo2.keyEnd.x, lineInfo2.keyEnd.y + 0.25f, 0f);
			lineInfo3.keyStart = lineInfo.keyEnd;
			lines.Insert(index, lineInfo);
		}
		else if (index == 0)
		{
			LineInfo lineInfo4 = new LineInfo();
			LineInfo lineInfo5 = lines[0];
			lineInfo4.keyStart = new Vector3(lineInfo5.keyStart.x - 0.25f, lineInfo5.keyStart.y, 0f);
			lineInfo4.keyEnd = lineInfo5.keyStart;
			lines.Insert(0, lineInfo4);
		}
		else
		{
			if (lines == null)
			{
				lines = new List<LineInfo>();
			}
			if (lines.Count == 0)
			{
				LineInfo lineInfo6 = new LineInfo();
				lineInfo6.keyStart = new Vector3(base.transform.position.x, base.transform.position.y, base.transform.position.z);
				lineInfo6.keyEnd = new Vector3(base.transform.position.x + 0.25f, base.transform.position.y, base.transform.position.z);
				lines.Add(lineInfo6);
			}
			else
			{
				LineInfo lineInfo7 = new LineInfo();
				lineInfo7.keyStart = lines[lines.Count - 1].keyEnd;
				lineInfo7.keyEnd = new Vector3(lineInfo7.keyStart.x + 0.25f, lineInfo7.keyStart.y, lineInfo7.keyStart.z);
				lines.Add(lineInfo7);
			}
		}
		DrawCurve();
	}

	public void DelLine(int index)
	{
		if (lines.Count > index)
		{
			lines.RemoveAt(index);
		}
	}

	public void DrawCurve()
	{
		if (lines == null)
		{
			return;
		}
		float num = 0f;
		int num2 = 0;
		for (int i = 0; i < lines.Count; i++)
		{
			LineInfo lineInfo = lines[i];
			if (i == 0)
			{
				lineRenderer.positionCount = 1;
				lineRenderer.SetPosition(0, lineInfo.keyStart);
			}
			if (lineInfo.type == LineType.StraightLine)
			{
				num2 = 2;
				for (int j = 1; j <= num2; j++)
				{
					float rate = (float)j / (float)num2;
					Vector3 vector = Point.interpolate(lineInfo.keyStart, lineInfo.keyEnd, rate);
					lineRenderer.positionCount += 1;
					lineRenderer.SetPosition(lineRenderer.positionCount - 1, vector);
					if (lineRenderer.positionCount > 1)
					{
						num += Vector3.Distance(lineRenderer.GetPosition(lineRenderer.positionCount - 2), vector);
					}
				}
				lineInfo.length = num;
			}
			else if (lineInfo.type == LineType.OneCtrlCurv)
			{
				num2 = SEGMENT_COUNT;
				for (int k = 1; k <= num2; k++)
				{
					float t = (float)k / (float)num2;
					Vector3 vector2 = CalculateCubicBezierPoint(t, lineInfo.keyStart, lineInfo.ctrlStart, lineInfo.ctrlStart, lineInfo.keyEnd);
					lineRenderer.positionCount += 1;
					lineRenderer.SetPosition(lineRenderer.positionCount - 1, vector2);
					if (lineRenderer.positionCount > 1)
					{
						num += Vector3.Distance(lineRenderer.GetPosition(lineRenderer.positionCount - 2), vector2);
					}
				}
				lineInfo.length = num;
			}
			else
			{
				if (lineInfo.type != LineType.TwoCtrlCurv)
				{
					continue;
				}
				num2 = SEGMENT_COUNT;
				for (int l = 1; l <= num2; l++)
				{
					float t2 = (float)l / (float)num2;
					Vector3 vector3 = CalculateCubicBezierPoint(t2, lineInfo.keyStart, lineInfo.ctrlStart, lineInfo.ctrlEnd, lineInfo.keyEnd);
					lineRenderer.positionCount += 1;
					lineRenderer.SetPosition(lineRenderer.positionCount - 1, vector3);
					if (lineRenderer.positionCount > 1)
					{
						num += Vector3.Distance(lineRenderer.GetPosition(lineRenderer.positionCount - 2), vector3);
					}
				}
				lineInfo.length = num;
			}
		}
	}

	private bool Intersect(Vector3 aa, Vector3 bb, Vector3 cc, Vector3 dd)
	{
		if (Mathf.Max(aa.x, bb.x) < Mathf.Min(cc.x, dd.x))
		{
			return false;
		}
		if (Mathf.Max(aa.y, bb.y) < Mathf.Min(cc.y, dd.y))
		{
			return false;
		}
		if (Mathf.Max(cc.x, dd.x) < Mathf.Min(aa.x, bb.x))
		{
			return false;
		}
		if (Mathf.Max(cc.y, dd.y) < Mathf.Min(aa.y, bb.y))
		{
			return false;
		}
		if (mult(cc, bb, aa) * mult(bb, dd, aa) < 0f)
		{
			return false;
		}
		if (mult(aa, dd, cc) * mult(dd, bb, cc) < 0f)
		{
			return false;
		}
		return true;
	}

	private float mult(Vector3 a, Vector3 b, Vector3 c)
	{
		return (a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y);
	}

	public static Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3)
	{
		float num = 1f - t;
		float num2 = t * t;
		float num3 = num * num;
		float num4 = num3 * num;
		float num5 = num2 * t;
		Vector3 vector = num4 * p0;
		vector += 3f * num3 * t * p1;
		vector += 3f * num * num2 * p2;
		return vector + num5 * p3;
	}

	public static Vector3[] GetCalPoint(Vector3 p0, Vector3 p1, Vector3 p2, float rate = 1f)
	{
		Vector3[] array = new Vector3[2];
		Vector3 pointA = Point.interpolate(p0, p1);
		Vector3 vector = Point.interpolate(p1, p2);
		Vector3 pointB = Point.interpolate(pointA, vector);
		pointB = Point.dec(p1, pointB);
		pointA = Point.add(pointA, pointB);
		vector = Point.add(vector, pointB);
		pointA = Point.interpolate(p1, pointA, rate);
		vector = Point.interpolate(p1, vector, rate);
		array[0] = pointA;
		array[1] = vector;
		return array;
	}

	private void OnGUIXX()
	{
		GUILayout.BeginHorizontal();
		if (GUILayout.Button("ADDShowRate"))
		{
			targetShowRate = lineRenderer.sharedMaterial.GetFloat("_ShowRate") + 0.01f;
			if (targetShowRate > 1f)
			{
				targetShowRate = 1f;
			}
			SetShowRate(targetShowRate);
		}
		if (GUILayout.Button("DECShowRate"))
		{
			targetShowRate = lineRenderer.sharedMaterial.GetFloat("_ShowRate") - 0.01f;
			if (targetShowRate < 0f)
			{
				targetShowRate = 0f;
			}
			SetShowRate(targetShowRate);
		}
		if (GUILayout.Button("ADDSwitchRate"))
		{
			targetSwitchRate = lineRenderer.sharedMaterial.GetFloat("_SwitchRate") + 0.01f;
			if (targetSwitchRate > 1f)
			{
				targetSwitchRate = 1f;
			}
			SetShowRate(targetSwitchRate);
		}
		if (GUILayout.Button("DECSwitchRate"))
		{
			targetSwitchRate = lineRenderer.sharedMaterial.GetFloat("_SwitchRate") - 0.01f;
			if (targetSwitchRate < 0f)
			{
				targetSwitchRate = 0f;
			}
			SetShowRate(targetSwitchRate);
		}
		if (GUILayout.Button("AddShowIndex"))
		{
			TweenToShowIndex(curShowIndex + 1);
		}
		if (GUILayout.Button("DECShowIndex"))
		{
			TweenToShowIndex(curShowIndex - 1);
		}
		if (GUILayout.Button("AddSwitchIndex"))
		{
			TweenToSwitchIndex(curSwitchIndex + 1);
		}
		if (GUILayout.Button("DECSwitchIndex"))
		{
			TweenToSwitchIndex(curSwitchIndex - 1);
		}
		GUILayout.EndHorizontal();
	}
}
