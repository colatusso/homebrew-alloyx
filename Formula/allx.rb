class Allx < Formula
  desc "Run Salesforce Apex locally on the JVM"
  homepage "https://github.com/colatusso/alloyx"
  url "https://github.com/colatusso/alloyx/releases/download/v0.2.6/allx-0.2.6.zip"
  sha256 "0d822b817b8d5d7a3ca6b755d49fd7f4718f066553facd4e5feb4bb8f695ef29"
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
