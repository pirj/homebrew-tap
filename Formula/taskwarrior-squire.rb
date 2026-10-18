class TaskwarriorSquire < Formula
  desc "Taskwarrior for one human and the AI assistants who work for them"
  homepage "https://github.com/pirj/taskwarrior-squire"
  url "https://github.com/pirj/taskwarrior-squire/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "1a518b92cc40452635a18e28d7618255be8dc9b30d0a5a07fd4eeabec49ce26f"
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
