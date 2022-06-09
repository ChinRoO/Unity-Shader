Shader "Unity_Shaders_Book/Chapter 6/Blinn-Phong Specular"
{
    Properties {
        _Diffuse ("Diffuse", Color) = (1,1,1,1)
        _Specular ("Specular", Color) = (1,1,1,1)
        _Gloss ("Gloss", Range(8.0, 256)) = 20
    }

    SubShader{
        Pass {
            Tags { "LightMode"="ForwardBase"}
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 worldNormal : TEXCOORD0;
                fixed3 worldPos : TEXCOORD1;
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);     //  向片元着色器传递裁剪空间的顶点坐标信息
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);   //  向片元着色器传递世界空间的法线方向
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;    //  向Frag传递顶点在世界空间中的坐标

                return o;
            }

            fixed4 frag(v2f i) : SV_Target {

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(i.worldNormal);   //    得到vertex传递的法线方向
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);     //  得到世界空间的光照方向（平行光）

                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));   //  计算漫反射

                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);  //  计算观察方向
                fixed3 halfDir = normalize(worldLightDir + viewDir);    //  计算光线方向和观察方向的和

                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, halfDir)), _Gloss);   //  Blinn-Phong模型高光反射方程

                fixed3 color = ambient + diffuse + specular;
                return fixed4(color, 1.0);
            }

            ENDCG
        }
    }
    Fallback "Specular"
}
