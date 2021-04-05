require_relative '../../test_init'

context Nodoor::Repo do
  subject = Nodoor::Repo.new('test/fixtures/repo')

  test "enumerates records in the directory, ignoring hidden files" do
    paths = subject.each.map { _1.path.to_s }.sort
    detail paths.inspect
    assert paths == %w[
      parent.md
      parent/child.md
      parent/child/grandchild.md
      sidecar_metadata.md
    ]
  end

  test "extracts metadata from frontmatter" do
    metadata = subject.metadata_for('parent.md')
    detail metadata.inspect
    assert metadata == {"title"=>"Parent", "tags"=>["tag1", "tag2"]}
  end

  test "extracts metadata from sidecar yaml files" do
    metadata = subject.metadata_for('sidecar_metadata.md')
    detail metadata.inspect
    assert metadata == {"from_sidecar"=> true}
  end
end
