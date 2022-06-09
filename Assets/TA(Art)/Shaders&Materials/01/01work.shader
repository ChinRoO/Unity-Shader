// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33235,y:32596,varname:node_3138,prsc:2|emission-8766-RGB,olwid-1619-OUT,olcol-4706-RGB;n:type:ShaderForge.SFN_NormalVector,id:4995,x:32163,y:32637,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:4889,x:32163,y:32811,varname:node_4889,prsc:2;n:type:ShaderForge.SFN_Dot,id:9991,x:32390,y:32657,varname:node_9991,prsc:2,dt:0|A-4995-OUT,B-4889-OUT;n:type:ShaderForge.SFN_Multiply,id:258,x:32549,y:32657,varname:node_258,prsc:2|A-9991-OUT,B-2123-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2123,x:32354,y:32873,ptovrint:False,ptlb:node_2123,ptin:_node_2123,varname:node_2123,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Add,id:3880,x:32712,y:32657,varname:node_3880,prsc:2|A-258-OUT,B-2123-OUT;n:type:ShaderForge.SFN_Append,id:2244,x:32783,y:32860,varname:node_2244,prsc:2|A-3880-OUT,B-5223-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5223,x:32549,y:32894,ptovrint:False,ptlb:node_5223,ptin:_node_5223,varname:node_5223,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:8766,x:32964,y:32816,ptovrint:False,ptlb:node_8766,ptin:_node_8766,varname:node_8766,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8199bda8fee262d49be5512f66dd3a0c,ntxv:0,isnm:False|UVIN-2244-OUT;n:type:ShaderForge.SFN_Color,id:4706,x:32995,y:33102,ptovrint:False,ptlb:node_4706,ptin:_node_4706,varname:node_4706,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3107868,c2:0.2127447,c3:0.3396226,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1619,x:33028,y:33016,ptovrint:False,ptlb:node_1619,ptin:_node_1619,varname:node_1619,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.02;proporder:2123-5223-8766-1619-4706;pass:END;sub:END;*/

Shader "Shader Forge/01work" {
    Properties {
        _node_2123 ("node_2123", Float ) = 0.5
        _node_5223 ("node_5223", Float ) = 0.3
        _node_8766 ("node_8766", 2D) = "white" {}
        _node_1619 ("node_1619", Float ) = 0.02
        _node_4706 ("node_4706", Color) = (0.3107868,0.2127447,0.3396226,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_4706)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1619)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                float _node_1619_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1619 );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_node_1619_var,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_4706_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4706 );
                return fixed4(_node_4706_var.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_8766; uniform float4 _node_8766_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2123)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5223)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _node_2123_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2123 );
                float _node_5223_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5223 );
                float2 node_2244 = float2(((dot(i.normalDir,lightDirection)*_node_2123_var)+_node_2123_var),_node_5223_var);
                float4 _node_8766_var = tex2D(_node_8766,TRANSFORM_TEX(node_2244, _node_8766));
                float3 emissive = _node_8766_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_8766; uniform float4 _node_8766_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2123)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5223)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
