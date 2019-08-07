class Github
  attr_reader :repo_name, :url, :clone_dir

  def initialize(repo_name, protocol: :ssh, clone_dir: '')
    @repo_name = repo_name
    case protocol
    when :ssh
      url = 'https://github.com/'
    when :git
      url = 'git@github.com:'
    else
      raise 'Unknown protocol'
    end

    @clone_dir = clone_dir
    @url = "#{url}#{repo_name}"
  end

  def clone_dir(dir)
    @clone_dir = dir
  end

  def clone
    system("git clone #{url} #{@clone_dir}")
  end
end
