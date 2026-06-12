class Allx < Formula
  desc "Run Salesforce Apex locally on the JVM"
  homepage "https://github.com/colatusso/alloyx"
  url "https://github.com/colatusso/alloyx/releases/download/v0.1.1/allx-0.1.1.zip"
  sha256 "10f38f7ba9b964f45917d1069cb8b6f7ef687020484bc8e7a2e3c19e98315e0f"
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
