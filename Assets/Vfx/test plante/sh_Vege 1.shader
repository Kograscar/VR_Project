// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader 1"
{
	Properties
	{
		_worldfreq("world freq", Range( 0 , 1)) = 0
		_Bendammount("Bend ammount", Range( 0 , 1)) = 0
		_winddirection("wind direction", Range( 0 , 1)) = 0
		_albedo("albedo", 2D) = "white" {}
		_emiss("emiss", Color) = (0.1570573,0.2641509,0.1383054,0)
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
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _winddirection;
		uniform float _worldfreq;
		uniform float _Bendammount;
		uniform sampler2D _albedo;
		uniform float4 _albedo_ST;
		uniform float4 _emiss;


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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_albedo = i.uv_texcoord * _albedo_ST.xy + _albedo_ST.zw;
			float4 tex2DNode23 = tex2D( _albedo, uv_albedo );
			o.Albedo = tex2DNode23.rgb;
			o.Emission = _emiss.rgb;
			o.Alpha = tex2DNode23.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;213;1906;820;591.1346;-2124.37;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;28;-2245.264,1443.074;Float;False;3197;1077;old;19;1;2;4;5;3;6;7;8;9;13;10;11;14;15;17;16;18;20;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-2099.264,1493.074;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1811.264,1589.074;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-2195.264,1797.074;Float;False;Property;_worldfreq;world freq;1;0;Create;True;0;0;False;0;0;0.116;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;5;-2003.264,1957.074;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1667.264,1749.074;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1411.264,1941.074;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;8;-1123.265,1957.074;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;7;-1299.264,2133.074;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1027.265,2405.074;Float;False;Property;_Bendammount;Bend ammount;2;0;Create;True;0;0;False;0;0;0.116;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-947.265,2149.074;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-707.2651,2165.074;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-483.2652,2037.074;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;14;-519.1985,2290.648;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-259.2653,2181.074;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;16;-67.26501,2085.074;Float;True;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector3Node;17;-163.2651,1829.074;Float;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;20;-51.26501,2389.074;Float;False;Property;_winddirection;wind direction;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;348.7353,1925.074;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;21;620.7355,2213.074;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;398.9246,2441.701;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;78;987.6828,2277.497;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;27;1469.008,1510.493;Float;False;Property;_emiss;emiss;5;0;Create;True;0;0;False;0;0.1570573,0.2641509,0.1383054,0;0.1570567,0.2641503,0.1383048,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;1018.569,1514.545;Float;True;Property;_albedo;albedo;4;0;Create;True;0;0;False;0;None;c6d51c3cb958d794ca5890c44907d2f1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldToObjectTransfNode;77;1212.233,2207.181;Float;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;1798.854,2080.102;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;1;3
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;6;0;3;0
WireConnection;6;1;5;2
WireConnection;7;0;6;0
WireConnection;9;0;8;2
WireConnection;9;1;7;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;11;0;10;0
WireConnection;11;2;10;0
WireConnection;15;0;11;0
WireConnection;15;1;14;0
WireConnection;16;0;15;0
WireConnection;18;0;16;0
WireConnection;18;1;17;2
WireConnection;18;2;16;2
WireConnection;21;1;20;0
WireConnection;21;3;18;0
WireConnection;78;0;21;0
WireConnection;78;1;14;0
WireConnection;78;2;79;2
WireConnection;77;0;78;0
WireConnection;26;0;23;0
WireConnection;26;2;27;0
WireConnection;26;9;23;4
WireConnection;26;11;77;0
ASEEND*/
//CHKSM=6BF77A66A0D7CA9442240B01575240C30EBB890A