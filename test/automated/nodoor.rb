require_relative '../test_init'

context Nodoor do
  test 'has a version' do
    assert(Nodoor::VERSION.is_a?(String))
  end

  test 'has a CLI that lists files' do
    output, status = Open3.capture2e(
      File.join(Dir.pwd, 'bin/nodoor'),
      chdir: 'test/fixtures/repo',
    )

    detail("Status: #{status.inspect}")
    detail("Output:\n#{output}")

    assert(status == 0)
    assert(output == <<~END_OUTPUT)
      parent/child/grandchild.md
      parent/child.md
      parent.md
    END_OUTPUT
  end
end
