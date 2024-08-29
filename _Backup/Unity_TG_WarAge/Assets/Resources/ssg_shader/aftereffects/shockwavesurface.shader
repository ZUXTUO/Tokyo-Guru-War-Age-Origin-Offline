Shader "DyShader/TokyoGhoul/ShockWaveSurface" {
	Properties {
		_NoiseTex ("絮乱图", 2D) = "white" {}
		_MaskTex ("遮罩图", 2D) = "RGB" {}
		_MoveSpeed ("絮乱图移动速度", Range(0, 3)) = 1
		_MoveForce ("絮乱图叠加后移动强度", Range(0, 1)) = 0.1
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
}