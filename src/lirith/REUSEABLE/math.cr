require "./math/*"

module Lirith
  module Math
    # Vectors
    alias Vector3 = TVector3(Float32)

    # Matrices
    alias Matrix4 = TMatrix4(Float32)

    # Faces
    alias Face3 = TFace3(Int32)

    alias Quaternion = TQuaternion(Float32)
    alias Euler = TEuler(Float32)
  end
end
