require "./math/*"

module Lirith
  module Math
    # Vectors
    alias Vector3 = TVector3(Float32)

    # Matrices
    alias Matrix4 = TMatrix4(Float32)

    alias Quaternion = TQuaternion(Float32)
  end
end
