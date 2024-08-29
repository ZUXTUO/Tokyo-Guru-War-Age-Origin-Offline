Shader "Custom/dg01" {
	Properties {
		_color ("color", Vector) = (0.5,0.5,0.5,1)
		_diffuse ("diffuse", 2D) = "white" {}
		_alpha ("alpha", 2D) = "white" {}
		_U ("U", Float) = 0
		_V ("V", Float) = 0
		_QD ("QD", Float) = 1
		_alp_qd ("alp_qd", Float) = 1.25
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = 1;
		}
		ENDCG
	}
	Fallback "Diffuse"
	//CustomEditor "ShaderForgeMaterialInspector"
}