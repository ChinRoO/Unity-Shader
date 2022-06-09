Shader "Unity_Shaders_Book/Chapter 11/Water"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Magnitude ("Distortion Magnitude", float) = 1  // 控制水波幅度
        _Frequency ("Distortion Frequency", float) = 1  //  控制波动频率
        _InvWaveLength ("Distortion Inverse Wave Length", float) = 10   //  控制波长的倒数、波长越大值越小
        _Speed ("Speed", float) = 0.5   //  控制河流纹理移动的速度
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderTpye"="Transparent" "DisableBatching"="True"}

        Pass {
            Tags {"LightMode"="ForwardBase"}

            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Magnitude;
            float _Frequency;
            float _InvWaveLength;
            float _Speed;

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

                float4 offset;
                offset.yzw = float3(0.0, 0.0, 0.0);     //  只希望在x轴进行偏移，所以其他分量设置为0
                //  使用内置的_Time.y变量来和_Frquency来控制正弦函数的频率并加上模型空间的分量和_InWaveLength相乘的结果之和来作为频率输入，更好的随机性，并用_Magnitude控制振幅大小
                offset.x = sin(_Frequency * _Time.y + v.vertex.x * _InvWaveLength + v.vertex.y * _InvWaveLength + v.vertex.z * _InvWaveLength) * _Magnitude;
                o.pos = UnityObjectToClipPos(v.vertex + offset);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uv += float2(0.0, _Time.y * _Speed);  //  用_Time.y和_Speed来进行纹理动画

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
    FallBack "Transparent/VertexLit"
}
