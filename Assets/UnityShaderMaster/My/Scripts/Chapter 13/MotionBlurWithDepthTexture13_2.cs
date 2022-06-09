using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MotionBlurWithDepthTexture13_2 : PostEffectsBase
{
    public Shader montionBlurWithDepthTextureShader;
    private Material montionBlurWithDepthTextureMaterial = null;
    public Material material {
        get {
            montionBlurWithDepthTextureMaterial = CheckShaderAndCreateMaterial(montionBlurWithDepthTextureShader, montionBlurWithDepthTextureMaterial);
            return montionBlurWithDepthTextureMaterial;
        }
    }

    [Range(0.0f, 1.0f)]
    public float blurSize = 0.5f;

    private Camera myCamera;    // 得到camera组件
    public Camera camera {
        get {
            if (myCamera == null) {
                myCamera = GetComponent<Camera>();
            }
            return myCamera;
        }
    }

    private Matrix4x4 previousViewProjectionMatrix;     //  定义储存上一帧摄像机的视角*投影矩阵；

    void OnEnable() {       //  获取深度纹理
        camera.depthTextureMode |= DepthTextureMode.Depth;
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest) {
        if (material != null) {
            material.SetFloat("_BlurSize", blurSize);

            material.SetMatrix("_PreviousViewProjectionMatrix", previousViewProjectionMatrix);      // 通过对视角投影变换矩阵求逆后得到VPInverse矩阵，计算世界空间下的深度信息
            Matrix4x4 currentViewProjectionMatrix = camera.projectionMatrix * camera.worldToCameraMatrix;
            Matrix4x4 currentViewProjectionInverseMatrix = currentViewProjectionMatrix.inverse;
            material.SetMatrix("_CurrentViewProjectionInverseMatrix", currentViewProjectionInverseMatrix);  //  传递给材质

            previousViewProjectionMatrix = currentViewProjectionMatrix;     //  迭代

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
    
}
