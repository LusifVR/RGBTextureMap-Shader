Shader "[ Prelancer Studios ]/TextureMap"
// Texturemap shader made by Lusif - Prelancer Studios
// You are free to use in any project, including commerical
// Do not sell the code or a version of it on its own.
// Happy creating!
{
    Properties
    {
        [Header(Global)]
        _MainColor("Main Color", Color) = (1,1,1,1)
        _Brightness("Brightness", Range(0,5)) = 1

        [Header(Mask)]
        _Mask("RGB Mask", 2D) = "white" {}

        [Header(Red Layer)]
        _MainTexR("Albedo", 2D) = "white" {}
        _NormalR("Normal", 2D) = "bump" {}
        _NormalStrengthR("Normal Strength", Range(0,2)) = 1

        [Header(Green Layer)]
        _MainTexG("Albedo", 2D) = "white" {}
        _NormalG("Normal", 2D) = "bump" {}
        _NormalStrengthG("Normal Strength", Range(0,2)) = 1

        [Header(Blue Layer)]
        _MainTexB("Albedo", 2D) = "white" {}
        _NormalB("Normal", 2D) = "bump" {}
        _NormalStrengthB("Normal Strength", Range(0,2)) = 1

        [Header(Black Layer)]
        _MainTexK("Albedo", 2D) = "white" {}
        _NormalK("Normal", 2D) = "bump" {}
        _NormalStrengthK("Normal Strength", Range(0,2)) = 1

            [Header(Surface)]
            _SmoothnessMap("Smoothness Map", 2D) = "white" {}
            _SmoothnessIntensity("Smoothness Intensity", Range(0,2)) = 1

            _OcclusionMap("Occlusion Map", 2D) = "white" {}
            _OcclusionIntensity("Occlusion Intensity", Range(0,5)) = 1

             [Header(FX)]
             _OverlayTex("Overlay", 2D) = "white" {}
             _OverlayStrength("Overlay Strength", Range(0,1)) = 1

             _EmissionMap("Emission Map", 2D) = "black" {}
             [HDR] _EmissionColor("Emission Color (HDR)", Color) = (1,1,1,1)
             _EmissionStrength("Emission Strength", Range(0,5)) = 1
    }

        SubShader
                {
                    Tags { "RenderType" = "Opaque" }

                    CGPROGRAM
                    #pragma surface surf Standard fullforwardshadows

                    sampler2D _Mask;

                    sampler2D _MainTexR;
                    sampler2D _MainTexG;
                    sampler2D _MainTexB;
                    sampler2D _MainTexK;

                    sampler2D _NormalR;
                    sampler2D _NormalG;
                    sampler2D _NormalB;
                    sampler2D _NormalK;

                    sampler2D _SmoothnessMap;
                    sampler2D _OcclusionMap;

                    sampler2D _OverlayTex;
                    sampler2D _EmissionMap;

                    float4 _MainTexR_ST;
                    float4 _MainTexG_ST;
                    float4 _MainTexB_ST;
                    float4 _MainTexK_ST;

                    half4 _MainColor;
                    half4 _EmissionColor;

                    half _NormalStrengthR;
                    half _NormalStrengthG;
                    half _NormalStrengthB;
                    half _NormalStrengthK;

                    half _SmoothnessIntensity;
                    half _OcclusionIntensity;

                    half _OverlayStrength;
                    half _EmissionStrength;
                    half _Brightness;

                    struct Input
                    {
                        float2 uv_MainTex;
                        float2 uv2_MainTex;
                    };

                    float2 ApplyST(float2 uv, float4 st)
                    {
                        return uv * st.xy + st.zw;
                    }

                    void surf(Input IN, inout SurfaceOutputStandard o)
                    {
                        // Mask texture

                        half4 mask = tex2D(_Mask, IN.uv2_MainTex);

                        // Fourth channel = black areas of mask
                        half maskK = saturate(1.0 - (mask.r + mask.g + mask.b));

                        // Each RGB (+ k/black) gets its own UV via texture

                        float2 uvR = ApplyST(IN.uv_MainTex, _MainTexR_ST);
                        float2 uvG = ApplyST(IN.uv_MainTex, _MainTexG_ST);
                        float2 uvB = ApplyST(IN.uv_MainTex, _MainTexB_ST);
                        float2 uvK = ApplyST(IN.uv_MainTex, _MainTexK_ST);

                        // Texture for each channel

                        half3 rgbAlbedo =
                            tex2D(_MainTexR, uvR).rgb * mask.r +
                            tex2D(_MainTexG, uvG).rgb * mask.g +
                            tex2D(_MainTexB, uvB).rgb * mask.b +
                            tex2D(_MainTexK, uvK).rgb * maskK;

                        // Normals for each channel

                        half3 nR = UnpackNormal(tex2D(_NormalR, uvR)) * _NormalStrengthR;
                        half3 nG = UnpackNormal(tex2D(_NormalG, uvG)) * _NormalStrengthG;
                        half3 nB = UnpackNormal(tex2D(_NormalB, uvB)) * _NormalStrengthB;
                        half3 nK = UnpackNormal(tex2D(_NormalK, uvK)) * _NormalStrengthK;

                        o.Normal = normalize(
                            nR * mask.r +
                            nG * mask.g +
                            nB * mask.b +
                            nK * maskK
                        );

                        // Overlap map (Manual lighting, visual effect stuff)

                        half4 overlay = tex2D(_OverlayTex, IN.uv2_MainTex);

                        rgbAlbedo = lerp(
                            rgbAlbedo,
                            rgbAlbedo * overlay.rgb,
                            saturate(overlay.a * _OverlayStrength)
                        );

                        // Smoothness Map (Could use for puddles, edge smoothed, etc)

                        half smoothness =
                            tex2D(_SmoothnessMap, IN.uv_MainTex).r *
                            _SmoothnessIntensity;

                        // Emission Stuff

                        half3 emission =
                            tex2D(_EmissionMap, IN.uv_MainTex).rgb *
                            _EmissionColor.rgb *
                            _EmissionStrength;

                        // AO, manual shadows, no color here though

                        half occlusion =
                            tex2D(_OcclusionMap, IN.uv2_MainTex).r;

                        // Final Output

                        o.Albedo =
                            rgbAlbedo *
                            _MainColor.rgb *
                            _Brightness;

                        o.Smoothness = saturate(smoothness);
                        o.Occlusion = saturate(1 - (1 - occlusion) * _OcclusionIntensity);
                        o.Emission = emission;
                    }

                    ENDCG
                }

                    FallBack "Diffuse"
}