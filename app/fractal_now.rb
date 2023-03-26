# frozen_string_literal: true

require 'json'
require 'rack'
require 'open3'

class FractalNow
  def call(env)
    req = Rack::Request.new(env)

    if req.post? && req.path == '/fractal'
      text_config = req.body.read
      return build_error(400, 'Request can not be empty') if text_config.empty?

      config = create_config(text_config)
      output_file = create_output

      status = generate_fractal(config, output_file)
      if status.exitstatus != 0
        return build_error(500, 'Error running fractalnow')
      end

      [200, { 'Content-Type' => 'image/x-portable-pixmap' }, [File.read(output_file)]]
    else
      build_error(404, 'Not found')
    end
  ensure
    config&.unlink
    output_file&.unlink
  end

  private

  def generate_fractal(config, output_file)
    command = "fractalnow -c #{config.path} -x 500 -y 500 -o #{output_file.path}"
    _, status = Open3.capture2e(command)
    output_file.close
    status
  end

  def create_output
    Tempfile.new('fractal_output')
  end

  def create_config(text_config)
    config = Tempfile.new('fractal_config')
    config.write(text_config)
    config.close
    config
  end

  def build_error(code, message)
    [code, { 'Content-Type' => 'application/json' }, [{ error: message }.to_json]]
  end
end
