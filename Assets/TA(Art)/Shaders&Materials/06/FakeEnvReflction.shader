Shader "06/FakeEnvFlaction"
{
    Properties {
        _RampTex ("Ramp Tex", 2D) = "white" {}
        _RampType ("Ramp Tpye", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(10, 90)) = 10
    }
    SubShader {
        Pass {
            Tags {"LightMode" = "ForwardBase"}
            
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"
            
            sampler2D _RampTex;
            float4 _RampTex_ST;
            fixed _RampType;
            float _Gloss;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
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
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.uv = TRANSFORM_TEX(v.texcoord, _RampTex);

                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET {
                float3 worldNormal = normalize(i.worldNormal);
                float3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                float3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                float3 viewReflectDir = reflect(worldViewDir, worldNormal);

                fixed phong = dot(viewReflectDir, worldLightDir) * 0.5 + 0.5;
                fixed3 diffuseColor = tex2D(_RampTex, fixed2(phong, phong)).rgb * _RampType;

                fixed3 diffuse = _LightColor0.rgb * diffuseColor;
                fixed3 specular = _LightColor0.rgb * pow(saturate(dot(viewReflectDir, worldLightDir)), _Gloss);
                
                return fixed4(diffuseColor + specular, 1.0);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
