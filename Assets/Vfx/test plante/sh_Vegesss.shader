// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader 1"
{
	Properties
	{
		_Shininess("Shininess", Range( 0.01 , 1)) = 0.1
		_worldfreq("world freq", Range( 0 , 1)) = 0
		_Bendammount("Bend ammount", Range( 0 , 1)) = 0
		_winddirection("wind direction", Range( 0 , 1)) = 0
		_albedo("albedo", 2D) = "white" {}
		_emiss("emiss", Color) = (0.1570573,0.2641509,0.1383054,0)
		_SSSdistord("SSS distord", Float) = 1
		_SSSpow("SSS pow", Float) = 1
		_SSSScale("SSS Scale", Float) = 1
		_specu("specu", Float) = 0
		_Color1("Color 1", Color) = (1,0.1745283,0.1745283,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _winddirection;
		uniform float _worldfreq;
		uniform float _Bendammount;
		uniform sampler2D _albedo;
		uniform float4 _albedo_ST;
		uniform float4 _emiss;
		uniform float _specu;
		uniform float _Shininess;
		uniform float _SSSdistord;
		uniform float _SSSpow;
		uniform float _SSSScale;
		uniform float4 _Color1;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_10_0 = ( ( ase_vertex3Pos.y * cos( ( ( ( ase_worldPos.x + ase_worldPos.z ) * _worldfreq ) + _Time.y ) ) ) * _Bendammount );
			float4 appendResult11 = (float4(temp_output_10_0 , 0.0 , temp_output_10_0 , 0.0));
			float4 break16 = mul( appendResult11, unity_ObjectToWorld );
			float4 appendResult18 = (float4(break16.x , 0 , break16.z , 0.0));
			float3 rotatedValue21 = RotateAroundAxis( float3( 0,0,0 ), appendResult18.xyz, float3( 0,0,0 ), _winddirection );
			float3 lerpResult78 = lerp( rotatedValue21 , 0 , v.texcoord.xy.y);
			float4 transform77 = mul(unity_WorldToObject,float4( lerpResult78 , 0.0 ));
			v.vertex.xyz += transform77.xyz;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_albedo = i.uv_texcoord * _albedo_ST.xy + _albedo_ST.zw;
			float4 tex2DNode23 = tex2D( _albedo, uv_albedo );
			float4 temp_cast_2 = (_specu).xxxx;
			float4 temp_output_43_0_g1 = temp_cast_2;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult4_g2 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float3 normalizeResult64_g1 = normalize( (WorldNormalVector( i , float3(0,0,1) )) );
			float dotResult19_g1 = dot( normalizeResult4_g2 , normalizeResult64_g1 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_40_0_g1 = ( ase_lightColor * ase_lightAtten );
			float dotResult14_g1 = dot( normalizeResult64_g1 , ase_worldlightDir );
			UnityGI gi34_g1 = gi;
			float3 diffNorm34_g1 = normalizeResult64_g1;
			gi34_g1 = UnityGI_Base( data, 1, diffNorm34_g1 );
			float3 indirectDiffuse34_g1 = gi34_g1.indirect.diffuse + diffNorm34_g1 * 0.0001;
			float4 temp_output_42_0_g1 = tex2DNode23;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 objToWorldDir86 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos, 0 ) ).xyz;
			float3 normalizeResult87 = normalize( objToWorldDir86 );
			float dotResult89 = dot( ase_worldViewDir , -( ase_worldlightDir + ( normalizeResult87 * _SSSdistord ) ) );
			float dotResult91 = dot( pow( dotResult89 , _SSSpow ) , _SSSScale );
			c.rgb = ( ( ( float4( (temp_output_43_0_g1).rgb , 0.0 ) * (temp_output_43_0_g1).a * pow( max( dotResult19_g1 , 0.0 ) , ( _Shininess * 128.0 ) ) * temp_output_40_0_g1 ) + ( ( ( temp_output_40_0_g1 * max( dotResult14_g1 , 0.0 ) ) + float4( indirectDiffuse34_g1 , 0.0 ) ) * float4( (temp_output_42_0_g1).rgb , 0.0 ) ) ) + ( ( saturate( dotResult91 ) * distance( ase_vertex3Pos , float3( 0,0,0 ) ) ) * _Color1 ) ).rgb;
			c.a = tex2DNode23.a;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_albedo = i.uv_texcoord * _albedo_ST.xy + _albedo_ST.zw;
			float4 tex2DNode23 = tex2D( _albedo, uv_albedo );
			o.Albedo = tex2DNode23.rgb;
			o.Emission = _emiss.rgb;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;189;1906;844;110.4521;-711.808;1.918671;True;True
Node;AmplifyShaderEditor.CommentaryNode;28;-2328.484,1488.468;Float;False;3197;1077;old;20;1;2;4;5;3;6;7;8;9;13;10;11;14;15;17;16;18;20;21;79;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-2182.484,1538.468;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;85;-1470.9,1336.75;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1894.486,1634.468;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-2278.484,1842.468;Float;False;Property;_worldfreq;world freq;5;0;Create;True;0;0;False;0;0;0.931;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;86;-1138.7,1217.418;Float;False;Object;World;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TimeNode;5;-2086.485,2002.469;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1750.486,1794.468;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1494.486,1986.469;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;87;-876.0278,1259.745;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-1182.059,1076.563;Float;False;Property;_SSSdistord;SSS distord;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;8;-1206.487,2002.469;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;7;-1382.486,2178.47;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-652.6348,1006.082;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;80;-918.1663,622.5369;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;84;-475.6136,1035.586;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1030.487,2194.47;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1110.487,2450.47;Float;False;Property;_Bendammount;Bend ammount;6;0;Create;True;0;0;False;0;0;0.11;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;90;-212.4055,599.8474;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;88;-203.8313,875.8832;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-790.4875,2210.47;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;15.82898,1130.873;Float;False;Property;_SSSpow;SSS pow;11;0;Create;True;0;0;False;0;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;89;17.35054,873.7288;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;14;-602.4209,2336.044;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-566.4876,2082.47;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;94;335.3573,1164.347;Float;False;Property;_SSSScale;SSS Scale;12;0;Create;True;0;0;False;0;1;0.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-342.4877,2226.47;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;92;274.4948,904.1601;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;16;-150.4873,2130.47;Float;True;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector3Node;17;-246.4875,1874.468;Float;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;91;470.7765,861.5563;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;265.5129,1970.469;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceOpNode;98;-143.6364,1352.153;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;96;725.1483,868.6326;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-134.4873,2434.47;Float;False;Property;_winddirection;wind direction;7;0;Create;True;0;0;False;0;0;0.962;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;969.7692,896.7908;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;101;947.9835,1095.319;Float;False;Property;_Color1;Color 1;16;0;Create;True;0;0;False;0;1,0.1745283,0.1745283,0;0.03921569,0.06666665,0.04417348,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;105;1174.629,845.0524;Float;False;Property;_specu;specu;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;406.4903,2437.918;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;1018.569,1514.545;Float;True;Property;_albedo;albedo;8;0;Create;True;0;0;False;0;None;c6d51c3cb958d794ca5890c44907d2f1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;21;537.5131,2258.47;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;1366.764,1073.154;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;78;934.7233,2148.88;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;99;1386.841,790.5259;Float;False;Blinn-Phong Light;1;;1;cf814dba44d007a4e958d2ddd5813da6;0;3;42;COLOR;0,0,0,0;False;52;FLOAT3;0,0,0;False;43;COLOR;0,0,0,0;False;2;COLOR;0;FLOAT;57
Node;AmplifyShaderEditor.ColorNode;27;1470.008,1618.493;Float;False;Property;_emiss;emiss;9;0;Create;True;0;0;False;0;0.1570573,0.2641509,0.1383054,0;0.1570565,0.2641501,0.1383047,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;104;1745.863,1346.894;Float;False;Constant;_Color2;Color 2;12;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;107;894.8694,1383.016;Float;False;Property;_multalbedocolorsss;mult albedo color sss;13;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;1565.994,985.1224;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;1224.259,1356.559;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-566.9777,1301.224;Float;False;normalvertexpos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;100;1042.436,673.1501;Float;False;Property;_diffusespecu;diffuse specu;15;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldToObjectTransfNode;77;1212.233,2207.181;Float;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;2073.795,1441.918;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;New Amplify Shader 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;1;3
WireConnection;86;0;85;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;6;0;3;0
WireConnection;6;1;5;2
WireConnection;87;0;86;0
WireConnection;7;0;6;0
WireConnection;83;0;87;0
WireConnection;83;1;82;0
WireConnection;84;0;80;0
WireConnection;84;1;83;0
WireConnection;9;0;8;2
WireConnection;9;1;7;0
WireConnection;88;0;84;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;89;0;90;0
WireConnection;89;1;88;0
WireConnection;11;0;10;0
WireConnection;11;2;10;0
WireConnection;15;0;11;0
WireConnection;15;1;14;0
WireConnection;92;0;89;0
WireConnection;92;1;93;0
WireConnection;16;0;15;0
WireConnection;91;0;92;0
WireConnection;91;1;94;0
WireConnection;18;0;16;0
WireConnection;18;1;17;2
WireConnection;18;2;16;2
WireConnection;98;0;85;0
WireConnection;96;0;91;0
WireConnection;97;0;96;0
WireConnection;97;1;98;0
WireConnection;21;1;20;0
WireConnection;21;3;18;0
WireConnection;102;0;97;0
WireConnection;102;1;101;0
WireConnection;78;0;21;0
WireConnection;78;1;14;0
WireConnection;78;2;79;2
WireConnection;99;42;23;0
WireConnection;99;43;105;0
WireConnection;103;0;99;0
WireConnection;103;1;102;0
WireConnection;106;0;23;0
WireConnection;106;1;107;0
WireConnection;95;0;87;0
WireConnection;77;0;78;0
WireConnection;26;0;23;0
WireConnection;26;2;27;0
WireConnection;26;9;23;4
WireConnection;26;13;103;0
WireConnection;26;11;77;0
ASEEND*/
//CHKSM=F60C7916BFACB34AA7C0F123995DE6B9F49009DF