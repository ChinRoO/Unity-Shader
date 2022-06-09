// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33556,y:32622,varname:node_3138,prsc:2|emission-8185-OUT;n:type:ShaderForge.SFN_NormalVector,id:263,x:32255,y:32480,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:4360,x:32255,y:32684,varname:node_4360,prsc:2;n:type:ShaderForge.SFN_Dot,id:6689,x:32428,y:32623,varname:node_6689,prsc:2,dt:0|A-263-OUT,B-4360-OUT;n:type:ShaderForge.SFN_Multiply,id:528,x:32590,y:32633,varname:node_528,prsc:2|A-2454-OUT,B-6689-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2454,x:32428,y:32524,ptovrint:False,ptlb:node_2454,ptin:_node_2454,varname:node_2454,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Add,id:4999,x:32774,y:32527,varname:node_4999,prsc:2|A-2454-OUT,B-528-OUT;n:type:ShaderForge.SFN_Append,id:6528,x:32965,y:32555,varname:node_6528,prsc:2|A-4999-OUT,B-831-OUT;n:type:ShaderForge.SFN_ValueProperty,id:831,x:32774,y:32702,ptovrint:False,ptlb:node_831,ptin:_node_831,varname:node_831,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:6764,x:33161,y:32555,ptovrint:False,ptlb:RampTex,ptin:_RampTex,varname:node_6764,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f6f78e9d117458c47b1a81fb3231f8dc,ntxv:0,isnm:False|UVIN-6528-OUT;n:type:ShaderForge.SFN_Vector4Property,id:2269,x:32318,y:32856,ptovrint:False,ptlb:node_2269,ptin:_node_2269,varname:node_2269,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Vector4Property,id:9666,x:32318,y:33028,ptovrint:False,ptlb:node_9666,ptin:_node_9666,varname:node_9666,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_NormalVector,id:1112,x:32318,y:33195,prsc:2,pt:False;n:type:ShaderForge.SFN_Add,id:3534,x:32572,y:33233,varname:node_3534,prsc:2|A-9666-XYZ,B-1112-OUT;n:type:ShaderForge.SFN_Normalize,id:2167,x:32803,y:33233,varname:node_2167,prsc:2|IN-3534-OUT;n:type:ShaderForge.SFN_LightVector,id:6905,x:32318,y:33384,varname:node_6905,prsc:2;n:type:ShaderForge.SFN_Dot,id:302,x:32993,y:33233,varname:node_302,prsc:2,dt:0|A-2167-OUT,B-6905-OUT;n:type:ShaderForge.SFN_Add,id:6983,x:32592,y:32960,varname:node_6983,prsc:2|A-2269-XYZ,B-1112-OUT;n:type:ShaderForge.SFN_Normalize,id:8080,x:32776,y:32948,varname:node_8080,prsc:2|IN-6983-OUT;n:type:ShaderForge.SFN_Dot,id:747,x:32983,y:32948,varname:node_747,prsc:2,dt:0|A-8080-OUT,B-6905-OUT;n:type:ShaderForge.SFN_Slider,id:383,x:32866,y:33115,ptovrint:False,ptlb:node_383,ptin:_node_383,varname:node_383,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.6,cur:0.9878263,max:1;n:type:ShaderForge.SFN_If,id:9815,x:33240,y:32870,varname:node_9815,prsc:2|A-747-OUT,B-383-OUT,GT-1409-OUT,EQ-7654-OUT,LT-7654-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7654,x:32983,y:32856,ptovrint:False,ptlb:node_7654,ptin:_node_7654,varname:node_7654,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1409,x:32983,y:32913,ptovrint:False,ptlb:node_1409,ptin:_node_1409,varname:node_1409,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_If,id:6925,x:33264,y:33185,varname:node_6925,prsc:2|A-302-OUT,B-383-OUT,GT-1409-OUT,EQ-7654-OUT,LT-7654-OUT;n:type:ShaderForge.SFN_Max,id:8452,x:33413,y:33148,varname:node_8452,prsc:2|A-9815-OUT,B-6925-OUT;n:type:ShaderForge.SFN_Clamp01,id:8185,x:33573,y:33175,varname:node_8185,prsc:2|IN-8452-OUT;proporder:2454-831-6764-9666-2269-383-7654-1409;pass:END;sub:END;*/

Shader "Shader Forge/Jade" {
    Properties {
        _node_2454 ("node_2454", Float ) = 0.5
        _node_831 ("node_831", Float ) = 0.3
        _RampTex ("RampTex", 2D) = "white" {}
        _node_9666 ("node_9666", Vector) = (0,0,0,0)
        _node_2269 ("node_2269", Vector) = (0,0,0,0)
        _node_383 ("node_383", Range(0.6, 1)) = 0.9878263
        _node_7654 ("node_7654", Float ) = 0
        _node_1409 ("node_1409", Float ) = 1
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
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_2269)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_9666)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_383)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7654)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1409)
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
                float4 _node_2269_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2269 );
                float node_747 = dot(normalize((_node_2269_var.rgb+i.normalDir)),lightDirection);
                float _node_383_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_383 );
                float node_9815_if_leA = step(node_747,_node_383_var);
                float node_9815_if_leB = step(_node_383_var,node_747);
                float _node_7654_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7654 );
                float _node_1409_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1409 );
                float4 _node_9666_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_9666 );
                float node_6925_if_leA = step(dot(normalize((_node_9666_var.rgb+i.normalDir)),lightDirection),_node_383_var);
                float node_6925_if_leB = step(_node_383_var,dot(normalize((_node_9666_var.rgb+i.normalDir)),lightDirection));
                float node_8185 = saturate(max(lerp((node_9815_if_leA*_node_7654_var)+(node_9815_if_leB*_node_1409_var),_node_7654_var,node_9815_if_leA*node_9815_if_leB),lerp((node_6925_if_leA*_node_7654_var)+(node_6925_if_leB*_node_1409_var),_node_7654_var,node_6925_if_leA*node_6925_if_leB)));
                float3 emissive = float3(node_8185,node_8185,node_8185);
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_2269)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_9666)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_383)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7654)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1409)
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
