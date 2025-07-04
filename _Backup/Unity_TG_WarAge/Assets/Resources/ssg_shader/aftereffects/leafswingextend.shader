Shader "Consume/Leaf Swing Extend" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Pos ("Position", Vector) = (0,0,0,0)
		_Direction ("Direction", Vector) = (0,0,0,0)
		_TimeScale ("TimeScale", Float) = 1
		_TimeDelay ("TimeDelay", Float) = 1
		_WhiteTex ("White (RGB)", 2D) = "white" {}
		_Radius ("Radius", Float) = 0
		_Radius2 ("Radius2", Float) = 0
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
	Fallback "Unlit/Transparent Colored"
}