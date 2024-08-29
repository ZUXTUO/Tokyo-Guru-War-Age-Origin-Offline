Shader "DyShader/TokyoGhoul/weapon_fx_transparent" {
	Properties {
		_color ("color", 2D) = "white" {}
		_move ("move", 2D) = "black" {}
		_u_speed ("u_speed", Float) = 0.3
		_v_speed ("v_speed", Float) = 0.2
		_fresnelpower ("fresnel-power", Float) = 0.2
		_fresnelcolor ("fresnel-color", Vector) = (0.3261246,0.7647059,0.6558168,1)
		_moveColor2 ("moveColor2", Vector) = (0.8897059,0.1242972,0.3618377,1)
		_breath_speed ("breath_speed", Float) = 1
		_breath_min ("breath_min", Float) = 0.2
		_move_copy ("move_copy", 2D) = "black" {}
		_innerAlpha ("内部透明度", Range(0, 2)) = 1
		_rimAlpha ("边缘透明度", Range(0, 2)) = 1
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