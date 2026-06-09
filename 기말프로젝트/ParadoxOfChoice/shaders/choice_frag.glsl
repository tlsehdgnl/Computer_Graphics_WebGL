#version 300 es
precision mediump float;

in vec3 fWorldPos;

uniform vec3 eyePos;

uniform vec3 objectColor;

uniform float fogStart;
uniform float fogEnd;

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
            0.05,
            0.05,
            0.05
        );

    vec3 finalColor =
        mix(
            objectColor,
            fogColor,
            fogFactor
        );

    fragColor =
        vec4(
            finalColor,
            1.0
        );
}