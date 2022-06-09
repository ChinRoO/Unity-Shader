// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33276,y:32626,varname:node_3138,prsc:2|emission-2619-OUT;n:type:ShaderForge.SFN_LightVector,id:1972,x:32258,y:32668,varname:node_1972,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:6703,x:32258,y:32795,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:2574,x:32471,y:32725,varname:node_2574,prsc:2,dt:0|A-1972-OUT,B-6703-OUT;n:type:ShaderForge.SFN_Multiply,id:5354,x:32660,y:32702,varname:node_5354,prsc:2|A-1841-OUT,B-2574-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1841,x:32441,y:32608,ptovrint:False,ptlb:node_1841,ptin:_node_1841,varname:node_1841,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Add,id:8092,x:32864,y:32702,varname:node_8092,prsc:2|A-1841-OUT,B-5354-OUT;n:type:ShaderForge.SFN_Multiply,id:2619,x:33047,y:32712,varname:node_2619,prsc:2|A-8092-OUT,B-8647-RGB;n:type:ShaderForge.SFN_Color,id:8647,x:32819,y:32859,ptovrint:False,ptlb:node_8647,ptin:_node_8647,varname:node_8647,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4874984,c2:0.3292274,c3:0.6415094,c4:1;proporder:1841-8647;pass:END;sub:END;*/

Shader "Shader Forge/BasicShader" {
    Properties {
        _node_1841 ("node_1841", Float ) = 0.5
        _node_8647 ("node_8647", Color) = (0.4874984,0.3292274,0.6415094,1)
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1841)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_8647)
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
                float _node_1841_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1841 );
                float4 _node_8647_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_8647 );
                float3 emissive = ((_node_1841_var+(_node_1841_var*dot(lightDirection,i.normalDir)))*_node_8647_var.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
