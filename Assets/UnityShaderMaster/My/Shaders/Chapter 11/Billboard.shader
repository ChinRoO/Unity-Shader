Shader "Unity_Shaders_Book/Chapter 11/Billboard"
{
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _VerticalBillboarding ("Vertical Restraints", Range(0, 1)) = 1      //    用于调整是固定法线方向还是指定向上的方向
    }
    SubShader {
        Tags {"Queue"="Transparent" "IgnorProjector"="True" "RenderTpye"="Transparent" "DisableBatching"="True"}

        Pass {
            Tags {"LightMode"="ForwardBase"}

            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            Cull off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            fixed _VerticalBillboarding;

            struct a2v {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(a2v v) {
                v2f o;

                float3 center = float3(0, 0, 0);    //  设置锚点、模型空间下的原点坐标
                float3 viewer = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1));  //  将视角方向变换到模型空间下作为法线方向

                float3 normalDir = viewer - center;     // 得到法线方向
                
                normalDir.y = normalDir.y * _VerticalBillboarding;      //  使用一个变量对法线方向的Y轴进行约束，当变量为1时，意味着法线方向为视角方向，当变量为0时，意味着向上方向为（0，1，0）
                normalDir = normalize(normalDir);

                float3 upDir = abs(normalDir.y) > 0.999 ? float3(0, 0, 1) : float3(0, 1, 0);    //  对法线y分量进行判断防止法线和向上方向平行
                float3 rightDir = normalize(cross(normalDir, upDir));
                upDir = normalize(cross(rightDir, normalDir));

                float3 centerOffs = v.vertex.xyz - center;  //  每个顶点对锚点的偏移量
                float3 localPos = center + rightDir * centerOffs.x + upDir * centerOffs.y + normalDir * centerOffs.z;   //  计算新的顶点坐标

                o.pos = UnityObjectToClipPos(float4(localPos, 1));
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

                return o;
            }
            fixed4 frag(v2f i) : SV_TARGET {
                fixed4 c = tex2D(_MainTex, i.uv);
                c.rgb *= _Color.rgb;

                return c;
            }
            ENDCG
        }
    }
    Fallback "Transparent/VertexLit"
}
