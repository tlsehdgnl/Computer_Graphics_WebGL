#version 300 es

layout(location = 0) in vec3 vPosition;
layout(location = 2) in vec2 vTexCoord;

uniform mat4 worldMat;
uniform mat4 viewMat;
uniform mat4 projMat;

out vec3 fWorldPos;
out vec2 fTexCoord;

void main()
{
    vec4 worldPos =
        worldMat *
        vec4(vPosition, 1.0);

    fWorldPos = worldPos.xyz;

    fTexCoord = vTexCoord;

    gl_Position =
        projMat *
        viewMat *
        worldPos;
}