#version 330 core

in vec3 fragmentColor;
in vec2 fragmentUV;

// output color value
out vec3 color;

uniform sampler2D textureSampler;
uniform bool use_texture;

void main() {
  if(use_texture == true){
    color = texture( textureSampler, fragmentUV ).rgb;
    //color = vec4(1,0,0,1).rgb;  
  }else{
    color = fragmentColor;
  }
}
