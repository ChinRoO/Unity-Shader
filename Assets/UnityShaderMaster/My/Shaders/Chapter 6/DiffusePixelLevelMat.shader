Shader "Unity_Shaders_Book/Chapter 6/Difuse_Pixel_Level_Mat" {
	Properties {
		_Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
	}
	SubShader {
		Pass { 
			Tags { "LightMode"="ForwardBase" }
		
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			
			#include "Lighting.cginc"
			
			fixed4 _Diffuse;
			
			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
			
			struct v2f {
				float4 pos : SV_POSITION;
				float3 worldnormal : TEXCOORD0;
			};
			
			v2f vert(a2v v) {
				v2f o;
				//Vertex position vector from ObjectSpace to worldspace and transform worldnormal vertor to fragment shader
				o.pos = UnityObjectToClipPos(v.vertex);
                o.worldnormal = mul(v.normal, (float3x3)unity_WorldToObject);
				
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target {
                // Get ambient term
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				
				// Get the normal in world spce
				fixed3 worldNormal = normalize(i.worldnormal);
				// Get the light direction in world space
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				// Compute diffuse term
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));
				
				fixed3 color = ambient + diffuse;
				return fixed4(color, 1.0);
			}
			
			ENDCG
		}
	}
	FallBack "Diffuse"
}