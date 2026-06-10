#version 300 es

layout(location = 0) in vec3 vPosition;
layout(location = 1) in vec3 vNormal;
layout(location = 2) in vec2 vTexCoord;

out vec3 fNormal;
out vec3 fView;
out vec2 fTexCoord;

uniform mat4 worldMat;
uniform mat4 viewMat;
uniform mat4 projMat;

uniform vec3 eyePos;

void main()
{
    fNormal = normalize(transpose(inverse(mat3(worldMat))) * normalize(vNormal));

    vec3 worldPos = (worldMat * vec4(vPosition, 1.0)).xyz;

    fView = normalize(eyePos - worldPos);

    gl_Position = projMat * viewMat * vec4(worldPos, 1.0);

    fTexCoord = vTexCoord;
}