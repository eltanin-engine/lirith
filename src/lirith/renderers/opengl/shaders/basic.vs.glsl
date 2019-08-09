#version 330 core

// vertex input data
layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;

out vec4 fragmentColor;

// model/view/projection matrix

uniform mat4 world;
uniform mat4 view;
uniform mat4 projection;
// uniform mat4 MVP;

void main() {
  vec4 worldPos = world * vec4(position, 1);
  vec4 viewPos = view * worldPos;

  gl_Position = projection * viewPos;

  fragmentColor = color;
}
