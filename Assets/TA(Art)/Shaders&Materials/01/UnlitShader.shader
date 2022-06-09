// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33073,y:32667,varname:node_3138,prsc:2|emission-6702-RGB;n:type:ShaderForge.SFN_Tex2d,id:6702,x:32761,y:32908,ptovrint:False,ptlb:node_6702,ptin:_node_6702,varname:node_6702,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:eb41ab47112aa1a47bc20c8fafe76703,ntxv:3,isnm:False|UVIN-4639-OUT;n:type:ShaderForge.SFN_LightVector,id:2367,x:32135,y:32484,varname:node_2367,prsc:2;n:type:ShaderForge.SFN_Dot,id:1798,x:32385,y:32625,varname:node_1798,prsc:2,dt:0|A-2367-OUT,B-5840-OUT;n:type:ShaderForge.SFN_NormalVector,id:5840,x:32135,y:32672,prsc:2,pt:False;n:type:ShaderForge.SFN_ValueProperty,id:3858,x:32395,y:32798,ptovrint:False,ptlb:node_3858,ptin:_node_3858,varname:node_3858,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:2627,x:32550,y:32625,varname:node_2627,prsc:2|A-1798-OUT,B-3858-OUT;n:type:ShaderForge.SFN_Add,id:5051,x:32747,y:32625,varname:node_5051,prsc:2|A-2627-OUT,B-1405-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1405,x:32598,y:32785,ptovrint:False,ptlb:node_1405,ptin:_node_1405,varname:node_1405,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Append,id:4639,x:32611,y:32908,varname:node_4639,prsc:2|A-5051-OUT,B-9243-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9243,x:32885,y:32576,ptovrint:False,ptlb:node_9243,ptin:_node_9243,varname:node_9243,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;proporder:3858-1405-6702-9243;pass:END;sub:END;*/

Shader "Shader Forge/UnlitShader" {
    Properties {
        _node_3858 ("node_3858", Float ) = 0.5
        _node_1405 ("node_1405", Float ) = 0.5
        _node_6702 ("node_6702", 2D) = "bump" {}
        _node_9243 ("node_9243", Float ) = 0.2
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            uniform sampler2D _node_6702; uniform float4 _node_6702_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_3858)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1405)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_9243)
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
                float _node_3858_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_3858 );
                float _node_1405_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1405 );
                float _node_9243_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_9243 );
                float2 node_4639 = float2(((dot(lightDirection,i.normalDir)*_node_3858_var)+_node_1405_var),_node_9243_var);
                float4 _node_6702_var = tex2D(_node_6702,TRANSFORM_TEX(node_4639, _node_6702));
                float3 emissive = _node_6702_var.rgb;
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
            uniform sampler2D _node_6702; uniform float4 _node_6702_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_3858)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1405)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_9243)
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
