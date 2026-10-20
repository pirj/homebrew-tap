class TaskwarriorSquire < Formula
  desc "Taskwarrior for one human and the AI assistants who work for them"
  homepage "https://github.com/pirj/taskwarrior-squire"
  url "https://github.com/pirj/taskwarrior-squire/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "75cf6e260f8599f79a80e1e55696011557d2bbdca07f9536fa1ba8c531f68fbd"
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
