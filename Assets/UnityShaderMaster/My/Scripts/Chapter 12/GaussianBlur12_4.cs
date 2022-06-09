using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GaussianBlur12_4 : PostEffectsBase
{
    public Shader gaussianBlurShader;
    private Material gaussianBlurMaterial = null;
    public Material material {
        get {
            gaussianBlurMaterial = CheckShaderAndCreateMaterial(gaussianBlurShader, gaussianBlurMaterial);
            return gaussianBlurMaterial;
        }
    }

    [Range(0, 4)]
    public int iterations = 3;

    [Range(0.2f, 3.0f)]
    public float blurSpread = 3;

    [Range(1, 8)]
    public int downSample = 2;      //  缩放系数

    void OnRenderImage(RenderTexture src, RenderTexture dest) {
        if (material != null) {
            int rtW = src.width / downSample;   // 使用了小于屏幕分辨路的尺寸，总像素为原来的1/4
            int rtH = src.height / downSample;

            RenderTexture buffer0 = RenderTexture.GetTemporary(rtW, rtH, 0);    // 定义缓冲器0，大小为rtW, rtH
            buffer0.filterMode = FilterMode.Bilinear;   //  滤波模式为双线性

            Graphics.Blit(src, buffer0);    

            for (int i = 0; i < iterations; i++) {      //  开始迭代
                material.SetFloat("_BlurSize", 1.0f + i * blurSpread);      //  模糊范围

                RenderTexture buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);    //   定义缓冲器1

                Graphics.Blit(buffer0, buffer1, material, 0);   //  执行第一个Pass

                RenderTexture.ReleaseTemporary(buffer0);    //  释放buffer0，并且将buffer1中的信息传递给buffer0，buffer1重新取样
                buffer0 = buffer1;
                buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);

                Graphics.Blit(buffer0, buffer1, material, 1);       //  执行第二个Pass

                RenderTexture.ReleaseTemporary(buffer0);
                buffer0 = buffer1;  //将最终结果储存在buffer0
            }

            Graphics.Blit(buffer0, dest);
            RenderTexture.ReleaseTemporary(buffer0);    //  输出图像并且释放buffer0；
            
        } else {
            Graphics.Blit(src, dest);
        }
    }
}
