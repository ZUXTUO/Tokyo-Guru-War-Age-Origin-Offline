Shader "Shader Forge/rongjie_Dissolve" {
	Properties {
		_DiffuseTint ("DiffuseTint", Vector) = (0.5,0.5,0.5,1)
		_specGlass ("specGlass", Range(1, 11)) = 7.456789
		_Specintensity ("Specintensity", Range(0, 1)) = 1
		_BlendAmount ("BlendAmount", Range(0, 1)) = 1
		_node_37 ("node_37", 2D) = "white" {}
		_EdgeWidth ("EdgeWidth", Range(0, 100)) = 100
		_Glowcolor ("Glowcolor", Vector) = (0.1783088,0.5140213,0.7132353,1)
		_Diffuse ("Diffuse", 2D) = "white" {}
		_Diffusecolor ("Diffusecolor", Vector) = (1,1,1,1)
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