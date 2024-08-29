Shader "Unlit/Transparent UV Mask 2Tex" {
	Properties {
		[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("Source Blend Mode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("Dest Blend Mode", Float) = 10
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_SecondTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_StartRate1 ("StartRate1", Range(0, 1)) = 0
		_SwitchStartRate1 ("SwitchStartRate1", Range(0, 1)) = 0
		_SwitchEndRate1 ("SwitchEndRate1", Range(0, 1)) = 1
		_EndRate1 ("EndRate1", Range(0, 1)) = 1
		_StartRate2 ("StartRate2", Range(0, 1)) = 0
		_SwitchStartRate2 ("SwitchStartRate2", Range(0, 1)) = 0
		_SwitchEndRate2 ("SwitchEndRate2", Range(0, 1)) = 1
		_EndRate2 ("EndRate2", Range(0, 1)) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}