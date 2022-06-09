Shader "Unity_Shaders_Book/Chapter 13/EdgeDetectNormalAndDepth"
{
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
        _EdgeOnly ("Edge Only", float) = 1.0
        _EdgeColor ("Edge Color", Color) = (0, 0, 0, 1)
        _BackgroundColor ("Background Color", Color) = (1, 1, 1, 1)
        _SampleDistance ("Sample Distance", float) = 1.0
        _Sensitivity ("Sensitivity", vector) = (1, 1, 1, 1)
    }
    SubShader {
        CGINCLUDE

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        half4 _MainTex_TexelSize;
        fixed _EdgeOnly;
        fixed4 _EdgeColor;
        fixed4 _BackgroundColor;
        half _SampleDistance;
        half4 _Sensitivity;
        sampler2D _CameraDepthNormalsTexture;

        struct v2f {
            float4 pos : SV_POSITION;
            half2 uv[5] : TEXCOORD0;
        };

        v2f vert(appdata_img v) {
            v2f o;
            
            o.pos = UnityObjectToClipPos(v.vertex);
            
            half2 uv = v.texcoord;

            o.uv[0] = uv;

            #if UNITY_UV_STARTS_AT_TOP
            if(_MainTex_TexelSize.y < 0)
                uv.y = 1 - uv.y;
            #endif

            o.uv[1] = uv + _MainTex_TexelSize.xy * half2(1, 1) * _SampleDistance;       //  Roberts算子的4个取样点
            o.uv[2] = uv + _MainTex_TexelSize.xy * half2(-1, -1) * _SampleDistance;
            o.uv[3] = uv + _MainTex_TexelSize.xy * half2(-1, 1) * _SampleDistance;
            o.uv[4] = uv + _MainTex_TexelSize.xy * half2(1, -1) * _SampleDistance;

            return o;
        }

        half CheckSame(half4 center, half4 sample) {    //  主要比较两个是不是在同一深度同一法线
            half2 centerNormal = center.xy;
            float centerDepth = DecodeFloatRG(center.zw);
            half2 sampleNormal = sample.xy;
            float sampleDepth = DecodeFloatRG(sample.zw);

            // difference in normals
            // do not bother decoding normals - there's no need here
            half2 diffNormal = abs(centerNormal - sampleNormal) * _Sensitivity.x;
            int isSameNormal = (diffNormal.x + diffNormal.y) < 0.1;
            // difference in depth
            float diffDepth = abs(centerDepth - sampleDepth) * _Sensitivity.y;
            int isSameDepth = diffDepth < 0.1 * centerDepth;

            return isSameNormal * isSameDepth ? 1.0 : 0.0;
        }

        fixed4 fragRobertsCrossDepthAndNormal (v2f i) : SV_TARGET {
            half4 sample1 = tex2D(_CameraDepthNormalsTexture, i.uv[1]);     //  取样
            half4 sample2 = tex2D(_CameraDepthNormalsTexture, i.uv[2]);
            half4 sample3 = tex2D(_CameraDepthNormalsTexture, i.uv[3]);
            half4 sample4 = tex2D(_CameraDepthNormalsTexture, i.uv[4]);

            half edge = 1.0;

            edge *= CheckSame(sample1, sample2);
            edge *= CheckSame(sample2, sample4);

            fixed4 withEdgeColor = lerp(_EdgeColor, tex2D(_MainTex, i.uv[0]), edge);        //  对边缘颜色和纹理颜色在边缘处进行插值
            fixed4 onlyEdgeColor = lerp(_EdgeColor, _BackgroundColor, edge);        //  对边缘颜色和背景颜色在边缘处插值

            return lerp(withEdgeColor, onlyEdgeColor, _EdgeOnly);
        }
        ENDCG

        Pass {
            ZTest Always Cull Off ZWrite Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment fragRobertsCrossDepthAndNormal

            ENDCG
        }    
    }
    Fallback Off
}