Shader "Unity_Shaders_Book/Chapter 6/SpacularVertexLevel"
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
                fixed3 color : COLOR;
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));   //  得到世界空间下的法线方向
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);     //  得到世界空间的光照方向（平行光）

                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));   //  计算漫反射

                fixed3 reflectDir = normalize(reflect(-worldLightDir, worldNormal));    //  计算反射方向
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz);  //  计算观察方向

                fixed3 specular = _LightColor0.rgb * _Specular * pow(saturate(dot(viewDir, reflectDir)), _Gloss);   //  Phong模型高光反射方程

                o.color = ambient + diffuse + specular;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                return fixed4(i.color, 1.0);
            }

            ENDCG
        }
    }
    Fallback "Specular"
}