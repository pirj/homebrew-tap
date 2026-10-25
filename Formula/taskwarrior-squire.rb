class TaskwarriorSquire < Formula
  desc "Taskwarrior for one human and the AI assistants who work for them"
  homepage "https://github.com/pirj/taskwarrior-squire"
  url "https://github.com/pirj/taskwarrior-squire/archive/refs/tags/v0.17.1.tar.gz"
  sha256 "4fd56cbe4cd810070e7dfeb50f187647a00f67a3965d447a2b66f32f9e0153e1"
  license "MIT"

  depends_on "task"
  uses_from_macos "python"

  def install
    system "make", "install", "PREFIX=#{prefix}", "RUNTIME=#{opt_pkgshare}"
  end

  def caveats
    <<~EOS
      In a project, run:
        squire init
      Then read: man taskwarrior-squire
    EOS
  end

  test do
    ENV["TASKRC"] = pkgshare/"taskrc"
    ENV["TASKDATA"] = testpath
    touch testpath/".taskrc"
    ENV["HOME"] = testpath
    system "task", "add", "a task"
    assert_equal "idea", shell_output("task 1 _get 1.state").strip
  end
end
