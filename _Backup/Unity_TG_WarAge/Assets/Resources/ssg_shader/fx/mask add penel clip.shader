Shader "CGwell FX/Mask Additive Panel Clip" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_MaskTex ("Masked Texture", 2D) = "gray" {}
		_MinX ("Min X", Float) = -10
		_MaxX ("Max X", Float) = 10
		_MinY ("Min Y", Float) = -10
		_MaxY ("Max Y", Float) = 10
		_SoftX ("Soft X", Float) = 0
		_SoftY ("Soft Y", Float) = 0
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