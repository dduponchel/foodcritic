require "spec_helper"

describe "FC070" do
  context "with a cookbook with a metadata file specifying a single valid supports statement" do
    metadata_file "supports 'ubuntu'"
    it { is_expected.to_not violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying multiple valid supports statements" do
    metadata_file "%w(ubuntu debian fedora).each do |plat|\nsupports plat\nend"
    it { is_expected.to_not violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying a single invalid supports statement" do
    metadata_file "supports 'aws'"
    it { is_expected.to violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying multiple invalid supports statements" do
    metadata_file "%w(aws oel rhel).each do |plat|\nsupports plat\nend"
    it { is_expected.to violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying a mix of valid and invalid supports statements" do
    metadata_file "%w(aws oracle scientific).each do |plat|\nsupports plat\nend"
    it { is_expected.to violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying a valid supports platform, but uppercase" do
    metadata_file "supports 'UBUNTU'"
    it { is_expected.to violate_rule("FC070") }
  end

  context "with a cookbook with a metadata file specifying a valid supports platform, but with a version string" do
    metadata_file "supports 'ubuntu >= 16.04'"
    it { is_expected.to violate_rule("FC070") }
  end
end
