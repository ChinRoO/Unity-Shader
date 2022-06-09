Shader "Unity_Shaders_Book/Chapter 7/SingleTexture"
{
    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Main Tex", 2D) = "white" {}  //  纹理属性是2D
        _Specular ("Specular", Color) = (1, 1, 1, 1)
        _Gloss ("Gloss", Range(8.0, 256)) = 20  //  控制高光反射区域大小
    }

    SubShader {
        Pass {
            Tags { "LightMode"="ForwardBase" }

            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;     //  定义了一个—_MainTex_ST的属性，其中xy分量表示缩放属性，zw分量表示平移属性
            fixed4 _Specular;
            float _Gloss;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;    //  TEXCOORD0语义表示将第一组纹理加载到texcoord变量中
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
                o.worldNormal = UnityObjectToWorldNormal(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;     //  对2D纹理进行缩放和平移，先缩放后平移
                // o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                fixed3 worldNormal = normalize(i.worldNormal);      //  得到世界空间下的法线方向和光线方向
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                //  采用CG语言的内置函数TEX2D对纹理进行采样，第一个参数是纹理，第二个参数是纹理坐标，并将得到的结果和漫反射颜色相乘，将纹理信息映射到颜色信息
                fixed3 albedo = tex2D(_MainTex, i.uv).rgb * _Color.rgb;
                //  将纹理信息映射到环境光
                fixed3 ambilent = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
                //  将纹理信息映射到漫反射
                fixed3 diffuse = _LightColor0.rgb * albedo * max(0, dot(worldLightDir,worldNormal));
                //  计算高光反射
                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                fixed3 halfDir = normalize(worldLightDir + viewDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, halfDir)), _Gloss);

                return fixed4(ambilent + diffuse + specular, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Specular"
}
