﻿Shader "Unity_Shaders_Book/Chapter 9/AlphaTestWithShadow"
{
   Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5     //  用来控制Alpha Test的阈值
    }
    SubShader {
        Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}

        Pass {
            Tags {"LightMode"="ForwardBase"}

            Cull Off    //  关闭Cull剔除功能

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _Cutoff;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float2 uv : TEXCOORD2;
                SHADOW_COORDS(3)
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);     //  将纹理坐标和缩放属性储存到uv变量中
                TRANSFER_SHADOW(o);
                
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                
                fixed4 texColor = tex2D(_MainTex, i.uv);   //   对纹理进行采样并且映射到texColor变量中
                //  Alpha Test
                clip(texColor.a - _Cutoff);    
                 /*  进行混合度测试
                  Equal :  if((texColor.a - _Cutoff) < 0){
                      discard;
                }
                */

                fixed3 albedo = texColor.rgb * _Color.rgb;
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;

                fixed3 diffuse = _LightColor0.rgb * albedo.rgb * saturate(dot(worldLightDir,worldNormal));
                UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
                return fixed4(ambient + diffuse * atten, 1.0);
            }
            ENDCG
        }
    }
    Fallback "Transparent/Cutout/VertexLit"
}
