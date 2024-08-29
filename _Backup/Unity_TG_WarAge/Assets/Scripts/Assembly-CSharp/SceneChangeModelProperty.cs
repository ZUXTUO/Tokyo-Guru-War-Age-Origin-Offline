using UnityEngine;

[ExecuteInEditMode]
public class SceneChangeModelProperty : MonoBehaviour
{
	public enum PropertyType
	{
		主界面 = 0,
		装备 = 1,
		结算 = 2,
		扭蛋图鉴 = 3,
		阵容 = 4,
		董香之家 = 5,
		守护者 = 6
	}

	public static bool ForceApplyProperty;

	public static PropertyType ForceType = PropertyType.装备;

	public bool[] UseGlobalColor = new bool[7] { true, true, true, true, true, true, true };

	public Color[] globalColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public Color[] bodyColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public Color[] hairColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public Color[] headColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public Color[] heziColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public Color[] hezifresnelColor = new Color[7]
	{
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white,
		Color.white
	};

	public bool[] savedState = new bool[7];

	public float[] SHfactor = new float[7];

	public float[] bloomFactor = new float[7] { 0.5f, 0.5f, 0.5f, 0.5f, 0.5f, 0.5f, 0.5f };

	public float[] outLineWidth = new float[7] { 1f, 1f, 1f, 1f, 1f, 1f, 1f };

	public Vector3[] LightDir = new Vector3[7]
	{
		Vector3.one,
		Vector3.one,
		Vector3.one,
		Vector3.one,
		Vector3.one,
		Vector3.one,
		Vector3.one
	};

	public Quaternion[] lq = new Quaternion[7]
	{
		Quaternion.identity,
		Quaternion.identity,
		Quaternion.identity,
		Quaternion.identity,
		Quaternion.identity,
		Quaternion.identity,
		Quaternion.identity
	};

	private Material materialbody;

	private Material materialhair;

	private Material materialhead;

	private Material materialhezi;

	public bool canChangeProperty;

	public PropertyType type = PropertyType.阵容;

	private void OnEnable()
	{
		Init();
		ChangeModelProperty componentInParent = base.transform.GetComponentInParent<ChangeModelProperty>();
		if (componentInParent != null)
		{
			canChangeProperty = true;
			type = componentInParent.currentType;
		}
		else
		{
			canChangeProperty = false;
		}
		if (canChangeProperty)
		{
			ApplyProperty();
		}
	}

	private void Init()
	{
		Renderer[] componentsInChildren = base.transform.GetComponentsInChildren<Renderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (!(componentsInChildren[i].sharedMaterial != null))
			{
				continue;
			}
			if (componentsInChildren[i].sharedMaterial.shader.name == "DyShader/TokyoGhoul/Hero_OutLine")
			{
				if (componentsInChildren[i].transform.name.Contains("body"))
				{
					materialbody = componentsInChildren[i].material;
				}
				else if (componentsInChildren[i].transform.name.Contains("hair"))
				{
					materialhair = componentsInChildren[i].material;
				}
				else if (componentsInChildren[i].transform.name.Contains("head"))
				{
					materialhead = componentsInChildren[i].material;
				}
				else if (componentsInChildren[i].transform.name.Contains("face"))
				{
					materialhead = componentsInChildren[i].material;
				}
			}
			if (componentsInChildren[i].sharedMaterial.shader.name == "DyShader/TokyoGhoul/weapon_2.0" || componentsInChildren[i].sharedMaterial.shader.name == "DyShader/TokyoGhoul/weapon_normal")
			{
				materialhezi = componentsInChildren[i].material;
			}
		}
	}

	public void checkDataIsFull()
	{
		if (savedState == null || savedState.GetType() == typeof(bool) || UseGlobalColor == null || UseGlobalColor.GetType() == typeof(bool) || globalColor == null || globalColor.GetType() == typeof(Color) || bodyColor == null || bodyColor.GetType() == typeof(Color) || headColor == null || headColor.GetType() == typeof(Color) || heziColor == null || heziColor.GetType() == typeof(Color) || hairColor == null || hairColor.GetType() == typeof(Color) || hezifresnelColor == null || hezifresnelColor.GetType() == typeof(Color) || SHfactor == null || SHfactor.GetType() == typeof(float) || outLineWidth == null || outLineWidth.GetType() == typeof(float) || bloomFactor == null || bloomFactor.GetType() == typeof(float) || LightDir == null || LightDir.GetType() == typeof(Vector3) || lq == null || lq.GetType() == typeof(Quaternion))
		{
			savedState = new bool[7];
			UseGlobalColor = new bool[7];
			globalColor = new Color[7];
			bodyColor = new Color[7];
			headColor = new Color[7];
			heziColor = new Color[7];
			hairColor = new Color[7];
			hezifresnelColor = new Color[7];
			SHfactor = new float[7];
			bloomFactor = new float[7];
			outLineWidth = new float[7];
			LightDir = new Vector3[7];
			lq = new Quaternion[7];
			for (int i = 0; i < 7; i++)
			{
				savedState[i] = false;
				UseGlobalColor[i] = true;
				globalColor[i] = Color.white;
				bodyColor[i] = Color.white;
				headColor[i] = Color.white;
				heziColor[i] = Color.white;
				hairColor[i] = Color.white;
				hezifresnelColor[i] = Color.white;
				SHfactor[i] = 0f;
				bloomFactor[i] = 0.5f;
				outLineWidth[i] = 1f;
				LightDir[i] = Vector3.forward;
				lq[i] = Quaternion.identity;
			}
		}
		else
		{
			if (savedState.Length >= 7 && UseGlobalColor.Length >= 7 && globalColor.Length >= 7 && bodyColor.Length >= 7 && LightDir.Length >= 7 && lq.Length >= 7 && headColor.Length >= 7 && heziColor.Length >= 7 && hairColor.Length >= 7 && hezifresnelColor.Length >= 7 && SHfactor.Length >= 7 && bloomFactor.Length >= 7 && outLineWidth.Length >= 7)
			{
				return;
			}
			bool[] array = new bool[7];
			if (savedState.Length == 0)
			{
				for (int j = 0; j < 7; j++)
				{
					array[j] = false;
				}
			}
			else if (savedState.Length == 1)
			{
				array[0] = savedState[0];
				for (int k = 1; k < 7; k++)
				{
					array[k] = false;
				}
			}
			else
			{
				array[0] = savedState[0];
				array[1] = savedState[1];
				for (int l = 2; l < 7; l++)
				{
					if (savedState.Length > l)
					{
						array[l] = savedState[l];
					}
					else
					{
						array[l] = array[1];
					}
				}
			}
			savedState = array;
			bool[] array2 = new bool[7];
			if (UseGlobalColor.Length == 0)
			{
				for (int m = 0; m < 7; m++)
				{
					array2[m] = true;
				}
			}
			else if (UseGlobalColor.Length == 1)
			{
				array2[0] = UseGlobalColor[0];
				for (int n = 1; n < 7; n++)
				{
					array2[n] = true;
				}
			}
			else
			{
				array2[0] = UseGlobalColor[0];
				array2[1] = UseGlobalColor[1];
				for (int num = 2; num < 7; num++)
				{
					if (UseGlobalColor.Length > num)
					{
						array2[num] = UseGlobalColor[num];
					}
					else
					{
						array2[num] = array2[1];
					}
				}
			}
			UseGlobalColor = array2;
			Color[] array3 = new Color[7];
			if (globalColor.Length == 0)
			{
				for (int num2 = 0; num2 < 7; num2++)
				{
					array3[num2] = Color.white;
				}
			}
			else if (globalColor.Length == 1)
			{
				array3[0] = globalColor[0];
				for (int num3 = 1; num3 < 7; num3++)
				{
					array3[num3] = Color.white;
				}
			}
			else
			{
				array3[0] = globalColor[0];
				array3[1] = globalColor[1];
				for (int num4 = 2; num4 < 7; num4++)
				{
					if (globalColor.Length > num4)
					{
						array3[num4] = globalColor[num4];
					}
					else
					{
						array3[num4] = array3[1];
					}
				}
			}
			globalColor = array3;
			Color[] array4 = new Color[7];
			if (bodyColor.Length == 0)
			{
				for (int num5 = 0; num5 < 7; num5++)
				{
					array4[num5] = Color.white;
				}
			}
			else if (bodyColor.Length == 1)
			{
				array4[0] = bodyColor[0];
				for (int num6 = 1; num6 < 7; num6++)
				{
					array4[num6] = Color.white;
				}
			}
			else
			{
				array4[0] = bodyColor[0];
				array4[1] = bodyColor[1];
				for (int num7 = 2; num7 < 7; num7++)
				{
					if (bodyColor.Length > num7)
					{
						array4[num7] = bodyColor[num7];
					}
					else
					{
						array4[num7] = array4[1];
					}
				}
			}
			bodyColor = array4;
			Color[] array5 = new Color[7];
			if (headColor.Length == 0)
			{
				for (int num8 = 0; num8 < 7; num8++)
				{
					array5[num8] = Color.white;
				}
			}
			else if (headColor.Length == 1)
			{
				array5[0] = headColor[0];
				for (int num9 = 1; num9 < 7; num9++)
				{
					array5[num9] = Color.white;
				}
			}
			else
			{
				array5[0] = headColor[0];
				array5[1] = headColor[1];
				for (int num10 = 2; num10 < 7; num10++)
				{
					if (headColor.Length > num10)
					{
						array5[num10] = headColor[num10];
					}
					else
					{
						array5[num10] = array5[1];
					}
				}
			}
			headColor = array5;
			Color[] array6 = new Color[7];
			if (heziColor.Length == 0)
			{
				for (int num11 = 0; num11 < 7; num11++)
				{
					array6[num11] = Color.white;
				}
			}
			else if (heziColor.Length == 1)
			{
				array6[0] = heziColor[0];
				for (int num12 = 1; num12 < 7; num12++)
				{
					array6[num12] = Color.white;
				}
			}
			else
			{
				array6[0] = heziColor[0];
				array6[1] = heziColor[1];
				for (int num13 = 2; num13 < 7; num13++)
				{
					if (heziColor.Length > num13)
					{
						array6[num13] = heziColor[num13];
					}
					else
					{
						array6[num13] = array6[1];
					}
				}
			}
			heziColor = array6;
			Color[] array7 = new Color[7];
			if (hairColor.Length == 0)
			{
				for (int num14 = 0; num14 < 7; num14++)
				{
					array7[num14] = Color.white;
				}
			}
			else if (hairColor.Length == 1)
			{
				array7[0] = hairColor[0];
				for (int num15 = 1; num15 < 7; num15++)
				{
					array7[num15] = Color.white;
				}
			}
			else
			{
				array7[0] = hairColor[0];
				array7[1] = hairColor[1];
				for (int num16 = 2; num16 < 7; num16++)
				{
					if (hairColor.Length > num16)
					{
						array7[num16] = hairColor[num16];
					}
					else
					{
						array7[num16] = array7[1];
					}
				}
			}
			hairColor = array7;
			Color[] array8 = new Color[7];
			if (hezifresnelColor.Length == 0)
			{
				for (int num17 = 0; num17 < 7; num17++)
				{
					array8[num17] = Color.white;
				}
			}
			else if (hezifresnelColor.Length == 1)
			{
				array8[0] = hezifresnelColor[0];
				for (int num18 = 1; num18 < 7; num18++)
				{
					array8[num18] = Color.white;
				}
			}
			else
			{
				array8[0] = hezifresnelColor[0];
				array8[1] = hezifresnelColor[1];
				for (int num19 = 2; num19 < 7; num19++)
				{
					if (hezifresnelColor.Length > num19)
					{
						array8[num19] = hezifresnelColor[num19];
					}
					else
					{
						array8[num19] = array8[1];
					}
				}
			}
			hezifresnelColor = array8;
			float[] array9 = new float[7];
			if (SHfactor.Length == 0)
			{
				for (int num20 = 0; num20 < 7; num20++)
				{
					array9[num20] = 0f;
				}
			}
			else if (SHfactor.Length == 1)
			{
				array9[0] = SHfactor[0];
				for (int num21 = 1; num21 < 7; num21++)
				{
					array9[num21] = 0f;
				}
			}
			else
			{
				array9[0] = SHfactor[0];
				array9[1] = SHfactor[1];
				for (int num22 = 2; num22 < 7; num22++)
				{
					if (SHfactor.Length > num22)
					{
						array9[num22] = SHfactor[num22];
					}
					else
					{
						array9[num22] = array9[1];
					}
				}
			}
			SHfactor = array9;
			float[] array10 = new float[7];
			if (bloomFactor.Length == 0)
			{
				for (int num23 = 0; num23 < 7; num23++)
				{
					array10[num23] = 0.5f;
				}
			}
			else if (bloomFactor.Length == 1)
			{
				array10[0] = bloomFactor[0];
				for (int num24 = 1; num24 < 7; num24++)
				{
					array10[num24] = 0.5f;
				}
			}
			else
			{
				array10[0] = bloomFactor[0];
				array10[1] = bloomFactor[1];
				for (int num25 = 2; num25 < 7; num25++)
				{
					if (bloomFactor.Length > num25)
					{
						array10[num25] = bloomFactor[num25];
					}
					else
					{
						array10[num25] = array10[1];
					}
				}
			}
			bloomFactor = array10;
			float[] array11 = new float[7];
			if (outLineWidth.Length == 0)
			{
				for (int num26 = 0; num26 < 7; num26++)
				{
					array11[num26] = 1f;
				}
			}
			else if (outLineWidth.Length == 1)
			{
				array11[0] = outLineWidth[0];
				for (int num27 = 1; num27 < 7; num27++)
				{
					array11[num27] = 1f;
				}
			}
			else
			{
				array11[0] = outLineWidth[0];
				array11[1] = outLineWidth[1];
				for (int num28 = 2; num28 < 7; num28++)
				{
					if (outLineWidth.Length > num28)
					{
						array11[num28] = outLineWidth[num28];
					}
					else
					{
						array11[num28] = array11[1];
					}
				}
			}
			outLineWidth = array11;
			Vector3[] array12 = new Vector3[7];
			if (LightDir.Length == 0)
			{
				for (int num29 = 0; num29 < 7; num29++)
				{
					array12[num29] = Vector3.one;
				}
			}
			else if (LightDir.Length == 1)
			{
				array12[0] = LightDir[0];
				for (int num30 = 1; num30 < 7; num30++)
				{
					array12[num30] = Vector3.one;
				}
			}
			else
			{
				array12[0] = LightDir[0];
				array12[1] = LightDir[1];
				for (int num31 = 2; num31 < 7; num31++)
				{
					if (LightDir.Length > num31)
					{
						array12[num31] = LightDir[num31];
					}
					else
					{
						array12[num31] = array12[1];
					}
				}
			}
			LightDir = array12;
			Quaternion[] array13 = new Quaternion[7];
			if (lq.Length == 0)
			{
				for (int num32 = 0; num32 < 7; num32++)
				{
					array13[num32] = Quaternion.identity;
				}
			}
			else if (lq.Length == 1)
			{
				array13[0] = lq[0];
				for (int num33 = 1; num33 < 7; num33++)
				{
					array13[num33] = Quaternion.identity;
				}
			}
			else
			{
				array13[0] = lq[0];
				array13[1] = lq[1];
				for (int num34 = 2; num34 < 7; num34++)
				{
					if (lq.Length > num34)
					{
						array13[num34] = lq[num34];
					}
					else
					{
						array13[num34] = array13[1];
					}
				}
			}
			lq = array13;
		}
	}

	public void CopyProperty(SceneChangeModelProperty scmp)
	{
		type = scmp.type;
		for (int i = 0; i < 7; i++)
		{
			savedState[i] = scmp.savedState[i];
			UseGlobalColor[i] = scmp.UseGlobalColor[i];
			globalColor[i] = scmp.globalColor[i];
			bodyColor[i] = scmp.bodyColor[i];
			headColor[i] = scmp.headColor[i];
			hairColor[i] = scmp.hairColor[i];
			heziColor[i] = scmp.heziColor[i];
			hezifresnelColor[i] = scmp.hezifresnelColor[i];
			SHfactor[i] = scmp.SHfactor[i];
			bloomFactor[i] = scmp.bloomFactor[i];
			outLineWidth[i] = scmp.outLineWidth[i];
			LightDir[i] = scmp.LightDir[i];
			lq[i] = scmp.lq[i];
		}
	}

	public void CopySingleSceneProperty(PropertyType from, PropertyType to)
	{
		checkDataIsFull();
		savedState[(int)to] = savedState[(int)from];
		UseGlobalColor[(int)to] = UseGlobalColor[(int)from];
		globalColor[(int)to] = globalColor[(int)from];
		bodyColor[(int)to] = bodyColor[(int)from];
		headColor[(int)to] = headColor[(int)from];
		hairColor[(int)to] = hairColor[(int)from];
		heziColor[(int)to] = heziColor[(int)from];
		hezifresnelColor[(int)to] = hezifresnelColor[(int)from];
		SHfactor[(int)to] = SHfactor[(int)from];
		bloomFactor[(int)to] = bloomFactor[(int)from];
		outLineWidth[(int)to] = outLineWidth[(int)from];
		LightDir[(int)to] = LightDir[(int)from];
		lq[(int)to] = lq[(int)from];
	}

	public void ApplyProperty(bool forceApply = false, bool isEditorGlobalSet = false)
	{
		checkDataIsFull();
		if (isEditorGlobalSet)
		{
			type = ForceType;
		}
		if (materialbody != null)
		{
			materialbody.SetColor("_Color", (!UseGlobalColor[(int)type]) ? bodyColor[(int)type] : globalColor[(int)type]);
			materialbody.SetVector("_LightDir", LightDir[(int)type]);
			materialbody.SetFloat("_SelfBloomFactor", bloomFactor[(int)type]);
			materialbody.SetFloat("_OutLineWidth", outLineWidth[(int)type]);
			if (materialbody.HasProperty("_SHfactor"))
			{
				materialbody.SetFloat("_SHfactor", SHfactor[(int)type]);
			}
		}
		if (materialhair != null)
		{
			materialhair.SetColor("_Color", (!UseGlobalColor[(int)type]) ? hairColor[(int)type] : globalColor[(int)type]);
			materialhair.SetVector("_LightDir", LightDir[(int)type]);
			materialhair.SetFloat("_SelfBloomFactor", bloomFactor[(int)type]);
			materialhair.SetFloat("_OutLineWidth", outLineWidth[(int)type]);
			if (materialhair.HasProperty("_SHfactor"))
			{
				materialhair.SetFloat("_SHfactor", SHfactor[(int)type]);
			}
		}
		if (materialhead != null)
		{
			materialhead.SetColor("_Color", (!UseGlobalColor[(int)type]) ? headColor[(int)type] : globalColor[(int)type]);
			materialhead.SetVector("_LightDir", LightDir[(int)type]);
			materialhead.SetFloat("_SelfBloomFactor", bloomFactor[(int)type]);
			materialhead.SetFloat("_OutLineWidth", outLineWidth[(int)type]);
			if (materialhead.HasProperty("_SHfactor"))
			{
				materialhead.SetFloat("_SHfactor", SHfactor[(int)type]);
			}
		}
		if (materialhezi != null)
		{
			materialhezi.SetColor("_Color", heziColor[(int)type]);
			materialhezi.SetFloat("_OutLineWidth", outLineWidth[(int)type]);
			if (materialhezi.HasProperty("_LightDir"))
			{
				materialhezi.SetVector("_LightDir", LightDir[(int)type]);
			}
			if (materialhezi.HasProperty("_fresnelcolor"))
			{
				materialhezi.SetColor("_fresnelcolor", hezifresnelColor[(int)type]);
			}
			if (materialhezi.HasProperty("_SHfactor"))
			{
				materialhezi.SetFloat("_SHfactor", SHfactor[(int)type]);
			}
			materialhezi.SetFloat("_SelfBloomFactor", bloomFactor[(int)type]);
		}
	}
}
