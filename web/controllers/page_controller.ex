defmodule Letsplay.PageController do
  use Letsplay.Web, :controller

  def index(conn, _params) do
    :random.seed(:os.timestamp)
    %{"name"          => name,
      "language"      => language,
      "test_filename" => test_filename,
      "code_filename" => code_filename} =
      File.read!("/app/code_katas/index.json")
      |> Poison.decode!
      |> Enum.random

    test_body = case File.read("/app/code_katas/#{test_filename}") do
      {:ok, text} -> text
      _           -> ""
    end
    code_body = case File.read("/app/code_katas/#{code_filename}") do
      {:ok, text} -> text
      _           -> ""
    end

    render conn, "index.html",
      code: %{filename: code_filename, body: code_body, language: language},
      test: %{filename: test_filename, body: test_body},
      name: name,
      language: language,
      output: ""
  end

  def run(conn, %{"code" => %{"filename" => code_filename, "body" => code_body},
                  "test" => %{"filename" => test_filename, "body" => test_body},
                  "language" => language, "name" => name}) do
    dir ="/app/code_katas/tmp/" <>
      (:crypto.strong_rand_bytes(16) |> Base.url_encode64 |> binary_part(0, 16))
    File.rm_rf(dir)
    File.mkdir(dir)
    File.write("#{dir}/#{code_filename}", code_body)
    File.write("#{dir}/#{test_filename}", test_body)

    cmd = ["run", "-v", dir <> ":/home/app", "letsplay/#{language}"]
    cmd = case language do
      "ruby"   -> cmd ++ ["ruby", test_filename]
      "nodejs" -> cmd ++ ["node", test_filename]
      "mono"   -> cmd ++ ["bash", "-c", mono_code(code_filename, test_filename)]
      _        -> cmd ++ ["ruby", "echo", "nosupport"]
    end

    case System.cmd("docker", cmd, stderr_to_stdout: true) do
      {output, _} ->
        File.rm_rf(dir)
        render conn, "index.html",
          code: %{filename: code_filename, body: code_body},
          test: %{filename: test_filename, body: test_body},
          name: name,
          language: language,
          output: output
    end
  end

  defp mono_code(code_filename, test_filename) do
    code_lib = Regex.replace(~r/\.cs$/, code_filename, "")
    test_dll = Regex.replace(~r/\.cs$/, test_filename, ".dll")

    compile_code = "mcs -t:library #{code_filename}"
    compile_test = "mcs -t:library -r:/nunit/nunit.framework,#{code_lib} #{test_filename}"
    run_test     = "mono /nunit/nunit-console.exe #{test_dll}"

    Enum.join([compile_code, compile_test, run_test], " && ")
  end

end
