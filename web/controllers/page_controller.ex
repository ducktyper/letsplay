defmodule Letsplay.PageController do
  use Letsplay.Web, :controller

  def index(conn, _params) do
    case File.read("web/test_codes/test_fibonacci.rb") do
      {:ok, text} ->
        render conn, "index.html", test: text, code: "", message: ""
      {:error, reason} ->
        render conn, "index.html", test: reason, code: "", message: ""
    end
  end

  def run(conn, %{"code" => code, "test" => test}) do
    dir = System.cwd() <> "/tmp/" <>
      (:crypto.strong_rand_bytes(16) |> Base.url_encode64 |> binary_part(0, 16))
    File.rm_rf(dir)
    File.mkdir(dir)
    File.write(dir <> "/test_fibonacci.rb", test)
    File.write(dir <> "/fibonacci.rb", code)
    case System.cmd("docker", ["run", "-v", dir <> ":/home/app",
      "letsplay/ruby", "ruby", "test_fibonacci.rb"], stderr_to_stdout: true) do
      {std, _} ->
        File.rm_rf(dir)
        render conn, "index.html", test: test, code: code, message: std
    end
  end
end
