Shader "Unity_Shaders_Book/Chapter 10/GrassRefraction"
{
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _Distortion ("Distortion", Range(0, 100)) = 10
        _RefractionAmount ("Refraction Amount", Range(0.0, 1.0)) = 1.0
    }
    SubShader {
        Tags {"RenderType"="Opaque" "Queue"="Transparent"}
        
        GrabPass {"_RefractionTex"}     //  采样GrabPass抓取屏幕图像并储存到一张名为_RefractionTex的纹理中

        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            samplerCUBE _Cubemap;
            float _Distortion;
            fixed _RefractionAmount;
            sampler2D _RefractionTex;
            float4 _RefractionTex_TexelSize;        //   得到抓取纹理的纹素大小

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord : TEXCOORD0;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                float4 scrPos : TEXCOORD0;
                float4 uv : TEXCOORD1;
                float4 TtoW0 : TEXCOORD2;
                float4 TtoW1 : TEXCOORD3;
                float4 TtoW2 : TEXCOORD4;
            };

            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.scrPos = ComputeGrabScreenPos(o.pos);     //  通过内置的ComputeGrabScreenPos函数来得到被抓取图形的采样坐标
                o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uv.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);

                float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                float3 worldBinormal = cross(worldTangent, worldNormal) * v.tangent.w;

                o.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
                o.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
                o.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

                return o;
            }
            fixed4 frag(v2f i) : SV_TARGET {
                float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);
                fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

                fixed3 bump = UnpackNormal(tex2D(_BumpMap, i.uv.zw));   //  将法线贴图上的法线解析到切线空间

                float2 offset = bump.xy * _Distortion * _RefractionTex_TexelSize.xy;    //  用_Distortion和_RefractionTex_TexelSize来计算偏移模拟折射效果
                i.scrPos.xy = offset + i.scrPos.xy;     //  使用透视除法，得到真正的屏幕坐标
                fixed3 refrCol = tex2D(_RefractionTex, i.scrPos.xy/i.scrPos.w).rgb;

                bump = normalize(half3(dot(i.TtoW0.xyz, bump), dot(i.TtoW1.xyz, bump), dot(i.TtoW2.xyz, bump)));

                fixed3 reflDir = (-worldViewDir, bump);     //  得到反射方向
                fixed4 texColor = tex2D(_MainTex, i.uv.xy);     //  得到纹理颜色
                fixed3 reflCor = texCUBE(_Cubemap, reflDir).rgb * texColor.rgb;     //  将Cubemap的颜色和纹理颜色相乘得到反射颜色

                fixed3 finaColor = reflCor * (1 - _RefractionAmount) + refrCol * _RefractionAmount;     //  任何事物都有菲涅尔效果，即吸收折射一部分光，反射一部分

                return fixed4(finaColor, 1.0);
            }
            ENDCG
        }
    }
    Fallback off
}
