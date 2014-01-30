class PullRequest
  attr_reader :action

  def initialize(options)
    @action = options.action
    @attributes = options.pull_request
  end

  def text
    @attributes.title
  end

  def opened?
    action.match /open/
  end

  def closed?
    !merged? && @attributes.closed_at != nil
  end

  def merged?
    @attributes.merged_at != nil
  end
end

