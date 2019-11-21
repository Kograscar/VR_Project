// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Face2("Face 2", Float) = 0
		_Face1("Face 1", Float) = 0
		_Face3("Face 3", Float) = 0
		_face6("face 6", Float) = 0
		_Face5("Face 5", Float) = 0
		_Face4("Face 4", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_t_cube_faceA("t_cube_faceA", 2D) = "white" {}
		_powemiss("powe miss", Float) = 1.2
		_powerblanc("power blanc", Float) = 4
		_TextureSample8("Texture Sample 8", 2D) = "white" {}
		_TextureSample9("Texture Sample 9", 2D) = "white" {}
		_Vector6("Vector 6", Vector) = (6,6,0,0)
		_Float0("Float 0", Float) = 0.6
		_disolve("disolve", Range( 0 , 1)) = 0
		_TextureSample6("Texture Sample 6", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
		uniform sampler2D _Texture0;
		uniform float _Face1;
		uniform float _Face2;
		uniform float _Face3;
		uniform float _Face4;
		uniform float _Face5;
		uniform float _face6;
		uniform float _powemiss;
		uniform sampler2D _TextureSample6;
		uniform float4 _TextureSample6_ST;
		uniform float _disolve;

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
			float4 appendResult31 = (float4(_Face1 , -0.5 , 0.0 , 0.0));
			float2 uv_TexCoord25 = i.uv_texcoord + appendResult31.xy;
			float4 appendResult36 = (float4(_Face2 , 0.7 , 0.0 , 0.0));
			float2 uv_TexCoord26 = i.uv_texcoord + appendResult36.xy;
			float4 appendResult37 = (float4(_Face3 , -0.2 , 0.0 , 0.0));
			float2 uv_TexCoord27 = i.uv_texcoord + appendResult37.xy;
			float4 appendResult38 = (float4(_Face4 , -0.1 , 0.0 , 0.0));
			float2 uv_TexCoord28 = i.uv_texcoord + appendResult38.xy;
			float4 appendResult39 = (float4(_Face5 , 0.6 , 0.0 , 0.0));
			float2 uv_TexCoord29 = i.uv_texcoord + appendResult39.xy;
			float4 appendResult68 = (float4(_face6 , 1 , 0.0 , 0.0));
			float2 uv_TexCoord69 = i.uv_texcoord + appendResult68.xy;
			float4 clampResult109 = clamp( ( temp_output_106_0 + 0.7 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 temp_output_61_0 = ( ( tex2D( _t_cube_faceA, uv_t_cube_faceA ) * _powerblanc * (float4( 0.1037736,0.1037736,0.1037736,0 ) + (temp_output_106_0 - float4( 0,0,0,0 )) * (float4( 1,1,1,0 ) - float4( 0.1037736,0.1037736,0.1037736,0 )) / (float4( 1,1,1,0 ) - float4( 0,0,0,0 ))) ) + ( ( ( tex2D( _Texture0, uv_TexCoord25 ) + tex2D( _Texture0, uv_TexCoord26 ) + tex2D( _Texture0, uv_TexCoord27 ) + tex2D( _Texture0, uv_TexCoord28 ) + tex2D( _Texture0, uv_TexCoord29 ) + tex2D( _Texture0, uv_TexCoord69 ) ) * 1.2 ) * _powemiss * clampResult109 ) );
			o.Emission = temp_output_61_0.rgb;
			float2 uv_TextureSample6 = i.uv_texcoord * _TextureSample6_ST.xy + _TextureSample6_ST.zw;
			float4 tex2DNode115 = tex2D( _TextureSample6, uv_TextureSample6 );
			float4 temp_cast_7 = ((0.0 + (_disolve - 1.0) * (0.5 - 0.0) / (0.0 - 1.0))).xxxx;
			float4 clampResult113 = clamp( step( ( tex2DNode115 * tex2DNode115 ) , temp_cast_7 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			o.Alpha = clampResult113.r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;236;1906;792;3129.96;1889.9;1.849374;True;True
Node;AmplifyShaderEditor.RangedFloatNode;97;-2169.415,-1492.226;Float;False;Property;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.6;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;98;-2429.334,-1609.185;Float;False;Property;_Vector6;Vector 6;12;0;Create;True;0;0;False;0;6,6;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;32;-2334.498,134.737;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;0,0.7;0,0.7;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;71;-2696.115,1128.708;Float;False;Property;_face6;face 6;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-2680.984,881.6807;Float;False;Property;_Face5;Face 5;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;30;-2336.624,-55.06321;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0,-0.5;0,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;100;-2028.823,-1512.47;Float;False;1;0;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;99;-2159.59,-1390.956;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;67;-2340.529,996.6655;Float;False;Constant;_Vector5;Vector 5;7;0;Create;True;0;0;False;0;0,1;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;33;-2341.001,342.7373;Float;False;Constant;_Vector2;Vector 2;9;0;Create;True;0;0;False;0;0,-0.2;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;34;-2334.499,606.6373;Float;False;Constant;_Vector3;Vector 3;6;0;Create;True;0;0;False;0;0,-0.1;0,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-2042.396,-1670.14;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2699.727,-1.480727;Float;False;Property;_Face1;Face 1;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;35;-2325.398,749.638;Float;False;Constant;_Vector4;Vector 4;8;0;Create;True;0;0;False;0;0,0.6;0,0.6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;56;-2670.358,165.0883;Float;False;Property;_Face2;Face 2;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2663.858,297.6883;Float;False;Property;_Face3;Face 3;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-2674.258,459.4039;Float;False;Property;_Face4;Face 4;5;0;Create;True;0;0;False;0;0;0.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;68;-2170.229,1033.065;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;102;-1759.609,-1406.236;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.2,-0.3;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-2143.399,614.4373;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-2142.099,251.7371;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-2138.199,418.1372;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-2155.099,786.0377;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;103;-1774.396,-1657.14;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.5,0.25;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-2164.198,11.2369;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;51;-1970.561,-292.5427;Float;True;Property;_Texture0;Texture 0;6;0;Create;True;0;0;False;0;None;9c8d85f7cbc2da547877bc9c91c63490;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-2003.849,968.7798;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1989.735,552.0493;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;105;-1408.414,-1529.702;Float;True;Property;_TextureSample9;Texture Sample 9;11;0;Create;True;0;0;False;0;None;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;104;-1423.201,-1780.606;Float;True;Property;_TextureSample8;Texture Sample 8;10;0;Create;True;0;0;False;0;None;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1991.114,360.6412;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1975.752,180.4402;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1988.721,721.7523;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1973.596,-8.497182;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1540.805,-221.5119;Float;True;Property;_TextureSample0;Texture Sample 0;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1506.456,484.478;Float;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-1526.436,978.9641;Float;True;Property;_TextureSample5;Texture Sample 5;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;108;-892.0001,-1372.731;Float;False;Constant;_Float1;Float 1;18;0;Create;True;0;0;False;0;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;-1512.926,249.9586;Float;True;Property;_TextureSample2;Texture Sample 2;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1013.233,-1635.771;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;52;-1512.926,10.58691;Float;True;Property;_TextureSample1;Texture Sample 1;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;-1511.308,731.9366;Float;True;Property;_TextureSample4;Texture Sample 4;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;-957.386,-95.08363;Float;False;Constant;_powercolor;power color;12;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;115;-1992.217,-960.7642;Float;True;Property;_TextureSample6;Texture Sample 6;15;0;Create;True;0;0;False;0;None;fff70cc323e7244f0a6fed5ecb11a9a1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-679.4757,-1463.409;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1042.066,53.86443;Float;True;6;6;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-2119.838,-1201.115;Float;False;Property;_disolve;disolve;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-726.6815,-201.2635;Float;False;Property;_powerblanc;power blanc;9;0;Create;True;0;0;False;0;4;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-760.2709,62.10626;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-1594.98,-885.6898;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;95;-667.5116,-645.5894;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0.1037736,0.1037736,0.1037736,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-596.9806,-25.85389;Float;False;Property;_powemiss;powe miss;8;0;Create;True;0;0;False;0;1.2;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1244.913,-452.6905;Float;True;Property;_t_cube_faceA;t_cube_faceA;7;0;Create;True;0;0;False;0;783550d47a8f1c5439aee0eb2ac1b91e;783550d47a8f1c5439aee0eb2ac1b91e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;109;-147.1783,-1033.855;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;112;-1604.674,-1215.071;Float;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-314.7299,41.25322;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-440.3896,-246.1678;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;110;-1316.675,-1167.07;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;464.1704,188.2755;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;60.53535,60.44693;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;113;335.0151,-154.2405;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;830.2772,72.7567;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;100;0;97;0
WireConnection;99;0;98;0
WireConnection;101;0;98;0
WireConnection;68;0;71;0
WireConnection;68;1;67;2
WireConnection;102;0;99;0
WireConnection;102;1;100;0
WireConnection;38;0;58;0
WireConnection;38;1;34;2
WireConnection;36;0;56;0
WireConnection;36;1;32;2
WireConnection;37;0;57;0
WireConnection;37;1;33;2
WireConnection;39;0;59;0
WireConnection;39;1;35;2
WireConnection;103;0;101;0
WireConnection;103;1;100;0
WireConnection;31;0;23;0
WireConnection;31;1;30;2
WireConnection;69;1;68;0
WireConnection;28;1;38;0
WireConnection;105;1;102;0
WireConnection;104;1;103;0
WireConnection;27;1;37;0
WireConnection;26;1;36;0
WireConnection;29;1;39;0
WireConnection;25;1;31;0
WireConnection;50;0;51;0
WireConnection;50;1;25;0
WireConnection;54;0;51;0
WireConnection;54;1;28;0
WireConnection;70;0;51;0
WireConnection;70;1;69;0
WireConnection;53;0;51;0
WireConnection;53;1;27;0
WireConnection;106;0;104;0
WireConnection;106;1;105;0
WireConnection;52;0;51;0
WireConnection;52;1;26;0
WireConnection;55;0;51;0
WireConnection;55;1;29;0
WireConnection;107;0;106;0
WireConnection;107;1;108;0
WireConnection;40;0;50;0
WireConnection;40;1;52;0
WireConnection;40;2;53;0
WireConnection;40;3;54;0
WireConnection;40;4;55;0
WireConnection;40;5;70;0
WireConnection;73;0;40;0
WireConnection;73;1;72;0
WireConnection;116;0;115;0
WireConnection;116;1;115;0
WireConnection;95;0;106;0
WireConnection;109;0;107;0
WireConnection;112;0;111;0
WireConnection;77;0;73;0
WireConnection;77;1;78;0
WireConnection;77;2;109;0
WireConnection;62;0;60;0
WireConnection;62;1;63;0
WireConnection;62;2;95;0
WireConnection;110;0;116;0
WireConnection;110;1;112;0
WireConnection;114;0;113;0
WireConnection;114;1;61;0
WireConnection;61;0;62;0
WireConnection;61;1;77;0
WireConnection;113;0;110;0
WireConnection;65;2;61;0
WireConnection;65;9;113;0
ASEEND*/
//CHKSM=DB5FE0D11F7245F9E7348D8E1028A18DF4B22DE0