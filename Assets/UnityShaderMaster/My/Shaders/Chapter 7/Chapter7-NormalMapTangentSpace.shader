Shader "Unity_Shaders_Book/Chapter 7/NormalMapTangentSpace"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _BumpScale ("Bump Scale", Float) = 1.0
        _Specular ("Specular", Color) = (1,1,1,1)
        _Gloss ("Gloss", Range(8.0, 256)) = 20
    }
    SubShader
    {
        Pass {
            Tags { "LightMode"="ForwardBase" }

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            float _BumpScale;
            fixed4 _Specular;
            float _Gloss;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 texcoord : TEXCOORD0;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
                float3 lightDir : TEXCOORD1;
                float3 viewDir : TEXCOORD2;  
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;  //  储存_MainTex的属性
                o.uv.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;  //  储存_BumpMap的属性，通常_MainTex和_BumpTex共用一套纹理坐标

                TANGENT_SPACE_ROTATION; //  使用Unity内置宏得到模型空间到切线空间的变换矩阵rotation

                o.lightDir = mul(rotation, ObjSpaceLightDir(v.vertex)).xyz; //  得到切线空间的光照方向
                o.viewDir = mul(rotation, ObjSpaceViewDir(v.vertex)).xyz;   //  得到切线空间的视野方向

                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET {
                fixed3 tangentLightDir = normalize(i.lightDir);
                fixed3 tangentViewDir = normalize(i.viewDir);
                
                fixed4 packedNormal = tex2D(_BumpMap, i.uv.zw);     //使用tex2D函数对法线纹理进行采样
                fixed3 tangentNormal;
                //  If the texture is not marked as "Normal Map"
                //  tangentNormal.xy = (packedNormal * 2 -1) * _BumpScale;
                //  tangentNormal.z = sqrt(1.0 - saturate(dot(tangentNormal.xy, tangentNormal.xy)));

                //  Or marked the texture as "Normal Map", use the build-in function
                tangentNormal = UnpackNormal(packedNormal);     //  使用UnpackNormal函数对法线进行映射
                tangentNormal.xy *= _BumpScale; //  切线空间的法线xy分量有一个缩放系数_BunpScale
                tangentNormal.z = sqrt(1.0 - saturate(dot(tangentNormal.xy, tangentNormal.xy)));    //  z=sqrt(1-dot(xy,xy))

                fixed3 albedo = tex2D(_MainTex, i.uv).rgb * _Color.rgb;
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
                fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(tangentLightDir, tangentNormal));

                fixed3 halfDir = normalize(tangentLightDir + tangentViewDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(halfDir, tangentNormal)), _Gloss);
                
                return fixed4(ambient + diffuse + specular, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Specular"
}
