class Allx < Formula
  desc "Run Salesforce Apex locally on the JVM"
  homepage "https://github.com/colatusso/alloyx"
  url "https://github.com/colatusso/alloyx/releases/download/v0.1.0/allx-0.1.0.zip"
  sha256 "cd5bf281e7868be2869f442b5320bc674c74f7b157aa239251b5065c5ba3f149"
  license "AGPL-3.0-only"

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]
    (bin/"allx").write_env_script libexec/"bin/allx",
      Language::Java.overridable_java_home_env("21")
  end

  test do
    (testpath/"Hello.cls").write <<~APEX
      public class Hello {
          public static void run() {
              System.debug(7);
          }
      }
    APEX
    assert_match "7", shell_output("#{bin}/allx run #{testpath}/Hello.cls --method Hello.run")
  end
end
