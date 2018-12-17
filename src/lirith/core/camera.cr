module Lirith
  class Camera

    def self.perspective(fov_y, aspect, near, far)
      raise ArgumentError.new if aspect == 0 || near == far
      rad = (fov_y / 180.0 * Math::PI)
      tan_half_fov = Math.tan(rad / 2)

      m = Math::Matrix4.zero
      m[0,0] = 1 / (aspect * tan_half_fov).to_f32
      m[1,1] = 1 / tan_half_fov.to_f32
      m[2,2] = -(far + near).to_f32 / (far - near).to_f32
      m[3,2] = -1_f32
      m[2,3] = -(2_f32 * far * near) / (far - near)
      m
    end

    def look_at(eye : Math::Vector3, center : Math::Vector3, up : Math::Vector3)
      f = (center - eye).normalize
      s = f.cross(up).normalize
      u = s.cross(f)

      m = Math::Matrix4.identity
      m[0,0] = s.x
      m[0,1] = s.y
      m[0,2] = s.z
      m[1,0] = u.x
      m[1,1] = u.y
      m[1,2] = u.z
      m[2,0] = -f.x
      m[2,1] = -f.y
      m[2,2] = -f.z
      m[0,3] = -s.dot(eye)
      m[1,3] = -u.dot(eye)
      m[2,3] = f.dot(eye)
      m
    end
  end
end
