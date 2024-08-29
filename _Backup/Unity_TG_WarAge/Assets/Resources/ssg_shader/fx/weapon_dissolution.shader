Shader "TokyoGhoul/Shader Forge/weapon_disslutioin" {
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
		_blend_amount ("blend_amount", Range(0, 1)) = 0
		_dissolution_mask ("dissolution_mask", 2D) = "white" {}
		_edge_width ("edge_width", Range(0, 100)) = 0
		_glow_color ("glow_color", Vector) = (0.5,0.5,0.5,1)
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