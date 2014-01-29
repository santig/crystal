class Push
  BRANCH_MATCHER = /\/(.*)$/

  attr_reader :action, :options

  def initialize(options)
    @action = options.action
    @options = options
    @pusher = options.pusher ? options.pusher.name : "anonymous"
    if @pusher == "anonymous"
      puts "unexpected push options #{options.inspect}"
    end
  end

  def branch_name
    options.ref.to_s.match(BRANCH_MATCHER)[1]
  end
  
  def base_ref_name
    options.base_ref ? options.base_ref.match(BRANCH_MATCHER)[1] : ""
  end
  
  def branch_names
    "#{branch_name} #{base_ref_name}"
  end
  
  def branch_url
    puts options.compare
    options.compare.sub(/\/compare\//,"/tree/")
  end
  
  def changes_url
    options.compare
  end
  
  def feature_branch?
    !!options.ref.match(/feature\/.*$/)
  end
  
  def feature_merge?
    !!(base_ref_name.match(/feature\/.*$/) && branch_name.match(/\/develop$/))
  end
  
  def new_branch?
    !!options.created
  end

end

