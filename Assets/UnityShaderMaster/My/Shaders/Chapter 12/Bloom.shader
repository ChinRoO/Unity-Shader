Shader "Unity_Shaders_Book/Bloom"
{
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
        _Bloom ("Bloom (RGB)", 2D) = "black" {}
        _LuminanceThreshold ("Luminance Threshold", float) = 0.5
        _BlurSize ("Blur Size", float) = 1.0
    }

    SubShader {
        CGINCLUDE

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        half4 _MainTex_TexelSize;
        sampler2D _Bloom;
        float _LuminanceThreshold;
        float _BlurSize;

        struct v2f {
            float4 pos : SV_POSITION;
            half2 uv : TEXCOORD0;
        };

        v2f vertExtractShader(appdata_img v) {      //  计算高亮区域Pass的vertex shader
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = v.texcoord;

            return o;
        }

        fixed luminance(fixed4 color) {
            return 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
        }

        fixed4 fragExtractBright(v2f i) : SV_TARGET {     //    在片元着色器中，展UV，并将亮度与阈值相减并截取结果在0到1范围内的片元
            fixed4 c = tex2D(_MainTex, i.uv);
            fixed val = clamp(luminance(c) - _LuminanceThreshold, 0.0, 1.0);    

            return c * val;
        }

        struct v2fBloom {
            float4 pos : SV_POSITION;
            half4 uv : TEXCOORD0;
        };

        v2fBloom vertBloom(appdata_img v) {
            v2fBloom o;
            
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv.xy = v.texcoord;   // 第一张题图存到xy,
            o.uv.zw = v.texcoord;   // 第二张贴图存到zw。

            #if UNITY_UV_STARTS_AT_TOP
            if(_MainTex_TexelSize.y < 0)
                o.uv.w = 1.0 - o.uv.w;
            #endif

            return o;
        }

        fixed4 fragBloom(v2fBloom i) : SV_TARGET {
            return tex2D(_MainTex, i.uv.xy) + tex2D(_Bloom, i.uv.zw);
        }
        ENDCG

        ZTest Always Cull Off ZWrite Off

        Pass {
            CGPROGRAM

            #pragma vertex vertExtractShader
            #pragma fragment fragExtractBright

            ENDCG
        }

        UsePass "Unity_Shaders_Book/Chapter 12/GaussianBlur/GAUSSIAN_BLUR_VERTICAL"
        UsePass "Unity_Shaders_Book/Chapter 12/GaussianBlur/GAUSSIAN_BLUR_HORIZONTAL"

        Pass {
            CGPROGRAM

            #pragma vertex vertBloom
            #pragma fragment fragBloom

            ENDCG
        }
    }
    Fallback Off
}
