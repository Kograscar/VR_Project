// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Color1("Color 1", Color) = (0.9622642,0.9332545,0.75801,0)
		_Color0("Color 0", Color) = (0.08561765,0.07342471,0.2075472,0)
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPosition;
		};

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform sampler2D _GrabTexture;
		uniform float4 _Vector0;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen23 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither23 = Dither4x4Bayer( fmod(clipScreen23.x, 4), fmod(clipScreen23.y, 4) );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor24 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ase_grabScreenPos ) );
			float4 clampResult39 = clamp( screenColor24 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 clampResult49 = clamp( ( clampResult39 * _Vector0 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 clampResult50 = clamp( (float4( 0.764151,0,0,0 ) + (clampResult49 - float4( 0,0,0,0 )) * (float4( 0,0,0,0 ) - float4( 0.764151,0,0,0 )) / (float4( 1,0,0,0 ) - float4( 0,0,0,0 ))) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			dither23 = step( dither23, clampResult50.r );
			float4 lerpResult40 = lerp( _Color0 , _Color1 , dither23);
			o.Emission = lerpResult40.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;373;1906;660;2096.487;144.8871;1.419894;True;True
Node;AmplifyShaderEditor.ScreenColorNode;24;-1708.982,46.79234;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;True;0;Object;-1;False;True;1;0;FLOAT4;0,0,0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;39;-1188.761,104.3185;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;45;-1430.718,287.999;Float;False;Property;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0,0,0,0;1,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1052.705,234.4618;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;49;-834.2025,272.5617;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;48;-676.5919,99.33453;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0.764151,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;50;-426.6912,214.3461;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;42;-655.4169,-161.9615;Float;False;Property;_Color1;Color 1;1;0;Create;True;0;0;False;0;0.9622642,0.9332545,0.75801,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;41;-413.4689,-322.7741;Float;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;0.08561765,0.07342471,0.2075472,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DitheringNode;23;-228.7195,161.3026;Float;False;0;True;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;46;-1455.407,54.52609;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.5236316,0,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;40;80.37878,-74.04173;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;298.2988,-89.13967;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;24;0
WireConnection;44;0;39;0
WireConnection;44;1;45;0
WireConnection;49;0;44;0
WireConnection;48;0;49;0
WireConnection;50;0;48;0
WireConnection;23;0;50;0
WireConnection;46;0;24;0
WireConnection;40;0;41;0
WireConnection;40;1;42;0
WireConnection;40;2;23;0
WireConnection;0;2;40;0
ASEEND*/
//CHKSM=F02E900FC8EB11EE077BA687B833C6D31C9C6123