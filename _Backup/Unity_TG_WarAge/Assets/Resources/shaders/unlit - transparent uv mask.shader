Shader "Unlit/Transparent UV Mask" {
	Properties {
		[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("Source Blend Mode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("Dest Blend Mode", Float) = 10
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_StartRate ("_StartRate", Range(0, 1)) = 1
		_SwitchStartRate ("_SwitchStartRate", Range(0, 1)) = 1
		_SwitchEndRate ("_SwitchEndRate", Range(0, 1)) = 1
		_EndRate ("_EndRate", Range(0, 1)) = 1
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