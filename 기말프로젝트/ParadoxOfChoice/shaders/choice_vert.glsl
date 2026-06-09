#version 300 es

layout(location = 0) in vec3 vPosition;

uniform mat4 worldMat;
uniform mat4 viewMat;
uniform mat4 projMat;

out vec3 fWorldPos;

void main()
{
    vec4 worldPos =
        worldMat *
        vec4(vPosition, 1.0);

    fWorldPos = worldPos.xyz;

    gl_Position =
        projMat *
        viewMat *
        worldPos;
}