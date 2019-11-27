// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Float0("Float 0", Float) = 1.5
		_t_trail_cube("t_trail_cube", 2D) = "white" {}
		_Float1("Float 1", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Float0;
		uniform sampler2D _t_trail_cube;
		uniform float _Float1;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord9 = i.uv_texcoord * float2( 5.25,1 );
			float2 panner8 = ( ( _Float1 * _Time.y ) * float2( -5,0 ) + uv_TexCoord9);
			float4 tex2DNode1 = tex2D( _t_trail_cube, panner8 );
			o.Emission = ( _Float0 * tex2DNode1 ).rgb;
			o.Alpha = tex2DNode1.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
186;508;1649;743;2464.004;536.2539;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;6;-1854.685,-138.9969;Float;False;Property;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-1860.678,-18.1174;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1667.236,-139.8023;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1764.247,-346.1838;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;5.25,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;8;-1499.281,-185.5787;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;-5,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-972.9019,-162.1851;Float;True;Property;_t_trail_cube;t_trail_cube;2;0;Create;True;0;0;False;0;684addf76637ec741b263d2f477d6a7d;e394e98c76a74cf4b8a6187650c9c350;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-299,-237;Float;False;Property;_Float0;Float 0;1;0;Create;True;0;0;False;0;1.5;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;24,-101;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;183,-33;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;6;0
WireConnection;5;1;4;0
WireConnection;8;0;9;0
WireConnection;8;1;5;0
WireConnection;1;1;8;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;0;2;3;0
WireConnection;0;9;1;0
ASEEND*/
//CHKSM=7C3F2A884374FCDE90A32DB43BAC0C60CD41EC99