#version 300 es
precision mediump float;

in vec3 fWorldPos;
in vec2 fTexCoord;

uniform vec3 eyePos;

uniform vec3 objectColor;

uniform float fogStart;
uniform float fogEnd;

uniform sampler2D texImage;
uniform sampler2D aoImage;
uniform bool useTexture;
uniform bool useAO;

out vec4 fragColor;

void main()
{
    float dist =
        length(
            eyePos -
            fWorldPos
        );

    float fogFactor =
        smoothstep(
            fogStart,
            fogEnd,
            dist
        );

    vec3 fogColor =
        vec3(
            0.02,
            0.03,
            0.04
        );

    vec3 ambient = vec3(0.08);

    vec3 baseColor;

    if(useTexture)
    {
        vec3 diffuse =
            texture(texImage, fTexCoord).rgb;

        vec3 ao = useAO ?
            texture(
                aoImage,
                fTexCoord
            ).rgb :
            vec3(1.0);

        baseColor =
            diffuse * ao;
    }
    else
    {
        baseColor = objectColor;
    }

    vec3 litColor = clamp(baseColor + ambient, 0.0, 1.0);

    vec3 finalColor =
        mix(
            litColor,
            fogColor,
            fogFactor
        );

    fragColor =
        vec4(
            finalColor,
            1.0
        );
}