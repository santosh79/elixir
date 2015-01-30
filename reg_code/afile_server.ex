defmodule FileServer do
  def start do
    pid = spawn FileServer, :loop, []
    Process.register pid, __MODULE__
  end

  def pwd do
    rpc :pwd
  end

  def ls do
    {:ok, cwd} = :file.get_cwd
    ls cwd
  end

  def ls(dir) do
    rpc {:list_dir, dir}
  end

  def get_file(file_path) do
    rpc {:get_file, file_path}
  end

  def rpc(msg) do
    pid = Process.whereis __MODULE__
    send pid, {self, msg}
    receive do
      {^pid, response} -> response
    end
  end

  def loop do
    receive do
      {from, {:list_dir, dir}} ->
        send from, {self, File.ls!(dir)}
        loop
      {from, {:get_file, file_path}} ->
        file_contents = File.read! file_path
        send from, {self, file_contents}
        loop
      {from, :pwd} ->
        my_pwd = IEx.Helpers.pwd
        send from, {self, my_pwd}
        loop
    end
  end

end

