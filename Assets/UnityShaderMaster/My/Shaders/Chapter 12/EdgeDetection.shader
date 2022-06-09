Shader "Unity_Shaders_Book/Chapter 12/EdgeDetection"
{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _EdgeOnly ("Edge Only", Float) = 1.0
        _EdgeColor ("Edge Color", Color) = (0, 0, 0, 1)
        _BackGroundColor ("BackGround Color", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Pass {
            ZTest Always Cull Off ZWrite Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            uniform half4 _MainTex_TexelSize;
            fixed _EdgeOnly;
            fixed4 _EdgeColor;
            fixed4 _BackGroundColor;

            struct v2f {
                float4 pos : SV_POSITION;
                half2 uv[9] : TEXCOORD0;
            };
            
            v2f vert(appdata_img v) {
                v2f o;

                o.pos = UnityObjectToClipPos(v.vertex);
                
                half2 uv = v.texcoord;

                o.uv[0] = uv + _MainTex_TexelSize.xy * half2(-1, -1);
                o.uv[1] = uv + _MainTex_TexelSize.xy * half2(0, -1);
                o.uv[2] = uv + _MainTex_TexelSize.xy * half2(1, -1);
                o.uv[3] = uv + _MainTex_TexelSize.xy * half2(-1, 0);
                o.uv[4] = uv + _MainTex_TexelSize.xy * half2(0, 0);
                o.uv[5] = uv + _MainTex_TexelSize.xy * half2(1, 0);
                o.uv[6] = uv + _MainTex_TexelSize.xy * half2(-1, 1);
                o.uv[7] = uv + _MainTex_TexelSize.xy * half2(0, 1);
                o.uv[8] = uv + _MainTex_TexelSize.xy * half2(1, 1);

                return o;
            }

            fixed luminance(fixed4 color) {
                return 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
            }

            half Sobel(v2f i) {
                const half Gx[9] = {-1,  0,  1, 
                                        -2,  0,  2, 
                                        -1,  0,  1};      //  定义水平方向的卷积核
                const half Gy[9] = {-1, -2, -1, 
                                        0,  0,  0, 
                                        1,  2,  1};      //  定义竖直方向的卷积核

                half texColor;
                half edgeX = 0;
                half edgeY = 0;
                for (int it = 0; it < 9; it++) {        //  依次对9个像素采样，并将采样到的亮度值和和卷积核中对应的权重进行相乘
                    texColor = luminance(tex2D(_MainTex, i.uv[it]));
                    edgeX += texColor * Gx[it];
                    edgeY += texColor * Gy[it];
                }

                half edge = 1 - abs(edgeX) - abs(edgeY);    // 当梯度越大时，越对应时一个边缘像素，edge值越小

                return edge;
            }

            fixed4 frag(v2f i) : SV_TARGET {
                half edge = Sobel(i);

                fixed4 WithEdgeColor = lerp(_EdgeColor, tex2D(_MainTex, i.uv[4]), edge);
                fixed4 OnlyEdgeColor = lerp(_EdgeColor, _BackGroundColor, edge);
                return lerp(WithEdgeColor, OnlyEdgeColor, _EdgeOnly);
            }           
            ENDCG
        }
    }
    Fallback Off
}
