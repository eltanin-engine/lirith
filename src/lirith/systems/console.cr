require "./base"

module Lirith
  module Systems
    class Console < Lirith::Systems::Base
      # property polling = false
      property log = true

      def initialize(@ignore_events = [] of Events::Base.class)
      end

      def get_command
        print "Command: "
        line = gets.to_s

        command_data = line.split(' ')

        handle_command(command_data.shift, command_data)
      end

      def handle_command(command : String, args = [] of String)
        case command
        when "exit"       ; Managers::System.trigger_event(Events::Application::Exit)
        when "listMesh"   ; listMesh
        when "randomColor"; randomColor
        else
          p "Command '#{command}' was not found"
        end
      end

      def handle_event(event)
        p event.info if @log && !@ignore_events.includes?(event.class)
        case event
        when Events::Console::RequestCommand; get_command
        when Events::Console::ToggleLog     ; @log = !@log
        end
      end

      def listMesh
        Lirith.application.scene.children.each_with_index do |obj, index|
          next unless obj.is_a?(Lirith::Objects::Mesh)

          p "#{index} | #{obj.class}"
        end
      end

      def randomColor
        Lirith.application.scene.children.each_with_index do |obj, index|
          next unless obj.is_a?(Lirith::Objects::Mesh)
          if material = obj.material
            material.color = Math::Color.random
            obj.needs_update = true
          end
        end
      end

      def updateMesh
      end
    end
  end
end
