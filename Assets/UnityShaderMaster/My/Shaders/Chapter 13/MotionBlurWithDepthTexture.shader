Shader "Unity_Shaders_Book/Chapter 13/MotionBlurWithDepthTexture"
{
    Properties {
        _MainTex ("Main Tex", 2D) = "white"{}
        _BlurSize ("Blur Size", float) = 1.0
    }

    SubShader {
        CGINCLUDE

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        half4 _MainTex_TexelSize;
        float _BlurSize;
        sampler2D _CameraDepthTexture;  //  Unity传递的深度纹理
        float4x4 _CurrentViewProjectionInverseMatrix;   //  由脚本传递的矩阵
        float4x4 _PreviousViewProjectionMatrix;

        struct v2f {
            float4 pos : SV_POSITION;
            half2 uv : TEXCOORD0;
            half2 uv_depth : TEXCOORD1;
        };

        v2f vert(appdata_img v) {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = v.texcoord;

            o.uv_depth = v.texcoord;

            #if UNITY_UV_STARTS_AT_TOP
            if (_MainTex_TexelSize.y < 0)
                o.uv_depth.y = 1 - o.uv_depth.y;
            #endif

            return o;
        }

        fixed4 frag(v2f i) : SV_TARGET {
            // Get the depth buffer value at this pixel.
            float d = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, i.uv_depth);
            // 将深度信息映射到NDC
            float4 H = float4(i.uv.x * 2 -1, i.uv.y * 2 -1, d, 1);
            // Transform by the view-projection Inverse
            float4 D = mul(_CurrentViewProjectionInverseMatrix, H);
            // Divide by w to get the worldpositon.
            float4 worldPos = D / D.w;

            // Current view position
            float4 currentPos = H;
            // Use the world positon, and transform by the previous view-projection matrix.
            float4 priviousPos = mul(_PreviousViewProjectionMatrix, worldPos);
            // Convert to nonhomogeneous point[-1, 1] by dividing by w
            priviousPos /= priviousPos.w;

            // Use this frame's position and last frame's to compute the pixel velocity
            float2 velocity = (currentPos.xy - priviousPos.xy) / 2.0f;

            float2 uv = i.uv;
            float4 c = tex2D(_MainTex, uv);
            uv += velocity * _BlurSize;
            for(int it = 1; it < 3; it++, uv += velocity * _BlurSize) {     // RGB3个分量
                float4 currentColor = tex2D(_MainTex, uv);
                c += currentColor;
            }

            c /= 3;

            return fixed4(c.rgb, 1.0);
        }
        ENDCG

        Pass {
            ZTest Always Cull Off ZWrite Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            ENDCG
        }
    }
    Fallback Off
}
