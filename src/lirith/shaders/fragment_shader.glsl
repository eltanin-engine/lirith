#version 330 core

in vec3 fragmentColor;

// output color value
out vec3 color;

void main() {
  color = fragmentColor;
  // color = vec3(1,0,0);
}
