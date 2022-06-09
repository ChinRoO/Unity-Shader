// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34106,y:32456,varname:node_3138,prsc:2|emission-4389-OUT,olwid-4466-OUT,olcol-2435-RGB;n:type:ShaderForge.SFN_LightVector,id:9484,x:32649,y:33046,varname:node_9484,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:2818,x:32649,y:33168,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:5195,x:32841,y:33046,varname:node_5195,prsc:2,dt:0|A-9484-OUT,B-2818-OUT;n:type:ShaderForge.SFN_Color,id:4901,x:32649,y:32873,ptovrint:False,ptlb:node_4901,ptin:_node_4901,varname:node_4901,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:2940,x:32511,y:32768,ptovrint:False,ptlb:颜色强度控制,ptin:_,varname:node_2940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:4720,x:32843,y:32768,varname:node_4720,prsc:2|A-2940-OUT,B-4901-RGB;n:type:ShaderForge.SFN_Step,id:5348,x:33021,y:32768,varname:node_5348,prsc:2|A-4720-OUT,B-5195-OUT;n:type:ShaderForge.SFN_RemapRange,id:2638,x:33301,y:32984,varname:node_2638,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-5348-OUT;n:type:ShaderForge.SFN_Color,id:5550,x:33301,y:33154,ptovrint:False,ptlb:ShadowColor,ptin:_ShadowColor,varname:node_5550,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7,c2:0.7,c3:0.7,c4:1;n:type:ShaderForge.SFN_Multiply,id:5138,x:33470,y:32984,varname:node_5138,prsc:2|A-2638-OUT,B-5550-RGB;n:type:ShaderForge.SFN_Color,id:5264,x:33288,y:32832,ptovrint:False,ptlb:LightColor,ptin:_LightColor,varname:node_5264,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.7,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:8144,x:33445,y:32773,varname:node_8144,prsc:2|A-5348-OUT,B-5264-RGB;n:type:ShaderForge.SFN_Add,id:4389,x:33749,y:32757,varname:node_4389,prsc:2|A-105-OUT,B-5138-OUT;n:type:ShaderForge.SFN_ScreenPos,id:4377,x:33090,y:32414,varname:node_4377,prsc:2,sctp:0;n:type:ShaderForge.SFN_Depth,id:3546,x:33090,y:32544,varname:node_3546,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1372,x:33277,y:32414,varname:node_1372,prsc:2|A-4377-UVOUT,B-3546-OUT;n:type:ShaderForge.SFN_Tex2d,id:4149,x:33454,y:32414,ptovrint:False,ptlb:node_4149,ptin:_node_4149,varname:node_4149,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1372-OUT;n:type:ShaderForge.SFN_Multiply,id:105,x:33601,y:32588,varname:node_105,prsc:2|A-4149-RGB,B-8144-OUT;n:type:ShaderForge.SFN_Color,id:2435,x:33901,y:32877,ptovrint:False,ptlb:node_2435,ptin:_node_2435,varname:node_2435,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:4466,x:33901,y:32791,ptovrint:False,ptlb:node_4466,ptin:_node_4466,varname:node_4466,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;proporder:4901-2940-5550-5264-4149-4466-2435;pass:END;sub:END;*/

Shader "Shader Forge/03_workCreate" {
    Properties {
        _node_4901 ("node_4901", Color) = (0.5,0.5,0.5,1)
        _ ("颜色强度控制", Range(0, 1)) = 0
        _ShadowColor ("ShadowColor", Color) = (0.7,0.7,0.7,1)
        _LightColor ("LightColor", Color) = (0.5,0.7,0.5,1)
        _node_4149 ("node_4149", 2D) = "white" {}
        _node_4466 ("node_4466", Float ) = 0
        _node_2435 ("node_2435", Color) = (0.5,0.5,0.5,1)
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
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_2435)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_4466)
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
                float _node_4466_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4466 );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_node_4466_var,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_2435_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2435 );
                return fixed4(_node_2435_var.rgb,0);
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
            uniform sampler2D _node_4149; uniform float4 _node_4149_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_4901)
                UNITY_DEFINE_INSTANCED_PROP( float, _)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ShadowColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightColor)
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
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float2 node_1372 = ((sceneUVs * 2 - 1).rg*partZ);
                float4 _node_4149_var = tex2D(_node_4149,TRANSFORM_TEX(node_1372, _node_4149));
                float __var = UNITY_ACCESS_INSTANCED_PROP( Props, _ );
                float4 _node_4901_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4901 );
                float3 node_5348 = step((__var*_node_4901_var.rgb),dot(lightDirection,i.normalDir));
                float4 _LightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightColor );
                float4 _ShadowColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ShadowColor );
                float3 emissive = ((_node_4149_var.rgb*(node_5348*_LightColor_var.rgb))+((node_5348*-1.0+1.0)*_ShadowColor_var.rgb));
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
            uniform sampler2D _node_4149; uniform float4 _node_4149_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_4901)
                UNITY_DEFINE_INSTANCED_PROP( float, _)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ShadowColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightColor)
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
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
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
