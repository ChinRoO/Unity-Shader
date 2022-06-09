using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bloom12_2 : PostEffectsBase
{
    public Shader bloomShader;
    private Material bloomMaterial = null;
    public Material material{
        get {
            bloomMaterial = CheckShaderAndCreateMaterial(bloomShader, bloomMaterial);
            return bloomMaterial;
        }
    }

    [Range(0, 4)]
    public int interations = 3;     //  迭代次数

    [Range(0.2f, 3.0f)]
    public float blurSpread = 0.6f;     //  模糊范围

    [Range(1, 8)]
    public int downSample = 2;  //  缩放系数

    [Range(0.0f, 4.0f)]
    public float luminanceThreshold = 0.6f;     //  亮度阈值

    void OnRenderImage(RenderTexture src, RenderTexture dest) {
        if(material != null) {
            material.SetFloat("_LuminanceThreshold", luminanceThreshold);

            int rtW = src.width / downSample;
            int rtH = src.height / downSample;

            RenderTexture buffer0 = RenderTexture.GetTemporary(rtW, rtH, 0);
            buffer0.filterMode = FilterMode.Bilinear;

            Graphics.Blit(src, buffer0, material, 0);

            for(int i = 0; i < interations; i++) {
                material.SetFloat("_BlurSize", 1.0f + i * blurSpread);    //  传递模糊范围给shader

                RenderTexture buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);

                Graphics.Blit(buffer0, buffer1, material, 1);

                RenderTexture.ReleaseTemporary(buffer0);
                buffer0 = buffer1;
                buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);

                Graphics.Blit(buffer0, buffer1, material, 2);
                
                RenderTexture.ReleaseTemporary(buffer0);
                buffer0 = buffer1;
            }
            
            material.SetTexture("_Bloom", buffer0);     //  传递迭代完成的Bloom纹理给shader
            Graphics.Blit(src, dest, material, 3);  //  将处理完成的图像显示输出
        } 
        else{
            Graphics.Blit(src, dest);
        }
    }
}
