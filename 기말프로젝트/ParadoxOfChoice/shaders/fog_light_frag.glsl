#version 300 es
precision mediump float;

uniform bool useTexture;
uniform bool useAO;
uniform bool useLighting;
uniform sampler2D texImage;
uniform sampler2D aoImage;
uniform vec3 objectColor;
uniform vec3 matSpec, matAmbi, matEmit;
uniform float matSh;
uniform vec3 srcDiff, srcSpec, srcAmbi;
uniform vec3 lightDir;
uniform vec3 eyePos;
uniform float fogStart, fogEnd, fogColor;

in vec3 fNormal, worldPos;
in vec2 fTexCoord;

layout(location = 0) out vec4 fragColor;

void main()
{
    //normalization
    vec3 normal = normalize(fNormal);
    //vec3 view = normalize(fView);
    vec3 view = normalize(eyePos - worldPos);
    vec3 light = normalize(lightDir);

    vec3 matDiff = useTexture ? texture(texImage, fTexCoord).rgb : objectColor;
    vec3 color = matDiff;

    if (useLighting) {
        vec3 diff = max(dot(normal, light), 0.0) * srcDiff * matDiff;
        vec3 halfV = normalize(light + view);
        vec3 spec = pow(max(dot(normal, halfV), 0.0), matSh) * srcSpec * matSpec;
        vec3 ambi = srcAmbi * matAmbi;
        vec3 ao = useAO ? mix(vec3(1.0), texture(aoImage, fTexCoord).rgb, 0.5) : vec3(1.0);
        color = (diff + spec + ambi + matEmit) * ao;
    }

    float fogDepth = length(eyePos - worldPos);
    float fogFactor = smoothstep(fogStart, fogEnd, fogDepth);
    vec3 fColor = mix(color, vec3(fogColor), fogFactor);
    fragColor = vec4(fColor, 1.0);
    //fragColor = vec4((diff + spec + ambi + matEmit) * ao, 1.0);
}