Shader "cgwell/Dissolution_Blend" {
	Properties {
		_TintColor ("Color&Alpha", Vector) = (1,1,1,1)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
		_N_mask ("N_mask", Float) = 0.3
		_T_mask ("T_mask", 2D) = "white" {}
		_C_BYcolor ("C_BYcolor", Vector) = (1,0,0,1)
		_N_BY_QD ("N_BY_QD", Float) = 3
		_N_BY_KD ("N_BY_KD", Float) = 0.01
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
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
	Fallback "Diffuse"
	//CustomEditor "ShaderForgeMaterialInspector"
}