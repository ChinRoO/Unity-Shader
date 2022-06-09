Shader "Unity_Shaders_Book/Chapter 12/GaussianBlur"
{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white"{}
        _BlurSize ("Blur Size", float) = 1.0
    }
    SubShader {
        CGINCLUDE

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        half4 _MainTex_TexelSize;
        float _BlurSize;

        struct v2f {
            float4 pos : SV_POSITION;
            half2 uv[5] : TEXCOORD0;
        };

        v2f vertBlurVertical(appdata_img v) {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);

            half2 uv = v.texcoord;

            o.uv[0] = uv;     //  水平方向的一维高斯模糊核
            o.uv[1] = uv + float2(0.0, _MainTex_TexelSize.y * 1.0) * _BlurSize;
            o.uv[2] = uv - float2(0.0, _MainTex_TexelSize.y * 1.0) * _BlurSize;
            o.uv[3] = uv + float2(0.0, _MainTex_TexelSize.y * 2.0) * _BlurSize;
            o.uv[4] = uv - float2(0.0, _MainTex_TexelSize.y * 2.0) * _BlurSize;

            return o;
        }
        
        v2f vertBlurHorizontal(appdata_img v) {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);

            half2 uv = v.texcoord;

            o.uv[0] = uv;     //  竖直方向的一维高斯核
            o.uv[1] = uv + float2(_MainTex_TexelSize.x * 1.0, 0.0) * _BlurSize;
            o.uv[2] = uv - float2(_MainTex_TexelSize.x * 1.0, 0.0) * _BlurSize;
            o.uv[3] = uv + float2(_MainTex_TexelSize.x * 2.0, 0.0) * _BlurSize;
            o.uv[4] = uv - float2(_MainTex_TexelSize.x * 2.0, 0.0) * _BlurSize;

            return o;
        }

        fixed4 fragBlur(v2f i) : SV_TARGET {
            float weight[3] = {0.4026, 0.2442, 0.0545};     //  上面高斯核的权重，按照 0.0545，0.2442，0.4026，0.2442，0.0545这样排列

            fixed3 sum = tex2D(_MainTex, i.uv[0]).rgb * weight[0];    // 中心的像素采样权重计算

            for (int it =1; it < 3; it++) {    // 迭代
                sum += tex2D(_MainTex, i.uv[it * 2 - 1]).rgb * weight[it];  //  uv[1]、uv[3]的权重
                sum += tex2D(_MainTex, i.uv[it * 2]).rgb * weight[it];  //  uv[2]、uv[4]的权重
            }

            return fixed4(sum, 1.0);
        }

        ENDCG

        ZTest Always Cull Off ZWrite Off

        Pass {
            NAME "GAUSSIAN_BLUR_VERTICAL"

            CGPROGRAM

            #pragma vertex vertBlurVertical
            #pragma fragment fragBlur

            ENDCG
        }

        Pass {
            NAME "GAUSSIAN_BLUR_HORIZONTAL"

            CGPROGRAM

            #pragma vertex vertBlurHorizontal
            #pragma fragment fragBlur

            ENDCG
        }
    }
    Fallback Off
}
