require "./renderable"

module Lirith
  module Drawable
    include Renderable
    # Move this to base object?

    property position = Math::Vector3.zero
    property quaternion = Math::Quaternion.new(0, 0, 0)
    property scale = Math::Vector3.new(1, 1, 1)

    property view = Math::Matrix4.identity # modelView?
    property worldView = Math::Matrix4.identity

    def update_view
      @quaternion.normalize!
      view.rotate(@quaternion)
      view.scale(@scale)
      view.position(@position)
    end

    def translate(axis : Math::Vector3, distance)
      axis.apply(@quaternion)
      @position = @position + (axis * distance)
    end

    def translate_x(distance)
      translate(Math::Vector3.x_axis, distance)
    end

    def translate_y(distance)
      translate(Math::Vector3.y_axis, distance)
    end

    def translate_z(distance)
      translate(Math::Vector3.z_axis, distance)
    end

    def rotate(axis, angle)
      q = Math::Quaternion.new(0, 0, 0, 1)
      q.apply_axis_angle!(axis, angle)
      @quaternion = @quaternion * q
    end

    def rotate_x(angle)
      rotate(Math::Vector3.x_axis, angle)
    end

    def rotate_y(angle)
      rotate(Math::Vector3.y_axis, angle)
    end

    def rotate_z(angle)
      rotate(Math::Vector3.z_axis, angle)
    end

    def clone
      obj = self.class.new

      obj.position = @position.clone
      obj.quaternion = @quaternion.clone
      obj.scale = @scale.clone
      obj.view = @view.clone
      obj.worldView = @worldView.clone

      obj
    end
  end
end
