#version 330 core

// vertex input data
layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;
layout(location = 2) in vec2 uv;

out vec3 fragmentColor;
out vec2 fragmentUV;

// model/view/projection matrix

uniform mat4 world;
uniform mat4 view;
uniform mat4 projection;

void main() {
  vec4 worldPos = world * vec4(position, 1);
  vec4 viewPos = view * worldPos;

  gl_Position = projection * viewPos;

  fragmentColor = color.rgb;
  fragmentUV = uv;
}
