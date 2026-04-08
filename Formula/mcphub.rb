class Mcphub < Formula
  desc "The package manager for Model Context Protocol (MCP) servers"
  homepage "https://github.com/Ricardo-M-L/mcphub"
  url "https://github.com/Ricardo-M-L/mcphub/archive/refs/tags/v0.2.0.tar.gz"
  sha256 ""
  license "Apache-2.0"
  head "https://github.com/Ricardo-M-L/mcphub.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/Ricardo-M-L/mcphub/internal/cli.version=#{version}"), "./cmd/mcphub"

    # Also build the MCP server binary
    system "go", "build", "-o", bin/"mcphub-mcp", *std_go_args(ldflags: "-s -w"), "./mcp"
  end

  test do
    assert_match "mcphub v#{version}", shell_output("#{bin}/mcphub version")
  end
end
