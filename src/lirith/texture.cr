module Lirith
  class Texture
    getter width : Int32
    getter height : Int32

    getter data : Bytes

    def initialize(file : File)
      header = Bytes.new(54)
      file.read_fully(header)

      raise "File is not a BMP" unless header[0] === 'B' && header[1] === 'M'

      #@width = file.read_bytes(Int32, IO::ByteFormat::LittleEndian)

      data_start = IO::ByteFormat::LittleEndian.decode(Int32, header[0x0a, 0x0e])
      #image_size = IO::ByteFormat::LittleEndian.decode(Int32, header[38, 42])

      @width = IO::ByteFormat::LittleEndian.decode(Int32, header[0x12, 0x16])
      @height = IO::ByteFormat::LittleEndian.decode(Int32, header[0x16, 0x1a])

      size = @width * @height * 3

      @data = Bytes.new(size)
      file.read_fully(@data)

      file.close
    end
  end
end
