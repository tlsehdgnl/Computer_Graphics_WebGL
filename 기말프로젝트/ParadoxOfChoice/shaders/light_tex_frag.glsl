#version 300 es

precision mediump float;

uniform sampler2D texImage;

uniform vec3 matSpec;
uniform vec3 matAmbi;
uniform vec3 matEmit;

uniform float matSh;

uniform vec3 srcDiff;
uniform vec3 srcSpec;
uniform vec3 srcAmbi;

uniform vec3 lightDir;

in vec3 fNormal;
in vec3 fView;
in vec2 fTexCoord;

out vec4 fragColor;

void main()
{
    vec3 normal = normalize(fNormal);
    vec3 view = normalize(fView);
    vec3 light = normalize(lightDir);

    vec3 matDiff = texture(texImage, fTexCoord).rgb;

    vec3 diff = max(dot(normal, light), 0.0) * srcDiff * matDiff;

    vec3 halfv = normalize(light + view);

    vec3 spec = pow(max(dot(normal, halfv), 0.0), matSh)
              * srcSpec * matSpec;

    vec3 ambi = srcAmbi * matAmbi;

    fragColor = vec4(diff + spec + ambi + matEmit, 1.0);
}