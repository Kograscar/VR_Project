// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Face2("Face 2", Float) = 0
		_Face1("Face 1", Float) = 0
		_Face3("Face 3", Float) = 0
		_Contours("Contours", Float) = 0
		_Face5("Face 5", Float) = 0
		_Face4("Face 4", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_t_cube_faceA("t_cube_faceA", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _t_cube_faceA;
		uniform float4 _t_cube_faceA_ST;
		uniform sampler2D _Texture0;
		uniform float _Face1;
		uniform float _Face2;
		uniform float _Face3;
		uniform float _Face4;
		uniform float _Face5;
		uniform float _Contours;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_t_cube_faceA = i.uv_texcoord * _t_cube_faceA_ST.xy + _t_cube_faceA_ST.zw;
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
			float4 appendResult68 = (float4(_Contours , 1 , 0.0 , 0.0));
			float2 uv_TexCoord69 = i.uv_texcoord + appendResult68.xy;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV66 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode66 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV66, 5.0 ) );
			float clampResult74 = clamp( fresnelNode66 , 0.0 , 1.0 );
			o.Emission = ( ( ( tex2D( _t_cube_faceA, uv_t_cube_faceA ) * 6.0 ) + ( ( tex2D( _Texture0, uv_TexCoord25 ) + tex2D( _Texture0, uv_TexCoord26 ) + tex2D( _Texture0, uv_TexCoord27 ) + tex2D( _Texture0, uv_TexCoord28 ) + tex2D( _Texture0, uv_TexCoord29 ) + tex2D( _Texture0, uv_TexCoord69 ) ) * 1.2 ) ) * ( 1.0 - clampResult74 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				o.worldNormal = worldNormal;
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
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
7;23;1906;1010;1558.724;32.19299;1;True;True
Node;AmplifyShaderEditor.Vector2Node;35;-2325.398,749.638;Float;False;Constant;_Vector4;Vector 4;8;0;Create;True;0;0;False;0;0,0.6;0,0.6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;67;-2340.529,996.6655;Float;False;Constant;_Vector5;Vector 5;7;0;Create;True;0;0;False;0;0,1;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;30;-2336.624,-55.06321;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0,-0.5;0,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;34;-2334.499,606.6373;Float;False;Constant;_Vector3;Vector 3;6;0;Create;True;0;0;False;0;0,-0.1;0,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;33;-2341.001,342.7373;Float;False;Constant;_Vector2;Vector 2;9;0;Create;True;0;0;False;0;0,-0.2;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;32;-2334.498,134.737;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;0,0.7;0,0.7;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;71;-2696.115,1128.708;Float;False;Property;_Contours;Contours;3;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2699.727,-1.480727;Float;False;Property;_Face1;Face 1;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2670.358,165.0883;Float;False;Property;_Face2;Face 2;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2663.858,297.6883;Float;False;Property;_Face3;Face 3;2;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-2674.258,459.4039;Float;False;Property;_Face4;Face 4;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-2680.984,881.6807;Float;False;Property;_Face5;Face 5;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-2143.399,614.4373;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-2138.199,418.1372;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-2142.099,251.7371;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-2164.198,11.2369;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-2155.099,786.0377;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;68;-2170.229,1033.065;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1989.735,552.0493;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1973.596,-8.497182;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;51;-1857.543,-376.7554;Float;True;Property;_Texture0;Texture 0;6;0;Create;True;0;0;False;0;None;9c8d85f7cbc2da547877bc9c91c63490;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1988.721,721.7523;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1975.752,180.4402;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1991.114,360.6412;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-2003.849,968.7798;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1506.456,484.478;Float;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1540.805,-221.5119;Float;True;Property;_TextureSample0;Texture Sample 0;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;-1512.926,249.9586;Float;True;Property;_TextureSample2;Texture Sample 2;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-1512.926,10.58691;Float;True;Property;_TextureSample1;Texture Sample 1;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-1526.436,978.9641;Float;True;Property;_TextureSample5;Texture Sample 5;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;-1511.308,731.9366;Float;True;Property;_TextureSample4;Texture Sample 4;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1042.066,53.86443;Float;True;6;6;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;66;-1050.705,520.5201;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1145.072,-382.0715;Float;True;Property;_t_cube_faceA;t_cube_faceA;7;0;Create;True;0;0;False;0;783550d47a8f1c5439aee0eb2ac1b91e;783550d47a8f1c5439aee0eb2ac1b91e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;-957.386,-95.08363;Float;False;Constant;_powercolor;power color;12;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-734.7255,-344.7161;Float;False;Constant;_powerblanc;power blanc;12;0;Create;True;0;0;False;0;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;74;-749.7242,520.807;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-692.4371,-199.244;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-760.2709,62.10626;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;75;-486.7242,522.807;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-509.0738,-17.16046;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-285.7242,370.807;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;-137.7379,200.7442;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;58;0
WireConnection;38;1;34;2
WireConnection;37;0;57;0
WireConnection;37;1;33;2
WireConnection;36;0;56;0
WireConnection;36;1;32;2
WireConnection;31;0;23;0
WireConnection;31;1;30;2
WireConnection;39;0;59;0
WireConnection;39;1;35;2
WireConnection;68;0;71;0
WireConnection;68;1;67;2
WireConnection;28;1;38;0
WireConnection;25;1;31;0
WireConnection;29;1;39;0
WireConnection;26;1;36;0
WireConnection;27;1;37;0
WireConnection;69;1;68;0
WireConnection;54;0;51;0
WireConnection;54;1;28;0
WireConnection;50;0;51;0
WireConnection;50;1;25;0
WireConnection;53;0;51;0
WireConnection;53;1;27;0
WireConnection;52;0;51;0
WireConnection;52;1;26;0
WireConnection;70;0;51;0
WireConnection;70;1;69;0
WireConnection;55;0;51;0
WireConnection;55;1;29;0
WireConnection;40;0;50;0
WireConnection;40;1;52;0
WireConnection;40;2;53;0
WireConnection;40;3;54;0
WireConnection;40;4;55;0
WireConnection;40;5;70;0
WireConnection;74;0;66;0
WireConnection;62;0;60;0
WireConnection;62;1;63;0
WireConnection;73;0;40;0
WireConnection;73;1;72;0
WireConnection;75;0;74;0
WireConnection;61;0;62;0
WireConnection;61;1;73;0
WireConnection;76;0;61;0
WireConnection;76;1;75;0
WireConnection;65;2;76;0
ASEEND*/
//CHKSM=23792528D0027D393D4052907A4485BD40A3454A