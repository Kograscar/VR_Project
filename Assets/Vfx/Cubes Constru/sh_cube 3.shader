// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_t_cube_faceA("t_cube_faceA", 2D) = "white" {}
		_powemiss("powe miss", Float) = 1.2
		_powerblanc("power blanc", Float) = 0.005
		_TextureSample8("Texture Sample 8", 2D) = "white" {}
		_TextureSample9("Texture Sample 9", 2D) = "white" {}
		_Vector6("Vector 6", Vector) = (6,6,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Float0("Float 0", Float) = 0.6
		_x("x", Float) = 0.23
		_y("y", Float) = 0.368
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _t_cube_faceA;
		uniform float4 _t_cube_faceA_ST;
		uniform float _powerblanc;
		uniform sampler2D _TextureSample8;
		uniform float _Float0;
		uniform float2 _Vector6;
		uniform sampler2D _TextureSample9;
		uniform sampler2D _TextureSample0;
		uniform float _x;
		uniform float _y;
		uniform float _powemiss;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_t_cube_faceA = i.uv_texcoord * _t_cube_faceA_ST.xy + _t_cube_faceA_ST.zw;
			float mulTime100 = _Time.y * _Float0;
			float2 uv_TexCoord101 = i.uv_texcoord * _Vector6;
			float2 panner103 = ( mulTime100 * float2( -0.5,0.25 ) + uv_TexCoord101);
			float2 uv_TexCoord99 = i.uv_texcoord * _Vector6;
			float2 panner102 = ( mulTime100 * float2( 0.2,-0.3 ) + uv_TexCoord99);
			float4 temp_output_106_0 = ( tex2D( _TextureSample8, panner103 ) * tex2D( _TextureSample9, panner102 ) );
			float4 appendResult112 = (float4(_x , _y , 0.0 , 0.0));
			float2 uv_TexCoord110 = i.uv_texcoord * float2( 0.06,0.08 ) + appendResult112.xy;
			float4 clampResult109 = clamp( ( temp_output_106_0 + 0.7 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Emission = ( ( tex2D( _t_cube_faceA, uv_t_cube_faceA ) * _powerblanc * (float4( 0.1037736,0.1037736,0.1037736,0 ) + (temp_output_106_0 - float4( 0,0,0,0 )) * (float4( 1,1,1,0 ) - float4( 0.1037736,0.1037736,0.1037736,0 )) / (float4( 1,1,1,0 ) - float4( 0,0,0,0 ))) ) + ( ( tex2D( _TextureSample0, uv_TexCoord110 ) * 1.2 ) * _powemiss * clampResult109 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;83;1906;941;1833.708;373.5067;2.096941;True;True
Node;AmplifyShaderEditor.RangedFloatNode;97;-2169.415,-1492.226;Float;False;Property;_Float0;Float 0;7;0;Create;True;0;0;False;0;0.6;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;98;-2429.334,-1609.185;Float;False;Property;_Vector6;Vector 6;5;0;Create;True;0;0;False;0;6,6;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;100;-2028.823,-1512.47;Float;False;1;0;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;99;-2159.59,-1390.956;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-2042.396,-1670.14;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;103;-1774.396,-1657.14;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.5,0.25;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-2074.521,33.90329;Float;False;Property;_y;y;9;0;Create;True;0;0;False;0;0.368;0.369;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2060.786,164.9427;Float;False;Property;_x;x;8;0;Create;True;0;0;False;0;0.23;0.23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;102;-1759.609,-1406.236;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.2,-0.3;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;105;-1408.414,-1529.702;Float;True;Property;_TextureSample9;Texture Sample 9;4;0;Create;True;0;0;False;0;None;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;112;-1839.744,84.43982;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;104;-1423.201,-1780.606;Float;True;Property;_TextureSample8;Texture Sample 8;3;0;Create;True;0;0;False;0;None;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1013.233,-1635.771;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;110;-1689.767,20.06873;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.06,0.08;False;1;FLOAT2;0.11,-0.65;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;108;-892.0001,-1372.731;Float;False;Constant;_Float1;Float 1;18;0;Create;True;0;0;False;0;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-957.386,-95.08363;Float;False;Constant;_powercolor;power color;12;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-1358.684,-14.20583;Float;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;9c8d85f7cbc2da547877bc9c91c63490;9c8d85f7cbc2da547877bc9c91c63490;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-679.4757,-1463.409;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-760.2709,62.10626;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;95;-667.5116,-645.5894;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0.1037736,0.1037736,0.1037736,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;109;-147.1783,-1033.855;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;60;-1244.913,-452.6905;Float;True;Property;_t_cube_faceA;t_cube_faceA;0;0;Create;True;0;0;False;0;783550d47a8f1c5439aee0eb2ac1b91e;783550d47a8f1c5439aee0eb2ac1b91e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;78;-596.9806,-25.85389;Float;False;Property;_powemiss;powe miss;1;0;Create;True;0;0;False;0;1.2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-726.6815,-201.2635;Float;False;Property;_powerblanc;power blanc;2;0;Create;True;0;0;False;0;0.005;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-440.3896,-246.1678;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-314.7299,41.25322;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;60.53535,60.44693;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;580.1098,327.2372;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;100;0;97;0
WireConnection;99;0;98;0
WireConnection;101;0;98;0
WireConnection;103;0;101;0
WireConnection;103;1;100;0
WireConnection;102;0;99;0
WireConnection;102;1;100;0
WireConnection;105;1;102;0
WireConnection;112;0;113;0
WireConnection;112;1;114;0
WireConnection;104;1;103;0
WireConnection;106;0;104;0
WireConnection;106;1;105;0
WireConnection;110;1;112;0
WireConnection;50;1;110;0
WireConnection;107;0;106;0
WireConnection;107;1;108;0
WireConnection;73;0;50;0
WireConnection;73;1;72;0
WireConnection;95;0;106;0
WireConnection;109;0;107;0
WireConnection;62;0;60;0
WireConnection;62;1;63;0
WireConnection;62;2;95;0
WireConnection;77;0;73;0
WireConnection;77;1;78;0
WireConnection;77;2;109;0
WireConnection;61;0;62;0
WireConnection;61;1;77;0
WireConnection;65;2;61;0
ASEEND*/
//CHKSM=D254D463CDBCA50214FBB00B17F584634E19143F