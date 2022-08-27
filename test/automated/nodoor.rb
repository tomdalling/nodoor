require_relative '../test_init'

context Nodoor do
  test 'has a version' do
    assert(Nodoor::VERSION.is_a?(String))
  end

  test 'has a CLI that lists files' do
    output, status = Open3.capture2e(
      File.join(Dir.pwd, 'bin/nodoor list'),
      chdir: 'test/fixtures/repo',
    )

    detail("Status: #{status.inspect}")
    detail("Output:\n#{output}")

    assert(status == 0)
    assert(output == <<~END_OUTPUT)
      parent/child/grandchild.md
      parent/child.md
      parent.md
      sidecar_metadata.md
    END_OUTPUT
  end

  test 'has a CLI that detects metadata' do
    output, status = Open3.capture2e(
      File.join(Dir.pwd, 'bin/nodoor meta parent.md'),
      chdir: 'test/fixtures/repo',
    )

    detail("Status: #{status.inspect}")
    detail("Output:\n#{output}")

    assert(status == 0)
    assert(output == <<~END_OUTPUT)
      ---
      title: Parent
      tags:
      - tag1
      - tag2
    END_OUTPUT
  end
end
