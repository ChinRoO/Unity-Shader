﻿Shader "Unity_Shaders_Book/Chapter 8/AlphaBlendZWrite"
{
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _AlphaScale ("Alpha Scale", Range(0, 1)) = 1
    }
    SubShader {
        Tags {"Queue"="Transparent" "IgnoreProject"="True" "RenderType"="Transparent"}
        Pass {              //  开启深度写入，写在第一个pass块中，this pass that renders to depth buffer only
            ZWrite On
            ColorMask 0
        }
        Pass {
            Tags {"LightMode"="ForwardBase"}        //  第二个Pass开始渲染透明效果，需要关闭深度写入，采用透明度混合

            ZWrite off
            Blend SrcAlpha OneMinusSrcAlpha     //  开启混合（Blend)并且采用源颜色的Alpha通道和1-Srcoue的Alpha通道作为混合因子参数混合21

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _AlphaScale;

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
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);     //  将纹理坐标和缩放属性储存到uv变量中
                
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                
                fixed4 texColor = tex2D(_MainTex, i.uv);   //   对纹理进行采样并且映射到texColor变量中

                fixed3 albedo = texColor.rgb * _Color.rgb;

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;

                fixed3 diffuse = _LightColor0.rgb * albedo.rgb * saturate(dot(worldLightDir,worldNormal));
                return fixed4(ambient + diffuse, texColor.a * _AlphaScale);     //  透明度混合
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
