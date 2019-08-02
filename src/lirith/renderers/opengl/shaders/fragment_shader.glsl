#version 330 core

in vec4 fragmentColor;

// output color value
out vec4 color;

void main() {
  color = fragmentColor;
  //color = vec4(0,0,0,1);
}
