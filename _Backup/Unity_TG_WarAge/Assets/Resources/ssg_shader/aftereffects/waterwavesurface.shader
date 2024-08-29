Shader "DyShader/TokyoGhoul/Scene/WaterWaveSurface" {
	Properties {
		_Color ("Main Color", Vector) = (0,0.15,0.115,1)
		_Specular ("Spec Color", Vector) = (1,1,1,1)
		_BaseColor ("Base Color", Vector) = (0,0,0,0.3)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_WaveMap ("Wave Map", 2D) = "bump" {}
		_WaveXSpeed ("Wave Horizontal Speed", Range(-0.1, 0.1)) = 0.01
		_WaveYSpeed ("Wave Vertical Speed", Range(-0.1, 0.1)) = 0.01
		_Distortion ("Distortion", Range(0, 100)) = 10
		_MoveX ("MoveX", Float) = 0
		_MoveY ("MoveY", Float) = 0
		_Gloss ("Gloss", Float) = 5
		_LightDir ("_LightDir", Vector) = (0,0,1,0)
		_AddSpec ("AddSpec", Range(-1, 1)) = 0
		_BumpScale ("_BumpScale", Range(0, 10)) = 1
		_DAlpha ("DAlpha", Range(0, 1)) = 1
		_SAlpha ("SAlpha", Range(0, 1)) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}