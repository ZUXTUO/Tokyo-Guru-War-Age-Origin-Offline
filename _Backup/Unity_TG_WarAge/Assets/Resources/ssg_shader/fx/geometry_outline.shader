Shader "D3/Effect/Geometry_OutLine" {
	Properties {
		_MainTex ("Base", 2D) = "white" {}
		_TintColor ("TintColor", Vector) = (1,1,1,1)
		_AddColor ("AddColor", Vector) = (1,1,1,1)
		_OutLineColor ("OutLineColor", Vector) = (0,0,0,0)
		_OutLineWidth ("OutLineWidth", Range(0, 1)) = 1
		_BloomFactor ("BloomFactor", Float) = 1
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