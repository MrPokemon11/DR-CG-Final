Shader "Custom/ScrollingSky"
{
    Properties
    {
        _MainTex ("Sky", 2D) = "white" {}
        _StarTex ("Shooting Stars", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-5,5)) = 1
        _ScrollY ("Scroll Y", Range(-5,5)) = 1
    }

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" "RenderType" = "Opaque" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // Include URP core functionality
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;  // Object space position
                float2 uv : TEXCOORD0;         // Texture coordinates
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION; // Homogeneous clip-space position
                float2 uv : TEXCOORD0;            // UV coordinates
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            TEXTURE2D(_StarTex);
            SAMPLER(sampler_StarTex);

            float _ScrollX;
            float _ScrollY;

            // Vertex Shader
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);  // Transform object position to clip space

                // Pass UVs to fragment shader
                OUT.uv = IN.uv;
                return OUT;
            }

            // Fragment Shader
            half4 frag(Varyings IN) : SV_Target
            {
                // Scroll UVs over time
                float2 scrolledUV = IN.uv + float2(_ScrollX, _ScrollY) * _Time.y;

                // Scroll UVs for foam texture at a different rate
                float2 scrolledStarUV = IN.uv + float2(_ScrollX, _ScrollY) * (_Time.y * 0.5);

                // Sample both textures using the scrolled UV coordinates
                half4 sky = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, scrolledUV);
                half4 snow = SAMPLE_TEXTURE2D(_StarTex, sampler_StarTex, scrolledStarUV);

                // Blend both textures
                half4 finalColor = (sky + snow) * 0.5;
                
                return finalColor;
            }

            ENDHLSL
        }
    }
}