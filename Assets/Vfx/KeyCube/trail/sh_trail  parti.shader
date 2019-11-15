// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_t_trail_cube("t_trail_cube", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
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

		uniform sampler2D _t_trail_cube;
		uniform float4 _t_trail_cube_ST;
		uniform sampler2D _TextureSample0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_t_trail_cube = i.uv_texcoord * _t_trail_cube_ST.xy + _t_trail_cube_ST.zw;
			float4 tex2DNode1 = tex2D( _t_trail_cube, uv_t_trail_cube );
			float2 _Vector0 = float2(-0.3,0);
			float2 uv_TexCoord4 = i.uv_texcoord * float2( 0.2,0 ) + float2( 0.1,-0.56 );
			float2 panner16 = ( _Time.y * _Vector0 + uv_TexCoord4);
			o.Emission = ( 2.0 * tex2DNode1 * tex2D( _TextureSample0, panner16 ) ).rgb;
			o.Alpha = tex2DNode1.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;29;1906;1004;1562.8;677.9455;2.117072;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1925.541,-38.14844;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1850.731,-538.8267;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.2,0;False;1;FLOAT2;0.1,-0.56;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;11;-2059.405,-326.3545;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;-0.3,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;16;-1466.541,-185.1392;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-299,-237;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1167.094,-370.5605;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;941d8c715082a5c468b07c561600379a;941d8c715082a5c468b07c561600379a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1222.619,58.99276;Float;True;Property;_t_trail_cube;t_trail_cube;1;0;Create;True;0;0;False;0;684addf76637ec741b263d2f477d6a7d;996ce86113ed7c646a3a09827307cfb9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1725.769,-173.1267;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;24,-101;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;183,-33;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;4;0
WireConnection;16;2;11;0
WireConnection;16;1;9;0
WireConnection;7;1;16;0
WireConnection;10;0;11;0
WireConnection;10;1;9;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;3;2;7;0
WireConnection;0;2;3;0
WireConnection;0;9;1;0
ASEEND*/
//CHKSM=646D5896CD7A278CBB03AA75AA0FDC58D08CF218