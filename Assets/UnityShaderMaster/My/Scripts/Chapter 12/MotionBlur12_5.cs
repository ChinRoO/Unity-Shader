using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MotionBlur12_5 : PostEffectsBase
{
    public Shader motionBlurShader;
    private Material motionBlurMaterial = null;
    public Material material {
        get {
            motionBlurMaterial = CheckShaderAndCreateMaterial(motionBlurShader, motionBlurMaterial);
            return motionBlurMaterial;
        }
    }

    [Range(0.0f, 0.9f)]
    public float blurAmount = 0.5f;     //  定义模糊参数

    private RenderTexture accumulationTexture;      //  保存之前叠加的图像

    void OnDisable() {
        DestroyImmediate(accumulationTexture);      //  当脚本不运行时，销毁accumulationTexture
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest) {
        if (material != null) {     //  先判断accumulationTexture是否满足条件，并且判断纹理是否和屏幕像素相等，不满足则创建新的纹理
            if(accumulationTexture == null || accumulationTexture.width != src.width || accumulationTexture.height != src.height) {
                DestroyImmediate(accumulationTexture);
                accumulationTexture = new RenderTexture(src.width, src.height, 0);
                accumulationTexture.hideFlags = HideFlags.HideAndDontSave;
                Graphics.Blit(src, accumulationTexture);
            }

            accumulationTexture.MarkRestoreExpected();  //  Using Restore operation

            material.SetFloat("_BlurAmount", blurAmount);

            Graphics.Blit(src, accumulationTexture, material);
            Graphics.Blit(accumulationTexture, dest);
        } else{
            Graphics.Blit(src, dest);
        }
    }
}